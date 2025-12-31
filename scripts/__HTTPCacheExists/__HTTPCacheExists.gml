// Feather disable all

/// @param hash

function __HTTPCacheExists(_hash)
{
    if (not HTTP_CACHE_AVAILABLE)
    {
        return false;
    }
    
    if (__HTTPGetUTCTime() > __HTTPCacheGetElapsedTime(_hash))
    {
        return false;
    }
    
    return file_exists(__HTTPCacheGetPath(_hash));
}