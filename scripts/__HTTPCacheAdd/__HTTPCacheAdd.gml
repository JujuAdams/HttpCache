// Feather disable all

/// @param hash

function __HTTPCacheAdd(_hash)
{
    static _system       = __HTTPCacheSystem();
    static _cacheTimeMap = _system.__cacheTimeMap;
    
    _cacheTimeMap[? _hash] = string_format(date_inc_minute(__HTTPGetUTCTime(), _system.__cacheDurationMins), 0, 10);
    __HTTPCacheSaveString(_system.__cacheDirectory + "manifest.json", json_encode(_cacheTimeMap));
}