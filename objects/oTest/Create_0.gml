// Feather disable all

HttpCacheGet("https://www.google.com", function(_success, _result, _responseHeaders, _callbackData)
{
    show_debug_message($"success = {_success}");
    show_debug_message($"responseHeaders = {json_encode(_responseHeaders, true)}");
    show_debug_message($"result = {_result}");
});

HttpCacheGetFile("https://www.webhamster.com/1.gif", ".gif", function(_success, _destinationPath, _callbackData)
{
    show_debug_message($"success = {_success}");
});

var _key = "test";
var _value = HttpCacheCustomGet(_key);
if (_value == undefined)
{
    _value = date_datetime_string(date_current_datetime());
    HttpCacheCustomSet(_key, _value);
}

show_debug_message($"value = {_value}");