import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/lang.value;
import ballerina/os;
import ballerina/regex;

const string ANTHROPIC_API_URL = "https://api.anthropic.com/v1/messages";
const int MAX_RETRIES = 2;
const decimal RETRY_DELAY_SECONDS = 3.0;
// Max characters to send to API (~4 chars per token, limit to ~150K tokens worth)
const int MAX_DIFF_CHARS = 600000;

type AnalysisResult record {
    string changeType;
    string[] breakingChanges;
    string[] newFeatures;
    string[] bugFixes;
    string summary;
    decimal confidence;
};

type DiffSection record {
    string fileName;
    string content;
    int priority; // Higher = more important
};

function analyzeWithAnthropic(string gitDiff) returns AnalysisResult|error {
    string apiKey = os:getEnv("ANTHROPIC_API_KEY");
    
    if apiKey == "" {
        return error("ANTHROPIC_API_KEY environment variable is not set");
    }
    
    io:println(string `🔑 Using Anthropic API (${apiKey.length()} chars)`);
    
    string prompt = string `You are analyzing git diff output for a Ballerina connector to determine the semantic version change needed.

GIT DIFF:
${gitDiff}

RULES FOR VERSION CLASSIFICATION:
- MAJOR: Breaking changes (removed/renamed methods, removed/renamed types, changed method signatures, changed field types, removed fields)
- MINOR: Backward-compatible additions (new methods, new types, new optional fields)
- PATCH: Documentation changes, internal refactoring, bug fixes with no API surface changes

Analyze the diff and respond with ONLY a JSON object (no markdown, no explanation):
{
  "changeType": "MAJOR|MINOR|PATCH",
  "breakingChanges": ["list specific breaking changes"],
  "newFeatures": ["list new features/additions"],
  "bugFixes": ["list bug fixes or improvements"],
  "summary": "concise summary of changes",
  "confidence": 0.95
}`;

    http:Client anthropicClient = check new ("https://api.anthropic.com", {
        httpVersion: http:HTTP_1_1,
        timeout: 60
    });
    
    json payload = {
        "model": "claude-sonnet-4-20250514",
        "max_tokens": 1024,
        "temperature": 0.1,
        "messages": [{"role": "user", "content": prompt}]
    };
    
    http:Request req = new;
    req.setJsonPayload(payload);
    req.setHeader("anthropic-version", "2023-06-01");
    req.setHeader("x-api-key", apiKey);
    req.setHeader("content-type", "application/json");
    
    io:println("📤 Sending request to Anthropic API...");
    
    json response = {};
    int retryCount = 0;
    boolean success = false;
    
    while !success && retryCount < MAX_RETRIES {
        do {
            http:Response httpResponse = check anthropicClient->post("/v1/messages", req);
            int statusCode = httpResponse.statusCode;
            io:println(string `📥 Response status: ${statusCode}`);
            
            string textResult = check httpResponse.getTextPayload();
            
            if statusCode != 200 {
                io:println(string `⚠️ Response: ${textResult}`);
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
            
            response = check value:fromJsonString(textResult);
            
            // Check for API errors
            json|error errorCheck = response.'error;
            if errorCheck is json {
                string errorMsg = check errorCheck.message;
                return error(string `Anthropic API Error: ${errorMsg}`);
            }
            
            success = true;
            
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
    
    json contentJson = check response.content;
    json[] content = check contentJson.ensureType();
    string text = check content[0].text;
    
    io:println(string `🔍 Extracted text: ${text}`);
    
    text = regex:replaceAll(text.trim(), "```json|```", "");
    return check value:fromJsonStringWithType(text.trim());
}

public function main(string diffFilePath) returns error? {
    
    io:println("📊 Analyzing git diff...");
    io:println(string `📂 Reading diff from: ${diffFilePath}`);
    
    string gitDiffContent = check io:fileReadString(diffFilePath);
    io:println(string `📏 Original diff size: ${gitDiffContent.length()} chars`);
    
    if gitDiffContent.length() == 0 {
        return error("Git diff content is empty");
    }
    
    // Smart filtering of diff content
    string processedDiff = gitDiffContent;
    boolean wasTruncated = false;
    
    if gitDiffContent.length() > MAX_DIFF_CHARS {
        io:println(string `⚠️ Diff too large (${gitDiffContent.length()} chars), applying smart filtering...`);
        processedDiff = smartFilterDiff(gitDiffContent, MAX_DIFF_CHARS);
        wasTruncated = true;
        io:println(string `📏 Filtered diff size: ${processedDiff.length()} chars`);
    }
    
    io:println("🤖 Analyzing with Claude...");
    
    AnalysisResult analysis = check analyzeWithAnthropic(processedDiff);
    
    // Adjust confidence if diff was truncated
    if wasTruncated && analysis.confidence > 0.7d {
        decimal originalConfidence = analysis.confidence;
        analysis.confidence = analysis.confidence * 0.85; // Reduce confidence by 15%
        io:println(string `⚠️ Confidence adjusted from ${originalConfidence} to ${analysis.confidence} due to diff truncation`);
    }
    
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

// Smart filtering: prioritizes meaningful changes over noise
function smartFilterDiff(string diff, int maxChars) returns string {
    io:println("🔍 Applying smart diff filtering...");
    
    // Parse diff into sections by file
    DiffSection[] sections = parseDiffSections(diff);
    
    io:println(string `📑 Found ${sections.length()} diff sections`);
    
    // Sort by priority (higher priority first)
    sections = sortByPriority(sections);
    
    // Build optimized diff within size limit
    string result = "";
    int totalSize = 0;
    int includedSections = 0;
    
    foreach DiffSection section in sections {
        // Add header for this file
        string sectionHeader = string `\n--- ${section.fileName} ---\n`;
        string sectionContent = filterNoiseFromSection(section.content);
        
        int sectionSize = sectionHeader.length() + sectionContent.length();
        
        // Reserve space for summary footer
        int reservedSpace = 500;
        
        if totalSize + sectionSize + reservedSpace <= maxChars {
            result += sectionHeader + sectionContent;
            totalSize += sectionSize;
            includedSections += 1;
        } else {
            // Try to include partial content from high-priority sections
            int remainingSpace = maxChars - totalSize - reservedSpace - sectionHeader.length();
            if remainingSpace > 500 && section.priority >= 3 {
                string partialContent = extractMostImportantChanges(sectionContent, remainingSpace);
                result += sectionHeader + partialContent;
                totalSize += sectionHeader.length() + partialContent.length();
                includedSections += 1;
            }
            break;
        }
    }
    
    // Add summary footer
    string footer = string `

[FILTERING SUMMARY]
- Included ${includedSections}/${sections.length()} diff sections
- Prioritized: public APIs, type definitions, function signatures
- Filtered out: whitespace changes, comments, import reordering
- Total size: ${totalSize} chars (from original ${diff.length()} chars)
`;
    
    result += footer;
    io:println(string `✅ Included ${includedSections}/${sections.length()} sections`);
    
    return result;
}

// Parse diff into sections by file
function parseDiffSections(string diff) returns DiffSection[] {
    DiffSection[] sections = [];
    string[] lines = regex:split(diff, "\n");
    
    string currentFile = "";
    string currentContent = "";
    int currentPriority = 1;
    
    foreach string line in lines {
        // Check for file header: diff --git a/... b/...
        if line.startsWith("diff --git") {
            // Save previous section if exists
            if currentFile != "" {
                sections.push({
                    fileName: currentFile,
                    content: currentContent,
                    priority: currentPriority
                });
            }
            
            // Extract filename from: diff --git a/ballerina/client.bal b/ballerina/client.bal
            string[] parts = regex:split(line, " ");
            if parts.length() >= 4 {
                string filePath = parts[3]; // b/ballerina/client.bal
                currentFile = filePath.substring(2); // Remove "b/"
                currentPriority = calculatePriority(currentFile);
            }
            currentContent = line + "\n";
        } else {
            currentContent += line + "\n";
        }
    }
    
    // Add last section
    if currentFile != "" {
        sections.push({
            fileName: currentFile,
            content: currentContent,
            priority: currentPriority
        });
    }
    
    return sections;
}

// Calculate priority for a file (higher = more important)
function calculatePriority(string fileName) returns int {
    // client.bal contains public API methods - highest priority
    if fileName.includes("client.bal") {
        return 5;
    }
    // types.bal contains type definitions - high priority
    if fileName.includes("types.bal") {
        return 4;
    }
    // Other .bal files
    if fileName.endsWith(".bal") {
        return 2;
    }
    // Config files, docs, etc.
    return 1;
}

// Sort sections by priority (descending)
function sortByPriority(DiffSection[] sections) returns DiffSection[] {
    // Simple bubble sort (sufficient for small arrays)
    DiffSection[] sorted = sections.clone();
    int n = sorted.length();
    
    foreach int i in 0 ..< n {
        foreach int j in 0 ..< (n - i - 1) {
            if sorted[j].priority < sorted[j + 1].priority {
                // Swap
                DiffSection temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }
    
    return sorted;
}

// Filter out noise from a diff section
function filterNoiseFromSection(string content) returns string {
    string[] lines = regex:split(content, "\n");
    string[] filtered = [];
    
    foreach string line in lines {
        string trimmed = line.trim();
        
        // Keep structural lines (file headers, hunk markers)
        if line.startsWith("diff --git") || 
           line.startsWith("+++") || 
           line.startsWith("---") ||
           line.startsWith("@@") {
            filtered.push(line);
            continue;
        }
        
        // Skip pure whitespace changes
        if trimmed == "+" || trimmed == "-" {
            continue;
        }
        
        // Skip comment-only changes (basic detection)
        if (trimmed.startsWith("+#") || trimmed.startsWith("-#") ||
            trimmed.startsWith("+//") || trimmed.startsWith("-//")) {
            continue;
        }
        
        // Keep everything else (actual code changes)
        filtered.push(line);
    }
    
    return joinStrings(filtered, "\n");
}

// Extract most important changes from a section
function extractMostImportantChanges(string content, int maxChars) returns string {
    string[] lines = regex:split(content, "\n");
    string[] important = [];
    int totalChars = 0;
    
    // Priority keywords that indicate important changes
    string[] highPriorityKeywords = [
        "public function", "resource function", "remote function",
        "public type", "public record", "public enum",
        "returns", "isolated", "transactional"
    ];
    
    // First pass: collect lines with high-priority keywords
    foreach string line in lines {
        if totalChars >= maxChars {
            break;
        }
        
        string lower = line.toLowerAscii();
        boolean isImportant = false;
        
        // Check for structural markers
        if line.startsWith("@@") || line.startsWith("+++") || line.startsWith("---") {
            isImportant = true;
        } else {
            // Check for high-priority keywords
            foreach string keyword in highPriorityKeywords {
                if lower.includes(keyword.toLowerAscii()) {
                    isImportant = true;
                    break;
                }
            }
        }
        
        if isImportant {
            important.push(line);
            totalChars += line.length() + 1; // +1 for newline
        }
    }
    
    string result = joinStrings(important, "\n");
    
    // Add truncation notice if we didn't include everything
    if totalChars >= maxChars {
        result += "\n... [Additional changes truncated] ...\n";
    }
    
    return result;
}

// Helper function to join strings
function joinStrings(string[] arr, string separator) returns string {
    string result = "";
    foreach int i in 0 ..< arr.length() {
        if i > 0 {
            result += separator;
        }
        result += arr[i];
    }
    return result;
}