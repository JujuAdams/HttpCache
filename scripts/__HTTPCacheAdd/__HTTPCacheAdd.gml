// Feather disable all

/// @param hash

function __HTTPCacheAdd(_hash)
{
    static _system       = __HTTPCacheSystem();
    static _cacheTimeMap = _system.__cacheTimeMap;
    
    var _elapseTime = date_inc_minute(__HTTPGetUTCTime(), _system.__cacheDurationMins)
    
    if (HTTP_CACHE_VERBOSE)
    {
        __HTTPCacheTrace($"Adding \"{_hash}\" to cache, elapse time = {date_datetime_string(_elapseTime)}");
    }
    
    _cacheTimeMap[? _hash] = string_format(_elapseTime, 0, 10);
    __HTTPCacheSaveString(_system.__cacheDirectory + "manifest.json", json_encode(_cacheTimeMap));
}