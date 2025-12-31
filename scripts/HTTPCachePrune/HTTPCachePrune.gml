// Feather disable all

/// Deletes cached data stored on disk that has elapsed. Files that have not elapsed will be
/// retained. This function is helpful for reducing the amount of unnecessary disk space that is
/// being used by HTTPCache.
/// 
/// N.B. This function is called automatically when the game starts or the game ends (without
///      an error).

function HTTPCachePrune()
{
    static _cacheTimeMap = __HTTPCacheSystem().__cacheTimeMap;
    
    if (HTTP_CACHE_VERBOSE)
    {
        __HTTPCacheTrace($"Starting cache pruning. Current UTC time is {date_datetime_string(__HTTPGetUTCTime())}, {ds_map_size(_cacheTimeMap)} entries in cache");
    }
    
    var _i = 0;
    var _hashArray = ds_map_keys_to_array(_cacheTimeMap);
    repeat(array_length(_hashArray))
    {
        var _hash = _hashArray[_i];
        
        if (not __HTTPCacheExists(_hash))
        {
            var _path = __HTTPCacheGetPath(_hash);
            
            if (HTTP_CACHE_VERBOSE)
            {
                __HTTPCacheTrace($"{_i}: \"{_hash}\" elapsed at {date_datetime_string(__HTTPCacheGetElapsedTime(_hash))}. Deleting \"{_path}\"");
            }
            
            file_delete(_path);
        }
        else
        {
            if (HTTP_CACHE_VERBOSE)
            {
                __HTTPCacheTrace($"{_i}: \"{_hash}\" elapses at {date_datetime_string(__HTTPCacheGetElapsedTime(_hash))}");
            }
        }
        
        ++_i;
    }
}