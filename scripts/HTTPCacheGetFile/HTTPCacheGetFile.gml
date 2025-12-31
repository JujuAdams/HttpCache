// Feather disable all

/// Attempts to download a single file from the specified URL endpoint. If the request is
/// successful, a file will be saved at the destination path that you specified when calling the
/// function. Additionally, the downloaded file will be cached elsewhere on disk. Subsequent calls
/// to this function will use the cached file on disk as the source rather than redownloading a
/// file from the HTTP endpoint.
/// 
/// You should specify a callback to execute when HTTPCache receives a response. Your callback
/// should take three parameters:
/// - success
/// - destinationPath
/// - callbackData
/// 
/// Cached data will be considered valid for a limited time span, as determined by the duration set
/// by `HTTPCacheSetDurationMins()` (the default timeout is 5 minutes). Cached data is stored on
/// disk and can persist for hours or days if you so choose.
/// 
/// @param url
/// @param destinationPath
/// @param callback
/// @param [callbackData]
/// @param [ignoreCache=false]

function HTTPCacheGetFile(_url, _destinationPath, _callback, _callbackData = undefined, _ignoreCache = false)
{
    static _system = __HTTPCacheSystem();
    static _httpFileMap = _system.__httpFileMap;
    
    __HTTPEnsureObject();
    
    if (not HTTP_CACHE_DISK_AVAILABLE)
    {
        var _requestID = http_get_file(_url, _destinationPath);
        if (_requestID < 0)
        {
            if (HTTP_CACHE_VERBOSE)
            {
                __HTTPCacheTrace($"`http_get_file()` failed for \"{_url}\"");
            }
            
            if (is_callable(__callback))
            {
                call_later(1, time_source_units_frames, method({
                    __destination:  _destinationPath,
                    __callback:     _callback,
                    __callbackData: _callbackData,
                },
                function()
                {
                    __callback(false, __destination, __callbackData);
                }), false);
            }
        }
        else
        {
            if (HTTP_CACHE_VERBOSE)
            {
                __HTTPCacheTrace($"Executed `http_get_file()` for \"{_url}\"");
            }
            
            _httpFileMap[? _requestID] = new __HTTPClassCacheFileGet(undefined, _destinationPath, _callback, _callbackData, _system.__globalDurationMins);
        }
    }
    else
    {
        var _hash = md5_string_utf8(_url);
        if ((not _ignoreCache) && __HTTPCacheExists(_hash))
        {
            if (HTTP_CACHE_VERBOSE)
            {
                __HTTPCacheTrace($"File has been cached for \"{_url}\" ({_hash})");
            }
            
            file_copy(__HTTPCacheGetPath(_hash), _destinationPath);
            
            if (is_callable(_callback))
            {
                call_later(1, time_source_units_frames, method({
                    __destination:  _destinationPath,
                    __callback:     _callback,
                    __callbackData: _callbackData,
                },
                function()
                {
                    __callback(true, __destination, __callbackData);
                }), false);
            }
        }
        else
        {
            var _requestID = http_get_file(_url, __HTTPCacheGetPath(_hash));
            if (_requestID < 0)
            {
                if (HTTP_CACHE_VERBOSE)
                {
                    __HTTPCacheTrace($"`http_get_file()` failed for \"{_url}\" ({_hash})");
                }
                
                if (is_callable(__callback))
                {
                    call_later(1, time_source_units_frames, method({
                        __destination:  _destinationPath,
                        __callback:     _callback,
                        __callbackData: _callbackData,
                    },
                    function()
                    {
                        __callback(false, __destination, __callbackData);
                    }), false);
                }
            }
            else
            {
                if (HTTP_CACHE_VERBOSE)
                {
                    __HTTPCacheTrace($"Executed `http_get_file()` for \"{_url}\" ({_hash})");
                }
                
                _httpFileMap[? _requestID] = new __HTTPClassCacheFileGet(_hash, _destinationPath, _callback, _callbackData, _system.__globalDurationMins);
            }
        }
    }
}