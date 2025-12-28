// Feather disable all

HTTPCacheGet("https://www.google.com", function(_success, _result, _responseHeaders, _callbackData)
{
    show_debug_message($"success = {_success}");
    show_debug_message($"responseHeaders = {json_encode(_responseHeaders, true)}");
});