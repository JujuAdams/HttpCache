// Feather disable all

/// Caches a value associated with a key. You can later retrieve this value using
/// `HTTPCacheCustomGet()`.
/// 
/// N.B. The value set by this function must be one of the following datatypes:
///      - boolean (`true` / `false`)
///      - `undefined`
///      - real number
///      - string
///      - array
///      - struct
/// 
/// Cached data will be considered valid for a limited time span, as determined by the duration set
/// by `HTTPCacheSetDurationMins()` (the default timeout is 5 minutes). Cached data is stored on
/// disk and can persist for hours or days if you so choose.
/// 
/// @param key
/// @param value

function HTTPCacheCustomSet(_key, _value)
{
    static _system = __HTTPCacheSystem();
    
    var _hash = md5_string_utf8(_key);
    __HTTPCacheSaveString(_system.__cacheDirectory + _hash, json_stringify(_value));
    __HTTPCacheAdd(_hash, _system.__globalDurationMins);
}