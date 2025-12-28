// Feather disable all

/// Callback takes three parameters:
/// - success
/// - destinationPath
/// - callbackData
/// 
/// @param url
/// @param destinationPath
/// @param callback
/// @param [callbackData]

function HTTPCacheGetFile(_url, _destinationPath, _callback, _callbackData = undefined)
{
    static _system = __HTTPCacheSystem();
    static _httpFileMap = _system.__httpFileMap;
    
    __HTTPEnsureObject();
    
    var _hash = md5_string_utf8(_url);
    if (__HTTPCacheExists(_hash))
    {
        __HTTPTrace("HTTP file has been cached");
        file_copy(__HTTPCacheGetPath(__hash), _destinationPath);
        
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
            __HTTPTrace("HTTP file failed");
            
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
            __HTTPTrace("Getting HTTP file");
            
            _httpFileMap[? _requestID] = new __HTTPClassCacheFileGet(_hash, _destinationPath, _callback, _callbackData);
        }
    }
}