// Feather disable all

function __HTTPCacheAsyncEvent()
{
    static _system         = __HTTPCacheSystem();
    static _httpRequestMap = _system.__httpRequestMap;
    static _httpFileMap    = _system.__httpFileMap;
    
    var _asyncMap = async_load;
    var _id = async_load[? "id"];
    
    //http_get() and http_request()
    with(_httpRequestMap[? _id])
    {
        var _status = async_load[? "status"];
        if (_status == 0)
        {
            ds_map_delete(_httpRequestMap, _id);
            
            var _httpStatus      = async_load[? "http_status"];
            var _result          = async_load[? "result"];
            var _responseHeaders = async_load[? "response_headers"];
            
            var _success = __HTTPResponseIsSuccess(_httpStatus);
            if (_success)
            {
                if (HTTP_CACHE_VERBOSE)
                {
                    __HTTPCacheTrace($"HTTP request successful (status={_status}, httpStatus={_httpStatus})");
                }
                
                var _struct = json_parse(json_encode(async_load));
                _struct.response_headers = json_parse(json_encode(_responseHeaders));
                
                __HTTPCacheSaveString(_system.__cacheDirectory + __hash, json_stringify(_struct));
                __HTTPCacheAdd(__hash);
            }
            else
            {
                if (HTTP_CACHE_VERBOSE)
                {
                    __HTTPCacheTrace($"HTTP request failed (status={_status}, httpStatus={_httpStatus})");
                    __HTTPCacheTrace(_result);
                }
            }
            
            if (is_callable(__callback))
            {
                __callback(_success, _result, _responseHeaders, __callbackData);
            }
        }
    }
    
    //http_get_file()
    with(_httpFileMap[? _id])
    {
        var _status = async_load[? "status"];
        if (_status == 0)
        {
            ds_map_delete(_httpRequestMap, _id);
            
            var _success = __HTTPResponseIsSuccess(async_load[? "http_status"]);
            if (_success)
            {
                __HTTPCacheTrace($"HTTP file get successful (status={_status}, httpStatus={_httpStatus})");
                
                file_copy(__HTTPCacheGetPath(__hash), __destination);
                __HTTPCacheAdd(__hash);
            }
            else
            {
                __HTTPCacheTrace($"HTTP file get failed (status={_status}, httpStatus={_httpStatus})");
            }
            
            if (is_callable(__callback))
            {
                __callback(_success, __destination, __callbackData);
            }
        }
    }
}