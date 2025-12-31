// Feather disable all

/// @param minutes

function HTTPCacheSetDuration(_minutes)
{
    static _system = __HTTPCacheSystem();
    
    _minutes = max(0, _minutes);
    
    if (_system.__cacheDurationMins != _minutes)
    {
        _system.__cacheDurationMins = _minutes;
        
        if (HTTP_CACHE_VERBOSE)
        {
            __HTTPCacheTrace($"Set cache duration to {_minutes} minues");
        }
    }
}