// Feather disable all

/// Callback takes four parameters:
/// - success
/// - result
/// - responseHeaders
/// - callbackData
/// 
/// @param url
/// @param method
/// @param headerMap
/// @param body
/// @param callback
/// @param [callbackData]

function HTTPCacheRequest(_url, _method, _headerMap, _body, _callback, _callbackData = undefined)
{
    static _system = __HTTPCacheSystem();
    static _requestDictionary = _system.__httpRequestMap;
    
    __HTTPEnsureObject();
    
    var _hashKey = $"{_url}::{_method}::{json_encode(_headerMap)}::{_body}";
    var _hash = md5_string_utf8(_hashKey);
    
    if (__HTTPCacheExists(_hash))
    {
        __HTTPTrace("HTTP request has been cached");
        
        if (not is_callable(_callback))
        {
            return;
        }
        else
        {
            var _asyncLoad = undefined;
            try
            {
                var _buffer = buffer_load(__HTTPCacheGetPath(_hash));
                var _jsonString = buffer_read(_buffer, buffer_text);
                buffer_delete(_buffer);
                
                _asyncLoad = json_decode(_jsonString);
            }
            catch(_error)
            {
                show_debug_message(json_stringify(_error, true));
                __HTTPTrace("Failed to parse cached data");
            }
            
            if (_asyncLoad != undefined)
            {
                call_later(1, time_source_units_frames, method({
                    __asyncLoad:    _asyncLoad,
                    __callback:     _callback,
                    __callbackData: _callbackData,
                },
                function()
                {
                    var _success         = __HTTPResponseIsSuccess(__asyncLoad[? "http_status"]);
                    var _result          = __asyncLoad[? "result"];
                    var _responseHeaders = __asyncLoad[? "response_headers"];
                    
                    __callback(_success, _result, _responseHeaders, __callbackData);
                    
                    ds_map_destroy(__asyncLoad);
                }), false);
                
                return;
            }
        }
    }
    
    var _requestID = http_request(_url, _method, _headerMap, _body);
    if (_requestID < 0)
    {
        __HTTPTrace("HTTP request failed");
        
        if (is_callable(__callback))
        {
            call_later(1, time_source_units_frames, method({
                __callback:     _callback,
                __callbackData: _callbackData,
            },
            function()
            {
                var _responseHeaders = ds_map_create();
                __callback(false, "", _responseHeaders, __callbackData);
                ds_map_destroy(_responseHeaders);
            }), false);
        }
    }
    else
    {
        __HTTPTrace("Making HTTP request");
        
        _requestDictionary[? _requestID] = new __HTTPClassCacheRequest(_hash, _callback, _callbackData);
    }
}