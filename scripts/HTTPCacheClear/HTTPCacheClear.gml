// Feather disable all

function HTTPCacheClear()
{
    static _system = __HTTPCacheSystem();
    static _httpRequestMap = _system.__httpRequestMap;
    
    ds_map_clear(_httpRequestMap);
    directory_destroy(_system.__cacheDirectory);
    
    if (HTTP_CACHE_VERBOSE)
    {
        __HTTPCacheTrace("Cleared cache");
    }
}