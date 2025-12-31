// Feather disable all

HTTPCacheGet("https://www.google.com", function(_success, _result, _responseHeaders, _callbackData)
{
    show_debug_message($"success = {_success}");
    show_debug_message($"responseHeaders = {json_encode(_responseHeaders, true)}");
    show_debug_message($"result = {_result}");
});

HTTPCacheGetFile("https://www.webhamster.com/1.gif", "hamster.gif", function(_success, _destinationPath, _callbackData)
{
    show_debug_message($"success = {_success}");
});