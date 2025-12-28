// Feather disable all

/// @param hash

function __HTTPCacheExists(_hash)
{
    static _cacheTimeMap = __HTTPCacheSystem().__cacheTimeMap;
    
    var _time = undefined;
    try
    {
        _time = real(_cacheTimeMap[? _hash]);
    }
    catch(_error)
    {
        
    }
    
    _time ??= 0;
    if (__HTTPGetUTCTime() > _time) return false;
    
    return file_exists(__HTTPCacheGetPath(_hash));
}