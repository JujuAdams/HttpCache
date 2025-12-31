// Feather disable all

/// Returns if the cache contains valid information associated with the key.
/// 
/// @param key

function HTTPCacheCustomExists(_key)
{
    return __HTTPCacheExists(md5_string_utf8(_key));
}