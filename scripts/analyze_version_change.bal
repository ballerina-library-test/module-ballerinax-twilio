import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/lang.value;
import ballerina/os;
import ballerina/regex;

const string ANTHROPIC_API_URL = "https://api.anthropic.com/v1/messages";
const int MAX_RETRIES = 2;
const decimal RETRY_DELAY_SECONDS = 3.0;
// Chunk size to stay well under 200K token limit (~37.5K tokens per chunk)
const int CHUNK_SIZE_CHARS = 150000;

type AnalysisResult record {
    string changeType;
    string[] breakingChanges;
    string[] newFeatures;
    string[] bugFixes;
    string summary;
    decimal confidence;
};

type Message record {
    string role;
    string content;
};

// Split diff into manageable chunks by file sections
// NOTE: The diff should only contain client.bal and types.bal as per workflow
function splitDiffIntoChunks(string diff) returns string[] {
    io:println("🔍 Parsing diff into file sections...");
    
    // Parse into file sections
    string[] lines = regex:split(diff, "\n");
    map<string> fileSections = {};
    
    string currentFile = "";
    string currentContent = "";
    
    foreach string line in lines {
        if line.startsWith("diff --git") {
            // Save previous section
            if currentFile != "" {
                fileSections[currentFile] = currentContent;
            }
            
            // Extract new filename
            string[] parts = regex:split(line, " ");
            if parts.length() >= 4 {
                string filePath = parts[3];
                currentFile = filePath.substring(2); // Remove "b/"
            }
            currentContent = line + "\n";
        } else {
            currentContent += line + "\n";
        }
    }
    
    // Add last section
    if currentFile != "" {
        fileSections[currentFile] = currentContent;
    }
    
    io:println(string `📁 Files found in diff: ${fileSections.keys().toString()}`);
    
    // Build chunks - process files in priority order
    string[] chunks = [];
    
    // Priority 1: client.bal (contains public API methods)
    string? clientContent = fileSections["ballerina/client.bal"];
    if clientContent is string {
        io:println(string `📄 Processing ballerina/client.bal (${clientContent.length()} chars)`);
        if clientContent.length() > CHUNK_SIZE_CHARS {
            // Split large file into multiple chunks
            string[] clientChunks = splitLargeContent("ballerina/client.bal", clientContent);
            io:println(string `   ↳ Split into ${clientChunks.length()} chunks`);
            chunks.push(...clientChunks);
        } else {
            chunks.push(clientContent);
            io:println("   ↳ Fits in 1 chunk");
        }
    }
    
    // Priority 2: types.bal (contains type definitions)
    string? typesContent = fileSections["ballerina/types.bal"];
    if typesContent is string {
        io:println(string `📄 Processing ballerina/types.bal (${typesContent.length()} chars)`);
        if typesContent.length() > CHUNK_SIZE_CHARS {
            string[] typesChunks = splitLargeContent("ballerina/types.bal", typesContent);
            io:println(string `   ↳ Split into ${typesChunks.length()} chunks`);
            chunks.push(...typesChunks);
        } else {
            chunks.push(typesContent);
            io:println("   ↳ Fits in 1 chunk");
        }
    }
    
    // If there are any other files (shouldn't happen based on workflow), add them
    foreach string fileName in fileSections.keys() {
        if fileName != "ballerina/client.bal" && fileName != "ballerina/types.bal" {
            io:println(string `⚠️ Unexpected file in diff: ${fileName}`);
            string content = fileSections.get(fileName);
            if content.length() > CHUNK_SIZE_CHARS {
                chunks.push(...splitLargeContent(fileName, content));
            } else {
                chunks.push(content);
            }
        }
    }
    
    return chunks;
}

// Split a large file's diff into smaller chunks
function splitLargeContent(string fileName, string content) returns string[] {
    string[] chunks = [];
    string[] lines = regex:split(content, "\n");
    
    string currentChunk = string `--- FILE: ${fileName} (Part ${chunks.length() + 1}) ---\n`;
    int currentSize = currentChunk.length();
    
    foreach string line in lines {
        int lineSize = line.length() + 1; // +1 for newline
        
        if currentSize + lineSize > CHUNK_SIZE_CHARS && currentChunk.length() > 0 {
            // Save current chunk and start new one
            chunks.push(currentChunk);
            currentChunk = string `--- FILE: ${fileName} (Part ${chunks.length() + 1}) - CONTINUED ---\n`;
            currentSize = currentChunk.length();
        }
        
        currentChunk += line + "\n";
        currentSize += lineSize;
    }
    
    // Add final chunk
    if currentChunk.length() > 0 {
        chunks.push(currentChunk);
    }
    
    return chunks;
}

function analyzeWithAnthropicMultiTurn(string[] diffChunks) returns AnalysisResult|error {
    string apiKey = os:getEnv("ANTHROPIC_API_KEY");
    
    if apiKey == "" {
        return error("ANTHROPIC_API_KEY environment variable is not set");
    }
    
    io:println(string `🔑 Using Anthropic API for multi-turn analysis`);
    io:println(string `📦 Total chunks to send: ${diffChunks.length()}`);
    
    http:Client anthropicClient = check new ("https://api.anthropic.com", {
        httpVersion: http:HTTP_1_1,
        timeout: 90
    });
    
    // System instructions that will be included with final analysis only
    string systemInstructions = string `You are analyzing git diff output for a Ballerina connector to determine the semantic version change needed.

RULES FOR VERSION CLASSIFICATION:
- MAJOR: Breaking changes (removed/renamed methods, removed/renamed types, changed method signatures, changed field types, removed fields)
- MINOR: Backward-compatible additions (new methods, new types, new optional fields)
- PATCH: Documentation changes, internal refactoring, bug fixes with no API surface changes

Respond with ONLY a JSON object (no markdown, no explanation):
{
  "changeType": "MAJOR|MINOR|PATCH",
  "breakingChanges": ["list specific breaking changes"],
  "newFeatures": ["list new features/additions"],
  "bugFixes": ["list bug fixes or improvements"],
  "summary": "concise summary of changes",
  "confidence": 0.95
}`;
    
    // Build complete diff content to send in final request
    string completeDiff = "";
    foreach int i in 0 ..< diffChunks.length() {
        completeDiff += diffChunks[i];
        if i < diffChunks.length() - 1 {
            completeDiff += "\n\n";
        }
    }
    
    io:println(string `📏 Complete diff size: ${completeDiff.length()} chars`);
    
    // Check if complete diff fits in one message (with safety margin)
    // 200K tokens = ~800K chars, leaving room for instructions
    if completeDiff.length() < 700000 {
        // Send everything in one request
        io:println("✅ Diff fits in single request");
        Message[] messages = [{
            role: "user",
            content: string `${systemInstructions}

GIT DIFF:
${completeDiff}`
        }];
        
        json response = check sendToAnthropic(anthropicClient, apiKey, messages, 2048);
        json contentJson = check response.content;
        json[] content = check contentJson.ensureType();
        string text = check content[0].text;
        
        text = regex:replaceAll(text.trim(), "```json|```", "");
        return check value:fromJsonStringWithType(text.trim());
    } else {
        // Multi-turn approach for very large diffs
        io:println("⚠️ Using multi-turn approach for large diff");
        
        // Send chunks with minimal conversation history to avoid token overflow
        string summaries = "";
        
        foreach int i in 0 ..< diffChunks.length() {
            int chunkNum = i + 1;
            io:println(string `📤 Processing chunk ${chunkNum}/${diffChunks.length()}...`);
            
            // Create a fresh message for each chunk to keep conversation short
            Message[] chunkMessages = [{
                role: "user",
                content: string `Analyze this git diff chunk (part ${chunkNum}/${diffChunks.length()}) and provide a brief summary of the changes. Focus on: breaking changes, new features, and bug fixes.

${diffChunks[i]}

Respond with a concise summary (2-3 sentences).`
            }];
            
            json response = check sendToAnthropic(anthropicClient, apiKey, chunkMessages, 500);
            json contentJson = check response.content;
            json[] content = check contentJson.ensureType();
            string chunkSummary = check content[0].text;
            
            summaries += string `CHUNK ${chunkNum}: ${chunkSummary}\n\n`;
            io:println(string `✅ Chunk ${chunkNum} summarized`);
            
            // Delay between requests
            if i < diffChunks.length() - 1 {
                runtime:sleep(1.0);
            }
        }
        
        // Final analysis based on all summaries
        io:println("\n🤖 Generating final analysis from summaries...");
        Message[] finalMessages = [{
            role: "user",
            content: string `${systemInstructions}

I've analyzed ${diffChunks.length()} chunks of a git diff for a Ballerina connector. Here are the summaries:

${summaries}

Based on these summaries, provide the final version change analysis.`
        }];
        
        json response = check sendToAnthropic(anthropicClient, apiKey, finalMessages, 2048);
        json contentJson = check response.content;
        json[] content = check contentJson.ensureType();
        string text = check content[0].text;
        
        text = regex:replaceAll(text.trim(), "```json|```", "");
        return check value:fromJsonStringWithType(text.trim());
    }
}

// Helper function to send request to Anthropic
function sendToAnthropic(http:Client httpClient, string apiKey, Message[] messages, int maxTokens) returns json|error {
    json[] messagesJson = [];
    foreach Message msg in messages {
        messagesJson.push({
            "role": msg.role,
            "content": msg.content
        });
    }
    json payload = {
        "model": "claude-sonnet-4-20250514",
        "max_tokens": maxTokens,
        "temperature": 0.1,
        "messages": messagesJson
    };
    
    http:Request req = new;
    req.setJsonPayload(payload);
    req.setHeader("anthropic-version", "2023-06-01");
    req.setHeader("x-api-key", apiKey);
    req.setHeader("content-type", "application/json");
    
    int retryCount = 0;
    
    while retryCount < MAX_RETRIES {
        do {
            http:Response httpResponse = check httpClient->post("/v1/messages", req);
            int statusCode = httpResponse.statusCode;
            
            string textResult = check httpResponse.getTextPayload();
            
            if statusCode != 200 {
                io:println(string `⚠️ Response status ${statusCode}: ${textResult.substring(0, 200)}`);
                if statusCode == 429 {
                    retryCount = retryCount + 1;
                    if retryCount < MAX_RETRIES {
                        io:println(string `⏳ Rate limited. Retry ${retryCount}/${MAX_RETRIES} in ${RETRY_DELAY_SECONDS}s...`);
                        runtime:sleep(RETRY_DELAY_SECONDS);
                        continue;
                    }
                }
                return error(string `Anthropic API returned status ${statusCode}: ${textResult}`);
            }
            
            json response = check value:fromJsonString(textResult);
            
            // Check for API errors
            json|error errorCheck = response.'error;
            if errorCheck is json {
                string errorMsg = check errorCheck.message;
                return error(string `Anthropic API Error: ${errorMsg}`);
            }
            
            return response;
            
        } on fail error e {
            retryCount = retryCount + 1;
            if retryCount < MAX_RETRIES {
                io:println(string `⏳ Request failed. Retry ${retryCount}/${MAX_RETRIES} in ${RETRY_DELAY_SECONDS}s...`);
                runtime:sleep(RETRY_DELAY_SECONDS);
            } else {
                return e;
            }
        }
    }
    
    return error("Max retries exceeded");
}

public function main(string diffFilePath) returns error? {
    io:println("📊 Analyzing git diff with multi-turn approach...");
    io:println(string `📂 Reading diff from: ${diffFilePath}`);
    
    string gitDiffContent = check io:fileReadString(diffFilePath);
    io:println(string `📏 Total diff size: ${gitDiffContent.length()} chars`);
    
    if gitDiffContent.length() == 0 {
        return error("Git diff content is empty");
    }
    
    // Validate that we're only processing client.bal and types.bal
    io:println("\n🔍 Validating diff content...");
    boolean hasClientBal = gitDiffContent.includes("ballerina/client.bal");
    boolean hasTypesBal = gitDiffContent.includes("ballerina/types.bal");
    
    if !hasClientBal && !hasTypesBal {
        return error("Diff does not contain client.bal or types.bal - nothing to analyze");
    }
    
    io:println(string `   ✓ client.bal: ${hasClientBal ? "Found" : "Not found"}`);
    io:println(string `   ✓ types.bal: ${hasTypesBal ? "Found" : "Not found"}`);
    io:println("   → Will send COMPLETE diff of these files to Claude in chunks");
    
    // Split into chunks
    string[] chunks = splitDiffIntoChunks(gitDiffContent);
    io:println(string `\n📦 Split into ${chunks.length()} chunks for multi-turn analysis`);
    
    foreach int i in 0 ..< chunks.length() {
        io:println(string `   Chunk ${i + 1}: ${chunks[i].length()} chars`);
    }
    
    // Analyze with multi-turn conversation
    io:println("\n🤖 Starting multi-turn analysis with Claude...");
    io:println("   → Sending complete diff (no filtering, no truncation)");
    AnalysisResult analysis = check analyzeWithAnthropicMultiTurn(chunks);
    
    // Output results
    io:println("\n" + repeatString("=", 60));
    io:println("📋 VERSION CHANGE ANALYSIS");
    io:println(repeatString("=", 60));
    io:println(string `
🔖 Version Bump: ${analysis.changeType}
✅ Confidence: ${analysis.confidence}

📝 Summary:
${analysis.summary}`);
    
    if analysis.breakingChanges.length() > 0 {
        io:println("\n⚠️  BREAKING CHANGES:");
        foreach string change in analysis.breakingChanges {
            io:println(string `  - ${change}`);
        }
    }
    
    if analysis.newFeatures.length() > 0 {
        io:println("\n✨ NEW FEATURES:");
        foreach string feature in analysis.newFeatures {
            io:println(string `  - ${feature}`);
        }
    }
    
    if analysis.bugFixes.length() > 0 {
        io:println("\n🐛 IMPROVEMENTS:");
        foreach string fix in analysis.bugFixes {
            io:println(string `  - ${fix}`);
        }
    }
    
    io:println("\n" + repeatString("=", 60));
    
    json resultJson = check analysis.cloneWithType(json);
    check io:fileWriteJson("analysis_result.json", resultJson);
    io:println("\n💾 Saved to: analysis_result.json");
}

function repeatString(string s, int n) returns string {
    string result = "";
    foreach int i in 0 ..< n {
        result = result + s;
    }
    return result;
}
