// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/data.jsondata;
import ballerina/http;

# Request payload for updating conference participant settings and behavior
public type UpdateParticipantRequest record {
    # The SID of the participant who is being `coached`. The participant being coached is the only participant who can hear the participant who is `coaching`
    @jsondata:Name {value: "CallSidToCoach"}
    string callSidToCoach?;
    # The HTTP method we should use to call `announce_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "AnnounceMethod"}
    "GET"|"POST" announceMethod?;
    # Whether the participant is coaching another call. Can be: `true` or `false`. If not present, defaults to `false` unless `call_sid_to_coach` is defined. If `true`, `call_sid_to_coach` must be defined
    @jsondata:Name {value: "Coaching"}
    boolean coaching?;
    # Whether to play a notification beep to the conference when the participant exits. Can be: `true` or `false`
    @jsondata:Name {value: "BeepOnExit"}
    boolean beepOnExit?;
    # The HTTP method we should use to call `wait_url`. Can be `GET` or `POST` and the default is `POST`. When using a static audio file, this should be `GET` so that we can cache the file
    @jsondata:Name {value: "WaitMethod"}
    "GET"|"POST" waitMethod?;
    # Whether to end the conference when the participant leaves. Can be: `true` or `false` and defaults to `false`
    @jsondata:Name {value: "EndConferenceOnExit"}
    boolean endConferenceOnExit?;
    # The URL we call using the `hold_method` for music that plays when the participant is on hold. The URL may return an MP3 file, a WAV file, or a TwiML document that contains `<Play>`, `<Say>`, `<Pause>`, or `<Redirect>` verbs
    @jsondata:Name {value: "HoldUrl"}
    string holdUrl?;
    # The URL that Twilio calls using the `wait_method` before the conference has started. The URL may return an MP3 file, a WAV file, or a TwiML document. The default value is the URL of our standard hold music. If you do not want anything to play while waiting for the conference to start, specify an empty string by setting `wait_url` to `''`. For more details on the allowable verbs within the `waitUrl`, see the `waitUrl` attribute in the [<Conference> TwiML instruction](https://www.twilio.com/docs/voice/twiml/conference#attributes-waiturl)
    @jsondata:Name {value: "WaitUrl"}
    string waitUrl?;
    # The HTTP method we should use to call `hold_url`. Can be: `GET` or `POST` and the default is `GET`
    @jsondata:Name {value: "HoldMethod"}
    "GET"|"POST" holdMethod?;
    # The URL we call using the `announce_method` for an announcement to the participant. The URL may return an MP3 file, a WAV file, or a TwiML document that contains `<Play>`, `<Say>`, `<Pause>`, or `<Redirect>` verbs
    @jsondata:Name {value: "AnnounceUrl"}
    string announceUrl?;
    # Whether the participant should be on hold. Can be: `true` or `false`. `true` puts the participant on hold, and `false` lets them rejoin the conference
    @jsondata:Name {value: "Hold"}
    boolean hold?;
    # Whether the participant should be muted. Can be `true` or `false`. `true` will mute the participant, and `false` will un-mute them. Anything value other than `true` or `false` is interpreted as `false`
    @jsondata:Name {value: "Muted"}
    boolean muted?;
};

# Represents the Queries record for the operation: listSipCredentialList
public type ListSipCredentialListQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Transcription resource containing text content and metadata from recordings
public type ApiV2010AccountTranscription record {
    # The text content of the transcription
    @jsondata:Name {value: "transcription_text"}
    string? transcriptionText?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) from which the transcription was created
    @jsondata:Name {value: "recording_sid"}
    string? recordingSid?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The API version used to create the transcription
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The transcription type. Can only be: `fast`
    string? 'type?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Transcription resource
    string? sid?;
    # The duration of the transcribed audio in seconds
    string? duration?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format (e.g. `usd`, `eur`, `jpy`)
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The charge for the transcript in the currency associated with the account. This value is populated after the transcript is complete so it may not be available immediately
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The status of the transcription. Can be: `in-progress`, `completed`, `failed`
    TranscriptionEnumStatus status?;
};

# The status of this call. Can be: `queued`, `ringing`, `in-progress`, `canceled`, `completed`, `failed`, `busy` or `no-answer`. See [Call Status Values](https://www.twilio.com/docs/voice/api/call-resource#call-status-values) below for more information
public type CallEnumStatus "queued"|"ringing"|"in-progress"|"completed"|"busy"|"failed"|"no-answer"|"canceled";

# Paginated response containing conference recordings and navigation metadata
public type ListConferenceRecordingResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of conference recording resources
    ApiV2010AccountConferenceConferenceRecording[] recordings?;
    # Starting index of results in current page
    int 'start?;
    # Ending index of results in current page
    int end?;
    # URI to the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Yearly usage record containing aggregated account usage metrics and costs
public type ApiV2010AccountUsageUsageRecordUsageRecordYearly record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# Represents the Queries record for the operation: listAvailablePhoneNumberNational
public type ListAvailablePhoneNumberNationalQueries record {
    # Whether the phone numbers can receive calls. Can be: `true` or `false`
    @http:Query {name: "VoiceEnabled"}
    boolean voiceEnabled?;
    # Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeForeignAddressRequired"}
    boolean excludeForeignAddressRequired?;
    # Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InPostalCode"}
    string inPostalCode?;
    # Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InLata"}
    string inLata?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether the phone numbers can receive MMS messages. Can be: `true` or `false`
    @http:Query {name: "MmsEnabled"}
    boolean mmsEnabled?;
    # Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearNumber"}
    string nearNumber?;
    # Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRegion"}
    string inRegion?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # Whether the phone numbers can receive text messages. Can be: `true` or `false`
    @http:Query {name: "SmsEnabled"}
    boolean smsEnabled?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRateCenter"}
    string inRateCenter?;
    # Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
    # Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearLatLong"}
    string nearLatLong?;
    # Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeLocalAddressRequired"}
    boolean excludeLocalAddressRequired?;
    # Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number
    @http:Query {name: "InLocality"}
    string inLocality?;
    # Matching pattern to identify phone numbers. This pattern can be between 2 and 16 characters long and allows all digits (0-9) and all non-diacritic latin alphabet letters (a-z, A-Z). It accepts four meta-characters: `*`, `%`, `+`, `$`. The `*` and `%` meta-characters can appear multiple times in the pattern. To match wildcards at the beginning or end of the pattern, use `*` to match any single character or `%` to match a sequence of characters. If you use the wildcard patterns, it must include at least two non-meta-characters, and wildcards cannot be used between non-meta-characters. To match the beginning of a pattern, start the pattern with `+`. To match the end of the pattern, append the pattern with `$`. These meta-characters can't be adjacent to each other
    @http:Query {name: "Contains"}
    string contains?;
    # The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada
    @http:Query {name: "AreaCode"}
    int areaCode?;
    # Whether the phone numbers can receive faxes. Can be: `true` or `false`
    @http:Query {name: "FaxEnabled"}
    boolean faxEnabled?;
    # The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada
    @http:Query {name: "Distance"}
    int distance?;
    # Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeAllAddressRequired"}
    boolean excludeAllAddressRequired?;
};

# Paginated response containing applications and navigation metadata
public type ListApplicationResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of results in current page
    int 'start?;
    # Ending index of results in current page
    int end?;
    # URI to the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated response
    int page?;
    # URI of the current resource
    string uri?;
    # Array of application resources in the current page
    ApiV2010AccountApplication[] applications?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response containing paginated list of local incoming phone numbers
public type ListIncomingPhoneNumberLocalResponse record {
    # URI of the first page in the result set
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Zero-based index of the first item in this page
    int 'start?;
    # Zero-based index of the last item in this page
    int end?;
    # URI of the next page, null if this is the last page
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI of the previous page, null if this is the first page
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated response
    int page?;
    # Array of local incoming phone number resources
    @jsondata:Name {value: "incoming_phone_numbers"}
    ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberLocal[] incomingPhoneNumbers?;
    # URI of the current resource
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# SIP IP access control list resource for managing allowed IP addresses
public type ApiV2010AccountSipSipIpAccessControlList record {
    # A list of the IpAddress resources associated with this IP access control list resource
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # A human readable descriptive text, up to 255 characters long
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date that this resource was last updated, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date that this resource was created, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) that owns this resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI for this resource, relative to `https://api.twilio.com`
    string? uri?;
    # A 34 character string that uniquely identifies this resource
    string? sid?;
};

# Request to create a SIPREC recording with configurable parameters
public type CreateSiprecRequest record {
    # Parameter value
    @jsondata:Name {value: "Parameter87.Value"}
    string parameter87Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter47.Value"}
    string parameter47Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter67.Value"}
    string parameter67Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter27.Name"}
    string parameter27Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter44.Name"}
    string parameter44Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter54.Value"}
    string parameter54Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter74.Value"}
    string parameter74Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter89.Name"}
    string parameter89Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter27.Value"}
    string parameter27Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter34.Value"}
    string parameter34Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter94.Value"}
    string parameter94Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter13.Name"}
    string parameter13Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter14.Value"}
    string parameter14Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter90.Name"}
    string parameter90Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter58.Name"}
    string parameter58Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter42.Name"}
    string parameter42Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter56.Name"}
    string parameter56Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter5.Value"}
    string parameter5Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter15.Name"}
    string parameter15Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter61.Name"}
    string parameter61Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter75.Name"}
    string parameter75Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter29.Name"}
    string parameter29Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter42.Value"}
    string parameter42Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter63.Name"}
    string parameter63Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter19.Value"}
    string parameter19Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter59.Value"}
    string parameter59Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter80.Name"}
    string parameter80Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter7.Name"}
    string parameter7Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter82.Value"}
    string parameter82Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter75.Value"}
    string parameter75Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter2.Name"}
    string parameter2Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter54.Name"}
    string parameter54Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter85.Name"}
    string parameter85Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter99.Value"}
    string parameter99Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter32.Name"}
    string parameter32Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter13.Value"}
    string parameter13Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter73.Name"}
    string parameter73Name?;
    # Absolute URL of the status callback
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # Parameter value
    @jsondata:Name {value: "Parameter41.Value"}
    string parameter41Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter81.Value"}
    string parameter81Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter25.Name"}
    string parameter25Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter93.Value"}
    string parameter93Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter6.Value"}
    string parameter6Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter88.Value"}
    string parameter88Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter92.Name"}
    string parameter92Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter79.Name"}
    string parameter79Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter53.Value"}
    string parameter53Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter48.Value"}
    string parameter48Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter70.Value"}
    string parameter70Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter52.Name"}
    string parameter52Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter97.Name"}
    string parameter97Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter80.Value"}
    string parameter80Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter19.Name"}
    string parameter19Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter49.Name"}
    string parameter49Name?;
    # The user-specified name of this Siprec, if one was given when the Siprec was created. This may be used to stop the Siprec
    @jsondata:Name {value: "Name"}
    string name?;
    # Parameter name
    @jsondata:Name {value: "Parameter96.Name"}
    string parameter96Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter51.Name"}
    string parameter51Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter5.Name"}
    string parameter5Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter82.Name"}
    string parameter82Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter48.Name"}
    string parameter48Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter23.Value"}
    string parameter23Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter15.Value"}
    string parameter15Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter66.Value"}
    string parameter66Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter67.Name"}
    string parameter67Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter1.Value"}
    string parameter1Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter46.Value"}
    string parameter46Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter78.Name"}
    string parameter78Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter20.Value"}
    string parameter20Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter23.Name"}
    string parameter23Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter53.Name"}
    string parameter53Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter43.Value"}
    string parameter43Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter34.Name"}
    string parameter34Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter98.Value"}
    string parameter98Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter18.Value"}
    string parameter18Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter38.Value"}
    string parameter38Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter24.Name"}
    string parameter24Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter22.Value"}
    string parameter22Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter39.Value"}
    string parameter39Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter72.Value"}
    string parameter72Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter95.Value"}
    string parameter95Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter16.Value"}
    string parameter16Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter33.Name"}
    string parameter33Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter39.Name"}
    string parameter39Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter4.Value"}
    string parameter4Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter69.Value"}
    string parameter69Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter71.Name"}
    string parameter71Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter77.Name"}
    string parameter77Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter87.Name"}
    string parameter87Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter96.Value"}
    string parameter96Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter6.Name"}
    string parameter6Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter81.Name"}
    string parameter81Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter62.Name"}
    string parameter62Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter14.Name"}
    string parameter14Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter21.Value"}
    string parameter21Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter45.Value"}
    string parameter45Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter68.Name"}
    string parameter68Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter50.Value"}
    string parameter50Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter68.Value"}
    string parameter68Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter73.Value"}
    string parameter73Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter3.Value"}
    string parameter3Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter2.Value"}
    string parameter2Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter77.Value"}
    string parameter77Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter91.Name"}
    string parameter91Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter57.Value"}
    string parameter57Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter60.Name"}
    string parameter60Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter97.Value"}
    string parameter97Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter64.Value"}
    string parameter64Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter84.Value"}
    string parameter84Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter17.Value"}
    string parameter17Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter43.Name"}
    string parameter43Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter88.Name"}
    string parameter88Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter37.Value"}
    string parameter37Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter24.Value"}
    string parameter24Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter44.Value"}
    string parameter44Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter74.Name"}
    string parameter74Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter8.Value"}
    string parameter8Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter45.Name"}
    string parameter45Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter71.Value"}
    string parameter71Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter59.Name"}
    string parameter59Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter31.Name"}
    string parameter31Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter31.Value"}
    string parameter31Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter11.Value"}
    string parameter11Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter51.Value"}
    string parameter51Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter91.Value"}
    string parameter91Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter12.Name"}
    string parameter12Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter72.Name"}
    string parameter72Name?;
    # Unique name used when configuring the connector via Marketplace Add-on
    @jsondata:Name {value: "ConnectorName"}
    string connectorName?;
    # Parameter name
    @jsondata:Name {value: "Parameter26.Name"}
    string parameter26Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter10.Name"}
    string parameter10Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter52.Value"}
    string parameter52Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter69.Name"}
    string parameter69Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter49.Value"}
    string parameter49Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter41.Name"}
    string parameter41Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter12.Value"}
    string parameter12Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter38.Name"}
    string parameter38Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter86.Name"}
    string parameter86Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter8.Name"}
    string parameter8Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter47.Name"}
    string parameter47Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter92.Value"}
    string parameter92Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter1.Name"}
    string parameter1Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter89.Value"}
    string parameter89Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter16.Name"}
    string parameter16Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter7.Value"}
    string parameter7Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter76.Name"}
    string parameter76Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter28.Name"}
    string parameter28Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter36.Value"}
    string parameter36Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter76.Value"}
    string parameter76Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter70.Name"}
    string parameter70Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter57.Name"}
    string parameter57Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter22.Name"}
    string parameter22Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter65.Value"}
    string parameter65Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter25.Value"}
    string parameter25Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter30.Value"}
    string parameter30Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter95.Name"}
    string parameter95Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter98.Name"}
    string parameter98Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter66.Name"}
    string parameter66Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter90.Value"}
    string parameter90Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter35.Name"}
    string parameter35Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter60.Value"}
    string parameter60Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter4.Name"}
    string parameter4Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter9.Value"}
    string parameter9Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter83.Name"}
    string parameter83Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter36.Name"}
    string parameter36Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter21.Name"}
    string parameter21Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter86.Value"}
    string parameter86Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter20.Name"}
    string parameter20Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter26.Value"}
    string parameter26Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter55.Value"}
    string parameter55Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter83.Value"}
    string parameter83Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter18.Name"}
    string parameter18Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter64.Name"}
    string parameter64Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter35.Value"}
    string parameter35Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter40.Value"}
    string parameter40Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter50.Name"}
    string parameter50Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter63.Value"}
    string parameter63Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter37.Name"}
    string parameter37Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter58.Value"}
    string parameter58Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter78.Value"}
    string parameter78Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter29.Value"}
    string parameter29Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter32.Value"}
    string parameter32Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter62.Value"}
    string parameter62Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter55.Name"}
    string parameter55Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter85.Value"}
    string parameter85Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter94.Name"}
    string parameter94Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter46.Name"}
    string parameter46Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter99.Name"}
    string parameter99Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter40.Name"}
    string parameter40Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter93.Name"}
    string parameter93Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter79.Value"}
    string parameter79Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter61.Value"}
    string parameter61Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter33.Value"}
    string parameter33Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter9.Name"}
    string parameter9Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter84.Name"}
    string parameter84Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter56.Value"}
    string parameter56Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter65.Name"}
    string parameter65Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter17.Name"}
    string parameter17Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter10.Value"}
    string parameter10Value?;
    # The http method for the status_callback (one of GET, POST)
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # Parameter name
    @jsondata:Name {value: "Parameter30.Name"}
    string parameter30Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter11.Name"}
    string parameter11Name?;
    # Audio track configuration for the SIPREC recording
    @jsondata:Name {value: "Track"}
    SiprecEnumTrack track?;
    # Parameter name
    @jsondata:Name {value: "Parameter3.Name"}
    string parameter3Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter28.Value"}
    string parameter28Value?;
};

# Connect App resource for third-party application integration
public type ApiV2010AccountConnectApp record {
    # The URL we call using the `deauthorize_callback_method` to de-authorize the Connect App
    @jsondata:Name {value: "deauthorize_callback_url"}
    string? deauthorizeCallbackUrl?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The HTTP method we use to call `deauthorize_callback_url`
    @jsondata:Name {value: "deauthorize_callback_method"}
    "GET"|"POST"? deauthorizeCallbackMethod?;
    # The set of permissions that your ConnectApp requests
    ConnectAppEnumPermission[]? permissions?;
    # The company name set for the Connect App
    @jsondata:Name {value: "company_name"}
    string? companyName?;
    # The public URL where users can obtain more information about this Connect App
    @jsondata:Name {value: "homepage_url"}
    string? homepageUrl?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ConnectApp resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The description of the Connect App
    string? description?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The URL we redirect the user to after we authenticate the user and obtain authorization to access the Connect App
    @jsondata:Name {value: "authorize_redirect_url"}
    string? authorizeRedirectUrl?;
    # The unique string that that we created to identify the ConnectApp resource
    string? sid?;
};

# Conference recording resource containing recording details and metadata
public type ApiV2010AccountConferenceConferenceRecording record {
    # The date and time in GMT that the resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # How to decrypt the recording if it was encrypted using [Call Recording Encryption](https://www.twilio.com/docs/voice/tutorials/voice-recording-encryption) feature
    @jsondata:Name {value: "encryption_details"}
    anydata? encryptionDetails?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The Conference SID that identifies the conference associated with the recording
    @jsondata:Name {value: "conference_sid"}
    string? conferenceSid?;
    # How the recording was created. Can be: `DialVerb`, `Conference`, `OutboundAPI`, `Trunking`, `RecordVerb`, `StartCallRecordingAPI`, `StartConferenceRecordingAPI`
    ConferenceRecordingEnumSource 'source?;
    # The API version used to create the recording
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Conference Recording resource
    string? sid?;
    # The length of the recording in seconds
    string? duration?;
    # The currency used in the `price` property. Example: `USD`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The start time of the recording in GMT and in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "start_time"}
    string? startTime?;
    # The number of channels in the final recording file.  Can be: `1`, or `2`. Separating a two leg call into two separate channels of the recording file is supported in [Dial](https://www.twilio.com/docs/voice/twiml/dial#attributes-record) and [Outbound Rest API](https://www.twilio.com/docs/voice/make-calls) record options
    int channels = 0;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Conference Recording resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The one-time cost of creating the recording in the `price_unit` currency
    string? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Conference Recording resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The error code that describes why the recording is `absent`. The error code is described in our [Error Dictionary](https://www.twilio.com/docs/api/errors). This value is null if the recording `status` is not `absent`
    @jsondata:Name {value: "error_code"}
    int? errorCode?;
    # The status of the recording. Can be: `processing`, `completed` and `absent`. For more detailed statuses on in-progress recordings, check out how to [Update a Recording Resource](https://www.twilio.com/docs/voice/api/recording#update-a-recording-resource)
    ConferenceRecordingEnumStatus status?;
};

# Response containing paginated list of message resources
public type ListMessageResponse record {
    # URI of the first page in the result set
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the first message in the current page
    int 'start?;
    # Array of message objects returned in the response
    ApiV2010AccountMessage[] messages?;
    # Ending index of the last message in the current page
    int end?;
    # URI for the next page of results, null if no more pages
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, null if first page
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Number of messages returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request to purchase and configure a new toll-free phone number
public type CreateIncomingPhoneNumberTollFreeRequest record {
    # The HTTP method that we should use to call `sms_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsFallbackMethod"}
    "GET"|"POST" smsFallbackMethod?;
    # The API version to use for incoming calls made to the new phone number. The default is `2010-04-01`
    @jsondata:Name {value: "ApiVersion"}
    string apiVersion?;
    # The URL we should call when the new phone number receives an incoming SMS message
    @jsondata:Name {value: "SmsUrl"}
    string smsUrl?;
    # The SID of the application we should use to handle calls to the new phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "VoiceApplicationSid"}
    string voiceApplicationSid?;
    # The HTTP method that we should use to call `voice_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # A descriptive string that you created to describe the new phone number. It can be up to 64 characters long. By default, this is a formatted version of the phone number
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether to lookup the caller's name from the CNAM database and post it to your app. Can be: `true` or `false` and defaults to `false`
    @jsondata:Name {value: "VoiceCallerIdLookup"}
    boolean voiceCallerIdLookup?;
    # The URL we should call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The SID of the Trunk we should use to handle calls to the new phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use only those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "TrunkSid"}
    string trunkSid?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "BundleSid"}
    string bundleSid?;
    # The SID of the emergency address configuration to use for emergency calling from the new phone number
    @jsondata:Name {value: "EmergencyAddressSid"}
    string emergencyAddressSid?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # The SID of the Identity resource that we should associate with the new phone number. Some regions require an Identity to meet local regulations
    @jsondata:Name {value: "IdentitySid"}
    string identitySid?;
    # The URL that we should call when an error occurs while requesting or executing the TwiML defined by `sms_url`
    @jsondata:Name {value: "SmsFallbackUrl"}
    string smsFallbackUrl?;
    # The HTTP method that we should use to call `voice_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # Mode for receiving voice calls on the toll-free number
    @jsondata:Name {value: "VoiceReceiveMode"}
    IncomingPhoneNumberTollFreeEnumVoiceReceiveMode voiceReceiveMode?;
    # The phone number to purchase specified in [E.164](https://www.twilio.com/docs/glossary/what-e164) format.  E.164 phone numbers consist of a + followed by the country code and subscriber number without punctuation characters. For example, +14155551234
    @jsondata:Name {value: "PhoneNumber"}
    string phoneNumber;
    # The SID of the application that should handle SMS messages sent to the new phone number. If an `sms_application_sid` is present, we ignore all `sms_*_url` values and use those of the application
    @jsondata:Name {value: "SmsApplicationSid"}
    string smsApplicationSid?;
    # The URL that we should call to answer a call to the new phone number. The `voice_url` will not be called if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The SID of the Address resource we should associate with the new phone number. Some regions require addresses to meet local regulations
    @jsondata:Name {value: "AddressSid"}
    string addressSid?;
    # The HTTP method that we should use to call `sms_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsMethod"}
    "GET"|"POST" smsMethod?;
    # Emergency calling status for the toll-free number
    @jsondata:Name {value: "EmergencyStatus"}
    IncomingPhoneNumberTollFreeEnumEmergencyStatus emergencyStatus?;
    # The URL that we should call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# Incoming phone number resource with configuration and capabilities
public type ApiV2010AccountIncomingPhoneNumber record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the Trunk that handles calls to the phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "trunk_sid"}
    string? trunkSid?;
    # The HTTP method we use to call `status_callback`. Can be: `GET` or `POST`
    @jsondata:Name {value: "status_callback_method"}
    "GET"|"POST"? statusCallbackMethod?;
    # The phone number's origin. `twilio` identifies Twilio-owned phone numbers and `hosted` identifies hosted phone numbers
    string? origin?;
    # The HTTP method we use to call `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_fallback_method"}
    "GET"|"POST"? smsFallbackMethod?;
    # Status of the emergency address configuration for the phone number
    @jsondata:Name {value: "emergency_address_status"}
    IncomingPhoneNumberEnumEmergencyAddressStatus emergencyAddressStatus?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "bundle_sid"}
    string? bundleSid?;
    # The unique string that that we created to identify this IncomingPhoneNumber resource
    string? sid?;
    # The URL that we call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "voice_fallback_url"}
    string? voiceFallbackUrl?;
    # The URL that we call when an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "sms_fallback_url"}
    string? smsFallbackUrl?;
    # Emergency calling capability status for the phone number
    @jsondata:Name {value: "emergency_status"}
    IncomingPhoneNumberEnumEmergencyStatus emergencyStatus?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this IncomingPhoneNumber resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # Mode for receiving voice calls on this phone number
    @jsondata:Name {value: "voice_receive_mode"}
    IncomingPhoneNumberEnumVoiceReceiveMode voiceReceiveMode?;
    # The SID of the Identity resource that we associate with the phone number. Some regions require an Identity to meet local regulations
    @jsondata:Name {value: "identity_sid"}
    string? identitySid?;
    # The SID of the application that handles calls to the phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "voice_application_sid"}
    string? voiceApplicationSid?;
    # The HTTP method we use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_method"}
    "GET"|"POST"? voiceMethod?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are  `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountincomingPhoneNumberCapabilities? capabilities?;
    # The URL we call when the phone number receives a call. The `voice_url` will not be used if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "voice_url"}
    string? voiceUrl?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL we call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "sms_url"}
    string? smsUrl?;
    # Address verification requirements for this phone number
    @jsondata:Name {value: "address_requirements"}
    IncomingPhoneNumberEnumAddressRequirement addressRequirements?;
    # The HTTP method we use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_fallback_method"}
    "GET"|"POST"? voiceFallbackMethod?;
    # The URL we call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "status_callback"}
    string? statusCallback?;
    # The API version used to start a new TwiML session
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID of the Address resource associated with the phone number
    @jsondata:Name {value: "address_sid"}
    string? addressSid?;
    # Whether we look up the caller's caller-ID name from the CNAM database ($0.01 per look up). Can be: `true` or `false`
    @jsondata:Name {value: "voice_caller_id_lookup"}
    boolean? voiceCallerIdLookup?;
    # The HTTP method we use to call `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_method"}
    "GET"|"POST"? smsMethod?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The SID of the application that handles SMS messages sent to the phone number. If an `sms_application_sid` is present, we ignore all `sms_*_url` values and use those of the application
    @jsondata:Name {value: "sms_application_sid"}
    string? smsApplicationSid?;
    # The SID of the emergency address configuration that we use for emergency calling from this phone number
    @jsondata:Name {value: "emergency_address_sid"}
    string? emergencyAddressSid?;
    # Current status of the incoming phone number
    string? status?;
};

# Request to update an API key's properties
public type UpdateKeyRequest record {
    # A descriptive string that you create to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
};

# Message resource containing SMS/MMS message details and metadata
public type ApiV2010AccountMessage record {
    # The description of the `error_code` if the Message `status` is `failed` or `undelivered`. If no error was encountered, the value is `null`. The value returned in this field for a specific error cause is subject to change as Twilio improves errors. Users should not use the `error_code` and `error_message` fields programmatically
    @jsondata:Name {value: "error_message"}
    string? errorMessage?;
    # A list of related resources identified by their URIs relative to `https://api.twilio.com`
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The [RFC 2822](https://datatracker.ietf.org/doc/html/rfc2822#section-3.3) timestamp (in GMT) of when the Message resource was last updated
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The [RFC 2822](https://datatracker.ietf.org/doc/html/rfc2822#section-3.3) timestamp (in GMT) of when the Message was sent. For an outgoing message, this is when Twilio sent the message. For an incoming message, this is when Twilio sent the HTTP request to your incoming message webhook URL
    @jsondata:Name {value: "date_sent"}
    string? dateSent?;
    # The [RFC 2822](https://datatracker.ietf.org/doc/html/rfc2822#section-3.3) timestamp (in GMT) of when the Message resource was created
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The text content of the message
    string? body?;
    # The API version used to process the Message
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The number of segments that make up the complete message. SMS message bodies that exceed the [character limit](https://www.twilio.com/docs/glossary/what-sms-character-limit) are segmented and charged as multiple messages. Note: For messages sent via a Messaging Service, `num_segments` is initially `0`, since a sender hasn't yet been assigned
    @jsondata:Name {value: "num_segments"}
    string? numSegments?;
    # The URI of the Message resource, relative to `https://api.twilio.com`
    string? uri?;
    # The number of media files associated with the Message resource
    @jsondata:Name {value: "num_media"}
    string? numMedia?;
    # The unique, Twilio-provided string that identifies the Message resource
    string? sid?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format (e.g. `usd`, `eur`, `jpy`)
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The SID of the [Messaging Service](https://www.twilio.com/docs/messaging/api/service-resource) associated with the Message resource. A unique default value is assigned if a Messaging Service is not used
    @jsondata:Name {value: "messaging_service_sid"}
    string? messagingServiceSid?;
    # The amount billed for the message in the currency specified by `price_unit`. The `price` is populated after the message has been sent/received, and may not be immediately availalble. View the [Pricing page](https://www.twilio.com/en-us/pricing) for more details
    string? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The sender's phone number (in [E.164](https://en.wikipedia.org/wiki/E.164) format), [alphanumeric sender ID](https://www.twilio.com/docs/sms/quickstart), [Wireless SIM](https://www.twilio.com/docs/iot/wireless/programmable-wireless-send-machine-machine-sms-commands), [short code](https://www.twilio.com/en-us/messaging/channels/sms/short-codes), or  [channel address](https://www.twilio.com/docs/messaging/channels) (e.g., `whatsapp:+15554449999`). For incoming messages, this is the number or channel address of the sender. For outgoing messages, this value is a Twilio phone number, alphanumeric sender ID, short code, or channel address from which the message is sent
    string? 'from?;
    # The [error code](https://www.twilio.com/docs/api/errors) returned if the Message `status` is `failed` or `undelivered`. If no error was encountered, the value is `null`. The value returned in this field for a specific error cause is subject to change as Twilio improves errors. Users should not use the `error_code` and `error_message` fields programmatically
    @jsondata:Name {value: "error_code"}
    int? errorCode?;
    # The recipient's phone number (in [E.164](https://en.wikipedia.org/wiki/E.164) format) or [channel address](https://www.twilio.com/docs/messaging/channels) (e.g. `whatsapp:+15552229999`)
    string? to?;
    # The direction of the message. Can be: `inbound` for incoming messages, `outbound-api` for messages created by the REST API, `outbound-call` for messages created during a call, or `outbound-reply` for messages created in response to an incoming message
    MessageEnumDirection direction?;
    # The status of the Message. Possible values: `accepted`, `scheduled`, `canceled`, `queued`, `sending`, `sent`, `failed`, `delivered`, `undelivered`, `receiving`, `received`, or `read` (WhatsApp only). For more information, See [detailed descriptions](https://www.twilio.com/docs/sms/api/message-resource#message-status-values)
    MessageEnumStatus status?;
};

# Newly created API key resource with authentication credentials
public type ApiV2010AccountNewKey record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the new API Key was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the API Key was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The secret your application uses to sign Access Tokens and to authenticate to the REST API (you will use this as the basic-auth `password`).  **Note that for security reasons, this field is ONLY returned when the API Key is first created.**
    string? secret?;
    # The unique string that that we created to identify the NewKey resource. You will use this as the basic-auth `user` when authenticating to the API
    string? sid?;
};

# Paginated response containing recording add-on result payloads
public type ListRecordingAddOnResultPayloadResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of recording add-on result payload objects
    ApiV2010AccountRecordingRecordingAddOnResultRecordingAddOnResultPayload[] payloads?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI of the current page resource
    string uri?;
    # Number of items per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Short code resource for SMS messaging with configuration details
public type ApiV2010AccountShortCode record {
    # A string that you assigned to describe this resource. By default, the `FriendlyName` is the short code
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that this resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that this resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL that we call if an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "sms_fallback_url"}
    string? smsFallbackUrl?;
    # The URL we call when receiving an incoming SMS message to this short code
    @jsondata:Name {value: "sms_url"}
    string? smsUrl?;
    # The HTTP method we use to call the `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_fallback_method"}
    "GET"|"POST"? smsFallbackMethod?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this ShortCode resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The HTTP method we use to call the `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_method"}
    "GET"|"POST"? smsMethod?;
    # The API version used to start a new TwiML session when an SMS message is sent to this short code
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of this resource, relative to `https://api.twilio.com`
    string? uri?;
    # The short code. e.g., 894546
    @jsondata:Name {value: "short_code"}
    string? shortCode?;
    # The unique string that that we created to identify this ShortCode resource
    string? sid?;
};

# Represents the Queries record for the operation: listShortCode
public type ListShortCodeQueries record {
    # Only show the ShortCode resources that match this pattern. You can specify partial numbers and use '*' as a wildcard for any digit
    @http:Query {name: "ShortCode"}
    string shortCode?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The string that identifies the ShortCode resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Paginated response containing Connect App resources
public type ListConnectAppResponse record {
    # URI for the first page of Connect App results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Array of Connect App resources returned in the response
    @jsondata:Name {value: "connect_apps"}
    ApiV2010AccountConnectApp[] connectApps?;
    # The end index of the current page of results
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of the current page of results
    string uri?;
    # The number of results per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Enumeration of valid message update status values
public type MessageEnumUpdateStatus "canceled";

# The status of the Message. Possible values: `accepted`, `scheduled`, `canceled`, `queued`, `sending`, `sent`, `failed`, `delivered`, `undelivered`, `receiving`, `received`, or `read` (WhatsApp only). For more information, See [detailed descriptions](https://www.twilio.com/docs/sms/api/message-resource#message-status-values)
public type MessageEnumStatus "queued"|"sending"|"sent"|"failed"|"delivered"|"undelivered"|"receiving"|"received"|"accepted"|"scheduled"|"read"|"partially_delivered"|"canceled";

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:CredentialsConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 30;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects followRedirects?;
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with cookies
    http:CookieConfig cookieConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Provides settings related to client socket configuration
    http:ClientSocketConfig socketConfig = {};
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};

# The frequency of a recurring UsageTrigger.  Can be: `daily`, `monthly`, or `yearly` for recurring triggers or empty for non-recurring triggers. A trigger will only fire once during each period. Recurring times are in GMT
public type UsageTriggerEnumRecurring "daily"|"monthly"|"yearly"|"alltime";

# Represents the Queries record for the operation: listAvailablePhoneNumberSharedCost
public type ListAvailablePhoneNumberSharedCostQueries record {
    # Whether the phone numbers can receive calls. Can be: `true` or `false`
    @http:Query {name: "VoiceEnabled"}
    boolean voiceEnabled?;
    # Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeForeignAddressRequired"}
    boolean excludeForeignAddressRequired?;
    # Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InPostalCode"}
    string inPostalCode?;
    # Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InLata"}
    string inLata?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether the phone numbers can receive MMS messages. Can be: `true` or `false`
    @http:Query {name: "MmsEnabled"}
    boolean mmsEnabled?;
    # Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearNumber"}
    string nearNumber?;
    # Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRegion"}
    string inRegion?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # Whether the phone numbers can receive text messages. Can be: `true` or `false`
    @http:Query {name: "SmsEnabled"}
    boolean smsEnabled?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRateCenter"}
    string inRateCenter?;
    # Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
    # Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearLatLong"}
    string nearLatLong?;
    # Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeLocalAddressRequired"}
    boolean excludeLocalAddressRequired?;
    # Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number
    @http:Query {name: "InLocality"}
    string inLocality?;
    # Matching pattern to identify phone numbers. This pattern can be between 2 and 16 characters long and allows all digits (0-9) and all non-diacritic latin alphabet letters (a-z, A-Z). It accepts four meta-characters: `*`, `%`, `+`, `$`. The `*` and `%` meta-characters can appear multiple times in the pattern. To match wildcards at the beginning or end of the pattern, use `*` to match any single character or `%` to match a sequence of characters. If you use the wildcard patterns, it must include at least two non-meta-characters, and wildcards cannot be used between non-meta-characters. To match the beginning of a pattern, start the pattern with `+`. To match the end of the pattern, append the pattern with `$`. These meta-characters can't be adjacent to each other
    @http:Query {name: "Contains"}
    string contains?;
    # The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada
    @http:Query {name: "AreaCode"}
    int areaCode?;
    # Whether the phone numbers can receive faxes. Can be: `true` or `false`
    @http:Query {name: "FaxEnabled"}
    boolean faxEnabled?;
    # The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada
    @http:Query {name: "Distance"}
    int distance?;
    # Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeAllAddressRequired"}
    boolean excludeAllAddressRequired?;
};

# Available local phone number resource with geographic and capability details
public type ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberLocal record {
    # A formatted version of the phone number
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of this phone number
    @jsondata:Name {value: "iso_country"}
    string? isoCountry?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are: `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountavailablePhoneNumberCountryavailablePhoneNumberLocalCapabilities? capabilities?;
    # The latitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? latitude?;
    # The locality or city of this phone number's location
    string? locality?;
    # The type of [Address](https://www.twilio.com/docs/usage/api/address) resource the phone number requires. Can be: `none`, `any`, `local`, or `foreign`. `none` means no address is required. `any` means an address is required, but it can be anywhere in the world. `local` means an address in the phone number's country is required. `foreign` means an address outside of the phone number's country is required
    @jsondata:Name {value: "address_requirements"}
    string? addressRequirements?;
    # The [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) of this phone number. Available for only phone numbers from the US and Canada
    string? lata?;
    # The [rate center](https://en.wikipedia.org/wiki/Telephone_exchange) of this phone number. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "rate_center"}
    string? rateCenter?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The two-letter state or province abbreviation of this phone number's location. Available for only phone numbers from the US and Canada
    string? region?;
    # The postal or ZIP code of this phone number's location. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "postal_code"}
    string? postalCode?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # The longitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? longitude?;
};

# Represents the Queries record for the operation: listDependentPhoneNumber
public type ListDependentPhoneNumberQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Request schema for mapping a credential list to a SIP domain
public type CreateSipAuthCallsCredentialListMappingRequest record {
    # The SID of the CredentialList resource to map to the SIP domain
    @jsondata:Name {value: "CredentialListSid"}
    string credentialListSid;
};

# How the recording was created. Can be: `DialVerb`, `Conference`, `OutboundAPI`, `Trunking`, `RecordVerb`, `StartCallRecordingAPI`, `StartConferenceRecordingAPI`
public type ConferenceRecordingEnumSource "DialVerb"|"Conference"|"OutboundAPI"|"Trunking"|"RecordVerb"|"StartCallRecordingAPI"|"StartConferenceRecordingAPI";

# Represents the Queries record for the operation: listTranscription
public type ListTranscriptionQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Response schema containing paginated monthly usage records
public type ListUsageRecordMonthlyResponse record {
    # URI for the first page of usage records
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The start index of the current page of usage records
    int 'start?;
    # The end index of the current page of usage records
    int end?;
    # URI for the next page of usage records, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of usage records, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated usage records
    int page?;
    # The URI of the current page of usage records
    string uri?;
    # Array of monthly usage record resources
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecordUsageRecordMonthly[] usageRecords?;
    # Number of records returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request schema for creating a new mobile incoming phone number
public type CreateIncomingPhoneNumberMobileRequest record {
    # The HTTP method that we should use to call `sms_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsFallbackMethod"}
    "GET"|"POST" smsFallbackMethod?;
    # The API version to use for incoming calls made to the new phone number. The default is `2010-04-01`
    @jsondata:Name {value: "ApiVersion"}
    string apiVersion?;
    # The URL we should call when the new phone number receives an incoming SMS message
    @jsondata:Name {value: "SmsUrl"}
    string smsUrl?;
    # The SID of the application we should use to handle calls to the new phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use only those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "VoiceApplicationSid"}
    string voiceApplicationSid?;
    # The HTTP method that we should use to call `voice_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # A descriptive string that you created to describe the new phone number. It can be up to 64 characters long. By default, the is a formatted version of the phone number
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether to lookup the caller's name from the CNAM database and post it to your app. Can be: `true` or `false` and defaults to `false`
    @jsondata:Name {value: "VoiceCallerIdLookup"}
    boolean voiceCallerIdLookup?;
    # The URL we should call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The SID of the Trunk we should use to handle calls to the new phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use only those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "TrunkSid"}
    string trunkSid?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "BundleSid"}
    string bundleSid?;
    # The SID of the emergency address configuration to use for emergency calling from the new phone number
    @jsondata:Name {value: "EmergencyAddressSid"}
    string emergencyAddressSid?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # The SID of the Identity resource that we should associate with the new phone number. Some regions require an identity to meet local regulations
    @jsondata:Name {value: "IdentitySid"}
    string identitySid?;
    # The URL that we should call when an error occurs while requesting or executing the TwiML defined by `sms_url`
    @jsondata:Name {value: "SmsFallbackUrl"}
    string smsFallbackUrl?;
    # The HTTP method that we should use to call `voice_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # Voice receive mode configuration for the mobile phone number
    @jsondata:Name {value: "VoiceReceiveMode"}
    IncomingPhoneNumberMobileEnumVoiceReceiveMode voiceReceiveMode?;
    # The phone number to purchase specified in [E.164](https://www.twilio.com/docs/glossary/what-e164) format.  E.164 phone numbers consist of a + followed by the country code and subscriber number without punctuation characters. For example, +14155551234
    @jsondata:Name {value: "PhoneNumber"}
    string phoneNumber;
    # The SID of the application that should handle SMS messages sent to the new phone number. If an `sms_application_sid` is present, we ignore all of the `sms_*_url` urls and use those of the application
    @jsondata:Name {value: "SmsApplicationSid"}
    string smsApplicationSid?;
    # The URL that we should call to answer a call to the new phone number. The `voice_url` will not be called if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The SID of the Address resource we should associate with the new phone number. Some regions require addresses to meet local regulations
    @jsondata:Name {value: "AddressSid"}
    string addressSid?;
    # The HTTP method that we should use to call `sms_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsMethod"}
    "GET"|"POST" smsMethod?;
    # Emergency calling status configuration for the mobile phone number
    @jsondata:Name {value: "EmergencyStatus"}
    IncomingPhoneNumberMobileEnumEmergencyStatus emergencyStatus?;
    # The URL that we should call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# Response schema containing usage records from the previous month
public type ListUsageRecordLastMonthResponse record {
    # URI to the first page of usage record results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page of results
    int 'start?;
    # Ending index of the current page of results
    int end?;
    # URI to the next page of usage record results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of usage record results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current usage records resource
    string uri?;
    # Array of usage record objects from the previous month
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecordUsageRecordLastMonth[] usageRecords?;
    # Number of records returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Whether the phone number requires an [Address](https://www.twilio.com/docs/usage/api/address) registered with Twilio. Can be: `none`, `any`, `local`, or `foreign`
public type IncomingPhoneNumberLocalEnumAddressRequirement "none"|"any"|"local"|"foreign";

# Schema representing a user-defined message associated with a call
public type ApiV2010AccountCallUserDefinedMessage record {
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the User Defined Message is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The date that this User Defined Message was created, given in RFC 2822 format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created User Defined Message
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The SID that uniquely identifies this User Defined Message
    string? sid?;
};

# Response schema containing a paginated list of signing keys
public type ListSigningKeyResponse record {
    # URI to the first page of signing key results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page of results
    int 'start?;
    # Array of signing key objects returned in the response
    @jsondata:Name {value: "signing_keys"}
    ApiV2010AccountSigningKey[] signingKeys?;
    # The end index of the current page of results
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of the current resource
    string uri?;
    # The number of items returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listRecording
public type ListRecordingQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Only include recordings that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read recordings that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read recordings that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read recordings that were created on or after midnight of this date
    @http:Query {name: "DateCreated<"}
    string dateCreated?;
    # A boolean parameter indicating whether to retrieve soft deleted recordings or not. Recordings metadata are kept after deletion for a retention period of 40 days
    @http:Query {name: "IncludeSoftDeleted"}
    boolean includeSoftDeleted?;
    # Only include recordings that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read recordings that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read recordings that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read recordings that were created on or after midnight of this date
    @http:Query {name: "DateCreated"}
    string dateCreated?;
    # The Conference SID that identifies the conference associated with the recording to read
    @http:Query {name: "ConferenceSid"}
    string conferenceSid?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the resources to read
    @http:Query {name: "CallSid"}
    string callSid?;
    # Only include recordings that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read recordings that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read recordings that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read recordings that were created on or after midnight of this date
    @http:Query {name: "DateCreated>"}
    string dateCreated?;
};

# Schema representing account usage record with billing and usage details
public type ApiV2010AccountUsageUsageRecord record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# Indicates whether the current payment session should be cancelled or completed. When `cancel` the payment session is cancelled. When `complete`, Twilio sends the payment information to the selected Pay Connector for processing
public type PaymentsEnumStatus "complete"|"cancel";

# Represents the Queries record for the operation: listConferenceRecording
public type ListConferenceRecordingQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date
    @http:Query {name: "DateCreated<"}
    string dateCreated?;
    # The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date
    @http:Query {name: "DateCreated"}
    string dateCreated?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date
    @http:Query {name: "DateCreated>"}
    string dateCreated?;
};

# Request schema for creating a new usage trigger with callback configuration
public type CreateUsageTriggerRequest record {
    # The URL we should call using `callback_method` when the trigger fires
    @jsondata:Name {value: "CallbackUrl"}
    string callbackUrl;
    # The usage category that the trigger should watch.  Use one of the supported [usage categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) for this value
    @jsondata:Name {value: "UsageCategory"}
    string usageCategory;
    # The usage value at which the trigger should fire.  For convenience, you can use an offset value such as `+30` to specify a trigger_value that is 30 units more than the current usage value. Be sure to urlencode a `+` as `%2B`
    @jsondata:Name {value: "TriggerValue"}
    string triggerValue;
    # Specifies if the trigger should fire repeatedly or only once
    @jsondata:Name {value: "Recurring"}
    UsageTriggerEnumRecurring recurring?;
    # The HTTP method we should use to call `callback_url`. Can be: `GET` or `POST` and the default is `POST`
    @jsondata:Name {value: "CallbackMethod"}
    "GET"|"POST" callbackMethod?;
    # A descriptive string that you create to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # The field that should be monitored to trigger the usage alert
    @jsondata:Name {value: "TriggerBy"}
    UsageTriggerEnumTriggerField triggerBy?;
};

# The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are  `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
public type Apiv2010accountincomingPhoneNumberCapabilities record {
    # Indicates if the phone number supports voice calls
    boolean voice?;
    # Indicates if the phone number supports MMS messaging
    boolean mms?;
    # Indicates if the phone number supports SMS messaging
    boolean sms?;
    # Indicates if the phone number supports fax transmission
    boolean fax?;
};

# Request schema for purchasing and configuring a new incoming phone number
public type CreateIncomingPhoneNumberRequest record {
    # The HTTP method that we should use to call `sms_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsFallbackMethod"}
    "GET"|"POST" smsFallbackMethod?;
    # The API version to use for incoming calls made to the new phone number. The default is `2010-04-01`
    @jsondata:Name {value: "ApiVersion"}
    string apiVersion?;
    # The URL we should call when the new phone number receives an incoming SMS message
    @jsondata:Name {value: "SmsUrl"}
    string smsUrl?;
    # The SID of the application we should use to handle calls to the new phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use only those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "VoiceApplicationSid"}
    string voiceApplicationSid?;
    # The HTTP method that we should use to call `voice_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # A descriptive string that you created to describe the new phone number. It can be up to 64 characters long. By default, this is a formatted version of the new phone number
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether to lookup the caller's name from the CNAM database and post it to your app. Can be: `true` or `false` and defaults to `false`
    @jsondata:Name {value: "VoiceCallerIdLookup"}
    boolean voiceCallerIdLookup?;
    # The URL we should call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The SID of the Trunk we should use to handle calls to the new phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use only those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "TrunkSid"}
    string trunkSid?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "BundleSid"}
    string bundleSid?;
    # The SID of the emergency address configuration to use for emergency calling from the new phone number
    @jsondata:Name {value: "EmergencyAddressSid"}
    string emergencyAddressSid?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # The SID of the Identity resource that we should associate with the new phone number. Some regions require an identity to meet local regulations
    @jsondata:Name {value: "IdentitySid"}
    string identitySid?;
    # The URL that we should call when an error occurs while requesting or executing the TwiML defined by `sms_url`
    @jsondata:Name {value: "SmsFallbackUrl"}
    string smsFallbackUrl?;
    # The HTTP method that we should use to call `voice_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # The mode for receiving voice calls on the phone number
    @jsondata:Name {value: "VoiceReceiveMode"}
    IncomingPhoneNumberEnumVoiceReceiveMode voiceReceiveMode?;
    # The phone number to purchase specified in [E.164](https://www.twilio.com/docs/glossary/what-e164) format.  E.164 phone numbers consist of a + followed by the country code and subscriber number without punctuation characters. For example, +14155551234
    @jsondata:Name {value: "PhoneNumber"}
    string phoneNumber?;
    # The desired area code for your new incoming phone number. Can be any three-digit, US or Canada area code. We will provision an available phone number within this area code for you. **You must provide an `area_code` or a `phone_number`.** (US and Canada only)
    @jsondata:Name {value: "AreaCode"}
    string areaCode?;
    # The SID of the application that should handle SMS messages sent to the new phone number. If an `sms_application_sid` is present, we ignore all of the `sms_*_url` urls and use those set on the application
    @jsondata:Name {value: "SmsApplicationSid"}
    string smsApplicationSid?;
    # The URL that we should call to answer a call to the new phone number. The `voice_url` will not be called if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The SID of the Address resource we should associate with the new phone number. Some regions require addresses to meet local regulations
    @jsondata:Name {value: "AddressSid"}
    string addressSid?;
    # The HTTP method that we should use to call `sms_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsMethod"}
    "GET"|"POST" smsMethod?;
    # The emergency calling status for the phone number
    @jsondata:Name {value: "EmergencyStatus"}
    IncomingPhoneNumberEnumEmergencyStatus emergencyStatus?;
    # The URL that we should call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# Represents the Queries record for the operation: listSipAuthCallsIpAccessControlListMapping
public type ListSipAuthCallsIpAccessControlListMappingQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Represents the Queries record for the operation: listIncomingPhoneNumber
public type ListIncomingPhoneNumberQueries record {
    # Whether to include phone numbers based on their origin. Can be: `twilio` or `hosted`. By default, phone numbers of all origin are included
    @http:Query {name: "Origin"}
    string origin?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # A string that identifies the IncomingPhoneNumber resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # The phone numbers of the IncomingPhoneNumber resources to read. You can specify partial numbers and use '*' as a wildcard for any digit
    @http:Query {name: "PhoneNumber"}
    string phoneNumber?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Whether to include phone numbers new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
};

# Response containing available VoIP phone numbers with pagination details
public type ListAvailablePhoneNumberVoipResponse record {
    # URI for the first page of available phone number results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of available VoIP phone numbers matching the search criteria
    @jsondata:Name {value: "available_phone_numbers"}
    ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberVoip[] availablePhoneNumbers?;
    # The start index of the current page of results
    int 'start?;
    # The index of the last item in the current page of results
    int end?;
    # The URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # The URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of the current page resource
    string uri?;
    # The number of items returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response object containing paginated list of short codes
public type ListShortCodeResponse record {
    # The URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The index of the first item in the current page of results
    int 'start?;
    # Array of short code resources in the current page
    @jsondata:Name {value: "short_codes"}
    ApiV2010AccountShortCode[] shortCodes?;
    # The index of the last item in the current page of results
    int end?;
    # The URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # The URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of the current page resource
    string uri?;
    # The number of items returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents a country with available phone numbers for purchase
public type ApiV2010AccountAvailablePhoneNumberCountry record {
    # The [ISO-3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code of the country
    @jsondata:Name {value: "country_code"}
    string? countryCode?;
    # The name of the country
    string? country?;
    # A list of related AvailablePhoneNumber resources identified by their URIs relative to `https://api.twilio.com`
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The URI of the Country resource, relative to `https://api.twilio.com`
    string? uri?;
    # Whether all phone numbers available in the country are new to the Twilio platform. `true` if they are and `false` if all numbers are not in the Twilio Phone Number Beta program
    boolean? beta?;
};

# Request object for updating account properties
public type UpdateAccountRequest record {
    # The new status to set for the account
    @jsondata:Name {value: "Status"}
    AccountEnumStatus status?;
    # Update the human-readable description of this Account
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
};

# The status of this conference. Can be: `init`, `in-progress`, or `completed`
public type ConferenceEnumStatus "init"|"in-progress"|"completed";

# Request object for creating a new SIP IP access control list
public type CreateSipIpAccessControlListRequest record {
    # A human readable descriptive text that describes the IpAccessControlList, up to 255 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName;
};

# Request schema for creating SIP IP access control list mapping
public type CreateSipIpAccessControlListMappingRequest record {
    # The unique id of the IP access control list to map to the SIP domain
    @jsondata:Name {value: "IpAccessControlListSid"}
    string ipAccessControlListSid;
};

# The tracks to be included in the Stream. Possible values are `inbound_track`, `outbound_track`, `both_tracks`. Default value is `inbound_track`
public type StreamEnumTrack "inbound_track"|"outbound_track"|"both_tracks";

# Response schema containing paginated list of address resources
public type ListAddressResponse record {
    # Array of address resources returned in the response
    ApiV2010AccountAddress[] addresses?;
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI to the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current page of results
    string uri?;
    # Number of items returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Usage trigger resource for monitoring account usage thresholds
public type ApiV2010AccountUsageUsageTrigger record {
    # The string that you assigned to describe the trigger
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The frequency of a recurring UsageTrigger.  Can be: `daily`, `monthly`, or `yearly` for recurring triggers or empty for non-recurring triggers. A trigger will only fire once during each period. Recurring times are in GMT
    UsageTriggerEnumRecurring recurring?;
    # The value at which the trigger will fire.  Must be a positive, numeric value
    @jsondata:Name {value: "trigger_value"}
    string? triggerValue?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The current value of the field the trigger is watching
    @jsondata:Name {value: "current_value"}
    string? currentValue?;
    # The unique string that that we created to identify the UsageTrigger resource
    string? sid?;
    # The URL we call using the `callback_method` when the trigger fires
    @jsondata:Name {value: "callback_url"}
    string? callbackUrl?;
    # The usage category the trigger watches. Must be one of the supported [usage categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    @jsondata:Name {value: "usage_category"}
    string? usageCategory?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that the trigger monitors
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The date and time in GMT that the trigger was last fired specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_fired"}
    string? dateFired?;
    # Field that the usage trigger monitors for threshold breaches
    @jsondata:Name {value: "trigger_by"}
    UsageTriggerEnumTriggerField triggerBy?;
    # The HTTP method we use to call `callback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "callback_method"}
    "GET"|"POST"? callbackMethod?;
    # The URI of the [UsageRecord](https://www.twilio.com/docs/usage/api/usage-record) resource this trigger watches, relative to `https://api.twilio.com`
    @jsondata:Name {value: "usage_record_uri"}
    string? usageRecordUri?;
};

# Available VoIP phone number resource with location and capability details
public type ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberVoip record {
    # A formatted version of the phone number
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of this phone number
    @jsondata:Name {value: "iso_country"}
    string? isoCountry?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are: `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountavailablePhoneNumberCountryavailablePhoneNumberLocalCapabilities? capabilities?;
    # The latitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? latitude?;
    # The locality or city of this phone number's location
    string? locality?;
    # The type of [Address](https://www.twilio.com/docs/usage/api/address) resource the phone number requires. Can be: `none`, `any`, `local`, or `foreign`. `none` means no address is required. `any` means an address is required, but it can be anywhere in the world. `local` means an address in the phone number's country is required. `foreign` means an address outside of the phone number's country is required
    @jsondata:Name {value: "address_requirements"}
    string? addressRequirements?;
    # The [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) of this phone number. Available for only phone numbers from the US and Canada
    string? lata?;
    # The [rate center](https://en.wikipedia.org/wiki/Telephone_exchange) of this phone number. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "rate_center"}
    string? rateCenter?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The two-letter state or province abbreviation of this phone number's location. Available for only phone numbers from the US and Canada
    string? region?;
    # The postal or ZIP code of this phone number's location. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "postal_code"}
    string? postalCode?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # The longitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? longitude?;
};

# Indicates whether the payment method should be tokenized as a `one-time`, `reusable`, or `payment-method` token. The default value is `reusable`. Do not enter a charge amount when tokenizing. If a charge amount is entered, the payment method will be charged and not tokenized
public type PaymentsEnumTokenType "one-time"|"reusable"|"payment-method";

# Represents the Queries record for the operation: listAuthorizedConnectApp
public type ListAuthorizedConnectAppQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Toll-free incoming phone number resource with configuration settings
public type ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberTollFree record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the Trunk that handles calls to the phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "trunk_sid"}
    string? trunkSid?;
    # The HTTP method we use to call `status_callback`. Can be: `GET` or `POST`
    @jsondata:Name {value: "status_callback_method"}
    "GET"|"POST"? statusCallbackMethod?;
    # The phone number's origin. `twilio` identifies Twilio-owned phone numbers and `hosted` identifies hosted phone numbers
    string? origin?;
    # The HTTP method we use to call `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_fallback_method"}
    "GET"|"POST"? smsFallbackMethod?;
    # Status of the emergency address configuration for the phone number
    @jsondata:Name {value: "emergency_address_status"}
    IncomingPhoneNumberTollFreeEnumEmergencyAddressStatus emergencyAddressStatus?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "bundle_sid"}
    string? bundleSid?;
    # The unique string that that we created to identify the resource
    string? sid?;
    # The URL that we call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "voice_fallback_url"}
    string? voiceFallbackUrl?;
    # The URL that we call when an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "sms_fallback_url"}
    string? smsFallbackUrl?;
    # Emergency calling status for the toll-free phone number
    @jsondata:Name {value: "emergency_status"}
    IncomingPhoneNumberTollFreeEnumEmergencyStatus emergencyStatus?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # Mode for receiving voice calls on the phone number
    @jsondata:Name {value: "voice_receive_mode"}
    IncomingPhoneNumberTollFreeEnumVoiceReceiveMode voiceReceiveMode?;
    # The SID of the Identity resource that we associate with the phone number. Some regions require an Identity to meet local regulations
    @jsondata:Name {value: "identity_sid"}
    string? identitySid?;
    # The SID of the application that handles calls to the phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "voice_application_sid"}
    string? voiceApplicationSid?;
    # The HTTP method we use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_method"}
    "GET"|"POST"? voiceMethod?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are  `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountincomingPhoneNumberCapabilities? capabilities?;
    # The URL we call when the phone number receives a call. The `voice_url` will not be used if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "voice_url"}
    string? voiceUrl?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL we call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "sms_url"}
    string? smsUrl?;
    # The address verification requirements for this toll-free phone number
    @jsondata:Name {value: "address_requirements"}
    IncomingPhoneNumberTollFreeEnumAddressRequirement addressRequirements?;
    # The HTTP method we use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_fallback_method"}
    "GET"|"POST"? voiceFallbackMethod?;
    # The URL we call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "status_callback"}
    string? statusCallback?;
    # The API version used to start a new TwiML session
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID of the Address resource associated with the phone number
    @jsondata:Name {value: "address_sid"}
    string? addressSid?;
    # Whether we look up the caller's caller-ID name from the CNAM database ($0.01 per look up). Can be: `true` or `false`
    @jsondata:Name {value: "voice_caller_id_lookup"}
    boolean? voiceCallerIdLookup?;
    # The HTTP method we use to call `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_method"}
    "GET"|"POST"? smsMethod?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The SID of the application that handles SMS messages sent to the phone number. If an `sms_application_sid` is present, we ignore all `sms_*_url` values and use those of the application
    @jsondata:Name {value: "sms_application_sid"}
    string? smsApplicationSid?;
    # The SID of the emergency address configuration that we use for emergency calling from this phone number
    @jsondata:Name {value: "emergency_address_sid"}
    string? emergencyAddressSid?;
    # The current status of the toll-free phone number
    string? status?;
};

# Request schema for updating SIP IP address configuration and properties
public type UpdateSipIpAddressRequest record {
    # A human readable descriptive text for this resource, up to 255 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # An integer representing the length of the CIDR prefix to use with this IP address when accepting traffic. By default the entire IP address is used
    @jsondata:Name {value: "CidrPrefixLength"}
    int cidrPrefixLength?;
    # An IP address in dotted decimal notation from which you want to accept traffic. Any SIP requests from this IP address will be allowed by Twilio. IPv4 only supported today
    @jsondata:Name {value: "IpAddress"}
    string ipAddress?;
};

# Request schema for updating SIP credential list properties
public type UpdateSipCredentialListRequest record {
    # A human readable descriptive text for a CredentialList, up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName;
};

# Represents a real-time media stream resource associated with a call
public type ApiV2010AccountCallStream record {
    # The date and time in GMT that this resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Stream resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The user-specified name of this Stream, if one was given when the Stream was created. This can be used to stop the Stream
    string? name?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Stream resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID of the Stream resource
    string? sid?;
    # The status of the Stream. Possible values are `stopped` and `in-progress`
    StreamEnumStatus status?;
};

# Response schema for paginated list of today's usage records
public type ListUsageRecordTodayResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Array of today's usage record objects
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecordUsageRecordToday[] usageRecords?;
    # Number of items per page in the paginated results
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Whether the phone number requires an [Address](https://www.twilio.com/docs/usage/api/address) registered with Twilio. Can be: `none`, `any`, `local`, or `foreign`
public type DependentPhoneNumberEnumAddressRequirement "none"|"any"|"local"|"foreign";

# Response schema for paginated list of machine-to-machine phone numbers
public type ListAvailablePhoneNumberMachineToMachineResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of available machine-to-machine phone number objects
    @jsondata:Name {value: "available_phone_numbers"}
    ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberMachineToMachine[] availablePhoneNumbers?;
    # The starting index of the current page of results
    int 'start?;
    # The ending index of the current page of results
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of the current resource
    string uri?;
    # The number of items per page in the paginated results
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listConnectApp
public type ListConnectAppQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Schema representing usage records for the current month with billing details
public type ApiV2010AccountUsageUsageRecordUsageRecordThisMonth record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# Represents the Queries record for the operation: listIncomingPhoneNumberLocal
public type ListIncomingPhoneNumberLocalQueries record {
    # Whether to include phone numbers based on their origin. Can be: `twilio` or `hosted`. By default, phone numbers of all origin are included
    @http:Query {name: "Origin"}
    string origin?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # A string that identifies the resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # The phone numbers of the IncomingPhoneNumber resources to read. You can specify partial numbers and use '*' as a wildcard for any digit
    @http:Query {name: "PhoneNumber"}
    string phoneNumber?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Whether to include phone numbers new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
};

# Schema representing an account balance with currency information
public type ApiV2010AccountBalance record {
    # The balance of the Account, in units specified by the unit parameter. Balance changes may not be reflected immediately. Child accounts do not contain balance information
    string? balance?;
    # The unique SID identifier of the Account
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units of currency for the account balance
    string? currency?;
};

# Schema for creating a new queue with friendly name and size limits
public type CreateQueueRequest record {
    # A descriptive string that you created to describe this resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName;
    # The maximum number of calls allowed to be in the queue. The default is 1000. The maximum is 5000
    @jsondata:Name {value: "MaxSize"}
    int maxSize?;
};

# Schema for paginated response containing API keys list
public type ListKeyResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of API key objects in the response
    ApiV2010AccountKey[] keys?;
    # The starting index of the current page of results
    int 'start?;
    # The ending index of the current page of results
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of the current resource
    string uri?;
    # The number of items per page in the paginated results
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Enumeration of possible stream update status values
public type StreamEnumUpdateStatus "stopped";

# The status of address registration with emergency services. A registered emergency address will be used during handling of emergency calls from this number
public type IncomingPhoneNumberMobileEnumEmergencyAddressStatus "registered"|"unregistered"|"pending-registration"|"registration-failure"|"pending-unregistration"|"unregistration-failure";

# Type of payment being captured. One of `credit-card` or `ach-debit`. The default value is `credit-card`
public type PaymentsEnumPaymentMethod "credit-card"|"ach-debit";

# Twilio account resource containing account details and metadata
public type ApiV2010Account record {
    # A Map of various subresources available for the given Account Instance
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # A human readable description of this account, up to 64 characters long. By default the FriendlyName is your email address
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date that this account was last updated, in GMT in RFC 2822 format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date that this account was created, in GMT in RFC 2822 format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The unique 34 character id that represents the parent of this account. The OwnerAccountSid of a parent account is it's own sid
    @jsondata:Name {value: "owner_account_sid"}
    string? ownerAccountSid?;
    # The authorization token for this account. This token should be kept a secret, so no sharing
    @jsondata:Name {value: "auth_token"}
    string? authToken?;
    # The type of this account. Either `Trial` or `Full` if it's been upgraded
    AccountEnumType 'type?;
    # The URI for this resource, relative to `https://api.twilio.com`
    string? uri?;
    # A 34 character string that uniquely identifies this resource
    string? sid?;
    # The status of this account. Usually `active`, but can be `suspended` or `closed`
    AccountEnumStatus status?;
};

# Represents the Queries record for the operation: listSipAuthRegistrationsCredentialListMapping
public type ListSipAuthRegistrationsCredentialListMappingQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# The status of address registration with emergency services. A registered emergency address will be used during handling of emergency calls from this number
public type IncomingPhoneNumberLocalEnumEmergencyAddressStatus "registered"|"unregistered"|"pending-registration"|"registration-failure"|"pending-unregistration"|"unregistration-failure";

# Call recording resource with metadata and playback details
public type ApiV2010AccountCallCallRecording record {
    # The date and time in GMT that the resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # How to decrypt the recording if it was encrypted using [Call Recording Encryption](https://www.twilio.com/docs/voice/tutorials/voice-recording-encryption) feature
    @jsondata:Name {value: "encryption_details"}
    anydata? encryptionDetails?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The Conference SID that identifies the conference associated with the recording, if a conference recording
    @jsondata:Name {value: "conference_sid"}
    string? conferenceSid?;
    # How the recording was created. Can be: `DialVerb`, `Conference`, `OutboundAPI`, `Trunking`, `RecordVerb`, `StartCallRecordingAPI`, and `StartConferenceRecordingAPI`
    CallRecordingEnumSource 'source?;
    # The API version used to make the recording
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Recording resource
    string? sid?;
    # The length of the recording in seconds
    string? duration?;
    # The currency used in the `price` property. Example: `USD`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The start time of the recording in GMT and in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "start_time"}
    string? startTime?;
    # The number of channels in the final recording file.  Can be: `1`, or `2`. Separating a two leg call into two separate channels of the recording file is supported in [Dial](https://www.twilio.com/docs/voice/twiml/dial#attributes-record) and [Outbound Rest API](https://www.twilio.com/docs/voice/make-calls) record options
    int channels = 0;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Recording resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The one-time cost of creating the recording in the `price_unit` currency
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The error code that describes why the recording is `absent`. The error code is described in our [Error Dictionary](https://www.twilio.com/docs/api/errors). This value is null if the recording `status` is not `absent`
    @jsondata:Name {value: "error_code"}
    int? errorCode?;
    # The recorded track. Can be: `inbound`, `outbound`, or `both`
    string? track?;
    # The status of the recording. Can be: `processing`, `completed` and `absent`. For more detailed statuses on in-progress recordings, check out how to [Update a Recording Resource](https://www.twilio.com/docs/voice/api/recording#update-a-recording-resource)
    CallRecordingEnumStatus status?;
};

# Represents the Queries record for the operation: listSipAuthCallsCredentialListMapping
public type ListSipAuthCallsCredentialListMappingQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Paginated response containing SIP auth credential list mappings
public type ListSipAuthCallsCredentialListMappingResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of SIP auth credential list mapping resources
    ApiV2010AccountSipSipDomainSipAuthSipAuthCallsSipAuthCallsCredentialListMapping[] contents?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI to the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current page resource
    string uri?;
    # Number of items returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Available national phone number with location and capability details
public type ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberNational record {
    # A formatted version of the phone number
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of this phone number
    @jsondata:Name {value: "iso_country"}
    string? isoCountry?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are: `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountavailablePhoneNumberCountryavailablePhoneNumberLocalCapabilities? capabilities?;
    # The latitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? latitude?;
    # The locality or city of this phone number's location
    string? locality?;
    # The type of [Address](https://www.twilio.com/docs/usage/api/address) resource the phone number requires. Can be: `none`, `any`, `local`, or `foreign`. `none` means no address is required. `any` means an address is required, but it can be anywhere in the world. `local` means an address in the phone number's country is required. `foreign` means an address outside of the phone number's country is required
    @jsondata:Name {value: "address_requirements"}
    string? addressRequirements?;
    # The [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) of this phone number. Available for only phone numbers from the US and Canada
    string? lata?;
    # The [rate center](https://en.wikipedia.org/wiki/Telephone_exchange) of this phone number. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "rate_center"}
    string? rateCenter?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The two-letter state or province abbreviation of this phone number's location. Available for only phone numbers from the US and Canada
    string? region?;
    # The postal or ZIP code of this phone number's location. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "postal_code"}
    string? postalCode?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # The longitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? longitude?;
};

# Represents the Queries record for the operation: listMedia
public type ListMediaQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Only include Media resources that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read Media that were created on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read Media that were created on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read Media that were created on or after midnight of this date
    @http:Query {name: "DateCreated<"}
    string dateCreated?;
    # Only include Media resources that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read Media that were created on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read Media that were created on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read Media that were created on or after midnight of this date
    @http:Query {name: "DateCreated"}
    string dateCreated?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include Media resources that were created on this date. Specify a date as `YYYY-MM-DD` in GMT, for example: `2009-07-06`, to read Media that were created on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read Media that were created on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read Media that were created on or after midnight of this date
    @http:Query {name: "DateCreated>"}
    string dateCreated?;
};

# Add-on result payload data for a recording with vendor-specific content
public type ApiV2010AccountRecordingRecordingAddOnResultRecordingAddOnResultPayload record {
    # A list of related resources identified by their relative URIs
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The SID of the AddOnResult to which the payload belongs
    @jsondata:Name {value: "add_on_result_sid"}
    string? addOnResultSid?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The MIME type of the payload
    @jsondata:Name {value: "content_type"}
    string? contentType?;
    # The SID of the Add-on to which the result belongs
    @jsondata:Name {value: "add_on_sid"}
    string? addOnSid?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The string provided by the vendor that describes the payload
    string? label?;
    # The SID of the recording to which the AddOnResult resource that contains the payload belongs
    @jsondata:Name {value: "reference_sid"}
    string? referenceSid?;
    # The unique string that that we created to identify the Recording AddOnResult Payload resource
    string? sid?;
    # The SID of the Add-on configuration
    @jsondata:Name {value: "add_on_configuration_sid"}
    string? addOnConfigurationSid?;
};

# Represents the Queries record for the operation: listQueue
public type ListQueueQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Message feedback resource containing outcome and metadata
public type ApiV2010AccountMessageMessageFeedback record {
    # The date and time in GMT when this MessageFeedback resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT when this MessageFeedback resource was created, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with this MessageFeedback resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The SID of the Message resource associated with this MessageFeedback resource
    @jsondata:Name {value: "message_sid"}
    string? messageSid?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # Reported outcome indicating whether there is confirmation that the Message recipient performed a tracked user action. Can be: `unconfirmed` or `confirmed`. For more details see [How to Optimize Message Deliverability with Message Feedback](https://www.twilio.com/docs/messaging/guides/send-message-feedback-to-twilio)
    MessageFeedbackEnumOutcome outcome?;
};

# Represents the Queries record for the operation: listCallRecording
public type ListCallRecordingQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date
    @http:Query {name: "DateCreated<"}
    string dateCreated?;
    # The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date
    @http:Query {name: "DateCreated"}
    string dateCreated?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # The `date_created` value, specified as `YYYY-MM-DD`, of the resources to read. You can also specify inequality: `DateCreated<=YYYY-MM-DD` will return recordings generated at or before midnight on a given date, and `DateCreated>=YYYY-MM-DD` returns recordings generated at or after midnight on a date
    @http:Query {name: "DateCreated>"}
    string dateCreated?;
};

# Represents the Queries record for the operation: listRecordingAddOnResult
public type ListRecordingAddOnResultQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Call notification resource containing error and warning details
public type ApiV2010AccountCallCallNotification record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # An integer log level that corresponds to the type of notification: `0` is ERROR, `1` is WARNING
    string? log?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL for more information about the error condition. This value is a page in our [Error Dictionary](https://www.twilio.com/docs/api/errors)
    @jsondata:Name {value: "more_info"}
    string? moreInfo?;
    # The HTTP method used to generate the notification. If the notification was generated during a phone call, this is the HTTP Method used to request the resource on your server. If the notification was generated by your use of our REST API, this is the HTTP method used to call the resource on our servers
    @jsondata:Name {value: "request_method"}
    "GET"|"POST"? requestMethod?;
    # The API version used to create the Call Notification resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URL of the resource that generated the notification. If the notification was generated during a phone call, this is the URL of the resource on your server that caused the notification. If the notification was generated by your use of our REST API, this is the URL of the resource you called
    @jsondata:Name {value: "request_url"}
    string? requestUrl?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Call Notification resource
    string? sid?;
    # The text of the notification
    @jsondata:Name {value: "message_text"}
    string? messageText?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Call Notification resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The date the notification was actually generated in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format. Message buffering can cause this value to differ from `date_created`
    @jsondata:Name {value: "message_date"}
    string? messageDate?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call Notification resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # A unique error code for the error condition that is described in our [Error Dictionary](https://www.twilio.com/docs/api/errors)
    @jsondata:Name {value: "error_code"}
    string? errorCode?;
};

# The status of address registration with emergency services. A registered emergency address will be used during handling of emergency calls from this number
public type IncomingPhoneNumberTollFreeEnumEmergencyAddressStatus "registered"|"unregistered"|"pending-registration"|"registration-failure"|"pending-unregistration"|"unregistration-failure";

# Request parameters for purchasing a local phone number
public type CreateIncomingPhoneNumberLocalRequest record {
    # The HTTP method that we should use to call `sms_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsFallbackMethod"}
    "GET"|"POST" smsFallbackMethod?;
    # The API version to use for incoming calls made to the new phone number. The default is `2010-04-01`
    @jsondata:Name {value: "ApiVersion"}
    string apiVersion?;
    # The URL we should call when the new phone number receives an incoming SMS message
    @jsondata:Name {value: "SmsUrl"}
    string smsUrl?;
    # The SID of the application we should use to handle calls to the new phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use only those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "VoiceApplicationSid"}
    string voiceApplicationSid?;
    # The HTTP method that we should use to call `voice_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # A descriptive string that you created to describe the new phone number. It can be up to 64 characters long. By default, this is a formatted version of the phone number
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether to lookup the caller's name from the CNAM database and post it to your app. Can be: `true` or `false` and defaults to `false`
    @jsondata:Name {value: "VoiceCallerIdLookup"}
    boolean voiceCallerIdLookup?;
    # The URL we should call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The SID of the Trunk we should use to handle calls to the new phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use only those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "TrunkSid"}
    string trunkSid?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "BundleSid"}
    string bundleSid?;
    # The SID of the emergency address configuration to use for emergency calling from the new phone number
    @jsondata:Name {value: "EmergencyAddressSid"}
    string emergencyAddressSid?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # The SID of the Identity resource that we should associate with the new phone number. Some regions require an identity to meet local regulations
    @jsondata:Name {value: "IdentitySid"}
    string identitySid?;
    # The URL that we should call when an error occurs while requesting or executing the TwiML defined by `sms_url`
    @jsondata:Name {value: "SmsFallbackUrl"}
    string smsFallbackUrl?;
    # The HTTP method that we should use to call `voice_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # Voice receive mode configuration for incoming calls
    @jsondata:Name {value: "VoiceReceiveMode"}
    IncomingPhoneNumberLocalEnumVoiceReceiveMode voiceReceiveMode?;
    # The phone number to purchase specified in [E.164](https://www.twilio.com/docs/glossary/what-e164) format.  E.164 phone numbers consist of a + followed by the country code and subscriber number without punctuation characters. For example, +14155551234
    @jsondata:Name {value: "PhoneNumber"}
    string phoneNumber;
    # The SID of the application that should handle SMS messages sent to the new phone number. If an `sms_application_sid` is present, we ignore all of the `sms_*_url` urls and use those set on the application
    @jsondata:Name {value: "SmsApplicationSid"}
    string smsApplicationSid?;
    # The URL that we should call to answer a call to the new phone number. The `voice_url` will not be called if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The SID of the Address resource we should associate with the new phone number. Some regions require addresses to meet local regulations
    @jsondata:Name {value: "AddressSid"}
    string addressSid?;
    # The HTTP method that we should use to call `sms_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsMethod"}
    "GET"|"POST" smsMethod?;
    # Emergency calling status for the phone number
    @jsondata:Name {value: "EmergencyStatus"}
    IncomingPhoneNumberLocalEnumEmergencyStatus emergencyStatus?;
    # The URL that we should call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# SIP credential resource with authentication details
public type ApiV2010AccountSipSipCredentialListSipCredential record {
    # The unique id that identifies the credential list that includes this credential
    @jsondata:Name {value: "credential_list_sid"}
    string? credentialListSid?;
    # The date that this resource was last updated, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date that this resource was created, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The unique id of the Account that is responsible for this resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI for this resource, relative to `https://api.twilio.com`
    string? uri?;
    # A 34 character string that uniquely identifies this resource
    string? sid?;
    # The username for this credential
    string? username?;
};

# Represents the Queries record for the operation: listUsageTrigger
public type ListUsageTriggerQueries record {
    # The usage category of the UsageTriggers to read. Must be a supported [usage categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    @http:Query {name: "UsageCategory"}
    string usageCategory?;
    # The frequency of recurring UsageTriggers to read. Can be: `daily`, `monthly`, or `yearly` to read recurring UsageTriggers. An empty value or a value of `alltime` reads non-recurring UsageTriggers
    @http:Query {name: "Recurring"}
    UsageTriggerEnumRecurring recurring?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The trigger field of the UsageTriggers to read.  Can be: `count`, `usage`, or `price` as described in the [UsageRecords documentation](https://www.twilio.com/docs/usage/api/usage-record#usage-count-price)
    @http:Query {name: "TriggerBy"}
    UsageTriggerEnumTriggerField triggerBy?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Yesterday's usage record with billing and consumption metrics
public type ApiV2010AccountUsageUsageRecordUsageRecordYesterday record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# Request to assign an add-on to an incoming phone number
public type CreateIncomingPhoneNumberAssignedAddOnRequest record {
    # The SID that identifies the Add-on installation
    @jsondata:Name {value: "InstalledAddOnSid"}
    string installedAddOnSid;
};

# Paginated response containing conference resources and navigation metadata
public type ListConferenceResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of results on current page
    int 'start?;
    # Ending index of results on current page
    int end?;
    # URI to the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI of the current resource
    string uri?;
    # Array of conference resources
    ApiV2010AccountConference[] conferences?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Newly created signing key resource with secret for authentication
public type ApiV2010AccountNewSigningKey record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The secret your application uses to sign Access Tokens and to authenticate to the REST API (you will use this as the basic-auth `password`).  **Note that for security reasons, this field is ONLY returned when the API Key is first created.**
    string? secret?;
    # The unique string that that we created to identify the NewSigningKey resource
    string? sid?;
};

# Request schema for updating SIP credential authentication settings
public type UpdateSipCredentialRequest record {
    # The password that the username will use when authenticating SIP requests. The password must be a minimum of 12 characters, contain at least 1 digit, and have mixed case. (eg `IWasAtSignal2018`)
    @jsondata:Name {value: "Password"}
    string password?;
};

# Response schema containing paginated list of recording resources
public type ListRecordingResponse record {
    # URI for the first page of results in the recording list
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of recording resources returned in the current page
    ApiV2010AccountRecording[] recordings?;
    # Zero-based index of the first recording in the current page
    int 'start?;
    # Zero-based index of the last recording in the current page
    int end?;
    # URI for the next page of results, null if no next page exists
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, null if no previous page exists
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated recording list
    int page?;
    # URI of the current page in the recording list
    string uri?;
    # Number of recordings returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request schema for creating authentication tokens with TTL settings
public type CreateTokenRequest record {
    # The duration in seconds for which the generated credentials are valid. The default value is 86400 (24 hours)
    @jsondata:Name {value: "Ttl"}
    int ttl?;
};

# Represents the Queries record for the operation: listUsageRecordLastMonth
public type ListUsageRecordLastMonthQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Response schema containing paginated list of usage trigger resources
public type ListUsageTriggerResponse record {
    # URI for the first page of results in the usage trigger list
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Zero-based index of the first usage trigger in the current page
    int 'start?;
    # Zero-based index of the last usage trigger in the current page
    int end?;
    # URI for the next page of results, null if no next page exists
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, null if no previous page exists
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Array of usage trigger resources returned in the current page
    @jsondata:Name {value: "usage_triggers"}
    ApiV2010AccountUsageUsageTrigger[] usageTriggers?;
    # Current page number in the paginated usage trigger list
    int page?;
    # The URI of the resource, relative to the API base URL
    string uri?;
    # The number of items returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request schema for updating Twilio application configuration and settings
public type UpdateApplicationRequest record {
    # The HTTP method we should use to call `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "SmsFallbackMethod"}
    "GET"|"POST" smsFallbackMethod?;
    # The API version to use to start a new TwiML session. Can be: `2010-04-01` or `2008-08-01`. The default value is your account's default API version
    @jsondata:Name {value: "ApiVersion"}
    string apiVersion?;
    # The HTTP method we should use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # The URL we should call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "SmsUrl"}
    string smsUrl?;
    # A descriptive string that you create to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether we should look up the caller's caller-ID name from the CNAM database (additional charges apply). Can be: `true` or `false`
    @jsondata:Name {value: "VoiceCallerIdLookup"}
    boolean voiceCallerIdLookup?;
    # The URL we should call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # Same as message_status_callback: The URL we should call using a POST method to send status information about SMS messages sent by the application. Deprecated, included for backwards compatibility
    @jsondata:Name {value: "SmsStatusCallback"}
    string smsStatusCallback?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # The URL that we should call when an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "SmsFallbackUrl"}
    string smsFallbackUrl?;
    # Whether to allow other Twilio accounts to dial this applicaton using Dial verb. Can be: `true` or `false`
    @jsondata:Name {value: "PublicApplicationConnectEnabled"}
    boolean publicApplicationConnectEnabled?;
    # The HTTP method we should use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # The URL we should call using a POST method to send message status information to your application
    @jsondata:Name {value: "MessageStatusCallback"}
    string messageStatusCallback?;
    # The URL we should call when the phone number assigned to this application receives a call
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The HTTP method we should use to call `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "SmsMethod"}
    "GET"|"POST" smsMethod?;
    # The URL that we should call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# How the recording was created. Can be: `DialVerb`, `Conference`, `OutboundAPI`, `Trunking`, `RecordVerb`, `StartCallRecordingAPI`, and `StartConferenceRecordingAPI`
public type RecordingEnumSource "DialVerb"|"Conference"|"OutboundAPI"|"Trunking"|"RecordVerb"|"StartCallRecordingAPI"|"StartConferenceRecordingAPI";

# Authorized Connect App resource with permissions and application details
public type ApiV2010AccountAuthorizedConnectApp record {
    # The public URL for the Connect App
    @jsondata:Name {value: "connect_app_homepage_url"}
    string? connectAppHomepageUrl?;
    # The company name set for the Connect App
    @jsondata:Name {value: "connect_app_company_name"}
    string? connectAppCompanyName?;
    # A detailed description of the Connect App
    @jsondata:Name {value: "connect_app_description"}
    string? connectAppDescription?;
    # The name of the Connect App
    @jsondata:Name {value: "connect_app_friendly_name"}
    string? connectAppFriendlyName?;
    # The set of permissions that you authorized for the Connect App.  Can be: `get-all` or `post-all`
    AuthorizedConnectAppEnumPermission[]? permissions?;
    # The SID that we assigned to the Connect App
    @jsondata:Name {value: "connect_app_sid"}
    string? connectAppSid?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the AuthorizedConnectApp resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
};

# Include this parameter with a value of `disable` to skip any kind of risk check on the respective message request
public type MessageEnumRiskCheck "enable"|"disable";

# The type of this account. Either `Trial` or `Full` if it's been upgraded
public type AccountEnumType "Trial"|"Full";

# Paginated response containing SIP credential lists and navigation metadata
public type ListSipCredentialListResponse record {
    # URI to the first page of results in the paginated response
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The starting index of items in the current page
    int 'start?;
    # The ending index of items in the current page
    int end?;
    # URI to the next page of results, null if no next page exists
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results, null if no previous page exists
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated response
    int page?;
    # The URI of the current resource, relative to the API base URL
    string uri?;
    # Array of SIP credential list resources returned in this page
    @jsondata:Name {value: "credential_lists"}
    ApiV2010AccountSipSipCredentialList[] credentialLists?;
    # The number of items returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Recording transcription resource with text content, status, and metadata
public type ApiV2010AccountRecordingRecordingTranscription record {
    # The text content of the transcription
    @jsondata:Name {value: "transcription_text"}
    string? transcriptionText?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) from which the transcription was created
    @jsondata:Name {value: "recording_sid"}
    string? recordingSid?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The API version used to create the transcription
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The transcription type
    string? 'type?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Transcription resource
    string? sid?;
    # The duration of the transcribed audio in seconds
    string? duration?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format (e.g. `usd`, `eur`, `jpy`)
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The charge for the transcript in the currency associated with the account. This value is populated after the transcript is complete so it may not be available immediately
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The status of the transcription. Can be: `in-progress`, `completed`, `failed`
    RecordingTranscriptionEnumStatus status?;
};

# Paginated response containing mobile phone numbers and navigation metadata
public type ListIncomingPhoneNumberMobileResponse record {
    # URI to the first page of results in the paginated response
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The starting index of items in the current page
    int 'start?;
    # The ending index of items in the current page
    int end?;
    # URI for the next page of mobile phone number results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of mobile phone number results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the mobile phone number listing
    int page?;
    # Array of incoming mobile phone number resources
    @jsondata:Name {value: "incoming_phone_numbers"}
    ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberMobile[] incomingPhoneNumbers?;
    # URI of the mobile phone number list resource
    string uri?;
    # Number of mobile phone number resources per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request schema for creating a new API key resource
public type CreateNewKeyRequest record {
    # A descriptive string that you create to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
};

# The parameter displays if emergency calling is enabled for this number. Active numbers may place emergency calls by dialing valid emergency numbers for the country
public type IncomingPhoneNumberLocalEnumEmergencyStatus "Active"|"Inactive";

# Queue resource for managing call queuing and wait times
public type ApiV2010AccountQueue record {
    # A string that you assigned to describe this resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that this resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that this resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Queue resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The number of calls currently in the queue
    @jsondata:Name {value: "current_size"}
    int currentSize = 0;
    # The URI of this resource, relative to `https://api.twilio.com`
    string? uri?;
    #  The average wait time in seconds of the members in this queue. This is calculated at the time of the request
    @jsondata:Name {value: "average_wait_time"}
    int averageWaitTime = 0;
    #  The maximum number of calls that can be in the queue. The default is 1000 and the maximum is 5000
    @jsondata:Name {value: "max_size"}
    int maxSize = 0;
    # The unique string that that we created to identify this Queue resource
    string? sid?;
};

# Response schema containing daily usage record data and pagination
public type ListUsageRecordDailyResponse record {
    # URI for the first page of daily usage records
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Start index for the current page of usage records
    int 'start?;
    # End index for the current page of usage records
    int end?;
    # URI for the next page of daily usage records
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of daily usage records
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the daily usage record listing
    int page?;
    # URI of the daily usage record list resource
    string uri?;
    # Array of daily usage record resources
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecordUsageRecordDaily[] usageRecords?;
    # Number of daily usage records per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response schema for assigned add-ons on incoming phone numbers
public type ListIncomingPhoneNumberAssignedAddOnResponse record {
    # Array of assigned add-on resources for incoming phone numbers
    @jsondata:Name {value: "assigned_add_ons"}
    ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOn[] assignedAddOns?;
    # URI to retrieve the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Index of the first item in the current page
    int 'start?;
    # Index of the last item in the current page
    int end?;
    # URI to retrieve the next page of results, null if none
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to retrieve the previous page of results, null if none
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page in the paginated results
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response containing paginated list of SIP credentials
public type ListSipCredentialResponse record {
    # URI to retrieve the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of SIP credential objects
    ApiV2010AccountSipSipCredentialListSipCredential[] credentials?;
    # Index of the first item in the current page
    int 'start?;
    # Index of the last item in the current page
    int end?;
    # URI to retrieve the next page of results, null if none
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to retrieve the previous page of results, null if none
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page in the paginated results
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response containing paginated list of call events
public type ListCallEventResponse record {
    # URI to retrieve the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The starting index of the returned results page
    int 'start?;
    # The ending index of the returned results page
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of the current resource
    string uri?;
    # Array of call event objects returned in the response
    ApiV2010AccountCallCallEvent[] events?;
    # Number of items returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listCallNotification
public type ListCallNotificationQueries record {
    # Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date
    @http:Query {name: "MessageDate"}
    string messageDate?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Only read notifications of the specified log level. Can be:  `0` to read only ERROR notifications or `1` to read only WARNING notifications. By default, all notifications are read
    @http:Query {name: "Log"}
    int log?;
    # Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date
    @http:Query {name: "MessageDate>"}
    string messageDate?;
    # Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date
    @http:Query {name: "MessageDate<"}
    string messageDate?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Represents the Queries record for the operation: listSipDomain
public type ListSipDomainQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Request schema for creating a new address resource
public type CreateAddressRequest record {
    # The ISO country code of the new address
    @jsondata:Name {value: "IsoCountry"}
    string isoCountry;
    # A descriptive string that you create to describe the new address. It can be up to 64 characters long for Regulatory Compliance addresses and 32 characters long for Emergency addresses
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether to enable emergency calling on the new address. Can be: `true` or `false`
    @jsondata:Name {value: "EmergencyEnabled"}
    boolean emergencyEnabled?;
    # The number and street address of the new address
    @jsondata:Name {value: "Street"}
    string street;
    # The state or region of the new address
    @jsondata:Name {value: "Region"}
    string region;
    # The postal code of the new address
    @jsondata:Name {value: "PostalCode"}
    string postalCode;
    # Whether we should automatically correct the address. Can be: `true` or `false` and the default is `true`. If empty or `true`, we will correct the address you provide if necessary. If `false`, we won't alter the address you provide
    @jsondata:Name {value: "AutoCorrectAddress"}
    boolean autoCorrectAddress?;
    # The name to associate with the new address
    @jsondata:Name {value: "CustomerName"}
    string customerName;
    # The city of the new address
    @jsondata:Name {value: "City"}
    string city;
    # The additional number and street address of the address
    @jsondata:Name {value: "StreetSecondary"}
    string streetSecondary?;
};

# Represents the Queries record for the operation: listUsageRecordToday
public type ListUsageRecordTodayQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Request schema for creating a call recording with configuration options
public type CreateCallRecordingRequest record {
    # The audio track to record for the call. Can be: `inbound`, `outbound` or `both`. The default is `both`. `inbound` records the audio that is received by Twilio. `outbound` records the audio that is generated from Twilio. `both` records the audio that is received and generated by Twilio
    @jsondata:Name {value: "RecordingTrack"}
    string recordingTrack?;
    # Whether to trim any leading and trailing silence in the recording. Can be: `trim-silence` or `do-not-trim` and the default is `do-not-trim`. `trim-silence` trims the silence from the beginning and end of the recording and `do-not-trim` does not
    @jsondata:Name {value: "Trim"}
    string trim?;
    # The URL we should call using the `recording_status_callback_method` on each recording event specified in  `recording_status_callback_event`. For more information, see [RecordingStatusCallback parameters](https://www.twilio.com/docs/voice/api/recording#recordingstatuscallback)
    @jsondata:Name {value: "RecordingStatusCallback"}
    string recordingStatusCallback?;
    # The number of channels used in the recording. Can be: `mono` or `dual` and the default is `mono`. `mono` records all parties of the call into one channel. `dual` records each party of a 2-party call into separate channels
    @jsondata:Name {value: "RecordingChannels"}
    string recordingChannels?;
    # The recording status events on which we should call the `recording_status_callback` URL. Can be: `in-progress`, `completed` and `absent` and the default is `completed`. Separate multiple event values with a space
    @jsondata:Name {value: "RecordingStatusCallbackEvent"}
    string[] recordingStatusCallbackEvent?;
    # The HTTP method we should use to call `recording_status_callback`. Can be: `GET` or `POST` and the default is `POST`
    @jsondata:Name {value: "RecordingStatusCallbackMethod"}
    "GET"|"POST" recordingStatusCallbackMethod?;
};

# Enumeration of valid status values for updating a call
public type CallEnumUpdateStatus "canceled"|"completed";

# Response schema for listing queue member resources with pagination
public type ListMemberResponse record {
    # Array of queue member objects returned in the response
    @jsondata:Name {value: "queue_members"}
    ApiV2010AccountQueueMember[] queueMembers?;
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The starting index of the returned results page
    int 'start?;
    # The ending index of the returned results page
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of the current resource
    string uri?;
    # Number of items returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents an API key resource with metadata and authentication details
public type ApiV2010AccountKey record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The unique string that that we created to identify the Key resource
    string? sid?;
};

# The status of the recording. Can be: `processing`, `completed`, `absent` or `deleted`. For information about more detailed statuses on in-progress recordings, check out how to [Update a Recording Resource](https://www.twilio.com/docs/voice/api/recording#update-a-recording-resource)
public type RecordingEnumStatus "in-progress"|"paused"|"stopped"|"processing"|"completed"|"absent"|"deleted";

# Voice reception mode for local phone numbers (voice or fax)
public type IncomingPhoneNumberLocalEnumVoiceReceiveMode "voice"|"fax";

# Mobile phone number resource with voice, SMS, and emergency configurations
public type ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberMobile record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the Trunk that handles calls to the phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "trunk_sid"}
    string? trunkSid?;
    # The HTTP method we use to call `status_callback`. Can be: `GET` or `POST`
    @jsondata:Name {value: "status_callback_method"}
    "GET"|"POST"? statusCallbackMethod?;
    # The phone number's origin. `twilio` identifies Twilio-owned phone numbers and `hosted` identifies hosted phone numbers
    string? origin?;
    # The HTTP method we use to call `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_fallback_method"}
    "GET"|"POST"? smsFallbackMethod?;
    # Status of the emergency address configuration for the mobile phone number
    @jsondata:Name {value: "emergency_address_status"}
    IncomingPhoneNumberMobileEnumEmergencyAddressStatus emergencyAddressStatus?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "bundle_sid"}
    string? bundleSid?;
    # The unique string that that we created to identify the resource
    string? sid?;
    # The URL that we call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "voice_fallback_url"}
    string? voiceFallbackUrl?;
    # The URL that we call when an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "sms_fallback_url"}
    string? smsFallbackUrl?;
    # Emergency calling status for the mobile phone number
    @jsondata:Name {value: "emergency_status"}
    IncomingPhoneNumberMobileEnumEmergencyStatus emergencyStatus?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # Voice reception mode configuration for the mobile phone number
    @jsondata:Name {value: "voice_receive_mode"}
    IncomingPhoneNumberMobileEnumVoiceReceiveMode voiceReceiveMode?;
    # The SID of the Identity resource that we associate with the phone number. Some regions require an Identity to meet local regulations
    @jsondata:Name {value: "identity_sid"}
    string? identitySid?;
    # The SID of the application that handles calls to the phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "voice_application_sid"}
    string? voiceApplicationSid?;
    # The HTTP method we use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_method"}
    "GET"|"POST"? voiceMethod?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are  `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountincomingPhoneNumberCapabilities? capabilities?;
    # The URL we call when the phone number receives a call. The `voice_url` will not be used if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "voice_url"}
    string? voiceUrl?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL we call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "sms_url"}
    string? smsUrl?;
    # Address verification requirements for the mobile phone number
    @jsondata:Name {value: "address_requirements"}
    IncomingPhoneNumberMobileEnumAddressRequirement addressRequirements?;
    # The HTTP method we use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_fallback_method"}
    "GET"|"POST"? voiceFallbackMethod?;
    # The URL we call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "status_callback"}
    string? statusCallback?;
    # The API version used to start a new TwiML session
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID of the Address resource associated with the phone number
    @jsondata:Name {value: "address_sid"}
    string? addressSid?;
    # Whether we look up the caller's caller-ID name from the CNAM database ($0.01 per look up). Can be: `true` or `false`
    @jsondata:Name {value: "voice_caller_id_lookup"}
    boolean? voiceCallerIdLookup?;
    # The HTTP method we use to call `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_method"}
    "GET"|"POST"? smsMethod?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The SID of the application that handles SMS messages sent to the phone number. If an `sms_application_sid` is present, we ignore all `sms_*_url` values and use those of the application
    @jsondata:Name {value: "sms_application_sid"}
    string? smsApplicationSid?;
    # The SID of the emergency address configuration that we use for emergency calling from this phone number
    @jsondata:Name {value: "emergency_address_sid"}
    string? emergencyAddressSid?;
    # Current status of the mobile phone number
    string? status?;
};

# Request parameters for updating an active call's configuration
public type UpdateCallRequest record {
    # New status to set for the call (completed, canceled)
    @jsondata:Name {value: "Status"}
    CallEnumUpdateStatus status?;
    # The HTTP method we should use when requesting the `status_callback` URL. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # TwiML instructions for the call Twilio will use without fetching Twiml from url. Twiml and url parameters are mutually exclusive
    @jsondata:Name {value: "Twiml"}
    string twiml?;
    # The URL that we call using the `fallback_method` if an error occurs when requesting or executing the TwiML at `url`. If an `application_sid` parameter is present, this parameter is ignored
    @jsondata:Name {value: "FallbackUrl"}
    string fallbackUrl?;
    # The URL we should call using the `status_callback_method` to send status information to your application. If no `status_callback_event` is specified, we will send the `completed` status. If an `application_sid` parameter is present, this parameter is ignored. URLs must contain a valid hostname (underscores are not permitted)
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The HTTP method we should use when calling the `url`. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored
    @jsondata:Name {value: "Method"}
    "GET"|"POST" method?;
    # The absolute URL that returns the TwiML instructions for the call. We will call this URL using the `method` when the call connects. For more information, see the [Url Parameter](https://www.twilio.com/docs/voice/make-calls#specify-a-url-parameter) section in [Making Calls](https://www.twilio.com/docs/voice/make-calls)
    @jsondata:Name {value: "Url"}
    string url?;
    # The maximum duration of the call in seconds. Constraints depend on account and configuration
    @jsondata:Name {value: "TimeLimit"}
    int timeLimit?;
    # The HTTP method that we should use to request the `fallback_url`. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored
    @jsondata:Name {value: "FallbackMethod"}
    "GET"|"POST" fallbackMethod?;
};

# Request parameters for updating call recording settings
public type UpdateCallRecordingRequest record {
    # Recording status to set (paused, stopped, in-progress)
    @jsondata:Name {value: "Status"}
    CallRecordingEnumStatus status;
    # Whether to record during a pause. Can be: `skip` or `silence` and the default is `silence`. `skip` does not record during the pause period, while `silence` will replace the actual audio of the call with silence during the pause period. This parameter only applies when setting `status` is set to `paused`
    @jsondata:Name {value: "PauseBehavior"}
    string pauseBehavior?;
};

# The status of the recording. Can be: `processing`, `completed` and `absent`. For more detailed statuses on in-progress recordings, check out how to [Update a Recording Resource](https://www.twilio.com/docs/voice/api/recording#update-a-recording-resource)
public type ConferenceRecordingEnumStatus "in-progress"|"paused"|"stopped"|"processing"|"completed"|"absent";

# Available status values for updating real-time transcription
public type RealtimeTranscriptionEnumUpdateStatus "stopped";

# Add-on processing result for a recording with status and metadata
public type ApiV2010AccountRecordingRecordingAddOnResult record {
    # A list of related resources identified by their relative URIs
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the Add-on to which the result belongs
    @jsondata:Name {value: "add_on_sid"}
    string? addOnSid?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The date and time in GMT that the result was completed specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_completed"}
    string? dateCompleted?;
    # The SID of the recording to which the AddOnResult resource belongs
    @jsondata:Name {value: "reference_sid"}
    string? referenceSid?;
    # The unique string that that we created to identify the Recording AddOnResult resource
    string? sid?;
    # The status of the result. Can be: `canceled`, `completed`, `deleted`, `failed`, `in-progress`, `init`, `processing`, `queued`
    RecordingAddOnResultEnumStatus status?;
    # The SID of the Add-on configuration
    @jsondata:Name {value: "add_on_configuration_sid"}
    string? addOnConfigurationSid?;
};

# Paginated response containing notification resources and navigation URIs
public type ListNotificationResponse record {
    # URI to the first page of notification results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of items in the current page
    int 'start?;
    # The index of the last notification in this page of results
    int end?;
    # URI for the next page of notification results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of notification results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of this resource
    string uri?;
    # Array of notification objects returned in this response
    ApiV2010AccountNotification[] notifications?;
    # The number of notifications returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response schema for listing media resources with pagination metadata
public type ListMediaResponse record {
    # URI for the first page of media results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of media objects returned in this response
    @jsondata:Name {value: "media_list"}
    ApiV2010AccountMessageMedia[] mediaList?;
    # The index of the first media item in this page of results
    int 'start?;
    # The index of the last media item in this page of results
    int end?;
    # URI for the next page of media results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of media results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The URI of this resource
    string uri?;
    # The number of media items returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Whether the phone number requires an [Address](https://www.twilio.com/docs/usage/api/address) registered with Twilio. Can be: `none`, `any`, `local`, or `foreign`
public type IncomingPhoneNumberEnumAddressRequirement "none"|"any"|"local"|"foreign";

# The status of the transcription. Can be: `in-progress`, `completed`, `failed`
public type RecordingTranscriptionEnumStatus "in-progress"|"completed"|"failed";

# Response schema for listing usage records with pagination metadata
public type ListUsageRecordResponse record {
    # URI for the first page of usage record results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The index of the first usage record in this page of results
    int 'start?;
    # End index of the current page of usage records
    int end?;
    # URI for the next page of usage records, null if no next page exists
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of usage records, null if no previous page exists
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated usage records list
    int page?;
    # URI of the current usage records list resource
    string uri?;
    # Array of usage record objects containing usage data
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecord[] usageRecords?;
    # Number of usage records returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listOutgoingCallerId
public type ListOutgoingCallerIdQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The string that identifies the OutgoingCallerId resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # The phone number of the OutgoingCallerId resources to read
    @http:Query {name: "PhoneNumber"}
    string phoneNumber?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Response schema for listing incoming phone number assigned add-on extensions
public type ListIncomingPhoneNumberAssignedAddOnExtensionResponse record {
    # Array of assigned add-on extension objects for the phone number
    ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOnIncomingPhoneNumberAssignedAddOnExtension[] extensions?;
    # URI for the first page of assigned add-on extensions
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Start index of the current page of assigned add-on extensions
    int 'start?;
    # End index of the current page of assigned add-on extensions
    int end?;
    # URI for the next page of extensions, null if no next page exists
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of extensions, null if no previous page exists
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated extensions list
    int page?;
    # URI of the current assigned add-on extensions list resource
    string uri?;
    # Number of assigned add-on extensions returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listMessage
public type ListMessageQueries record {
    # Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date)
    @http:Query {name: "DateSent"}
    string dateSent?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date)
    @http:Query {name: "DateSent>"}
    string dateSent?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Filter by recipient. For example: Set this parameter to `+15558881111` to retrieve a list of Message resources sent to `+15558881111`
    @http:Query {name: "To"}
    string to?;
    # Filter by sender. For example: Set this parameter to `+15552229999` to retrieve a list of Message resources sent by `+15552229999`
    @http:Query {name: "From"}
    string 'from?;
    # Filter by Message `sent_date`. Accepts GMT dates in the following formats: `YYYY-MM-DD` (to find Messages with a specific `sent_date`), `<=YYYY-MM-DD` (to find Messages with `sent_date`s on and before a specific date), and `>=YYYY-MM-DD` (to find Messages with `sent_dates` on and after a specific date)
    @http:Query {name: "DateSent<"}
    string dateSent?;
};

# Response schema for listing SIP auth calls IP access control list mappings
public type ListSipAuthCallsIpAccessControlListMappingResponse record {
    # URI for the first page of SIP auth calls IP access control list mappings
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of SIP auth calls IP access control list mapping objects
    ApiV2010AccountSipSipDomainSipAuthSipAuthCallsSipAuthCallsIpAccessControlListMapping[] contents?;
    # Starting record index of the current page
    int 'start?;
    # Ending record index of the current page
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Number of records returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request schema for updating payment session status and configuration
public type UpdatePaymentsRequest record {
    # Payment session status to update
    @jsondata:Name {value: "Status"}
    PaymentsEnumStatus status?;
    # A unique token that will be used to ensure that multiple API calls with the same information do not result in multiple transactions. This should be a unique string value per API call and can be a randomly generated
    @jsondata:Name {value: "IdempotencyKey"}
    string idempotencyKey;
    # Provide an absolute or relative URL to receive status updates regarding your Pay session. Read more about the [Update](https://www.twilio.com/docs/voice/api/payment-resource#statuscallback-update) and [Complete/Cancel](https://www.twilio.com/docs/voice/api/payment-resource#statuscallback-cancelcomplete) POST requests
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback;
    # Payment capture configuration setting
    @jsondata:Name {value: "Capture"}
    PaymentsEnumCapture capture?;
};

# Request schema for creating a new Twilio subaccount
public type CreateAccountRequest record {
    # A human readable description of the account to create, defaults to `SubAccount Created at {YYYY-MM-DD HH:MM meridian}`
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
};

# The status of the result. Can be: `canceled`, `completed`, `deleted`, `failed`, `in-progress`, `init`, `processing`, `queued`
public type RecordingAddOnResultEnumStatus "canceled"|"completed"|"deleted"|"failed"|"in-progress"|"init"|"processing"|"queued";

# Response schema for listing SIP auth registrations credential list mappings
public type ListSipAuthRegistrationsCredentialListMappingResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of SIP auth registrations credential list mapping objects
    ApiV2010AccountSipSipDomainSipAuthSipAuthRegistrationsSipAuthRegistrationsCredentialListMapping[] contents?;
    # Starting record index of the current page
    int 'start?;
    # Ending record index of the current page
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request object for updating a signing key
public type UpdateSigningKeyRequest record {
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
};

# Represents the Queries record for the operation: listSigningKey
public type ListSigningKeyQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# The set of permissions that your ConnectApp requests
public type ConnectAppEnumPermission "get-all"|"post-all";

# Response object containing paginated list of transcription resources
public type ListTranscriptionResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Array of transcription resources
    ApiV2010AccountTranscription[] transcriptions?;
    # Ending index of the current page results
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# The status of this account. Usually `active`, but can be `suspended` or `closed`
public type AccountEnumStatus "active"|"suspended"|"closed";

# Usage record data for the last month period
public type ApiV2010AccountUsageUsageRecordUsageRecordLastMonth record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# Response object containing paginated list of queue resources
public type ListQueueResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of queue resources
    ApiV2010AccountQueue[] queues?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated queue list
    int page?;
    # URI of the queue list resource
    string uri?;
    # Number of queue records returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# The status - one of `stopped`, `in-progress`
public type SiprecEnumStatus "in-progress"|"stopped";

# Daily usage record containing billing and consumption data for account services
public type ApiV2010AccountUsageUsageRecordUsageRecordDaily record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# Call event containing request and response data with sensitive information handling
public type ApiV2010AccountCallCallEvent record {
    # Contains a dictionary representing the request of the call
    anydata? request?;
    # Contains a dictionary representing the call response, including a list of the call events
    anydata? response?;
};

# Payment resource for capturing credit card or ACH information via DTMF during calls
public type ApiV2010AccountCallPayments record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Payments resource is associated with. This will refer to the call sid that is producing the payment card (credit/ACH) information thru DTMF
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Payments resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID of the Payments resource
    string? sid?;
};

# Request to create real-time transcription with speech recognition and callback settings
public type CreateRealtimeTranscriptionRequest record {
    # The SID or unique name of the [Intelligence Service](https://www.twilio.com/docs/conversational-intelligence/api/service-resource) for persisting transcripts and running post-call Language Operators
    @jsondata:Name {value: "IntelligenceService"}
    string intelligenceService?;
    # Whether the callback includes raw provider data
    @jsondata:Name {value: "EnableProviderData"}
    boolean enableProviderData?;
    # A Phrase contains words and phrase "hints" so that the speech recognition engine is more likely to recognize them
    @jsondata:Name {value: "Hints"}
    string hints?;
    # Recognition model used by the transcription engine, among those supported by the provider
    @jsondata:Name {value: "SpeechModel"}
    string speechModel?;
    # The provider will add punctuation to recognition result
    @jsondata:Name {value: "EnableAutomaticPunctuation"}
    boolean enableAutomaticPunctuation?;
    # The user-specified name of this Transcription, if one was given when the Transcription was created. This may be used to stop the Transcription
    @jsondata:Name {value: "Name"}
    string name?;
    # Absolute URL of the status callback
    @jsondata:Name {value: "StatusCallbackUrl"}
    string statusCallbackUrl?;
    # Friendly name given to the Outbound Track
    @jsondata:Name {value: "OutboundTrackLabel"}
    string outboundTrackLabel?;
    # Language code used by the transcription engine, specified in [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) format
    @jsondata:Name {value: "LanguageCode"}
    string languageCode?;
    # The http method for the status_callback (one of GET, POST)
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # Indicates if partial results are going to be sent to the customer
    @jsondata:Name {value: "PartialResults"}
    boolean partialResults?;
    # Friendly name given to the Inbound Track
    @jsondata:Name {value: "InboundTrackLabel"}
    string inboundTrackLabel?;
    # Definition of the transcription engine to be used, among those supported by Twilio
    @jsondata:Name {value: "TranscriptionEngine"}
    string transcriptionEngine?;
    # indicates if the server will attempt to filter out profanities, replacing all but the initial character in each filtered word with asterisks
    @jsondata:Name {value: "ProfanityFilter"}
    boolean profanityFilter?;
    # Audio track to transcribe (inbound, outbound, or both)
    @jsondata:Name {value: "Track"}
    RealtimeTranscriptionEnumTrack track?;
};

# Request to map a credential list to SIP domain for authentication
public type CreateSipAuthRegistrationsCredentialListMappingRequest record {
    # The SID of the CredentialList resource to map to the SIP domain
    @jsondata:Name {value: "CredentialListSid"}
    string credentialListSid;
};

# The piece of payment information that you wish the caller to enter. Must be one of `payment-card-number`, `expiration-date`, `security-code`, `postal-code`, `bank-routing-number`, or `bank-account-number`
public type PaymentsEnumCapture "payment-card-number"|"expiration-date"|"security-code"|"postal-code"|"bank-routing-number"|"bank-account-number";

# Enumeration for SIPREC update status with 'stopped' value
public type SiprecEnumUpdateStatus "stopped";

# Represents the Queries record for the operation: listAvailablePhoneNumberCountry
public type ListAvailablePhoneNumberCountryQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Enumeration for conference update status with 'completed' value
public type ConferenceEnumUpdateStatus "completed";

# SIP domain configuration with authentication, voice handling, and security settings
public type ApiV2010AccountSipSipDomain record {
    # The HTTP method we use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_method"}
    "GET"|"POST"? voiceMethod?;
    # Whether an emergency caller sid is configured for the domain. If present, this phone number will be used as the callback for the emergency call
    @jsondata:Name {value: "emergency_caller_sid"}
    string? emergencyCallerSid?;
    # A list of mapping resources associated with the SIP Domain resource identified by their relative URIs
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The types of authentication you have mapped to your domain. Can be: `IP_ACL` and `CREDENTIAL_LIST`. If you have both defined for your domain, both will be returned in a comma delimited string. If `auth_type` is not defined, the domain will not be able to receive any traffic
    @jsondata:Name {value: "auth_type"}
    string? authType?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The URL we call using the `voice_method` when the domain receives a call
    @jsondata:Name {value: "voice_url"}
    string? voiceUrl?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The HTTP method we use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_fallback_method"}
    "GET"|"POST"? voiceFallbackMethod?;
    # The API version used to process the call
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # Whether secure SIP is enabled for the domain. If enabled, TLS will be enforced and SRTP will be negotiated on all incoming calls to this sip domain
    boolean? secure?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # Whether to allow SIP Endpoints to register with the domain to receive calls
    @jsondata:Name {value: "sip_registration"}
    boolean? sipRegistration?;
    # The unique string that that we created to identify the SipDomain resource
    string? sid?;
    # The unique address you reserve on Twilio to which you route your SIP traffic. Domain names can contain letters, digits, and "-" and must end with `sip.twilio.com`
    @jsondata:Name {value: "domain_name"}
    string? domainName?;
    # The URL that we call when an error occurs while retrieving or executing the TwiML requested from `voice_url`
    @jsondata:Name {value: "voice_fallback_url"}
    string? voiceFallbackUrl?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The HTTP method we use to call `voice_status_callback_url`. Either `GET` or `POST`
    @jsondata:Name {value: "voice_status_callback_method"}
    "GET"|"POST"? voiceStatusCallbackMethod?;
    # The SID of the BYOC Trunk(Bring Your Own Carrier) resource that the Sip Domain will be associated with
    @jsondata:Name {value: "byoc_trunk_sid"}
    string? byocTrunkSid?;
    # The URL that we call to pass status parameters (such as call ended) to your application
    @jsondata:Name {value: "voice_status_callback_url"}
    string? voiceStatusCallbackUrl?;
    # Whether emergency calling is enabled for the domain. If enabled, allows emergency calls on the domain from phone numbers with validated addresses
    @jsondata:Name {value: "emergency_calling_enabled"}
    boolean? emergencyCallingEnabled?;
};

# ICE server configuration for WebRTC connectivity with authentication credentials
public type Apiv2010accounttokenIceServers record {
    # Array of ICE server URLs for WebRTC connection establishment
    string urls?;
    # Authentication credential for accessing the ICE server
    string credential?;
    # Single ICE server URL for WebRTC connection
    string url?;
    # Username for ICE server authentication
    string username?;
};

# Represents the Queries record for the operation: listIncomingPhoneNumberTollFree
public type ListIncomingPhoneNumberTollFreeQueries record {
    # Whether to include phone numbers based on their origin. Can be: `twilio` or `hosted`. By default, phone numbers of all origin are included
    @http:Query {name: "Origin"}
    string origin?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # A string that identifies the resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # The phone numbers of the IncomingPhoneNumber resources to read. You can specify partial numbers and use '*' as a wildcard for any digit
    @http:Query {name: "PhoneNumber"}
    string phoneNumber?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Whether to include phone numbers new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
};

# Paginated response containing conference participants with navigation metadata
public type ListParticipantResponse record {
    # URI to the first page of participant results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of participants in the current page
    int 'start?;
    # The index of the last participant returned in the current page
    int end?;
    # The URI for the next page of participants, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # The URI for the previous page of participants, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated result set
    int page?;
    # The URI of the current participant list resource
    string uri?;
    # Array of conference participant objects returned in the response
    ApiV2010AccountConferenceParticipant[] participants?;
    # The number of participants returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response schema for paginated list of yearly usage records
public type ListUsageRecordYearlyResponse record {
    # The URI for the first page of yearly usage records
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The index of the first usage record returned in the current page
    int 'start?;
    # The index of the last usage record returned in the current page
    int end?;
    # The URI for the next page of yearly usage records, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # The URI for the previous page of yearly usage records, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated result set
    int page?;
    # The URI of the current yearly usage records list resource
    string uri?;
    # Array of yearly usage record objects returned in the response
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecordUsageRecordYearly[] usageRecords?;
    # The number of usage records returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request schema for creating a new outbound call with voice configuration options
public type CreateCallRequest record {
    # The URL that we call using the `fallback_method` if an error occurs when requesting or executing the TwiML at `url`. If an `application_sid` parameter is present, this parameter is ignored
    @jsondata:Name {value: "FallbackUrl"}
    string fallbackUrl?;
    # The number of milliseconds that is used as the measuring stick for the length of the speech activity, where durations lower than this value will be interpreted as a human and longer than this value as a machine. Possible Values: 1000-6000. Default: 2400
    @jsondata:Name {value: "MachineDetectionSpeechThreshold"}
    int machineDetectionSpeechThreshold?;
    # The call progress events that we will send to the `status_callback` URL. Can be: `initiated`, `ringing`, `answered`, and `completed`. If no event is specified, we send the `completed` status. If you want to receive multiple events, specify each one in a separate `status_callback_event` parameter. See the code sample for [monitoring call progress](https://www.twilio.com/docs/voice/api/call-resource?code-sample=code-create-a-call-resource-and-specify-a-statuscallbackevent&code-sdk-version=json). If an `application_sid` is present, this parameter is ignored
    @jsondata:Name {value: "StatusCallbackEvent"}
    string[] statusCallbackEvent?;
    # The absolute URL that returns the TwiML instructions for the call. We will call this URL using the `method` when the call connects. For more information, see the [Url Parameter](https://www.twilio.com/docs/voice/make-calls#specify-a-url-parameter) section in [Making Calls](https://www.twilio.com/docs/voice/make-calls)
    @jsondata:Name {value: "Url"}
    string url?;
    # The HTTP method we should use when calling the `async_amd_status_callback` URL. Can be: `GET` or `POST` and the default is `POST`
    @jsondata:Name {value: "AsyncAmdStatusCallbackMethod"}
    "GET"|"POST" asyncAmdStatusCallbackMethod?;
    # TwiML instructions for the call Twilio will use without fetching Twiml from url parameter. If both `twiml` and `url` are provided then `twiml` parameter will be ignored. Max 4000 characters
    @jsondata:Name {value: "Twiml"}
    string twiml?;
    # The Reason for the outgoing call. Use it to specify the purpose of the call that is presented on the called party's phone. (Branded Calls Beta)
    @jsondata:Name {value: "CallReason"}
    string callReason?;
    # The audio track to record for the call. Can be: `inbound`, `outbound` or `both`. The default is `both`. `inbound` records the audio that is received by Twilio. `outbound` records the audio that is generated from Twilio. `both` records the audio that is received and generated by Twilio
    @jsondata:Name {value: "RecordingTrack"}
    string recordingTrack?;
    # The SID of a BYOC (Bring Your Own Carrier) trunk to route this call with. Note that `byoc` is only meaningful when `to` is a phone number; it will otherwise be ignored. (Beta)
    @jsondata:Name {value: "Byoc"}
    string byoc?;
    # Whether to record the call. Can be `true` to record the phone call, or `false` to not. The default is `false`. The `recording_url` is sent to the `status_callback` URL
    @jsondata:Name {value: "Record"}
    boolean 'record?;
    # The URL that we call when the recording is available to be accessed
    @jsondata:Name {value: "RecordingStatusCallback"}
    string recordingStatusCallback?;
    # The phone number, SIP address, or client identifier to call
    @jsondata:Name {value: "To"}
    string to;
    # The number of channels in the final recording. Can be: `mono` or `dual`. The default is `mono`. `mono` records both legs of the call in a single channel of the recording file. `dual` records each leg to a separate channel of the recording file. The first channel of a dual-channel recording contains the parent call and the second channel contains the child call
    @jsondata:Name {value: "RecordingChannels"}
    string recordingChannels?;
    # The username used to authenticate the caller making a SIP call
    @jsondata:Name {value: "SipAuthUsername"}
    string sipAuthUsername?;
    # The maximum duration of the call in seconds. Constraints depend on account and configuration
    @jsondata:Name {value: "TimeLimit"}
    int timeLimit?;
    # A token string needed to invoke a forwarded call. A call_token is generated when an incoming call is received on a Twilio number. Pass an incoming call's call_token value to a forwarded call via the call_token parameter when creating a new call. A forwarded call should bear the same CallerID of the original incoming call
    @jsondata:Name {value: "CallToken"}
    string callToken?;
    # Whether to trim any leading and trailing silence from the recording. Can be: `trim-silence` or `do-not-trim` and the default is `trim-silence`
    @jsondata:Name {value: "Trim"}
    string trim?;
    # The number of milliseconds of silence after speech activity at which point the speech activity is considered complete. Possible Values: 500-5000. Default: 1200
    @jsondata:Name {value: "MachineDetectionSpeechEndThreshold"}
    int machineDetectionSpeechEndThreshold?;
    # The number of milliseconds of initial silence after which an `unknown` AnsweredBy result will be returned. Possible Values: 2000-10000. Default: 5000
    @jsondata:Name {value: "MachineDetectionSilenceTimeout"}
    int machineDetectionSilenceTimeout?;
    # The integer number of seconds that we should allow the phone to ring before assuming there is no answer. The default is `60` seconds and the maximum is `600` seconds. For some call flows, we will add a 5-second buffer to the timeout value you provide. For this reason, a timeout value of 10 seconds could result in an actual timeout closer to 15 seconds. You can set this to a short time, such as `15` seconds, to hang up before reaching an answering machine or voicemail
    @jsondata:Name {value: "Timeout"}
    int timeout?;
    # Whether to detect if a human, answering machine, or fax has picked up the call. Can be: `Enable` or `DetectMessageEnd`. Use `Enable` if you would like us to return `AnsweredBy` as soon as the called party is identified. Use `DetectMessageEnd`, if you would like to leave a message on an answering machine. If `send_digits` is provided, this parameter is ignored. For more information, see [Answering Machine Detection](https://www.twilio.com/docs/voice/answering-machine-detection)
    @jsondata:Name {value: "MachineDetection"}
    string machineDetection?;
    # The URL we should call using the `status_callback_method` to send status information to your application. If no `status_callback_event` is specified, we will send the `completed` status. If an `application_sid` parameter is present, this parameter is ignored. URLs must contain a valid hostname (underscores are not permitted)
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The phone number or client identifier to use as the caller id. If using a phone number, it must be a Twilio number or a Verified [outgoing caller id](https://www.twilio.com/docs/voice/api/outgoing-caller-ids) for your account. If the `to` parameter is a phone number, `From` must also be a phone number
    @jsondata:Name {value: "From"}
    string 'from;
    # The HTTP method we should use when calling the `url` parameter's value. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored
    @jsondata:Name {value: "Method"}
    "GET"|"POST" method?;
    # The URL that we should call using the `async_amd_status_callback_method` to notify customer application whether the call was answered by human, machine or fax
    @jsondata:Name {value: "AsyncAmdStatusCallback"}
    string asyncAmdStatusCallback?;
    # The HTTP method we should use when calling the `recording_status_callback` URL. Can be: `GET` or `POST` and the default is `POST`
    @jsondata:Name {value: "RecordingStatusCallbackMethod"}
    "GET"|"POST" recordingStatusCallbackMethod?;
    # The recording status events that will trigger calls to the URL specified in `recording_status_callback`. Can be: `in-progress`, `completed` and `absent`. Defaults to `completed`. Separate  multiple values with a space
    @jsondata:Name {value: "RecordingStatusCallbackEvent"}
    string[] recordingStatusCallbackEvent?;
    # The string of keys to dial after connecting to the number, with a maximum length of 32 digits. Valid digits in the string include any digit (`0`-`9`), '`A`', '`B`', '`C`', '`D`', '`#`', and '`*`'. You can also use '`w`' to insert a half-second pause and '`W`' to insert a one-second pause. For example, to pause for one second after connecting and then dial extension 1234 followed by the # key, set this parameter to `W1234#`. Be sure to URL-encode this string because the '`#`' character has special meaning in a URL. If both `SendDigits` and `MachineDetection` parameters are provided, then `MachineDetection` will be ignored
    @jsondata:Name {value: "SendDigits"}
    string sendDigits?;
    # The SID of the Application resource that will handle the call, if the call will be handled by an application
    @jsondata:Name {value: "ApplicationSid"}
    string applicationSid?;
    # The HTTP method we should use when calling the `status_callback` URL. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # Select whether to perform answering machine detection in the background. Default, blocks the execution of the call until Answering Machine Detection is completed. Can be: `true` or `false`
    @jsondata:Name {value: "AsyncAmd"}
    string asyncAmd?;
    # The URL that we should use to deliver `push call notification`
    @jsondata:Name {value: "ClientNotificationUrl"}
    string clientNotificationUrl?;
    # The password required to authenticate the user account specified in `sip_auth_username`
    @jsondata:Name {value: "SipAuthPassword"}
    string sipAuthPassword?;
    # The phone number, SIP address, or Client identifier that made this call. Phone numbers are in [E.164 format](https://wwnw.twilio.com/docs/glossary/what-e164) (e.g., +16175551212). SIP addresses are formatted as `name@company.com`
    @jsondata:Name {value: "CallerId"}
    string callerId?;
    # The HTTP method that we should use to request the `fallback_url`. Can be: `GET` or `POST` and the default is `POST`. If an `application_sid` parameter is present, this parameter is ignored
    @jsondata:Name {value: "FallbackMethod"}
    "GET"|"POST" fallbackMethod?;
    # The number of seconds that we should attempt to detect an answering machine before timing out and sending a voice request with `AnsweredBy` of `unknown`. The default timeout is 30 seconds
    @jsondata:Name {value: "MachineDetectionTimeout"}
    int machineDetectionTimeout?;
};

# Response schema for paginated list of current month usage records
public type ListUsageRecordThisMonthResponse record {
    # The URI for the first page of current month usage records
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The index of the first item in this page of results
    int 'start?;
    # The index of the last item in this page of results
    int end?;
    # The URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # The URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number (zero-indexed)
    int page?;
    # The URI of the current page
    string uri?;
    # Array of usage records for the current month
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecordUsageRecordThisMonth[] usageRecords?;
    # The number of items returned in this page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listUsageRecordThisMonth
public type ListUsageRecordThisMonthQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Represents an available mobile phone number with location and capability details
public type ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberMobile record {
    # A formatted version of the phone number
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of this phone number
    @jsondata:Name {value: "iso_country"}
    string? isoCountry?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are: `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountavailablePhoneNumberCountryavailablePhoneNumberLocalCapabilities? capabilities?;
    # The latitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? latitude?;
    # The locality or city of this phone number's location
    string? locality?;
    # The type of [Address](https://www.twilio.com/docs/usage/api/address) resource the phone number requires. Can be: `none`, `any`, `local`, or `foreign`. `none` means no address is required. `any` means an address is required, but it can be anywhere in the world. `local` means an address in the phone number's country is required. `foreign` means an address outside of the phone number's country is required
    @jsondata:Name {value: "address_requirements"}
    string? addressRequirements?;
    # The [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) of this phone number. Available for only phone numbers from the US and Canada
    string? lata?;
    # The [rate center](https://en.wikipedia.org/wiki/Telephone_exchange) of this phone number. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "rate_center"}
    string? rateCenter?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The two-letter state or province abbreviation of this phone number's location. Available for only phone numbers from the US and Canada
    string? region?;
    # The postal or ZIP code of this phone number's location. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "postal_code"}
    string? postalCode?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # The longitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? longitude?;
};

# Response containing a paginated list of available mobile phone numbers
public type ListAvailablePhoneNumberMobileResponse record {
    # The URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of available mobile phone numbers
    @jsondata:Name {value: "available_phone_numbers"}
    ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberMobile[] availablePhoneNumbers?;
    # The index of the first item in this page of results
    int 'start?;
    # The index of the last item in this page of results
    int end?;
    # The URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # The URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number (zero-indexed)
    int page?;
    # The URI of the current page
    string uri?;
    # The number of items returned in this page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Machine-to-machine available phone number with location and capability details
public type ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberMachineToMachine record {
    # A formatted version of the phone number
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of this phone number
    @jsondata:Name {value: "iso_country"}
    string? isoCountry?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are: `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountavailablePhoneNumberCountryavailablePhoneNumberLocalCapabilities? capabilities?;
    # The latitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? latitude?;
    # The locality or city of this phone number's location
    string? locality?;
    # The type of [Address](https://www.twilio.com/docs/usage/api/address) resource the phone number requires. Can be: `none`, `any`, `local`, or `foreign`. `none` means no address is required. `any` means an address is required, but it can be anywhere in the world. `local` means an address in the phone number's country is required. `foreign` means an address outside of the phone number's country is required
    @jsondata:Name {value: "address_requirements"}
    string? addressRequirements?;
    # The [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) of this phone number. Available for only phone numbers from the US and Canada
    string? lata?;
    # The [rate center](https://en.wikipedia.org/wiki/Telephone_exchange) of this phone number. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "rate_center"}
    string? rateCenter?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The two-letter state or province abbreviation of this phone number's location. Available for only phone numbers from the US and Canada
    string? region?;
    # The postal or ZIP code of this phone number's location. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "postal_code"}
    string? postalCode?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # The longitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? longitude?;
};

# Represents the Queries record for the operation: listIncomingPhoneNumberMobile
public type ListIncomingPhoneNumberMobileQueries record {
    # Whether to include phone numbers based on their origin. Can be: `twilio` or `hosted`. By default, phone numbers of all origin are included
    @http:Query {name: "Origin"}
    string origin?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # A string that identifies the resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # The phone numbers of the IncomingPhoneNumber resources to read. You can specify partial numbers and use '*' as a wildcard for any digit
    @http:Query {name: "PhoneNumber"}
    string phoneNumber?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Whether to include phone numbers new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
};

# The status of the Stream. Possible values are `stopped` and `in-progress`
public type StreamEnumStatus "in-progress"|"stopped";

# Request object for creating payment sessions with Twilio Pay
public type CreatePaymentsRequest record {
    # A unique token that will be used to ensure that multiple API calls with the same information do not result in multiple transactions. This should be a unique string value per API call and can be a randomly generated
    @jsondata:Name {value: "IdempotencyKey"}
    string idempotencyKey;
    # This is the unique name corresponding to the Pay Connector installed in the Twilio Add-ons. Learn more about [<Pay> Connectors](https://www.twilio.com/console/voice/pay-connectors). The default value is `Default`
    @jsondata:Name {value: "PaymentConnector"}
    string paymentConnector?;
    # The description can be used to provide more details regarding the transaction. This information is submitted along with the payment details to the Payment Connector which are then posted on the transactions
    @jsondata:Name {value: "Description"}
    string description?;
    # The number of seconds that <Pay> should wait for the caller to press a digit between each subsequent digit, after the first one, before moving on to validate the digits captured. The default is `5`, maximum is `600`
    @jsondata:Name {value: "Timeout"}
    int timeout?;
    # A positive integer that is used to validate the length of the `PostalCode` inputted by the user. User must enter this many digits
    @jsondata:Name {value: "MinPostalCodeLength"}
    int minPostalCodeLength?;
    # Indicates whether the credit card postal code (zip code) is a required piece of payment information that must be provided by the caller. The default is `true`
    @jsondata:Name {value: "PostalCode"}
    boolean postalCode?;
    # Provide an absolute or relative URL to receive status updates regarding your Pay session. Read more about the [expected StatusCallback values](https://www.twilio.com/docs/voice/api/payment-resource#statuscallback)
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback;
    # A positive decimal value less than 1,000,000 to charge against the credit card or bank account. Default currency can be overwritten with `currency` field. Leave blank or set to 0 to tokenize
    @jsondata:Name {value: "ChargeAmount"}
    decimal chargeAmount?;
    # A list of inputs that should be accepted. Currently only `dtmf` is supported. All digits captured during a pay session are redacted from the logs
    @jsondata:Name {value: "Input"}
    string input?;
    # Type of payment token to generate
    @jsondata:Name {value: "TokenType"}
    PaymentsEnumTokenType tokenType?;
    # The currency of the `charge_amount`, formatted as [ISO 4127](http://www.iso.org/iso/home/standards/currency_codes.htm) format. The default value is `USD` and all values allowed from the Pay Connector are accepted
    @jsondata:Name {value: "Currency"}
    string currency?;
    # Type of bank account for ACH payments
    @jsondata:Name {value: "BankAccountType"}
    PaymentsEnumBankAccountType bankAccountType?;
    # A single-level JSON object used to pass custom parameters to payment processors. (Required for ACH payments). The information that has to be included here depends on the <Pay> Connector. [Read more](https://www.twilio.com/console/voice/pay-connectors)
    @jsondata:Name {value: "Parameter"}
    anydata 'parameter?;
    # Payment method to accept (credit card, ACH, etc.)
    @jsondata:Name {value: "PaymentMethod"}
    PaymentsEnumPaymentMethod paymentMethod?;
    # Credit card types separated by space that Pay should accept. The default value is `visa mastercard amex`
    @jsondata:Name {value: "ValidCardTypes"}
    string validCardTypes?;
    # Indicates whether the credit card security code is a required piece of payment information that must be provided by the caller. The default is `true`
    @jsondata:Name {value: "SecurityCode"}
    boolean securityCode?;
};

# Paginated response containing available toll-free phone numbers
public type ListAvailablePhoneNumberTollFreeResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of available toll-free phone numbers
    @jsondata:Name {value: "available_phone_numbers"}
    ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberTollFree[] availablePhoneNumbers?;
    # Starting index of results on current page
    int 'start?;
    # Ending index of results on current page
    int end?;
    # URI to the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number
    int page?;
    # URI of the current resource
    string uri?;
    # Number of results per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Paginated response containing SIP credential list mappings
public type ListSipCredentialListMappingResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of results on current page
    int 'start?;
    # Ending index of results on current page
    int end?;
    # URI for the next page of results in the paginated response
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results in the paginated response
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated response
    int page?;
    # URI of the current resource
    string uri?;
    # Array of SIP credential list mapping resources
    @jsondata:Name {value: "credential_list_mappings"}
    ApiV2010AccountSipSipDomainSipCredentialListMapping[] credentialListMappings?;
    # Number of items per page in the paginated response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request schema for updating message properties
public type UpdateMessageRequest record {
    # New status to set for the message
    @jsondata:Name {value: "Status"}
    MessageEnumUpdateStatus status?;
    # The new `body` of the Message resource. To redact the text content of a Message, this parameter's value must be an empty string
    @jsondata:Name {value: "Body"}
    string body?;
};

# User-defined message subscription associated with a call
public type ApiV2010AccountCallUserDefinedMessageSubscription record {
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the User Defined Message Subscription is associated with. This refers to the Call SID that is producing the User Defined Messages
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The date that this User Defined Message Subscription was created, given in RFC 2822 format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that subscribed to the User Defined Messages
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI of the User Defined Message Subscription Resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID that uniquely identifies this User Defined Message Subscription
    string? sid?;
};

# All-time usage record containing billing and usage information
public type ApiV2010AccountUsageUsageRecordUsageRecordAllTime record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# Request schema for updating outgoing caller ID properties
public type UpdateOutgoingCallerIdRequest record {
    # A descriptive string that you create to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
};

# Request schema for updating incoming phone number configuration
public type UpdateIncomingPhoneNumberRequest record {
    # The HTTP method that we should use to call `sms_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsFallbackMethod"}
    "GET"|"POST" smsFallbackMethod?;
    # The API version to use for incoming calls made to the phone number. The default is `2010-04-01`
    @jsondata:Name {value: "ApiVersion"}
    string apiVersion?;
    # The URL we should call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "SmsUrl"}
    string smsUrl?;
    # The SID of the application we should use to handle phone calls to the phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use only those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "VoiceApplicationSid"}
    string voiceApplicationSid?;
    # The HTTP method that we should use to call `voice_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # A descriptive string that you created to describe this phone number. It can be up to 64 characters long. By default, this is a formatted version of the phone number
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether to lookup the caller's name from the CNAM database and post it to your app. Can be: `true` or `false` and defaults to `false`
    @jsondata:Name {value: "VoiceCallerIdLookup"}
    boolean voiceCallerIdLookup?;
    # The URL we should call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The SID of the Trunk we should use to handle phone calls to the phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use only those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "TrunkSid"}
    string trunkSid?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "BundleSid"}
    string bundleSid?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IncomingPhoneNumber resource to update.  For more information, see [Exchanging Numbers Between Subaccounts](https://www.twilio.com/docs/iam/api/subaccounts#exchanging-numbers)
    @jsondata:Name {value: "AccountSid"}
    string accountSid?;
    # The SID of the emergency address configuration to use for emergency calling from this phone number
    @jsondata:Name {value: "EmergencyAddressSid"}
    string emergencyAddressSid?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # The SID of the Identity resource that we should associate with the phone number. Some regions require an identity to meet local regulations
    @jsondata:Name {value: "IdentitySid"}
    string identitySid?;
    # The URL that we should call when an error occurs while requesting or executing the TwiML defined by `sms_url`
    @jsondata:Name {value: "SmsFallbackUrl"}
    string smsFallbackUrl?;
    # The HTTP method that we should use to call `voice_fallback_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # Voice receive mode for incoming calls to the phone number
    @jsondata:Name {value: "VoiceReceiveMode"}
    IncomingPhoneNumberEnumVoiceReceiveMode voiceReceiveMode?;
    # The SID of the application that should handle SMS messages sent to the number. If an `sms_application_sid` is present, we ignore all of the `sms_*_url` urls and use those set on the application
    @jsondata:Name {value: "SmsApplicationSid"}
    string smsApplicationSid?;
    # The URL that we should call to answer a call to the phone number. The `voice_url` will not be called if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The SID of the Address resource we should associate with the phone number. Some regions require addresses to meet local regulations
    @jsondata:Name {value: "AddressSid"}
    string addressSid?;
    # The HTTP method that we should use to call `sms_url`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "SmsMethod"}
    "GET"|"POST" smsMethod?;
    # Emergency calling status for the phone number
    @jsondata:Name {value: "EmergencyStatus"}
    IncomingPhoneNumberEnumEmergencyStatus emergencyStatus?;
    # The URL that we should call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# Request schema for updating address information
public type UpdateAddressRequest record {
    # A descriptive string that you create to describe the new address. It can be up to 64 characters long for Regulatory Compliance addresses and 32 characters long for Emergency addresses
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether to enable emergency calling on the address. Can be: `true` or `false`
    @jsondata:Name {value: "EmergencyEnabled"}
    boolean emergencyEnabled?;
    # The number and street address of the address
    @jsondata:Name {value: "Street"}
    string street?;
    # The state or region of the address
    @jsondata:Name {value: "Region"}
    string region?;
    # The postal code of the address
    @jsondata:Name {value: "PostalCode"}
    string postalCode?;
    # Whether we should automatically correct the address. Can be: `true` or `false` and the default is `true`. If empty or `true`, we will correct the address you provide if necessary. If `false`, we won't alter the address you provide
    @jsondata:Name {value: "AutoCorrectAddress"}
    boolean autoCorrectAddress?;
    # The name to associate with the address
    @jsondata:Name {value: "CustomerName"}
    string customerName?;
    # The city of the address
    @jsondata:Name {value: "City"}
    string city?;
    # The additional number and street address of the address
    @jsondata:Name {value: "StreetSecondary"}
    string streetSecondary?;
};

# Represents the Queries record for the operation: listApplication
public type ListApplicationQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The string that identifies the Application resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Signing key resource for API request authentication
public type ApiV2010AccountSigningKey record {
    # Human-readable name for the signing key
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # Date and time when the signing key was last updated
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # Date and time when the signing key was created
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # Unique identifier for the signing key resource
    string? sid?;
};

# Represents the Queries record for the operation: listAvailablePhoneNumberMachineToMachine
public type ListAvailablePhoneNumberMachineToMachineQueries record {
    # Whether the phone numbers can receive calls. Can be: `true` or `false`
    @http:Query {name: "VoiceEnabled"}
    boolean voiceEnabled?;
    # Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeForeignAddressRequired"}
    boolean excludeForeignAddressRequired?;
    # Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InPostalCode"}
    string inPostalCode?;
    # Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InLata"}
    string inLata?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether the phone numbers can receive MMS messages. Can be: `true` or `false`
    @http:Query {name: "MmsEnabled"}
    boolean mmsEnabled?;
    # Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearNumber"}
    string nearNumber?;
    # Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRegion"}
    string inRegion?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # Whether the phone numbers can receive text messages. Can be: `true` or `false`
    @http:Query {name: "SmsEnabled"}
    boolean smsEnabled?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRateCenter"}
    string inRateCenter?;
    # Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
    # Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearLatLong"}
    string nearLatLong?;
    # Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeLocalAddressRequired"}
    boolean excludeLocalAddressRequired?;
    # Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number
    @http:Query {name: "InLocality"}
    string inLocality?;
    # Matching pattern to identify phone numbers. This pattern can be between 2 and 16 characters long and allows all digits (0-9) and all non-diacritic latin alphabet letters (a-z, A-Z). It accepts four meta-characters: `*`, `%`, `+`, `$`. The `*` and `%` meta-characters can appear multiple times in the pattern. To match wildcards at the beginning or end of the pattern, use `*` to match any single character or `%` to match a sequence of characters. If you use the wildcard patterns, it must include at least two non-meta-characters, and wildcards cannot be used between non-meta-characters. To match the beginning of a pattern, start the pattern with `+`. To match the end of the pattern, append the pattern with `$`. These meta-characters can't be adjacent to each other
    @http:Query {name: "Contains"}
    string contains?;
    # The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada
    @http:Query {name: "AreaCode"}
    int areaCode?;
    # Whether the phone numbers can receive faxes. Can be: `true` or `false`
    @http:Query {name: "FaxEnabled"}
    boolean faxEnabled?;
    # The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada
    @http:Query {name: "Distance"}
    int distance?;
    # Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeAllAddressRequired"}
    boolean excludeAllAddressRequired?;
};

# Response object containing paginated list of dependent phone numbers
public type ListDependentPhoneNumberResponse record {
    # Array of phone numbers that depend on the address
    @jsondata:Name {value: "dependent_phone_numbers"}
    ApiV2010AccountAddressDependentPhoneNumber[] dependentPhoneNumbers?;
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Index of the first item in the current page
    int 'start?;
    # Index of the last item in the current page
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response object containing paginated list of available national phone numbers
public type ListAvailablePhoneNumberNationalResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of available national phone numbers for purchase
    @jsondata:Name {value: "available_phone_numbers"}
    ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberNational[] availablePhoneNumbers?;
    # Index of the first item in the current page
    int 'start?;
    # Index of the last item in the current page
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# For Messaging Services only: Include this parameter with a value of `fixed` in conjuction with the `send_time` parameter in order to [schedule a Message](https://www.twilio.com/docs/messaging/features/message-scheduling)
public type MessageEnumScheduleType "fixed";

# Response schema for listing available shared cost phone numbers
public type ListAvailablePhoneNumberSharedCostResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of available shared cost phone numbers
    @jsondata:Name {value: "available_phone_numbers"}
    ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberSharedCost[] availablePhoneNumbers?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI for the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI for the current page of results
    string uri?;
    # Number of results per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response schema for listing call notifications
public type ListCallNotificationResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI for the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI for the current page of results
    string uri?;
    # Array of call notification objects
    ApiV2010AccountCallCallNotification[] notifications?;
    # Number of results per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listNotification
public type ListNotificationQueries record {
    # Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date
    @http:Query {name: "MessageDate"}
    string messageDate?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Only read notifications of the specified log level. Can be:  `0` to read only ERROR notifications or `1` to read only WARNING notifications. By default, all notifications are read
    @http:Query {name: "Log"}
    int log?;
    # Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date
    @http:Query {name: "MessageDate>"}
    string messageDate?;
    # Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date
    @http:Query {name: "MessageDate<"}
    string messageDate?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# SIP IP address resource with access control and CIDR configuration
public type ApiV2010AccountSipSipIpAccessControlListSipIpAddress record {
    # A human readable descriptive text for this resource, up to 255 characters long
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date that this resource was last updated, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # An integer representing the length of the CIDR prefix to use with this IP address when accepting traffic. By default the entire IP address is used
    @jsondata:Name {value: "cidr_prefix_length"}
    int cidrPrefixLength = 0;
    # The date that this resource was created, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The unique id of the Account that is responsible for this resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # An IP address in dotted decimal notation from which you want to accept traffic. Any SIP requests from this IP address will be allowed by Twilio. IPv4 only supported today
    @jsondata:Name {value: "ip_address"}
    string? ipAddress?;
    # The unique id of the IpAccessControlList resource that includes this resource
    @jsondata:Name {value: "ip_access_control_list_sid"}
    string? ipAccessControlListSid?;
    # The URI for this resource, relative to `https://api.twilio.com`
    string? uri?;
    # A 34 character string that uniquely identifies this resource
    string? sid?;
};

# Represents the Queries record for the operation: listUsageRecord
public type ListUsageRecordQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Monthly usage record containing billing and consumption data
public type ApiV2010AccountUsageUsageRecordUsageRecordMonthly record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# SIP domain credential list mapping for call authentication
public type ApiV2010AccountSipSipDomainSipAuthSipAuthCallsSipAuthCallsCredentialListMapping record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The unique string that that we created to identify the CredentialListMapping resource
    string? sid?;
};

# The set of permissions that you authorized for the Connect App.  Can be: `get-all` or `post-all`
public type AuthorizedConnectAppEnumPermission "get-all"|"post-all";

# Available toll-free phone number with location and capability details
public type ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberTollFree record {
    # A formatted version of the phone number
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of this phone number
    @jsondata:Name {value: "iso_country"}
    string? isoCountry?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are: `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountavailablePhoneNumberCountryavailablePhoneNumberLocalCapabilities? capabilities?;
    # The latitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? latitude?;
    # The locality or city of this phone number's location
    string? locality?;
    # The type of [Address](https://www.twilio.com/docs/usage/api/address) resource the phone number requires. Can be: `none`, `any`, `local`, or `foreign`. `none` means no address is required. `any` means an address is required, but it can be anywhere in the world. `local` means an address in the phone number's country is required. `foreign` means an address outside of the phone number's country is required
    @jsondata:Name {value: "address_requirements"}
    string? addressRequirements?;
    # The [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) of this phone number. Available for only phone numbers from the US and Canada
    string? lata?;
    # The [rate center](https://en.wikipedia.org/wiki/Telephone_exchange) of this phone number. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "rate_center"}
    string? rateCenter?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The two-letter state or province abbreviation of this phone number's location. Available for only phone numbers from the US and Canada
    string? region?;
    # The postal or ZIP code of this phone number's location. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "postal_code"}
    string? postalCode?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # The longitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? longitude?;
};

# Paginated response containing a list of call resources
public type ListCallResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of call resources in the current page
    ApiV2010AccountCall[] calls?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI to the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listSipIpAddress
public type ListSipIpAddressQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# System notification for API errors and warnings
public type ApiV2010AccountNotification record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # An integer log level that corresponds to the type of notification: `0` is ERROR, `1` is WARNING
    string? log?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL for more information about the error condition. This value is a page in our [Error Dictionary](https://www.twilio.com/docs/api/errors)
    @jsondata:Name {value: "more_info"}
    string? moreInfo?;
    # The HTTP method used to generate the notification. If the notification was generated during a phone call, this is the HTTP Method used to request the resource on your server. If the notification was generated by your use of our REST API, this is the HTTP method used to call the resource on our servers
    @jsondata:Name {value: "request_method"}
    "GET"|"POST"? requestMethod?;
    # The API version used to generate the notification. Can be empty for events that don't have a specific API version, such as incoming phone calls
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URL of the resource that generated the notification. If the notification was generated during a phone call, this is the URL of the resource on your server that caused the notification. If the notification was generated by your use of our REST API, this is the URL of the resource you called
    @jsondata:Name {value: "request_url"}
    string? requestUrl?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Notification resource
    string? sid?;
    # The text of the notification
    @jsondata:Name {value: "message_text"}
    string? messageText?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Notification resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The date the notification was actually generated in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format. Message buffering can cause this value to differ from `date_created`
    @jsondata:Name {value: "message_date"}
    string? messageDate?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Notification resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # A unique error code for the error condition that is described in our [Error Dictionary](https://www.twilio.com/docs/api/errors)
    @jsondata:Name {value: "error_code"}
    string? errorCode?;
};

# SIP domain IP access control list mapping configuration
public type ApiV2010AccountSipSipDomainSipIpAccessControlListMapping record {
    # A human readable descriptive text for this resource, up to 64 characters long
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date that this resource was last updated, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The unique string that is created to identify the SipDomain resource
    @jsondata:Name {value: "domain_sid"}
    string? domainSid?;
    # The date that this resource was created, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The unique id of the Account that is responsible for this resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI for this resource, relative to `https://api.twilio.com`
    string? uri?;
    # A 34 character string that uniquely identifies this resource
    string? sid?;
};

# Whether the phone number requires an [Address](https://www.twilio.com/docs/usage/api/address) registered with Twilio. Can be: `none`, `any`, `local`, or `foreign`
public type IncomingPhoneNumberMobileEnumAddressRequirement "none"|"any"|"local"|"foreign";

# Represents the Queries record for the operation: listSipIpAccessControlList
public type ListSipIpAccessControlListQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Conference call resource with participant and status information
public type ApiV2010AccountConference record {
    # A list of related resources identified by their URIs relative to `https://api.twilio.com`
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # A string that you assigned to describe this conference room. Maximum length is 128 characters
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in UTC that this resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in UTC that this resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Conference resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The call SID that caused the conference to end
    @jsondata:Name {value: "call_sid_ending_conference"}
    string? callSidEndingConference?;
    # The API version used to create this conference
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # A string that represents the Twilio Region where the conference audio was mixed. May be `us1`, `us2`, `ie1`,  `de1`, `sg1`, `br1`, `au1`, and `jp1`. Basic conference audio will always be mixed in `us1`. Global Conference audio will be mixed nearest to the majority of participants
    string? region?;
    # The URI of this resource, relative to `https://api.twilio.com`
    string? uri?;
    # Reason why the conference call ended
    @jsondata:Name {value: "reason_conference_ended"}
    ConferenceEnumReasonConferenceEnded reasonConferenceEnded?;
    # The unique, Twilio-provided string used to identify this Conference resource
    string? sid?;
    # The status of this conference. Can be: `init`, `in-progress`, or `completed`
    ConferenceEnumStatus status?;
};

# Request object for creating message feedback with outcome information
public type CreateMessageFeedbackRequest record {
    # The feedback outcome for the message delivery attempt
    @jsondata:Name {value: "Outcome"}
    MessageFeedbackEnumOutcome outcome?;
};

# Represents the Queries record for the operation: listSipIpAccessControlListMapping
public type ListSipIpAccessControlListMappingQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Response containing paginated list of outgoing caller ID resources
public type ListOutgoingCallerIdResponse record {
    # Array of outgoing caller ID resources
    @jsondata:Name {value: "outgoing_caller_ids"}
    ApiV2010AccountOutgoingCallerId[] outgoingCallerIds?;
    # URI of the first page in the paginated results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI of the next page in the paginated results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI of the previous page in the paginated results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page in the paginated results
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request object for mapping a credential list to a SIP domain
public type CreateSipCredentialListMappingRequest record {
    # A 34 character string that uniquely identifies the CredentialList resource to map to the SIP domain
    @jsondata:Name {value: "CredentialListSid"}
    string credentialListSid;
};

# Response containing paginated list of SIP IP access control lists
public type ListSipIpAccessControlListResponse record {
    # Array of SIP IP access control list resources
    @jsondata:Name {value: "ip_access_control_lists"}
    ApiV2010AccountSipSipIpAccessControlList[] ipAccessControlLists?;
    # URI of the first page in the paginated results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI of the next page in the paginated results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI of the previous page in the paginated results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated response
    int page?;
    # URI of the current page
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Response schema for listing Twilio accounts with pagination metadata
public type ListAccountResponse record {
    # URI of the first page in the result set
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI of the next page, null if no next page exists
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI of the previous page, null if no previous page exists
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Array of Twilio account objects
    ApiV2010Account[] accounts?;
    # Current page number in the paginated response
    int page?;
    # URI of the current page
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listAvailablePhoneNumberVoip
public type ListAvailablePhoneNumberVoipQueries record {
    # Whether the phone numbers can receive calls. Can be: `true` or `false`
    @http:Query {name: "VoiceEnabled"}
    boolean voiceEnabled?;
    # Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeForeignAddressRequired"}
    boolean excludeForeignAddressRequired?;
    # Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InPostalCode"}
    string inPostalCode?;
    # Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InLata"}
    string inLata?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether the phone numbers can receive MMS messages. Can be: `true` or `false`
    @http:Query {name: "MmsEnabled"}
    boolean mmsEnabled?;
    # Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearNumber"}
    string nearNumber?;
    # Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRegion"}
    string inRegion?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # Whether the phone numbers can receive text messages. Can be: `true` or `false`
    @http:Query {name: "SmsEnabled"}
    boolean smsEnabled?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRateCenter"}
    string inRateCenter?;
    # Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
    # Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearLatLong"}
    string nearLatLong?;
    # Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeLocalAddressRequired"}
    boolean excludeLocalAddressRequired?;
    # Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number
    @http:Query {name: "InLocality"}
    string inLocality?;
    # Matching pattern to identify phone numbers. This pattern can be between 2 and 16 characters long and allows all digits (0-9) and all non-diacritic latin alphabet letters (a-z, A-Z). It accepts four meta-characters: `*`, `%`, `+`, `$`. The `*` and `%` meta-characters can appear multiple times in the pattern. To match wildcards at the beginning or end of the pattern, use `*` to match any single character or `%` to match a sequence of characters. If you use the wildcard patterns, it must include at least two non-meta-characters, and wildcards cannot be used between non-meta-characters. To match the beginning of a pattern, start the pattern with `+`. To match the end of the pattern, append the pattern with `$`. These meta-characters can't be adjacent to each other
    @http:Query {name: "Contains"}
    string contains?;
    # The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada
    @http:Query {name: "AreaCode"}
    int areaCode?;
    # Whether the phone numbers can receive faxes. Can be: `true` or `false`
    @http:Query {name: "FaxEnabled"}
    boolean faxEnabled?;
    # The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada
    @http:Query {name: "Distance"}
    int distance?;
    # Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeAllAddressRequired"}
    boolean excludeAllAddressRequired?;
};

# Response schema for listing incoming phone numbers with pagination metadata
public type ListIncomingPhoneNumberResponse record {
    # URI of the first page in the result set
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI of the next page, null if no next page exists
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI of the previous page, null if no previous page exists
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated response
    int page?;
    # Array of incoming phone number resources
    @jsondata:Name {value: "incoming_phone_numbers"}
    ApiV2010AccountIncomingPhoneNumber[] incomingPhoneNumbers?;
    # URI of the incoming phone numbers list resource
    string uri?;
    # Number of resources returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listUsageRecordYesterday
public type ListUsageRecordYesterdayQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Represents the Queries record for the operation: listCallEvent
public type ListCallEventQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Recording resource containing audio file details and metadata
public type ApiV2010AccountRecording record {
    # A list of related resources identified by their relative URIs
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # How to decrypt the recording if it was encrypted using [Call Recording Encryption](https://www.twilio.com/docs/voice/tutorials/voice-recording-encryption) feature
    @jsondata:Name {value: "encryption_details"}
    anydata? encryptionDetails?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The Conference SID that identifies the conference associated with the recording, if a conference recording
    @jsondata:Name {value: "conference_sid"}
    string? conferenceSid?;
    # How the recording was created. Can be: `DialVerb`, `Conference`, `OutboundAPI`, `Trunking`, `RecordVerb`, `StartCallRecordingAPI`, and `StartConferenceRecordingAPI`
    RecordingEnumSource 'source?;
    # The API version used during the recording
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The URL of the media file associated with this recording resource. When stored externally, this is the full URL location of the media file
    @jsondata:Name {value: "media_url"}
    string? mediaUrl?;
    # The unique string that that we created to identify the Recording resource
    string? sid?;
    # The length of the recording in seconds
    string? duration?;
    # The currency used in the `price` property. Example: `USD`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The start time of the recording in GMT and in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "start_time"}
    string? startTime?;
    # The number of channels in the recording resource. For information on specifying the number of channels in the downloaded recording file, check out [Fetch a Recording’s media file](https://www.twilio.com/docs/voice/api/recording#download-dual-channel-media-file)
    int? channels?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Recording resource is associated with. This will always refer to the parent leg of a two-leg call
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The one-time cost of creating the recording in the `price_unit` currency
    string? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The error code that describes why the recording is `absent`. The error code is described in our [Error Dictionary](https://www.twilio.com/docs/api/errors). This value is null if the recording `status` is not `absent`
    @jsondata:Name {value: "error_code"}
    int? errorCode?;
    # The status of the recording. Can be: `processing`, `completed`, `absent` or `deleted`. For information about more detailed statuses on in-progress recordings, check out how to [Update a Recording Resource](https://www.twilio.com/docs/voice/api/recording#update-a-recording-resource)
    RecordingEnumStatus status?;
};

# The reason why a conference ended. When a conference is in progress, will be `null`. When conference is completed, can be: `conference-ended-via-api`, `participant-with-end-conference-on-exit-left`, `participant-with-end-conference-on-exit-kicked`, `last-participant-kicked`, or `last-participant-left`
public type ConferenceEnumReasonConferenceEnded "conference-ended-via-api"|"participant-with-end-conference-on-exit-left"|"participant-with-end-conference-on-exit-kicked"|"last-participant-kicked"|"last-participant-left";

# Voice receive mode for toll-free incoming phone numbers
public type IncomingPhoneNumberTollFreeEnumVoiceReceiveMode "voice"|"fax";

# Represents the Queries record for the operation: listKey
public type ListKeyQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# SIP credential list resource for authentication management
public type ApiV2010AccountSipSipCredentialList record {
    # A list of credentials associated with this credential list
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # A human readable descriptive text that describes the CredentialList, up to 64 characters long
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date that this resource was last updated, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date that this resource was created, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The unique id of the [Account](https://www.twilio.com/docs/iam/api/account) that owns this resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI for this resource, relative to `https://api.twilio.com`
    string? uri?;
    # A 34 character string that uniquely identifies this resource
    string? sid?;
};

# Call resource containing call details and status information
public type ApiV2010AccountCall record {
    # The SID that identifies the call that created this leg
    @jsondata:Name {value: "parent_call_sid"}
    string? parentCallSid?;
    # A list of subresources available to this call, identified by their URIs relative to `https://api.twilio.com`
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The date and time in UTC that this resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The unique identifier of the trunk resource that was used for this call. The field is empty if the call was not made using a SIP trunk or if the call is not terminated
    @jsondata:Name {value: "trunk_sid"}
    string? trunkSid?;
    # Either `human` or `machine` if this call was initiated with answering machine detection. Empty otherwise
    @jsondata:Name {value: "answered_by"}
    string? answeredBy?;
    # If the call was inbound, this is the SID of the IncomingPhoneNumber resource that received the call. If the call was outbound, it is the SID of the OutgoingCallerId resource from which the call was placed
    @jsondata:Name {value: "phone_number_sid"}
    string? phoneNumberSid?;
    # The unique string that we created to identify this Call resource
    string? sid?;
    # The length of the call in seconds. This value is empty for busy, failed, unanswered, or ongoing calls
    string? duration?;
    # The caller's name if this call was an incoming call to a phone number with caller ID Lookup enabled. Otherwise, empty
    @jsondata:Name {value: "caller_name"}
    string? callerName?;
    # The charge for this call, in the currency associated with the account. Populated after the call is completed. May not be immediately available. The price associated with a call only reflects the charge for connectivity.  Charges for other call-related features such as Answering Machine Detection, Text-To-Speech, and SIP REFER are not included in this value
    string? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Call resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The phone number, SIP address, Client identifier or SIM SID that made this call. Phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +16175551212). SIP addresses are formatted as `name@company.com`. Client identifiers are formatted `client:name`. SIM SIDs are formatted as `sim:sid`
    string? 'from?;
    # The phone number, SIP address or Client identifier that received this call. Formatted for display. Non-North American phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +442071838750)
    @jsondata:Name {value: "to_formatted"}
    string? toFormatted?;
    # A string describing the direction of the call. Can be: `inbound` for inbound calls, `outbound-api` for calls initiated via the REST API or `outbound-dial` for calls initiated by a `<Dial>` verb. Using [Elastic SIP Trunking](https://www.twilio.com/docs/sip-trunking), the values can be [`trunking-terminating`](https://www.twilio.com/docs/sip-trunking#termination) for outgoing calls from your communications infrastructure to the PSTN or [`trunking-originating`](https://www.twilio.com/docs/sip-trunking#origination) for incoming calls to your communications infrastructure from the PSTN
    string? direction?;
    # The forwarding phone number if this call was an incoming call forwarded from another number (depends on carrier supporting forwarding). Otherwise, empty
    @jsondata:Name {value: "forwarded_from"}
    string? forwardedFrom?;
    # The date and time in UTC that this resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The time the call ended, given as UTC in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format. Empty if the call did not complete successfully
    @jsondata:Name {value: "end_time"}
    string? endTime?;
    # The API version used to create the call
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of this resource, relative to `https://api.twilio.com`
    string? uri?;
    # The Group SID associated with this call. If no Group is associated with the call, the field is empty
    @jsondata:Name {value: "group_sid"}
    string? groupSid?;
    # The currency in which `Price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format (e.g., `USD`, `EUR`, `JPY`). Always capitalized for calls
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The wait time in milliseconds before the call is placed
    @jsondata:Name {value: "queue_time"}
    string? queueTime?;
    # The start time of the call, given as UTC in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format. Empty if the call has not yet been dialed
    @jsondata:Name {value: "start_time"}
    string? startTime?;
    # The phone number, SIP address, Client identifier or SIM SID that received this call. Phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +16175551212). SIP addresses are formatted as `name@company.com`. Client identifiers are formatted `client:name`. SIM SIDs are formatted as `sim:sid`
    string? to?;
    # The calling phone number, SIP address, or Client identifier formatted for display. Non-North American phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +442071838750)
    @jsondata:Name {value: "from_formatted"}
    string? fromFormatted?;
    # The status of this call. Can be: `queued`, `ringing`, `in-progress`, `canceled`, `completed`, `failed`, `busy` or `no-answer`. See [Call Status Values](https://www.twilio.com/docs/voice/api/call-resource#call-status-values) below for more information
    CallEnumStatus status?;
};

# Request to create a conference participant with call settings
public type CreateParticipantRequest record {
    # The URL that we should call using the `amd_status_callback_method` to notify customer application whether the call was answered by human, machine or fax
    @jsondata:Name {value: "AmdStatusCallback"}
    string amdStatusCallback?;
    # The SID of the participant who is being `coached`. The participant being coached is the only participant who can hear the participant who is `coaching`
    @jsondata:Name {value: "CallSidToCoach"}
    string callSidToCoach?;
    # A label for this participant. If one is supplied, it may subsequently be used to fetch, update or delete the participant
    @jsondata:Name {value: "Label"}
    string label?;
    # The conference state changes that should generate a call to `conference_status_callback`. Can be: `start`, `end`, `join`, `leave`, `mute`, `hold`, `modify`, `speaker`, and `announcement`. Separate multiple values with a space. Defaults to `start end`
    @jsondata:Name {value: "ConferenceStatusCallbackEvent"}
    string[] conferenceStatusCallbackEvent?;
    # The conference state changes that should generate a call to `status_callback`. Can be: `initiated`, `ringing`, `answered`, and `completed`. Separate multiple values with a space. The default value is `completed`
    @jsondata:Name {value: "StatusCallbackEvent"}
    string[] statusCallbackEvent?;
    # The HTTP method we should use to call `conference_status_callback`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "ConferenceStatusCallbackMethod"}
    "GET"|"POST" conferenceStatusCallbackMethod?;
    # The Reason for the outgoing call. Use it to specify the purpose of the call that is presented on the called party's phone. (Branded Calls Beta)
    @jsondata:Name {value: "CallReason"}
    string callReason?;
    # The audio track to record for the call. Can be: `inbound`, `outbound` or `both`. The default is `both`. `inbound` records the audio that is received by Twilio. `outbound` records the audio that is sent from Twilio. `both` records the audio that is received and sent by Twilio
    @jsondata:Name {value: "RecordingTrack"}
    string recordingTrack?;
    # The SID of a BYOC (Bring Your Own Carrier) trunk to route this call with. Note that `byoc` is only meaningful when `to` is a phone number; it will otherwise be ignored. (Beta)
    @jsondata:Name {value: "Byoc"}
    string byoc?;
    # Whether to record the conference the participant is joining. Can be: `true`, `false`, `record-from-start`, and `do-not-record`. The default value is `false`
    @jsondata:Name {value: "ConferenceRecord"}
    string conferenceRecord?;
    # The URL that we should call using the `recording_status_callback_method` when the recording status changes
    @jsondata:Name {value: "RecordingStatusCallback"}
    string recordingStatusCallback?;
    # The phone number, SIP address, Client, TwiML App identifier that received this call. Phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +16175551212). SIP addresses are formatted as `sip:name@company.com`. Client identifiers are formatted `client:name`. TwiML App identifiers are formatted `app:<APP_SID>`. [Custom parameters](https://www.twilio.com/docs/voice/api/conference-participant-resource#custom-parameters) may also be specified
    @jsondata:Name {value: "To"}
    string to;
    # The recording channels for the final recording. Can be: `mono` or `dual` and the default is `mono`
    @jsondata:Name {value: "RecordingChannels"}
    string recordingChannels?;
    # The URL we should call using the `conference_status_callback_method` when the conference events in `conference_status_callback_event` occur. Only the value set by the first participant to join the conference is used. Subsequent `conference_status_callback` values are ignored
    @jsondata:Name {value: "ConferenceStatusCallback"}
    string conferenceStatusCallback?;
    # The HTTP method we should use to call `conference_recording_status_callback`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "ConferenceRecordingStatusCallbackMethod"}
    "GET"|"POST" conferenceRecordingStatusCallbackMethod?;
    # The number of milliseconds of silence after speech activity at which point the speech activity is considered complete. Possible Values: 500-5000. Default: 1200
    @jsondata:Name {value: "MachineDetectionSpeechEndThreshold"}
    int machineDetectionSpeechEndThreshold?;
    # The number of seconds that we should allow the phone to ring before assuming there is no answer. Can be an integer between `5` and `600`, inclusive. The default value is `60`. We always add a 5-second timeout buffer to outgoing calls, so  value of 10 would result in an actual timeout that was closer to 15 seconds
    @jsondata:Name {value: "Timeout"}
    int timeout?;
    # Whether to start the conference when the participant joins, if it has not already started. Can be: `true` or `false` and the default is `true`. If `false` and the conference has not started, the participant is muted and hears background music until another participant starts the conference
    @jsondata:Name {value: "StartConferenceOnEnter"}
    boolean startConferenceOnEnter?;
    # The [region](https://support.twilio.com/hc/en-us/articles/223132167-How-global-low-latency-routing-and-region-selection-work-for-conferences-and-Client-calls) where we should mix the recorded audio. Can be:`us1`, `us2`, `ie1`, `de1`, `sg1`, `br1`, `au1`, or `jp1`
    @jsondata:Name {value: "Region"}
    string region?;
    # The maximum number of participants in the conference. Can be a positive integer from `2` to `250`. The default value is `250`
    @jsondata:Name {value: "MaxParticipants"}
    int maxParticipants?;
    # The SIP password for authentication
    @jsondata:Name {value: "SipAuthPassword"}
    string sipAuthPassword?;
    # The phone number, Client identifier, or username portion of SIP address that made this call. Phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +16175551212). Client identifiers are formatted `client:name`. If using a phone number, it must be a Twilio number or a Verified [outgoing caller id](https://www.twilio.com/docs/voice/api/outgoing-caller-ids) for your account. If the `to` parameter is a phone number, `callerId` must also be a phone number. If `to` is sip address, this value of `callerId` should be a username portion to be used to populate the From header that is passed to the SIP endpoint
    @jsondata:Name {value: "CallerId"}
    string callerId?;
    # Whether the agent is muted in the conference. Can be `true` or `false` and the default is `false`
    @jsondata:Name {value: "Muted"}
    boolean muted?;
    # The number of seconds that we should attempt to detect an answering machine before timing out and sending a voice request with `AnsweredBy` of `unknown`. The default timeout is 30 seconds
    @jsondata:Name {value: "MachineDetectionTimeout"}
    int machineDetectionTimeout?;
    # The HTTP method we should use when calling the `amd_status_callback` URL. Can be: `GET` or `POST` and the default is `POST`
    @jsondata:Name {value: "AmdStatusCallbackMethod"}
    "GET"|"POST" amdStatusCallbackMethod?;
    # Whether the participant is coaching another call. Can be: `true` or `false`. If not present, defaults to `false` unless `call_sid_to_coach` is defined. If `true`, `call_sid_to_coach` must be defined
    @jsondata:Name {value: "Coaching"}
    boolean coaching?;
    # The URL we should call using the `conference_recording_status_callback_method` when the conference recording is available
    @jsondata:Name {value: "ConferenceRecordingStatusCallback"}
    string conferenceRecordingStatusCallback?;
    # Whether to end the conference when the participant leaves. Can be: `true` or `false` and defaults to `false`
    @jsondata:Name {value: "EndConferenceOnExit"}
    boolean endConferenceOnExit?;
    # The number of milliseconds that is used as the measuring stick for the length of the speech activity, where durations lower than this value will be interpreted as a human and longer than this value as a machine. Possible Values: 1000-6000. Default: 2400
    @jsondata:Name {value: "MachineDetectionSpeechThreshold"}
    int machineDetectionSpeechThreshold?;
    # Whether to trim leading and trailing silence from the conference recording. Can be: `trim-silence` or `do-not-trim` and defaults to `trim-silence`
    @jsondata:Name {value: "ConferenceTrim"}
    string conferenceTrim?;
    # Whether to play a notification beep to the conference when the participant joins. Can be: `true`, `false`, `onEnter`, or `onExit`. The default value is `true`
    @jsondata:Name {value: "Beep"}
    string beep?;
    # The conference recording state changes that generate a call to `conference_recording_status_callback`. Can be: `in-progress`, `completed`, `failed`, and `absent`. Separate multiple values with a space, ex: `'in-progress completed failed'`
    @jsondata:Name {value: "ConferenceRecordingStatusCallbackEvent"}
    string[] conferenceRecordingStatusCallbackEvent?;
    # Whether to record the participant and their conferences, including the time between conferences. Can be `true` or `false` and the default is `false`
    @jsondata:Name {value: "Record"}
    boolean 'record?;
    # The URL that Twilio calls using the `wait_method` before the conference has started. The URL may return an MP3 file, a WAV file, or a TwiML document. The default value is the URL of our standard hold music. If you do not want anything to play while waiting for the conference to start, specify an empty string by setting `wait_url` to `''`. For more details on the allowable verbs within the `waitUrl`, see the `waitUrl` attribute in the [<Conference> TwiML instruction](https://www.twilio.com/docs/voice/twiml/conference#attributes-waiturl)
    @jsondata:Name {value: "WaitUrl"}
    string waitUrl?;
    # The SIP username used for authentication
    @jsondata:Name {value: "SipAuthUsername"}
    string sipAuthUsername?;
    # The maximum duration of the call in seconds. Constraints depend on account and configuration
    @jsondata:Name {value: "TimeLimit"}
    int timeLimit?;
    # A token string needed to invoke a forwarded call. A call_token is generated when an incoming call is received on a Twilio number. Pass an incoming call's call_token value to a forwarded call via the call_token parameter when creating a new call. A forwarded call should bear the same CallerID of the original incoming call
    @jsondata:Name {value: "CallToken"}
    string callToken?;
    # The number of milliseconds of initial silence after which an `unknown` AnsweredBy result will be returned. Possible Values: 2000-10000. Default: 5000
    @jsondata:Name {value: "MachineDetectionSilenceTimeout"}
    int machineDetectionSilenceTimeout?;
    # Whether to trim any leading and trailing silence from the participant recording. Can be: `trim-silence` or `do-not-trim` and the default is `trim-silence`
    @jsondata:Name {value: "Trim"}
    string trim?;
    # Whether to allow an agent to hear the state of the outbound call, including ringing or disconnect messages. Can be: `true` or `false` and defaults to `true`
    @jsondata:Name {value: "EarlyMedia"}
    boolean earlyMedia?;
    # Jitter buffer size for the connecting participant. Twilio will use this setting to apply Jitter Buffer before participant's audio is mixed into the conference. Can be: `off`, `small`, `medium`, and `large`. Default to `large`
    @jsondata:Name {value: "JitterBufferSize"}
    string jitterBufferSize?;
    # Whether to detect if a human, answering machine, or fax has picked up the call. Can be: `Enable` or `DetectMessageEnd`. Use `Enable` if you would like us to return `AnsweredBy` as soon as the called party is identified. Use `DetectMessageEnd`, if you would like to leave a message on an answering machine. For more information, see [Answering Machine Detection](https://www.twilio.com/docs/voice/answering-machine-detection)
    @jsondata:Name {value: "MachineDetection"}
    string machineDetection?;
    # The URL we should call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The HTTP method we should use to call `wait_url`. Can be `GET` or `POST` and the default is `POST`. When using a static audio file, this should be `GET` so that we can cache the file
    @jsondata:Name {value: "WaitMethod"}
    "GET"|"POST" waitMethod?;
    # The phone number, Client identifier, or username portion of SIP address that made this call. Phone numbers are in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (e.g., +16175551212). Client identifiers are formatted `client:name`. If using a phone number, it must be a Twilio number or a Verified [outgoing caller id](https://www.twilio.com/docs/voice/api/outgoing-caller-ids) for your account. If the `to` parameter is a phone number, `from` must also be a phone number. If `to` is sip address, this value of `from` should be a username portion to be used to populate the P-Asserted-Identity header that is passed to the SIP endpoint
    @jsondata:Name {value: "From"}
    string 'from;
    # The HTTP method we should use when we call `recording_status_callback`. Can be: `GET` or `POST` and defaults to `POST`
    @jsondata:Name {value: "RecordingStatusCallbackMethod"}
    "GET"|"POST" recordingStatusCallbackMethod?;
    # The recording state changes that should generate a call to `recording_status_callback`. Can be: `started`, `in-progress`, `paused`, `resumed`, `stopped`, `completed`, `failed`, and `absent`. Separate multiple values with a space, ex: `'in-progress completed failed'`
    @jsondata:Name {value: "RecordingStatusCallbackEvent"}
    string[] recordingStatusCallbackEvent?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` and `POST` and defaults to `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # The URL that we should use to deliver `push call notification`
    @jsondata:Name {value: "ClientNotificationUrl"}
    string clientNotificationUrl?;
    # The name that populates the display name in the From header. Must be between 2 and 255 characters. Only applicable for calls to sip address
    @jsondata:Name {value: "CallerDisplayName"}
    string callerDisplayName?;
};

# Call notification instance containing error and status details
public type ApiV2010AccountCallCallNotificationInstance record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # An integer log level that corresponds to the type of notification: `0` is ERROR, `1` is WARNING
    string? log?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL for more information about the error condition. This value is a page in our [Error Dictionary](https://www.twilio.com/docs/api/errors)
    @jsondata:Name {value: "more_info"}
    string? moreInfo?;
    # The HTTP body returned by your server
    @jsondata:Name {value: "response_body"}
    string? responseBody?;
    # The HTTP method used to generate the notification. If the notification was generated during a phone call, this is the HTTP Method used to request the resource on your server. If the notification was generated by your use of our REST API, this is the HTTP method used to call the resource on our servers
    @jsondata:Name {value: "request_method"}
    "GET"|"POST"? requestMethod?;
    # The API version used to create the Call Notification resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URL of the resource that generated the notification. If the notification was generated during a phone call, this is the URL of the resource on your server that caused the notification. If the notification was generated by your use of our REST API, this is the URL of the resource you called
    @jsondata:Name {value: "request_url"}
    string? requestUrl?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Call Notification resource
    string? sid?;
    # The text of the notification
    @jsondata:Name {value: "message_text"}
    string? messageText?;
    # The HTTP headers returned by your server
    @jsondata:Name {value: "response_headers"}
    string? responseHeaders?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Call Notification resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The date the notification was actually generated in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format. Message buffering can cause this value to differ from `date_created`
    @jsondata:Name {value: "message_date"}
    string? messageDate?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call Notification resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The HTTP GET or POST variables we sent to your server. However, if the notification was generated by our REST API, this contains the HTTP POST or PUT variables you sent to our API
    @jsondata:Name {value: "request_variables"}
    string? requestVariables?;
    # A unique error code for the error condition that is described in our [Error Dictionary](https://www.twilio.com/docs/api/errors)
    @jsondata:Name {value: "error_code"}
    string? errorCode?;
};

# Address resource for regulatory compliance and emergency services
public type ApiV2010AccountAddress record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The ISO country code of the address
    @jsondata:Name {value: "iso_country"}
    string? isoCountry?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The city in which the address is located
    string? city?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # Whether the address has been verified to comply with regulation. In countries that require valid addresses, an invalid address will not be accepted. `true` indicates the Address has been verified. `false` indicate the country doesn't require verified or the Address is not valid
    boolean? verified?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Address resource
    string? sid?;
    # Whether the address has been validated to comply with local regulation. In countries that require valid addresses, an invalid address will not be accepted. `true` indicates the Address has been validated. `false` indicate the country doesn't require validation or the Address is not valid
    boolean? validated?;
    # The number and street address of the address
    string? street?;
    # Whether emergency calling has been enabled on this number
    @jsondata:Name {value: "emergency_enabled"}
    boolean? emergencyEnabled?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that is responsible for the Address resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The name associated with the address.This property has a maximum length of 16 4-byte characters, or 21 3-byte characters
    @jsondata:Name {value: "customer_name"}
    string? customerName?;
    # The postal code of the address
    @jsondata:Name {value: "postal_code"}
    string? postalCode?;
    # The state or region of the address
    string? region?;
    # The additional number and street address of the address
    @jsondata:Name {value: "street_secondary"}
    string? streetSecondary?;
};

# Represents the Queries record for the operation: listAvailablePhoneNumberTollFree
public type ListAvailablePhoneNumberTollFreeQueries record {
    # Whether the phone numbers can receive calls. Can be: `true` or `false`
    @http:Query {name: "VoiceEnabled"}
    boolean voiceEnabled?;
    # Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeForeignAddressRequired"}
    boolean excludeForeignAddressRequired?;
    # Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InPostalCode"}
    string inPostalCode?;
    # Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InLata"}
    string inLata?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether the phone numbers can receive MMS messages. Can be: `true` or `false`
    @http:Query {name: "MmsEnabled"}
    boolean mmsEnabled?;
    # Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearNumber"}
    string nearNumber?;
    # Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRegion"}
    string inRegion?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # Whether the phone numbers can receive text messages. Can be: `true` or `false`
    @http:Query {name: "SmsEnabled"}
    boolean smsEnabled?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRateCenter"}
    string inRateCenter?;
    # Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
    # Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearLatLong"}
    string nearLatLong?;
    # Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeLocalAddressRequired"}
    boolean excludeLocalAddressRequired?;
    # Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number
    @http:Query {name: "InLocality"}
    string inLocality?;
    # Matching pattern to identify phone numbers. This pattern can be between 2 and 16 characters long and allows all digits (0-9) and all non-diacritic latin alphabet letters (a-z, A-Z). It accepts four meta-characters: `*`, `%`, `+`, `$`. The `*` and `%` meta-characters can appear multiple times in the pattern. To match wildcards at the beginning or end of the pattern, use `*` to match any single character or `%` to match a sequence of characters. If you use the wildcard patterns, it must include at least two non-meta-characters, and wildcards cannot be used between non-meta-characters. To match the beginning of a pattern, start the pattern with `+`. To match the end of the pattern, append the pattern with `$`. These meta-characters can't be adjacent to each other
    @http:Query {name: "Contains"}
    string contains?;
    # The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada
    @http:Query {name: "AreaCode"}
    int areaCode?;
    # Whether the phone numbers can receive faxes. Can be: `true` or `false`
    @http:Query {name: "FaxEnabled"}
    boolean faxEnabled?;
    # The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada
    @http:Query {name: "Distance"}
    int distance?;
    # Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeAllAddressRequired"}
    boolean excludeAllAddressRequired?;
};

# Notification instance containing error and status information
public type ApiV2010AccountNotificationInstance record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # An integer log level that corresponds to the type of notification: `0` is ERROR, `1` is WARNING
    string? log?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL for more information about the error condition. This value is a page in our [Error Dictionary](https://www.twilio.com/docs/api/errors)
    @jsondata:Name {value: "more_info"}
    string? moreInfo?;
    # The HTTP body returned by your server
    @jsondata:Name {value: "response_body"}
    string? responseBody?;
    # The HTTP method used to generate the notification. If the notification was generated during a phone call, this is the HTTP Method used to request the resource on your server. If the notification was generated by your use of our REST API, this is the HTTP method used to call the resource on our servers
    @jsondata:Name {value: "request_method"}
    "GET"|"POST"? requestMethod?;
    # The API version used to generate the notification. Can be empty for events that don't have a specific API version, such as incoming phone calls
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URL of the resource that generated the notification. If the notification was generated during a phone call, this is the URL of the resource on your server that caused the notification. If the notification was generated by your use of our REST API, this is the URL of the resource you called
    @jsondata:Name {value: "request_url"}
    string? requestUrl?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Notification resource
    string? sid?;
    # The text of the notification
    @jsondata:Name {value: "message_text"}
    string? messageText?;
    # The HTTP headers returned by your server
    @jsondata:Name {value: "response_headers"}
    string? responseHeaders?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Notification resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The date the notification was actually generated in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format. Message buffering can cause this value to differ from `date_created`
    @jsondata:Name {value: "message_date"}
    string? messageDate?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Notification resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The HTTP GET or POST variables we sent to your server. However, if the notification was generated by our REST API, this contains the HTTP POST or PUT variables you sent to our API
    @jsondata:Name {value: "request_variables"}
    string? requestVariables?;
    # A unique error code for the error condition that is described in our [Error Dictionary](https://www.twilio.com/docs/api/errors)
    @jsondata:Name {value: "error_code"}
    string? errorCode?;
};

# Queue member resource representing a call waiting in queue
public type ApiV2010AccountQueueMember record {
    # The number of seconds the member has been in the queue
    @jsondata:Name {value: "wait_time"}
    int waitTime = 0;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Member resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The SID of the Queue the member is in
    @jsondata:Name {value: "queue_sid"}
    string? queueSid?;
    # The date that the member was enqueued, given in RFC 2822 format
    @jsondata:Name {value: "date_enqueued"}
    string? dateEnqueued?;
    # This member's current position in the queue
    int position = 0;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
};

# Request to create a user-defined message event subscription
public type CreateUserDefinedMessageSubscriptionRequest record {
    # A unique string value to identify API call. This should be a unique string value per API call and can be a randomly generated
    @jsondata:Name {value: "IdempotencyKey"}
    string idempotencyKey?;
    # The URL we should call using the `method` to send user defined events to your application. URLs must contain a valid hostname (underscores are not permitted)
    @jsondata:Name {value: "Callback"}
    string callback;
    # The HTTP method Twilio will use when requesting the above `Url`. Either `GET` or `POST`. Default is `POST`
    @jsondata:Name {value: "Method"}
    "GET"|"POST" method?;
};

# Request to create a TwiML application with voice and SMS settings
public type CreateApplicationRequest record {
    # The HTTP method we should use to call `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "SmsFallbackMethod"}
    "GET"|"POST" smsFallbackMethod?;
    # The API version to use to start a new TwiML session. Can be: `2010-04-01` or `2008-08-01`. The default value is the account's default API version
    @jsondata:Name {value: "ApiVersion"}
    string apiVersion?;
    # The HTTP method we should use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # The URL we should call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "SmsUrl"}
    string smsUrl?;
    # A descriptive string that you create to describe the new application. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether we should look up the caller's caller-ID name from the CNAM database (additional charges apply). Can be: `true` or `false`
    @jsondata:Name {value: "VoiceCallerIdLookup"}
    boolean voiceCallerIdLookup?;
    # The URL we should call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The URL we should call using a POST method to send status information about SMS messages sent by the application
    @jsondata:Name {value: "SmsStatusCallback"}
    string smsStatusCallback?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # The URL that we should call when an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "SmsFallbackUrl"}
    string smsFallbackUrl?;
    # Whether to allow other Twilio accounts to dial this applicaton using Dial verb. Can be: `true` or `false`
    @jsondata:Name {value: "PublicApplicationConnectEnabled"}
    boolean publicApplicationConnectEnabled?;
    # The HTTP method we should use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # The URL we should call using a POST method to send message status information to your application
    @jsondata:Name {value: "MessageStatusCallback"}
    string messageStatusCallback?;
    # The URL we should call when the phone number assigned to this application receives a call
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The HTTP method we should use to call `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "SmsMethod"}
    "GET"|"POST" smsMethod?;
    # The URL that we should call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# Request to update Connect App configuration and permissions
public type UpdateConnectAppRequest record {
    # The company name to set for the Connect App
    @jsondata:Name {value: "CompanyName"}
    string companyName?;
    # A description of the Connect App
    @jsondata:Name {value: "Description"}
    string description?;
    # A descriptive string that you create to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # A comma-separated list of the permissions you will request from the users of this ConnectApp.  Can include: `get-all` and `post-all`
    @jsondata:Name {value: "Permissions"}
    ConnectAppEnumPermission[] permissions?;
    # The URL to redirect the user to after we authenticate the user and obtain authorization to access the Connect App
    @jsondata:Name {value: "AuthorizeRedirectUrl"}
    string authorizeRedirectUrl?;
    # The HTTP method to use when calling `deauthorize_callback_url`
    @jsondata:Name {value: "DeauthorizeCallbackMethod"}
    "GET"|"POST" deauthorizeCallbackMethod?;
    # The URL to call using the `deauthorize_callback_method` to de-authorize the Connect App
    @jsondata:Name {value: "DeauthorizeCallbackUrl"}
    string deauthorizeCallbackUrl?;
    # A public URL where users can obtain more information about this Connect App
    @jsondata:Name {value: "HomepageUrl"}
    string homepageUrl?;
};

# One of `inbound_track`, `outbound_track`, `both_tracks`
public type RealtimeTranscriptionEnumTrack "inbound_track"|"outbound_track"|"both_tracks";

# Available shared-cost phone number with location and capability details
public type ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberSharedCost record {
    # A formatted version of the phone number
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of this phone number
    @jsondata:Name {value: "iso_country"}
    string? isoCountry?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are: `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountavailablePhoneNumberCountryavailablePhoneNumberLocalCapabilities? capabilities?;
    # The latitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? latitude?;
    # The locality or city of this phone number's location
    string? locality?;
    # The type of [Address](https://www.twilio.com/docs/usage/api/address) resource the phone number requires. Can be: `none`, `any`, `local`, or `foreign`. `none` means no address is required. `any` means an address is required, but it can be anywhere in the world. `local` means an address in the phone number's country is required. `foreign` means an address outside of the phone number's country is required
    @jsondata:Name {value: "address_requirements"}
    string? addressRequirements?;
    # The [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) of this phone number. Available for only phone numbers from the US and Canada
    string? lata?;
    # The [rate center](https://en.wikipedia.org/wiki/Telephone_exchange) of this phone number. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "rate_center"}
    string? rateCenter?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The two-letter state or province abbreviation of this phone number's location. Available for only phone numbers from the US and Canada
    string? region?;
    # The postal or ZIP code of this phone number's location. Available for only phone numbers from the US and Canada
    @jsondata:Name {value: "postal_code"}
    string? postalCode?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # The longitude of this phone number's location. Available for only phone numbers from the US and Canada
    decimal? longitude?;
};

# Request schema for updating SIPREC recording status
public type UpdateSiprecRequest record {
    # The desired status for the SIPREC recording session
    @jsondata:Name {value: "Status"}
    SiprecEnumUpdateStatus status;
};

# Request schema for updating conference settings and announcements
public type UpdateConferenceRequest record {
    # The desired status for the conference
    @jsondata:Name {value: "Status"}
    ConferenceEnumUpdateStatus status?;
    # The HTTP method used to call `announce_url`. Can be: `GET` or `POST` and the default is `POST`
    @jsondata:Name {value: "AnnounceMethod"}
    "GET"|"POST" announceMethod?;
    # The URL we should call to announce something into the conference. The URL may return an MP3 file, a WAV file, or a TwiML document that contains `<Play>`, `<Say>`, `<Pause>`, or `<Redirect>` verbs
    @jsondata:Name {value: "AnnounceUrl"}
    string announceUrl?;
};

# Request schema for creating SIP authentication credentials
public type CreateSipCredentialRequest record {
    # The username that will be passed when authenticating SIP requests. The username should be sent in response to Twilio's challenge of the initial INVITE. It can be up to 32 characters long
    @jsondata:Name {value: "Username"}
    string username;
    # The password that the username will use when authenticating SIP requests. The password must be a minimum of 12 characters, contain at least 1 digit, and have mixed case. (eg `IWasAtSignal2018`)
    @jsondata:Name {value: "Password"}
    string password;
};

# Request schema for updating real-time transcription status
public type UpdateRealtimeTranscriptionRequest record {
    # The desired status for the real-time transcription session
    @jsondata:Name {value: "Status"}
    RealtimeTranscriptionEnumUpdateStatus status;
};

# Represents the Queries record for the operation: listConference
public type ListConferenceQueries record {
    # The status of the resources to read. Can be: `init`, `in-progress`, or `completed`
    @http:Query {name: "Status"}
    ConferenceEnumStatus status?;
    # Only include conferences that were last updated on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only conferences that were last updated on this date. You can also specify an inequality, such as `DateUpdated<=YYYY-MM-DD`, to read conferences that were last updated on or before midnight of this date, and `DateUpdated>=YYYY-MM-DD` to read conferences that were last updated on or after midnight of this date
    @http:Query {name: "DateUpdated<"}
    string dateUpdated?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The string that identifies the Conference resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # Only include conferences that were last updated on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only conferences that were last updated on this date. You can also specify an inequality, such as `DateUpdated<=YYYY-MM-DD`, to read conferences that were last updated on or before midnight of this date, and `DateUpdated>=YYYY-MM-DD` to read conferences that were last updated on or after midnight of this date
    @http:Query {name: "DateUpdated"}
    string dateUpdated?;
    # Only include conferences that were created on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only conferences that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read conferences that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read conferences that were created on or after midnight of this date
    @http:Query {name: "DateCreated<"}
    string dateCreated?;
    # Only include conferences that were created on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only conferences that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read conferences that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read conferences that were created on or after midnight of this date
    @http:Query {name: "DateCreated"}
    string dateCreated?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include conferences that were created on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only conferences that were created on this date. You can also specify an inequality, such as `DateCreated<=YYYY-MM-DD`, to read conferences that were created on or before midnight of this date, and `DateCreated>=YYYY-MM-DD` to read conferences that were created on or after midnight of this date
    @http:Query {name: "DateCreated>"}
    string dateCreated?;
    # Only include conferences that were last updated on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only conferences that were last updated on this date. You can also specify an inequality, such as `DateUpdated<=YYYY-MM-DD`, to read conferences that were last updated on or before midnight of this date, and `DateUpdated>=YYYY-MM-DD` to read conferences that were last updated on or after midnight of this date
    @http:Query {name: "DateUpdated>"}
    string dateUpdated?;
};

# Response schema containing paginated list of recording transcriptions
public type ListRecordingTranscriptionResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page
    int 'start?;
    # Array of recording transcription objects
    ApiV2010AccountRecordingRecordingTranscription[] transcriptions?;
    # Ending index of the current page
    int end?;
    # URI for the next page of results, null if no more pages
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, null if first page
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listUsageRecordYearly
public type ListUsageRecordYearlyQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Represents the Queries record for the operation: listAvailablePhoneNumberMobile
public type ListAvailablePhoneNumberMobileQueries record {
    # Whether the phone numbers can receive calls. Can be: `true` or `false`
    @http:Query {name: "VoiceEnabled"}
    boolean voiceEnabled?;
    # Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeForeignAddressRequired"}
    boolean excludeForeignAddressRequired?;
    # Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InPostalCode"}
    string inPostalCode?;
    # Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InLata"}
    string inLata?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether the phone numbers can receive MMS messages. Can be: `true` or `false`
    @http:Query {name: "MmsEnabled"}
    boolean mmsEnabled?;
    # Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearNumber"}
    string nearNumber?;
    # Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRegion"}
    string inRegion?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # Whether the phone numbers can receive text messages. Can be: `true` or `false`
    @http:Query {name: "SmsEnabled"}
    boolean smsEnabled?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRateCenter"}
    string inRateCenter?;
    # Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
    # Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearLatLong"}
    string nearLatLong?;
    # Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeLocalAddressRequired"}
    boolean excludeLocalAddressRequired?;
    # Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number
    @http:Query {name: "InLocality"}
    string inLocality?;
    # Matching pattern to identify phone numbers. This pattern can be between 2 and 16 characters long and allows all digits (0-9) and all non-diacritic latin alphabet letters (a-z, A-Z). It accepts four meta-characters: `*`, `%`, `+`, `$`. The `*` and `%` meta-characters can appear multiple times in the pattern. To match wildcards at the beginning or end of the pattern, use `*` to match any single character or `%` to match a sequence of characters. If you use the wildcard patterns, it must include at least two non-meta-characters, and wildcards cannot be used between non-meta-characters. To match the beginning of a pattern, start the pattern with `+`. To match the end of the pattern, append the pattern with `$`. These meta-characters can't be adjacent to each other
    @http:Query {name: "Contains"}
    string contains?;
    # The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada
    @http:Query {name: "AreaCode"}
    int areaCode?;
    # Whether the phone numbers can receive faxes. Can be: `true` or `false`
    @http:Query {name: "FaxEnabled"}
    boolean faxEnabled?;
    # The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada
    @http:Query {name: "Distance"}
    int distance?;
    # Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeAllAddressRequired"}
    boolean excludeAllAddressRequired?;
};

# The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are: `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
public type Apiv2010accountavailablePhoneNumberCountryavailablePhoneNumberLocalCapabilities record {
    # Indicates if the phone number supports voice calls
    boolean voice?;
    # Indicates if the phone number supports MMS messaging
    boolean mms?;
    # Indicates if the phone number supports SMS messaging
    boolean sms?;
    # Indicates whether the phone number supports fax capabilities
    boolean fax?;
};

# Response schema for listing toll-free incoming phone numbers
public type ListIncomingPhoneNumberTollFreeResponse record {
    # URI for the first page of results in the paginated response
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page in the result set
    int 'start?;
    # Ending index of the current page in the result set
    int end?;
    # URI for the next page of results, null if no more pages exist
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, null if on first page
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated response
    int page?;
    # Array of toll-free incoming phone number objects
    @jsondata:Name {value: "incoming_phone_numbers"}
    ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberTollFree[] incomingPhoneNumbers?;
    # URI of the current resource
    string uri?;
    # Number of items returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# The status of the recording. Can be: `processing`, `completed` and `absent`. For more detailed statuses on in-progress recordings, check out how to [Update a Recording Resource](https://www.twilio.com/docs/voice/api/recording#update-a-recording-resource)
public type CallRecordingEnumStatus "in-progress"|"paused"|"stopped"|"processing"|"completed"|"absent";

# Token resource for Twilio authentication and access credentials
public type ApiV2010AccountToken record {
    # The temporary password that the username will use when authenticating with Twilio
    string? password?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Token resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # An array representing the ephemeral credentials and the STUN and TURN server URIs
    @jsondata:Name {value: "ice_servers"}
    Apiv2010accounttokenIceServers[]? iceServers?;
    # The duration in seconds for which the username and password are valid
    string? ttl?;
    # The temporary username that uniquely identifies a Token
    string? username?;
};

# Represents the Queries record for the operation: listUsageRecordAllTime
public type ListUsageRecordAllTimeQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Response schema for listing SIP IP access control list mappings
public type ListSipIpAccessControlListMappingResponse record {
    # URI for the first page of results in the paginated response
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of SIP IP access control list mapping objects
    @jsondata:Name {value: "ip_access_control_list_mappings"}
    ApiV2010AccountSipSipDomainSipIpAccessControlListMapping[] ipAccessControlListMappings?;
    # Starting index of the current page in the result set
    int 'start?;
    # Ending index of the current page in the result set
    int end?;
    # URI for the next page of results, null if no more pages exist
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, null if on first page
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated response
    int page?;
    # URI of the SIP IP access control list mapping resource
    string uri?;
    # Number of items returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Voice receive mode for mobile phone numbers (voice or fax)
public type IncomingPhoneNumberMobileEnumVoiceReceiveMode "voice"|"fax";

# Request object for updating a stream resource
public type UpdateStreamRequest record {
    # New status to set for the stream
    @jsondata:Name {value: "Status"}
    StreamEnumUpdateStatus status;
};

# Represents the Queries record for the operation: listMember
public type ListMemberQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Request object for updating SIP domain configuration
public type UpdateSipDomainRequest record {
    # The HTTP method we should use to call `voice_url`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # The SID of the BYOC Trunk(Bring Your Own Carrier) resource that the Sip Domain will be associated with
    @jsondata:Name {value: "ByocTrunkSid"}
    string byocTrunkSid?;
    # A descriptive string that you created to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # The unique address you reserve on Twilio to which you route your SIP traffic. Domain names can contain letters, digits, and "-" and must end with `sip.twilio.com`
    @jsondata:Name {value: "DomainName"}
    string domainName?;
    # Whether to allow SIP Endpoints to register with the domain to receive calls. Can be `true` or `false`. `true` allows SIP Endpoints to register with the domain to receive calls, `false` does not
    @jsondata:Name {value: "SipRegistration"}
    boolean sipRegistration?;
    # The URL that we should call to pass status parameters (such as call ended) to your application
    @jsondata:Name {value: "VoiceStatusCallbackUrl"}
    string voiceStatusCallbackUrl?;
    # Whether an emergency caller sid is configured for the domain. If present, this phone number will be used as the callback for the emergency call
    @jsondata:Name {value: "EmergencyCallerSid"}
    string emergencyCallerSid?;
    # The HTTP method we should use to call `voice_status_callback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceStatusCallbackMethod"}
    "GET"|"POST" voiceStatusCallbackMethod?;
    # The HTTP method we should use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # Whether secure SIP is enabled for the domain. If enabled, TLS will be enforced and SRTP will be negotiated on all incoming calls to this sip domain
    @jsondata:Name {value: "Secure"}
    boolean secure?;
    # Whether emergency calling is enabled for the domain. If enabled, allows emergency calls on the domain from phone numbers with validated addresses
    @jsondata:Name {value: "EmergencyCallingEnabled"}
    boolean emergencyCallingEnabled?;
    # The URL we should call when the domain receives a call
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The URL that we should call when an error occurs while retrieving or executing the TwiML requested by `voice_url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# Request object for updating a queue member
public type UpdateMemberRequest record {
    # How to pass the update request data. Can be `GET` or `POST` and the default is `POST`. `POST` sends the data as encoded form data and `GET` sends the data as query parameters
    @jsondata:Name {value: "Method"}
    "GET"|"POST" method?;
    # The absolute URL of the Queue resource
    @jsondata:Name {value: "Url"}
    string url;
};

# Request object for creating a new SIP credential list
public type CreateSipCredentialListRequest record {
    # A human readable descriptive text that describes the CredentialList, up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName;
};

# Request object for adding an IP address to access control list
public type CreateSipIpAddressRequest record {
    # A human readable descriptive text for this resource, up to 255 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName;
    # An integer representing the length of the CIDR prefix to use with this IP address when accepting traffic. By default the entire IP address is used
    @jsondata:Name {value: "CidrPrefixLength"}
    int cidrPrefixLength?;
    # An IP address in dotted decimal notation from which you want to accept traffic. Any SIP requests from this IP address will be allowed by Twilio. IPv4 only supported today
    @jsondata:Name {value: "IpAddress"}
    string ipAddress;
};

# The direction of the message. Can be: `inbound` for incoming messages, `outbound-api` for messages created by the REST API, `outbound-call` for messages created during a call, or `outbound-reply` for messages created in response to an incoming message
public type MessageEnumDirection "inbound"|"outbound-api"|"outbound-call"|"outbound-reply";

# Response containing a paginated list of SIP IP addresses
public type ListSipIpAddressResponse record {
    # URI of the first page in the paginated results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of SIP IP address resources
    @jsondata:Name {value: "ip_addresses"}
    ApiV2010AccountSipSipIpAccessControlListSipIpAddress[] ipAddresses?;
    # Starting index of items in the current page
    int 'start?;
    # Ending index of items in the current page
    int end?;
    # URI of the next page in the paginated results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI of the previous page in the paginated results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current SIP IP address list resource
    string uri?;
    # Number of items returned per page in the response
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Type of bank account if payment source is ACH. One of `consumer-checking`, `consumer-savings`, or `commercial-checking`. The default value is `consumer-checking`
public type PaymentsEnumBankAccountType "consumer-checking"|"consumer-savings"|"commercial-checking";

# The status of address registration with emergency services. A registered emergency address will be used during handling of emergency calls from this number
public type IncomingPhoneNumberEnumEmergencyAddressStatus "registered"|"unregistered"|"pending-registration"|"registration-failure"|"pending-unregistration"|"unregistration-failure";

# Whether the phone number is enabled for emergency calling
public type DependentPhoneNumberEnumEmergencyStatus "Active"|"Inactive";

# Media resource associated with a message
public type ApiV2010AccountMessageMedia record {
    # The date and time in GMT when this Media resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The default [MIME type](https://en.wikipedia.org/wiki/Internet_media_type) of the media, for example `image/jpeg`, `image/png`, or `image/gif`
    @jsondata:Name {value: "content_type"}
    string? contentType?;
    # The date and time in GMT when this Media resource was created, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the Message resource that is associated with this Media resource
    @jsondata:Name {value: "parent_sid"}
    string? parentSid?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with this Media resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI of this Media resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that identifies this Media resource
    string? sid?;
};

# Response containing paginated list of available local phone numbers
public type ListAvailablePhoneNumberLocalResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of available local phone numbers
    @jsondata:Name {value: "available_phone_numbers"}
    ApiV2010AccountAvailablePhoneNumberCountryAvailablePhoneNumberLocal[] availablePhoneNumbers?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI to the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI of the current page
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request object for validating caller ID phone numbers
public type ApiV2010AccountValidationRequest record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Caller ID is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for the Caller ID
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The phone number to verify in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The 6 digit validation code that someone must enter to validate the Caller ID  when `phone_number` is called
    @jsondata:Name {value: "validation_code"}
    string? validationCode?;
};

# Response containing paginated usage records from yesterday
public type ListUsageRecordYesterdayResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Starting index of the current page results
    int 'start?;
    # Ending index of the current page results
    int end?;
    # URI to the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI to the previous page of results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the result set
    int page?;
    # URI of the current page
    string uri?;
    # Array of usage records from yesterday
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecordUsageRecordYesterday[] usageRecords?;
    # Number of records returned per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Represents the Queries record for the operation: listRecordingAddOnResultPayload
public type ListRecordingAddOnResultPayloadQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Conference participant with call details, status, and control settings
public type ApiV2010AccountConferenceParticipant record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # Whether the conference starts when the participant joins the conference, if it has not already started. Can be: `true` or `false` and the default is `true`. If `false` and the conference has not started, the participant is muted and hears background music until another participant starts the conference
    @jsondata:Name {value: "start_conference_on_enter"}
    boolean? startConferenceOnEnter?;
    # The SID of the conference the participant is in
    @jsondata:Name {value: "conference_sid"}
    string? conferenceSid?;
    # Whether the conference ends when the participant leaves. Can be: `true` or `false` and the default is `false`. If `true`, the conference ends and all other participants drop out when the participant leaves
    @jsondata:Name {value: "end_conference_on_exit"}
    boolean? endConferenceOnExit?;
    # The user-specified label of this participant, if one was given when the participant was created. This may be used to fetch, update or delete the participant
    string? label?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID of the participant who is being `coached`. The participant being coached is the only participant who can hear the participant who is `coaching`
    @jsondata:Name {value: "call_sid_to_coach"}
    string? callSidToCoach?;
    # Whether the participant is on hold. Can be `true` or `false`
    boolean? hold?;
    # The wait time in milliseconds before participant's call is placed. Only available in the response to a create participant request
    @jsondata:Name {value: "queue_time"}
    string? queueTime?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Participant resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Participant resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # Whether the participant is coaching another call. Can be: `true` or `false`. If not present, defaults to `false` unless `call_sid_to_coach` is defined. If `true`, `call_sid_to_coach` must be defined
    boolean? coaching?;
    # Whether the participant is muted. Can be `true` or `false`
    boolean? muted?;
    # The status of the participant's call in a session. Can be: `queued`, `connecting`, `ringing`, `connected`, `complete`, or `failed`
    ParticipantEnumStatus status?;
};

# Request parameters for updating a queue configuration
public type UpdateQueueRequest record {
    # A descriptive string that you created to describe this resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # The maximum number of calls allowed to be in the queue. The default is 1000. The maximum is 5000
    @jsondata:Name {value: "MaxSize"}
    int maxSize?;
};

# IP access control list mapping for SIP domain authentication
public type ApiV2010AccountSipSipDomainSipAuthSipAuthCallsSipAuthCallsIpAccessControlListMapping record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the IpAccessControlListMapping resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The unique string that that we created to identify the IpAccessControlListMapping resource
    string? sid?;
};

# Credential list mapping for SIP domain authentication
public type ApiV2010AccountSipSipDomainSipCredentialListMapping record {
    # A human readable descriptive text for this resource, up to 64 characters long
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date that this resource was last updated, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The unique string that is created to identify the SipDomain resource
    @jsondata:Name {value: "domain_sid"}
    string? domainSid?;
    # The date that this resource was created, given as GMT in [RFC 2822](https://www.php.net/manual/en/class.datetime.php#datetime.constants.rfc2822) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The unique id of the Account that is responsible for this resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI for this resource, relative to `https://api.twilio.com`
    string? uri?;
    # A 34 character string that uniquely identifies this resource
    string? sid?;
};

# The parameter displays if emergency calling is enabled for this number. Active numbers may place emergency calls by dialing valid emergency numbers for the country
public type IncomingPhoneNumberMobileEnumEmergencyStatus "Active"|"Inactive";

# Represents the Queries record for the operation: listAvailablePhoneNumberLocal
public type ListAvailablePhoneNumberLocalQueries record {
    # Whether the phone numbers can receive calls. Can be: `true` or `false`
    @http:Query {name: "VoiceEnabled"}
    boolean voiceEnabled?;
    # Whether to exclude phone numbers that require a foreign [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeForeignAddressRequired"}
    boolean excludeForeignAddressRequired?;
    # Limit results to a particular postal code. Given a phone number, search within the same postal code as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InPostalCode"}
    string inPostalCode?;
    # Limit results to a specific local access and transport area ([LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area)). Given a phone number, search within the same [LATA](https://en.wikipedia.org/wiki/Local_access_and_transport_area) as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InLata"}
    string inLata?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether the phone numbers can receive MMS messages. Can be: `true` or `false`
    @http:Query {name: "MmsEnabled"}
    boolean mmsEnabled?;
    # Given a phone number, find a geographically close number within `distance` miles. Distance defaults to 25 miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearNumber"}
    string nearNumber?;
    # Limit results to a particular region, state, or province. Given a phone number, search within the same region as that number. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRegion"}
    string inRegion?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # Whether the phone numbers can receive text messages. Can be: `true` or `false`
    @http:Query {name: "SmsEnabled"}
    boolean smsEnabled?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Limit results to a specific rate center, or given a phone number search within the same rate center as that number. Requires `in_lata` to be set as well. Applies to only phone numbers in the US and Canada
    @http:Query {name: "InRateCenter"}
    string inRateCenter?;
    # Whether to read phone numbers that are new to the Twilio platform. Can be: `true` or `false` and the default is `true`
    @http:Query {name: "Beta"}
    boolean beta?;
    # Given a latitude/longitude pair `lat,long` find geographically close numbers within `distance` miles. Applies to only phone numbers in the US and Canada
    @http:Query {name: "NearLatLong"}
    string nearLatLong?;
    # Whether to exclude phone numbers that require a local [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeLocalAddressRequired"}
    boolean excludeLocalAddressRequired?;
    # Limit results to a particular locality or city. Given a phone number, search within the same Locality as that number
    @http:Query {name: "InLocality"}
    string inLocality?;
    # Matching pattern to identify phone numbers. This pattern can be between 2 and 16 characters long and allows all digits (0-9) and all non-diacritic latin alphabet letters (a-z, A-Z). It accepts four meta-characters: `*`, `%`, `+`, `$`. The `*` and `%` meta-characters can appear multiple times in the pattern. To match wildcards at the beginning or end of the pattern, use `*` to match any single character or `%` to match a sequence of characters. If you use the wildcard patterns, it must include at least two non-meta-characters, and wildcards cannot be used between non-meta-characters. To match the beginning of a pattern, start the pattern with `+`. To match the end of the pattern, append the pattern with `$`. These meta-characters can't be adjacent to each other
    @http:Query {name: "Contains"}
    string contains?;
    # The area code of the phone numbers to read. Applies to only phone numbers in the US and Canada
    @http:Query {name: "AreaCode"}
    int areaCode?;
    # Whether the phone numbers can receive faxes. Can be: `true` or `false`
    @http:Query {name: "FaxEnabled"}
    boolean faxEnabled?;
    # The search radius, in miles, for a `near_` query.  Can be up to `500` and the default is `25`. Applies to only phone numbers in the US and Canada
    @http:Query {name: "Distance"}
    int distance?;
    # Whether to exclude phone numbers that require an [Address](https://www.twilio.com/docs/usage/api/address). Can be: `true` or `false` and the default is `false`
    @http:Query {name: "ExcludeAllAddressRequired"}
    boolean excludeAllAddressRequired?;
};

# Request parameters for creating a new signing key
public type CreateNewSigningKeyRequest record {
    # A descriptive string that you create to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
};

# Request parameters for updating a SIP IP access control list
public type UpdateSipIpAccessControlListRequest record {
    # A human readable descriptive text, up to 255 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName;
};

# Represents the Queries record for the operation: listSipCredentialListMapping
public type ListSipCredentialListMappingQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# The status - one of `stopped`, `in-flight`
public type RealtimeTranscriptionEnumStatus "in-progress"|"stopped";

# Determines if the address can be stored or obfuscated based on privacy settings
public type MessageEnumAddressRetention "retain"|"obfuscate";

# One of `inbound_track`, `outbound_track`, `both_tracks`
public type SiprecEnumTrack "inbound_track"|"outbound_track"|"both_tracks";

# Response containing available phone number countries
public type ListAvailablePhoneNumberCountryResponse record {
    # Array of countries with available phone numbers
    ApiV2010AccountAvailablePhoneNumberCountry[] countries?;
    # URI of the resource endpoint
    string? uri?;
};

# Paginated response containing call recordings
public type ListCallRecordingResponse record {
    # URI to the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of call recording resources
    ApiV2010AccountCallCallRecording[] recordings?;
    # Starting index of the current page
    int 'start?;
    # Ending index of the current page
    int end?;
    # URI to the next page of results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of call recording results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the call recording list
    int page?;
    # URI of the call recording list resource
    string uri?;
    # Number of call recording items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# SIPREC recording session associated with a call
public type ApiV2010AccountCallSiprec record {
    # The date and time in GMT that this resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Siprec resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The user-specified name of this Siprec, if one was given when the Siprec was created. This may be used to stop the Siprec
    string? name?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Siprec resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID of the Siprec resource
    string? sid?;
    # The status - one of `stopped`, `in-progress`
    SiprecEnumStatus status?;
};

# Request object for updating short code configuration and webhook settings
public type UpdateShortCodeRequest record {
    # The HTTP method that we should use to call the `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "SmsFallbackMethod"}
    "GET"|"POST" smsFallbackMethod?;
    # The API version to use to start a new TwiML session. Can be: `2010-04-01` or `2008-08-01`
    @jsondata:Name {value: "ApiVersion"}
    string apiVersion?;
    # The URL we should call when receiving an incoming SMS message to this short code
    @jsondata:Name {value: "SmsUrl"}
    string smsUrl?;
    # The URL that we should call if an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "SmsFallbackUrl"}
    string smsFallbackUrl?;
    # A descriptive string that you created to describe this resource. It can be up to 64 characters long. By default, the `FriendlyName` is the short code
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # The HTTP method we should use when calling the `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "SmsMethod"}
    "GET"|"POST" smsMethod?;
};

# Request object for updating conference recording status and pause behavior
public type UpdateConferenceRecordingRequest record {
    # New status for the conference recording
    @jsondata:Name {value: "Status"}
    ConferenceRecordingEnumStatus status;
    # Whether to record during a pause. Can be: `skip` or `silence` and the default is `silence`. `skip` does not record during the pause period, while `silence` will replace the actual audio of the call with silence during the pause period. This parameter only applies when setting `status` is set to `paused`
    @jsondata:Name {value: "PauseBehavior"}
    string pauseBehavior?;
};

# Request object for creating and sending SMS, MMS, or messaging service messages
public type CreateMessageRequest record {
    # Type of message scheduling to use
    @jsondata:Name {value: "ScheduleType"}
    MessageEnumScheduleType scheduleType?;
    # The SID of the [Messaging Service](https://www.twilio.com/docs/messaging/services) you want to associate with the Message. When this parameter is provided and the `from` parameter is omitted, Twilio selects the optimal sender from the Messaging Service's Sender Pool. You may also provide a `from` parameter if you want to use a specific Sender from the Sender Pool
    @jsondata:Name {value: "MessagingServiceSid"}
    string messagingServiceSid?;
    # The URL of media to include in the Message content. `jpeg`, `jpg`, `gif`, and `png` file types are fully supported by Twilio and content is formatted for delivery on destination devices. The media size limit is 5 MB for supported file types (`jpeg`, `jpg`, `png`, `gif`) and 500 KB for [other types](https://www.twilio.com/docs/messaging/guides/accepted-mime-types) of accepted media. To send more than one image in the message, provide multiple `media_url` parameters in the POST request. You can include up to ten `media_url` parameters per message. [International](https://support.twilio.com/hc/en-us/articles/223179808-Sending-and-receiving-MMS-messages) and [carrier](https://support.twilio.com/hc/en-us/articles/223133707-Is-MMS-supported-for-all-carriers-in-US-and-Canada-) limits apply
    @jsondata:Name {value: "MediaUrl"}
    string[] mediaUrl?;
    # Rich actions for non-SMS/MMS channels. Used for [sending location in WhatsApp messages](https://www.twilio.com/docs/whatsapp/message-features#location-messages-with-whatsapp)
    @jsondata:Name {value: "PersistentAction"}
    string[] persistentAction?;
    # For [Content Editor/API](https://www.twilio.com/docs/content) only: The SID of the Content Template to be used with the Message, e.g., `HXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`. If this parameter is not provided, a Content Template is not used. Find the SID in the Console on the Content Editor page. For Content API users, the SID is found in Twilio's response when [creating the Template](https://www.twilio.com/docs/content/content-api-resources#create-templates) or by [fetching your Templates](https://www.twilio.com/docs/content/content-api-resources#fetch-all-content-resources)
    @jsondata:Name {value: "ContentSid"}
    string contentSid?;
    # The URL of the endpoint to which Twilio sends [Message status callback requests](https://www.twilio.com/docs/sms/api/message-resource#twilios-request-to-the-statuscallback-url). URL must contain a valid hostname and underscores are not allowed. If you include this parameter with the `messaging_service_sid`, Twilio uses this URL instead of the Status Callback URL of the [Messaging Service](https://www.twilio.com/docs/messaging/api/service-resource). 
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # The sender's Twilio phone number (in [E.164](https://en.wikipedia.org/wiki/E.164) format), [alphanumeric sender ID](https://www.twilio.com/docs/sms/quickstart), [Wireless SIM](https://www.twilio.com/docs/iot/wireless/programmable-wireless-send-machine-machine-sms-commands), [short code](https://www.twilio.com/en-us/messaging/channels/sms/short-codes), or [channel address](https://www.twilio.com/docs/messaging/channels) (e.g., `whatsapp:+15554449999`). The value of the `from` parameter must be a sender that is hosted within Twilio and belongs to the Account creating the Message. If you are using `messaging_service_sid`, this parameter can be empty (Twilio assigns a `from` value from the Messaging Service's Sender Pool) or you can provide a specific sender from your Sender Pool
    @jsondata:Name {value: "From"}
    string 'from?;
    # The SID of the associated [TwiML Application](https://www.twilio.com/docs/usage/api/applications). [Message status callback requests](https://www.twilio.com/docs/sms/api/message-resource#twilios-request-to-the-statuscallback-url) are sent to the TwiML App's `message_status_callback` URL. Note that the `status_callback` parameter of a request takes priority over the `application_sid` parameter; if both are included `application_sid` is ignored
    @jsondata:Name {value: "ApplicationSid"}
    string applicationSid?;
    # Boolean indicating whether or not you intend to provide delivery confirmation feedback to Twilio (used in conjunction with the [Message Feedback subresource](https://www.twilio.com/docs/sms/api/message-feedback-resource)). Default value is `false`
    @jsondata:Name {value: "ProvideFeedback"}
    boolean provideFeedback?;
    # Risk assessment level to apply to the message
    @jsondata:Name {value: "RiskCheck"}
    MessageEnumRiskCheck riskCheck?;
    # Total number of attempts made (including this request) to send the message regardless of the provider used
    @jsondata:Name {value: "Attempt"}
    int attempt?;
    # Content retention policy for the message
    @jsondata:Name {value: "ContentRetention"}
    MessageEnumContentRetention contentRetention?;
    # Reserved
    @jsondata:Name {value: "ForceDelivery"}
    boolean forceDelivery?;
    # Address retention policy for the message
    @jsondata:Name {value: "AddressRetention"}
    MessageEnumAddressRetention addressRetention?;
    # The maximum length in seconds that the Message can remain in Twilio's outgoing message queue. If a queued Message exceeds the `validity_period`, the Message is not sent. Accepted values are integers from `1` to `36000`. Default value is `36000`. A `validity_period` greater than `5` is recommended. [Learn more about the validity period](https://www.twilio.com/blog/take-more-control-of-outbound-messages-using-validity-period-html)
    @jsondata:Name {value: "ValidityPeriod"}
    int validityPeriod?;
    # For Messaging Services with [Link Shortening configured](https://www.twilio.com/docs/messaging/features/link-shortening) only: A Boolean indicating whether or not Twilio should shorten links in the `body` of the Message. Default value is `false`. If `true`, the `messaging_service_sid` parameter must also be provided
    @jsondata:Name {value: "ShortenUrls"}
    boolean shortenUrls?;
    # The recipient's phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format (for SMS/MMS) or [channel address](https://www.twilio.com/docs/messaging/channels), e.g. `whatsapp:+15552229999`
    @jsondata:Name {value: "To"}
    string to;
    # If set to `true`, Twilio delivers the message as a single MMS message, regardless of the presence of media
    @jsondata:Name {value: "SendAsMms"}
    boolean sendAsMms?;
    # For [Content Editor/API](https://www.twilio.com/docs/content) only: Key-value pairs of [Template variables](https://www.twilio.com/docs/content/using-variables-with-content-api) and their substitution values. `content_sid` parameter must also be provided. If values are not defined in the `content_variables` parameter, the [Template's default placeholder values](https://www.twilio.com/docs/content/content-api-resources#create-templates) are used
    @jsondata:Name {value: "ContentVariables"}
    string contentVariables?;
    # [OBSOLETE] This parameter will no longer have any effect as of 2024-06-03
    @jsondata:Name {value: "MaxPrice"}
    decimal maxPrice?;
    # Whether to detect Unicode characters that have a similar GSM-7 character and replace them. Can be: `true` or `false`
    @jsondata:Name {value: "SmartEncoded"}
    boolean smartEncoded?;
    # The text content of the outgoing message. Can be up to 1,600 characters in length. SMS only: If the `body` contains more than 160 [GSM-7](https://www.twilio.com/docs/glossary/what-is-gsm-7-character-encoding) characters (or 70 [UCS-2](https://www.twilio.com/docs/glossary/what-is-ucs-2-character-encoding) characters), the message is segmented and charged accordingly. For long `body` text, consider using the [send_as_mms parameter](https://www.twilio.com/blog/mms-for-long-text-messages)
    @jsondata:Name {value: "Body"}
    string body?;
    # The time that Twilio will send the message. Must be in ISO 8601 format
    @jsondata:Name {value: "SendAt"}
    string sendAt?;
    # Type of traffic classification for the message
    @jsondata:Name {value: "TrafficType"}
    MessageEnumTrafficType trafficType?;
};

# Represents the Queries record for the operation: listSipCredential
public type ListSipCredentialQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Usage record containing today's account usage statistics and billing information
public type ApiV2010AccountUsageUsageRecordUsageRecordToday record {
    # The last date for which usage is included in the UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "end_date"}
    string? endDate?;
    # A list of related resources identified by their URIs. For more information, see [List Subresources](https://www.twilio.com/docs/usage/api/usage-record#list-subresources)
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The amount used to bill usage and measured in units described in `usage_unit`
    string? usage?;
    # Usage records up to date as of this timestamp, formatted as YYYY-MM-DDTHH:MM:SS+00:00. All timestamps are in GMT
    @jsondata:Name {value: "as_of"}
    string? asOf?;
    # The number of usage events, such as the number of calls
    string? count?;
    # A plain-language description of the usage category
    string? description?;
    # The API version used to create the resource
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The units in which `usage` is measured, such as `minutes` for calls or `messages` for SMS
    @jsondata:Name {value: "usage_unit"}
    string? usageUnit?;
    # The currency in which `price` is measured, in [ISO 4127](https://www.iso.org/iso/home/standards/currency_codes.htm) format, such as `usd`, `eur`, and `jpy`
    @jsondata:Name {value: "price_unit"}
    string? priceUnit?;
    # The total price of the usage in the currency specified in `price_unit` and associated with the account
    decimal? price?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that accrued the usage
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The units in which `count` is measured, such as `calls` for calls or `messages` for SMS
    @jsondata:Name {value: "count_unit"}
    string? countUnit?;
    # The category of usage. For more information, see [Usage Categories](https://www.twilio.com/docs/usage/api/usage-record#usage-categories)
    string? category?;
    # The first date for which usage is included in this UsageRecord. The date is specified in GMT and formatted as `YYYY-MM-DD`
    @jsondata:Name {value: "start_date"}
    string? startDate?;
};

# Represents the Queries record for the operation: listIncomingPhoneNumberAssignedAddOnExtension
public type ListIncomingPhoneNumberAssignedAddOnExtensionQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Whether the phone number requires an [Address](https://www.twilio.com/docs/usage/api/address) registered with Twilio. Can be: `none`, `any`, `local`, or `foreign`
public type IncomingPhoneNumberTollFreeEnumAddressRequirement "none"|"any"|"local"|"foreign";

# Reported outcome indicating whether there is confirmation that the Message recipient performed a tracked user action. Can be: `unconfirmed` or `confirmed`. For more details see [How to Optimize Message Deliverability with Message Feedback](https://www.twilio.com/docs/messaging/guides/send-message-feedback-to-twilio)
public type MessageFeedbackEnumOutcome "confirmed"|"unconfirmed";

# Local phone number resource with voice, SMS capabilities and emergency settings
public type ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberLocal record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the Trunk that handles calls to the phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "trunk_sid"}
    string? trunkSid?;
    # The HTTP method we use to call `status_callback`. Can be: `GET` or `POST`
    @jsondata:Name {value: "status_callback_method"}
    "GET"|"POST"? statusCallbackMethod?;
    # The phone number's origin. `twilio` identifies Twilio-owned phone numbers and `hosted` identifies hosted phone numbers
    string? origin?;
    # The HTTP method we use to call `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_fallback_method"}
    "GET"|"POST"? smsFallbackMethod?;
    # Status of the emergency address configuration
    @jsondata:Name {value: "emergency_address_status"}
    IncomingPhoneNumberLocalEnumEmergencyAddressStatus emergencyAddressStatus?;
    # The SID of the Bundle resource that you associate with the phone number. Some regions require a Bundle to meet local Regulations
    @jsondata:Name {value: "bundle_sid"}
    string? bundleSid?;
    # The unique string that that we created to identify the resource
    string? sid?;
    # The URL that we call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "voice_fallback_url"}
    string? voiceFallbackUrl?;
    # The URL that we call when an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "sms_fallback_url"}
    string? smsFallbackUrl?;
    # Emergency calling status for the phone number
    @jsondata:Name {value: "emergency_status"}
    IncomingPhoneNumberLocalEnumEmergencyStatus emergencyStatus?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # Whether the phone number is new to the Twilio platform. Can be: `true` or `false`
    boolean? beta?;
    # Mode for receiving voice calls on this number
    @jsondata:Name {value: "voice_receive_mode"}
    IncomingPhoneNumberLocalEnumVoiceReceiveMode voiceReceiveMode?;
    # The SID of the Identity resource that we associate with the phone number. Some regions require an Identity to meet local regulations
    @jsondata:Name {value: "identity_sid"}
    string? identitySid?;
    # The SID of the application that handles calls to the phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "voice_application_sid"}
    string? voiceApplicationSid?;
    # The HTTP method we use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_method"}
    "GET"|"POST"? voiceMethod?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The set of Boolean properties that indicate whether a phone number can receive calls or messages.  Capabilities are  `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    Apiv2010accountincomingPhoneNumberCapabilities? capabilities?;
    # The URL we call when this phone number receives a call. The `voice_url` will not be used if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "voice_url"}
    string? voiceUrl?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL we call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "sms_url"}
    string? smsUrl?;
    # Address verification requirements for the local phone number
    @jsondata:Name {value: "address_requirements"}
    IncomingPhoneNumberLocalEnumAddressRequirement addressRequirements?;
    # The HTTP method we use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_fallback_method"}
    "GET"|"POST"? voiceFallbackMethod?;
    # The URL we call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "status_callback"}
    string? statusCallback?;
    # The API version used to start a new TwiML session
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The SID of the Address resource associated with the phone number
    @jsondata:Name {value: "address_sid"}
    string? addressSid?;
    # Whether we look up the caller's caller-ID name from the CNAM database ($0.01 per look up). Can be: `true` or `false`
    @jsondata:Name {value: "voice_caller_id_lookup"}
    boolean? voiceCallerIdLookup?;
    # The HTTP method we use to call `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_method"}
    "GET"|"POST"? smsMethod?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The SID of the application that handles SMS messages sent to the phone number. If an `sms_application_sid` is present, we ignore all `sms_*_url` values and use those of the application
    @jsondata:Name {value: "sms_application_sid"}
    string? smsApplicationSid?;
    # The SID of the emergency address configuration that we use for emergency calling from this phone number
    @jsondata:Name {value: "emergency_address_sid"}
    string? emergencyAddressSid?;
    # Current status of the local incoming phone number
    string? status?;
};

# Outgoing caller ID configuration for making calls from verified phone numbers
public type ApiV2010AccountOutgoingCallerId record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the OutgoingCallerId resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the OutgoingCallerId resource
    string? sid?;
};

# Represents the Queries record for the operation: listCall
public type ListCallQueries record {
    # The status of the calls to include. Can be: `queued`, `ringing`, `in-progress`, `canceled`, `completed`, `failed`, `busy`, or `no-answer`
    @http:Query {name: "Status"}
    CallEnumStatus status?;
    # Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date
    @http:Query {name: "StartTime<"}
    string startTime?;
    # Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date
    @http:Query {name: "EndTime<"}
    string endTime?;
    # Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date
    @http:Query {name: "StartTime>"}
    string startTime?;
    # Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date
    @http:Query {name: "EndTime>"}
    string endTime?;
    # Only include calls that ended on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only calls that ended on this date. You can also specify an inequality, such as `EndTime<=YYYY-MM-DD`, to read calls that ended on or before midnight of this date, and `EndTime>=YYYY-MM-DD` to read calls that ended on or after midnight of this date
    @http:Query {name: "EndTime"}
    string endTime?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Only include calls spawned by calls with this SID
    @http:Query {name: "ParentCallSid"}
    string parentCallSid?;
    # Only include calls that started on this date. Specify a date as `YYYY-MM-DD` in UTC, for example: `2009-07-06`, to read only calls that started on this date. You can also specify an inequality, such as `StartTime<=YYYY-MM-DD`, to read calls that started on or before midnight of this date, and `StartTime>=YYYY-MM-DD` to read calls that started on or after midnight of this date
    @http:Query {name: "StartTime"}
    string startTime?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include calls from this phone number, SIP address, Client identifier or SIM SID
    @http:Query {name: "From"}
    string 'from?;
    # Only show calls made to this phone number, SIP address, Client identifier or SIM SID
    @http:Query {name: "To"}
    string to?;
};

# SIP credential list mapping for domain authentication registrations
public type ApiV2010AccountSipSipDomainSipAuthSipAuthRegistrationsSipAuthRegistrationsCredentialListMapping record {
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the CredentialListMapping resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The unique string that that we created to identify the CredentialListMapping resource
    string? sid?;
};

# The parameter displays if emergency calling is enabled for this number. Active numbers may place emergency calls by dialing valid emergency numbers for the country
public type IncomingPhoneNumberEnumEmergencyStatus "Active"|"Inactive";

# Paginated response containing authorized connect app resources
public type ListAuthorizedConnectAppResponse record {
    # URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Array of authorized connect app resources
    @jsondata:Name {value: "authorized_connect_apps"}
    ApiV2010AccountAuthorizedConnectApp[] authorizedConnectApps?;
    # Index of the first item in the current page
    int 'start?;
    # Index of the last item in the current page
    int end?;
    # URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the pagination sequence
    int page?;
    # URI of the current page
    string uri?;
    # Number of items per page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Determines if the message content can be stored or redacted based on privacy settings
public type MessageEnumContentRetention "retain"|"discard";

# Represents the Queries record for the operation: listParticipant
public type ListParticipantQueries record {
    # Whether to return only participants who are coaching another call. Can be: `true` or `false`
    @http:Query {name: "Coaching"}
    boolean coaching?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Whether to return only participants that are on hold. Can be: `true` or `false`
    @http:Query {name: "Hold"}
    boolean hold?;
    # Whether to return only participants that are muted. Can be: `true` or `false`
    @http:Query {name: "Muted"}
    boolean muted?;
};

# Request payload for creating a new media stream with WebSocket connection
public type CreateStreamRequest record {
    # Parameter value
    @jsondata:Name {value: "Parameter87.Value"}
    string parameter87Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter47.Value"}
    string parameter47Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter67.Value"}
    string parameter67Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter27.Name"}
    string parameter27Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter44.Name"}
    string parameter44Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter54.Value"}
    string parameter54Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter74.Value"}
    string parameter74Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter89.Name"}
    string parameter89Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter27.Value"}
    string parameter27Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter34.Value"}
    string parameter34Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter94.Value"}
    string parameter94Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter13.Name"}
    string parameter13Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter14.Value"}
    string parameter14Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter90.Name"}
    string parameter90Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter58.Name"}
    string parameter58Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter42.Name"}
    string parameter42Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter56.Name"}
    string parameter56Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter5.Value"}
    string parameter5Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter15.Name"}
    string parameter15Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter61.Name"}
    string parameter61Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter75.Name"}
    string parameter75Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter29.Name"}
    string parameter29Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter42.Value"}
    string parameter42Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter63.Name"}
    string parameter63Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter19.Value"}
    string parameter19Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter59.Value"}
    string parameter59Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter80.Name"}
    string parameter80Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter7.Name"}
    string parameter7Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter82.Value"}
    string parameter82Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter75.Value"}
    string parameter75Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter2.Name"}
    string parameter2Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter54.Name"}
    string parameter54Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter85.Name"}
    string parameter85Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter99.Value"}
    string parameter99Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter32.Name"}
    string parameter32Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter13.Value"}
    string parameter13Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter73.Name"}
    string parameter73Name?;
    # Absolute URL to which Twilio sends status callback HTTP requests
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
    # Parameter value
    @jsondata:Name {value: "Parameter41.Value"}
    string parameter41Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter81.Value"}
    string parameter81Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter25.Name"}
    string parameter25Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter93.Value"}
    string parameter93Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter6.Value"}
    string parameter6Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter88.Value"}
    string parameter88Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter92.Name"}
    string parameter92Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter79.Name"}
    string parameter79Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter53.Value"}
    string parameter53Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter48.Value"}
    string parameter48Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter70.Value"}
    string parameter70Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter52.Name"}
    string parameter52Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter97.Name"}
    string parameter97Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter80.Value"}
    string parameter80Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter19.Name"}
    string parameter19Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter49.Name"}
    string parameter49Name?;
    # The user-specified name of this Stream, if one was given when the Stream was created. This can be used to stop the Stream
    @jsondata:Name {value: "Name"}
    string name?;
    # Parameter name
    @jsondata:Name {value: "Parameter96.Name"}
    string parameter96Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter51.Name"}
    string parameter51Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter5.Name"}
    string parameter5Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter82.Name"}
    string parameter82Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter48.Name"}
    string parameter48Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter23.Value"}
    string parameter23Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter15.Value"}
    string parameter15Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter66.Value"}
    string parameter66Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter67.Name"}
    string parameter67Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter1.Value"}
    string parameter1Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter46.Value"}
    string parameter46Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter78.Name"}
    string parameter78Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter20.Value"}
    string parameter20Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter23.Name"}
    string parameter23Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter53.Name"}
    string parameter53Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter43.Value"}
    string parameter43Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter34.Name"}
    string parameter34Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter98.Value"}
    string parameter98Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter18.Value"}
    string parameter18Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter38.Value"}
    string parameter38Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter24.Name"}
    string parameter24Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter22.Value"}
    string parameter22Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter39.Value"}
    string parameter39Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter72.Value"}
    string parameter72Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter95.Value"}
    string parameter95Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter16.Value"}
    string parameter16Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter33.Name"}
    string parameter33Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter39.Name"}
    string parameter39Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter4.Value"}
    string parameter4Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter69.Value"}
    string parameter69Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter71.Name"}
    string parameter71Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter77.Name"}
    string parameter77Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter87.Name"}
    string parameter87Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter96.Value"}
    string parameter96Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter6.Name"}
    string parameter6Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter81.Name"}
    string parameter81Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter62.Name"}
    string parameter62Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter14.Name"}
    string parameter14Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter21.Value"}
    string parameter21Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter45.Value"}
    string parameter45Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter68.Name"}
    string parameter68Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter50.Value"}
    string parameter50Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter68.Value"}
    string parameter68Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter73.Value"}
    string parameter73Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter3.Value"}
    string parameter3Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter2.Value"}
    string parameter2Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter77.Value"}
    string parameter77Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter91.Name"}
    string parameter91Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter57.Value"}
    string parameter57Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter60.Name"}
    string parameter60Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter97.Value"}
    string parameter97Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter64.Value"}
    string parameter64Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter84.Value"}
    string parameter84Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter17.Value"}
    string parameter17Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter43.Name"}
    string parameter43Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter88.Name"}
    string parameter88Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter37.Value"}
    string parameter37Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter24.Value"}
    string parameter24Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter44.Value"}
    string parameter44Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter74.Name"}
    string parameter74Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter8.Value"}
    string parameter8Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter45.Name"}
    string parameter45Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter71.Value"}
    string parameter71Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter59.Name"}
    string parameter59Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter31.Name"}
    string parameter31Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter31.Value"}
    string parameter31Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter11.Value"}
    string parameter11Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter51.Value"}
    string parameter51Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter91.Value"}
    string parameter91Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter12.Name"}
    string parameter12Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter72.Name"}
    string parameter72Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter26.Name"}
    string parameter26Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter10.Name"}
    string parameter10Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter52.Value"}
    string parameter52Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter69.Name"}
    string parameter69Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter49.Value"}
    string parameter49Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter41.Name"}
    string parameter41Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter12.Value"}
    string parameter12Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter38.Name"}
    string parameter38Name?;
    # Relative or absolute URL where WebSocket connection will be established
    @jsondata:Name {value: "Url"}
    string url;
    # Parameter name
    @jsondata:Name {value: "Parameter86.Name"}
    string parameter86Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter8.Name"}
    string parameter8Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter47.Name"}
    string parameter47Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter92.Value"}
    string parameter92Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter1.Name"}
    string parameter1Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter89.Value"}
    string parameter89Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter16.Name"}
    string parameter16Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter7.Value"}
    string parameter7Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter76.Name"}
    string parameter76Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter28.Name"}
    string parameter28Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter36.Value"}
    string parameter36Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter76.Value"}
    string parameter76Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter70.Name"}
    string parameter70Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter57.Name"}
    string parameter57Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter22.Name"}
    string parameter22Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter65.Value"}
    string parameter65Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter25.Value"}
    string parameter25Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter30.Value"}
    string parameter30Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter95.Name"}
    string parameter95Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter98.Name"}
    string parameter98Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter66.Name"}
    string parameter66Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter90.Value"}
    string parameter90Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter35.Name"}
    string parameter35Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter60.Value"}
    string parameter60Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter4.Name"}
    string parameter4Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter9.Value"}
    string parameter9Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter83.Name"}
    string parameter83Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter36.Name"}
    string parameter36Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter21.Name"}
    string parameter21Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter86.Value"}
    string parameter86Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter20.Name"}
    string parameter20Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter26.Value"}
    string parameter26Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter55.Value"}
    string parameter55Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter83.Value"}
    string parameter83Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter18.Name"}
    string parameter18Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter64.Name"}
    string parameter64Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter35.Value"}
    string parameter35Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter40.Value"}
    string parameter40Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter50.Name"}
    string parameter50Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter63.Value"}
    string parameter63Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter37.Name"}
    string parameter37Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter58.Value"}
    string parameter58Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter78.Value"}
    string parameter78Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter29.Value"}
    string parameter29Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter32.Value"}
    string parameter32Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter62.Value"}
    string parameter62Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter55.Name"}
    string parameter55Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter85.Value"}
    string parameter85Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter94.Name"}
    string parameter94Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter46.Name"}
    string parameter46Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter99.Name"}
    string parameter99Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter40.Name"}
    string parameter40Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter93.Name"}
    string parameter93Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter79.Value"}
    string parameter79Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter61.Value"}
    string parameter61Value?;
    # Parameter value
    @jsondata:Name {value: "Parameter33.Value"}
    string parameter33Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter9.Name"}
    string parameter9Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter84.Name"}
    string parameter84Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter56.Value"}
    string parameter56Value?;
    # Parameter name
    @jsondata:Name {value: "Parameter65.Name"}
    string parameter65Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter17.Name"}
    string parameter17Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter10.Value"}
    string parameter10Value?;
    # The HTTP method Twilio uses when sending `status_callback` requests. Possible values are `GET` and `POST`. Default is `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # Parameter name
    @jsondata:Name {value: "Parameter30.Name"}
    string parameter30Name?;
    # Parameter name
    @jsondata:Name {value: "Parameter11.Name"}
    string parameter11Name?;
    # Audio track type to stream during the call
    @jsondata:Name {value: "Track"}
    StreamEnumTrack track?;
    # Parameter name
    @jsondata:Name {value: "Parameter3.Name"}
    string parameter3Name?;
    # Parameter value
    @jsondata:Name {value: "Parameter28.Value"}
    string parameter28Value?;
};

# Request payload for creating a user-defined message
public type CreateUserDefinedMessageRequest record {
    # A unique string value to identify API call. This should be a unique string value per API call and can be a randomly generated
    @jsondata:Name {value: "IdempotencyKey"}
    string idempotencyKey?;
    # The User Defined Message in the form of URL-encoded JSON string
    @jsondata:Name {value: "Content"}
    string content;
};

# Represents the Queries record for the operation: listUsageRecordDaily
public type ListUsageRecordDailyQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Represents the Queries record for the operation: listUsageRecordMonthly
public type ListUsageRecordMonthlyQueries record {
    # Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date
    @http:Query {name: "StartDate"}
    string startDate?;
    # The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved
    @http:Query {name: "Category"}
    string category?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account
    @http:Query {name: "IncludeSubaccounts"}
    boolean includeSubaccounts?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date
    @http:Query {name: "EndDate"}
    string endDate?;
};

# Request payload for mapping IP access control list to SIP domain
public type CreateSipAuthCallsIpAccessControlListMappingRequest record {
    # The SID of the IpAccessControlList resource to map to the SIP domain
    @jsondata:Name {value: "IpAccessControlListSid"}
    string ipAccessControlListSid;
};

# Represents the Queries record for the operation: listAccount
public type ListAccountQueries record {
    # Only return Account resources with the given status. Can be `closed`, `suspended` or `active`
    @http:Query {name: "Status"}
    AccountEnumStatus status?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # Only return the Account resources with friendly names that exactly match this name
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Real-time transcription resource for an active call
public type ApiV2010AccountCallRealtimeTranscription record {
    # The date and time in GMT that this resource was last updated, specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Transcription resource is associated with
    @jsondata:Name {value: "call_sid"}
    string? callSid?;
    # The user-specified name of this Transcription, if one was given when the Transcription was created. This may be used to stop the Transcription
    string? name?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Transcription resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # Relative URI of the transcription resource
    string? uri?;
    # The SID of the Transcription resource
    string? sid?;
    # The status - one of `stopped`, `in-flight`
    RealtimeTranscriptionEnumStatus status?;
};

# The status of the participant's call in a session. Can be: `queued`, `connecting`, `ringing`, `connected`, `complete`, or `failed`
public type ParticipantEnumStatus "queued"|"connecting"|"ringing"|"connected"|"complete"|"failed";

# How the recording was created. Can be: `DialVerb`, `Conference`, `OutboundAPI`, `Trunking`, `RecordVerb`, `StartCallRecordingAPI`, and `StartConferenceRecordingAPI`
public type CallRecordingEnumSource "DialVerb"|"Conference"|"OutboundAPI"|"Trunking"|"RecordVerb"|"StartCallRecordingAPI"|"StartConferenceRecordingAPI";

# Voice receive mode for incoming phone numbers (voice or fax)
public type IncomingPhoneNumberEnumVoiceReceiveMode "voice"|"fax";

# Add-on assigned to an incoming phone number with configuration and metadata
public type ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOn record {
    # A list of related resources identified by their relative URIs
    @jsondata:Name {value: "subresource_uris"}
    record {}? subresourceUris?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # An application-defined string that uniquely identifies the resource. It can be used in place of the resource's `sid` in the URL to address the resource
    @jsondata:Name {value: "unique_name"}
    string? uniqueName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # A JSON string that represents the current configuration of this Add-on installation
    anydata? configuration?;
    # The SID of the Phone Number to which the Add-on is assigned
    @jsondata:Name {value: "resource_sid"}
    string? resourceSid?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # A short description of the functionality that the Add-on provides
    string? description?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the resource
    string? sid?;
};

# Extension for an add-on assigned to an incoming phone number
public type ApiV2010AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOnIncomingPhoneNumberAssignedAddOnExtension record {
    # The SID that uniquely identifies the assigned Add-on installation
    @jsondata:Name {value: "assigned_add_on_sid"}
    string? assignedAddOnSid?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # An application-defined string that uniquely identifies the resource. It can be used in place of the resource's `sid` in the URL to address the resource
    @jsondata:Name {value: "unique_name"}
    string? uniqueName?;
    # The SID of the Phone Number to which the Add-on is assigned
    @jsondata:Name {value: "resource_sid"}
    string? resourceSid?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # A string that you assigned to describe the Product this Extension is used within
    @jsondata:Name {value: "product_name"}
    string? productName?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # Whether the Extension will be invoked
    boolean? enabled?;
    # The unique string that that we created to identify the resource
    string? sid?;
};

# Paginated response containing recording add-on results
public type ListRecordingAddOnResultResponse record {
    # Array of recording add-on results
    @jsondata:Name {value: "add_on_results"}
    ApiV2010AccountRecordingRecordingAddOnResult[] addOnResults?;
    # URI of the first page in the paginated results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # Start index of the current page results
    int 'start?;
    # End index of the current page results
    int end?;
    # URI of the next page in the paginated results
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # URI of the previous page in the paginated results
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # Current page number in the paginated results
    int page?;
    # URI of the current resource
    string uri?;
    # Number of items per page in the paginated results
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Phone number resource dependent on an address with voice and SMS capabilities
public type ApiV2010AccountAddressDependentPhoneNumber record {
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The SID of the Trunk that handles calls to the phone number. If a `trunk_sid` is present, we ignore all of the voice urls and voice applications and use those set on the Trunk. Setting a `trunk_sid` will automatically delete your `voice_application_sid` and vice versa
    @jsondata:Name {value: "trunk_sid"}
    string? trunkSid?;
    # The HTTP method we use to call `status_callback`. Can be: `GET` or `POST`
    @jsondata:Name {value: "status_callback_method"}
    "GET"|"POST"? statusCallbackMethod?;
    # The HTTP method we use to call `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_fallback_method"}
    "GET"|"POST"? smsFallbackMethod?;
    # The unique string that that we created to identify the DependentPhoneNumber resource
    string? sid?;
    # The URL that we call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "voice_fallback_url"}
    string? voiceFallbackUrl?;
    # The URL that we call when an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "sms_fallback_url"}
    string? smsFallbackUrl?;
    # Emergency service status for the phone number
    @jsondata:Name {value: "emergency_status"}
    DependentPhoneNumberEnumEmergencyStatus emergencyStatus?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the DependentPhoneNumber resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The SID of the application that handles calls to the phone number. If a `voice_application_sid` is present, we ignore all of the voice urls and use those set on the application. Setting a `voice_application_sid` will automatically delete your `trunk_sid` and vice versa
    @jsondata:Name {value: "voice_application_sid"}
    string? voiceApplicationSid?;
    # The HTTP method we use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_method"}
    "GET"|"POST"? voiceMethod?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The set of Boolean properties that indicates whether a phone number can receive calls or messages.  Capabilities are  `Voice`, `SMS`, and `MMS` and each capability can be: `true` or `false`
    anydata? capabilities?;
    # The URL we call when the phone number receives a call. The `voice_url` will not be used if a `voice_application_sid` or a `trunk_sid` is set
    @jsondata:Name {value: "voice_url"}
    string? voiceUrl?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL we call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "sms_url"}
    string? smsUrl?;
    # The HTTP method we use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_fallback_method"}
    "GET"|"POST"? voiceFallbackMethod?;
    # Address requirements for the phone number
    @jsondata:Name {value: "address_requirements"}
    DependentPhoneNumberEnumAddressRequirement addressRequirements?;
    # The URL we call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "status_callback"}
    string? statusCallback?;
    # The API version used to start a new TwiML session
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # Whether we look up the caller's caller-ID name from the CNAM database. Can be: `true` or `false`. Caller ID lookups can cost $0.01 each
    @jsondata:Name {value: "voice_caller_id_lookup"}
    boolean? voiceCallerIdLookup?;
    # The HTTP method we use to call `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_method"}
    "GET"|"POST"? smsMethod?;
    # The phone number in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "phone_number"}
    string? phoneNumber?;
    # The SID of the application that handles SMS messages sent to the phone number. If an `sms_application_sid` is present, we ignore all `sms_*_url` values and use those of the application
    @jsondata:Name {value: "sms_application_sid"}
    string? smsApplicationSid?;
    # The SID of the emergency address configuration that we use for emergency calling from the phone number
    @jsondata:Name {value: "emergency_address_sid"}
    string? emergencyAddressSid?;
};

# The field in the [UsageRecord](https://www.twilio.com/docs/usage/api/usage-record) resource that fires the trigger.  Can be: `count`, `usage`, or `price`, as described in the [UsageRecords documentation](https://www.twilio.com/docs/usage/api/usage-record#usage-count-price)
public type UsageTriggerEnumTriggerField "count"|"usage"|"price";

# Represents the Queries record for the operation: listRecordingTranscription
public type ListRecordingTranscriptionQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# Represents the Queries record for the operation: fetchRecording
public type FetchRecordingQueries record {
    # A boolean parameter indicating whether to retrieve soft deleted recordings or not. Recordings metadata are kept after deletion for a retention period of 40 days
    @http:Query {name: "IncludeSoftDeleted"}
    boolean includeSoftDeleted?;
};

# Request to create a caller ID validation with phone number and callback options
public type CreateValidationRequestRequest record {
    # The number of seconds to delay before initiating the verification call. Can be an integer between `0` and `60`, inclusive. The default is `0`
    @jsondata:Name {value: "CallDelay"}
    int callDelay?;
    # The digits to dial after connecting the verification call
    @jsondata:Name {value: "Extension"}
    string extension?;
    # The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST`, and the default is `POST`
    @jsondata:Name {value: "StatusCallbackMethod"}
    "GET"|"POST" statusCallbackMethod?;
    # A descriptive string that you create to describe the new caller ID resource. It can be up to 64 characters long. The default value is a formatted version of the phone number
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # The phone number to verify in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number
    @jsondata:Name {value: "PhoneNumber"}
    string phoneNumber;
    # The URL we should call using the `status_callback_method` to send status information about the verification process to your application
    @jsondata:Name {value: "StatusCallback"}
    string statusCallback?;
};

# TwiML application with voice and SMS handling configuration
public type ApiV2010AccountApplication record {
    # The HTTP method we use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_method"}
    "GET"|"POST"? voiceMethod?;
    # The string that you assigned to describe the resource
    @jsondata:Name {value: "friendly_name"}
    string? friendlyName?;
    # The date and time in GMT that the resource was last updated specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_updated"}
    string? dateUpdated?;
    # The HTTP method we use to call `status_callback`. Can be: `GET` or `POST`
    @jsondata:Name {value: "status_callback_method"}
    "GET"|"POST"? statusCallbackMethod?;
    # The URL we call when the phone number assigned to this application receives a call
    @jsondata:Name {value: "voice_url"}
    string? voiceUrl?;
    # The date and time in GMT that the resource was created specified in [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) format
    @jsondata:Name {value: "date_created"}
    string? dateCreated?;
    # The URL we call when the phone number receives an incoming SMS message
    @jsondata:Name {value: "sms_url"}
    string? smsUrl?;
    # The HTTP method we use to call `sms_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_fallback_method"}
    "GET"|"POST"? smsFallbackMethod?;
    # Whether to allow other Twilio accounts to dial this applicaton using Dial verb. Can be: `true` or `false`
    @jsondata:Name {value: "public_application_connect_enabled"}
    boolean? publicApplicationConnectEnabled?;
    # The HTTP method we use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "voice_fallback_method"}
    "GET"|"POST"? voiceFallbackMethod?;
    # The URL we call using the `status_callback_method` to send status information to your application
    @jsondata:Name {value: "status_callback"}
    string? statusCallback?;
    # The API version used to start a new TwiML session
    @jsondata:Name {value: "api_version"}
    string? apiVersion?;
    # The URI of the resource, relative to `https://api.twilio.com`
    string? uri?;
    # The unique string that that we created to identify the Application resource
    string? sid?;
    # Whether we look up the caller's caller-ID name from the CNAM database (additional charges apply). Can be: `true` or `false`
    @jsondata:Name {value: "voice_caller_id_lookup"}
    boolean? voiceCallerIdLookup?;
    # The URL we call using a POST method to send message status information to your application
    @jsondata:Name {value: "message_status_callback"}
    string? messageStatusCallback?;
    # The URL that we call when an error occurs retrieving or executing the TwiML requested by `url`
    @jsondata:Name {value: "voice_fallback_url"}
    string? voiceFallbackUrl?;
    # The URL that we call when an error occurs while retrieving or executing the TwiML from `sms_url`
    @jsondata:Name {value: "sms_fallback_url"}
    string? smsFallbackUrl?;
    # The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Application resource
    @jsondata:Name {value: "account_sid"}
    string? accountSid?;
    # The HTTP method we use to call `sms_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "sms_method"}
    "GET"|"POST"? smsMethod?;
    # The URL we call using a POST method to send status information to your application about SMS messages that refer to the application
    @jsondata:Name {value: "sms_status_callback"}
    string? smsStatusCallback?;
};

# Paginated response containing all-time usage records
public type ListUsageRecordAllTimeResponse record {
    # URI of the first page in the paginated results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The index of the first item in this page of results
    int 'start?;
    # The index of the last item in this page of results
    int end?;
    # The URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # The URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The absolute URI of this page of usage records
    string uri?;
    # Array of all-time usage record objects
    @jsondata:Name {value: "usage_records"}
    ApiV2010AccountUsageUsageRecordUsageRecordAllTime[] usageRecords?;
    # The number of items returned in this page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request object for updating usage trigger configuration
public type UpdateUsageTriggerRequest record {
    # The URL we should call using `callback_method` when the trigger fires
    @jsondata:Name {value: "CallbackUrl"}
    string callbackUrl?;
    # The HTTP method we should use to call `callback_url`. Can be: `GET` or `POST` and the default is `POST`
    @jsondata:Name {value: "CallbackMethod"}
    "GET"|"POST" callbackMethod?;
    # A descriptive string that you create to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
};

# Response object containing paginated list of SIP domains
public type ListSipDomainResponse record {
    # The URI for the first page of results
    @jsondata:Name {value: "first_page_uri"}
    string firstPageUri?;
    # The index of the first item in this page of results
    int 'start?;
    # Array of SIP domain objects
    ApiV2010AccountSipSipDomain[] domains?;
    # The index of the last item in this page of results
    int end?;
    # The URI for the next page of results, if available
    @jsondata:Name {value: "next_page_uri"}
    string? nextPageUri?;
    # The URI for the previous page of results, if available
    @jsondata:Name {value: "previous_page_uri"}
    string? previousPageUri?;
    # The current page number in the paginated results
    int page?;
    # The absolute URI of this page of SIP domains
    string uri?;
    # The number of items returned in this page
    @jsondata:Name {value: "page_size"}
    int pageSize?;
};

# Request object for creating a new SIP domain
public type CreateSipDomainRequest record {
    # The HTTP method we should use to call `voice_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceMethod"}
    "GET"|"POST" voiceMethod?;
    # The SID of the BYOC Trunk(Bring Your Own Carrier) resource that the Sip Domain will be associated with
    @jsondata:Name {value: "ByocTrunkSid"}
    string byocTrunkSid?;
    # The unique address you reserve on Twilio to which you route your SIP traffic. Domain names can contain letters, digits, and "-" and must end with `sip.twilio.com`
    @jsondata:Name {value: "DomainName"}
    string domainName;
    # A descriptive string that you created to describe the resource. It can be up to 64 characters long
    @jsondata:Name {value: "FriendlyName"}
    string friendlyName?;
    # Whether to allow SIP Endpoints to register with the domain to receive calls. Can be `true` or `false`. `true` allows SIP Endpoints to register with the domain to receive calls, `false` does not
    @jsondata:Name {value: "SipRegistration"}
    boolean sipRegistration?;
    # The URL that we should call to pass status parameters (such as call ended) to your application
    @jsondata:Name {value: "VoiceStatusCallbackUrl"}
    string voiceStatusCallbackUrl?;
    # Whether an emergency caller sid is configured for the domain. If present, this phone number will be used as the callback for the emergency call
    @jsondata:Name {value: "EmergencyCallerSid"}
    string emergencyCallerSid?;
    # The HTTP method we should use to call `voice_status_callback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceStatusCallbackMethod"}
    "GET"|"POST" voiceStatusCallbackMethod?;
    # The HTTP method we should use to call `voice_fallback_url`. Can be: `GET` or `POST`
    @jsondata:Name {value: "VoiceFallbackMethod"}
    "GET"|"POST" voiceFallbackMethod?;
    # Whether secure SIP is enabled for the domain. If enabled, TLS will be enforced and SRTP will be negotiated on all incoming calls to this sip domain
    @jsondata:Name {value: "Secure"}
    boolean secure?;
    # Whether emergency calling is enabled for the domain. If enabled, allows emergency calls on the domain from phone numbers with validated addresses
    @jsondata:Name {value: "EmergencyCallingEnabled"}
    boolean emergencyCallingEnabled?;
    # The URL we should when the domain receives a call
    @jsondata:Name {value: "VoiceUrl"}
    string voiceUrl?;
    # The URL that we should call when an error occurs while retrieving or executing the TwiML from `voice_url`
    @jsondata:Name {value: "VoiceFallbackUrl"}
    string voiceFallbackUrl?;
};

# Traffic type classification for message routing and billing purposes
public type MessageEnumTrafficType "free";

# Represents the Queries record for the operation: listIncomingPhoneNumberAssignedAddOn
public type ListIncomingPhoneNumberAssignedAddOnQueries record {
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
};

# The parameter displays if emergency calling is enabled for this number. Active numbers may place emergency calls by dialing valid emergency numbers for the country
public type IncomingPhoneNumberTollFreeEnumEmergencyStatus "Active"|"Inactive";

# The status of the transcription. Can be: `in-progress`, `completed`, `failed`
public type TranscriptionEnumStatus "in-progress"|"completed"|"failed";

# Represents the Queries record for the operation: listAddress
public type ListAddressQueries record {
    # The ISO country code of the Address resources to read
    @http:Query {name: "IsoCountry"}
    string isoCountry?;
    # How many resources to return in each list page. The default is 50, and the maximum is 1000
    @http:Query {name: "PageSize"}
    int pageSize?;
    # The string that identifies the Address resources to read
    @http:Query {name: "FriendlyName"}
    string friendlyName?;
    # Whether the address can be associated to a number for emergency calling
    @http:Query {name: "EmergencyEnabled"}
    boolean emergencyEnabled?;
    # The page token. This is provided by the API
    @http:Query {name: "PageToken"}
    string pageToken?;
    # The page index. This value is simply for client state
    @http:Query {name: "Page"}
    int page?;
    # The `customer_name` of the Address resources to read
    @http:Query {name: "CustomerName"}
    string customerName?;
};
