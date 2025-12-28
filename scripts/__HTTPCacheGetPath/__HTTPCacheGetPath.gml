// Feather disable all

/// @param hash

function __HTTPCacheGetPath(_hash)
{
    static _system = __HTTPCacheSystem();
    return _system.__cacheDirectory + _hash;
}