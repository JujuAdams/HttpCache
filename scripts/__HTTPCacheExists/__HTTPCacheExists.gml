// Feather disable all

/// @param hash

function __HTTPCacheExists(_hash)
{
    return (__HTTPGetUTCTime() > __HTTPCacheGetElapsedTime(_hash))? false : file_exists(__HTTPCacheGetPath(_hash));
}