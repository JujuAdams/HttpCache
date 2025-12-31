// Feather disable all

/// Clears the cache on disk, freeing up disk space and forcing subsequent HTTPCache functions to
/// redownload data.

function HTTPCacheClear()
{
    static _system = __HTTPCacheSystem();
    static _httpRequestMap = _system.__httpRequestMap;
    
    ds_map_clear(_httpRequestMap);
    
    if (HTTP_CACHE_AVAILABLE)
    {
        directory_destroy(_system.__cacheDirectory);
    }
    
    if (HTTP_CACHE_VERBOSE)
    {
        __HTTPCacheTrace($"Cleared cache (deleted directory \"{_system.__cacheDirectory}\")");
    }
}