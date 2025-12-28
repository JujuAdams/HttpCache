// Feather disable all

/// @param minutes

function HTTPCacheSetDuration(_minutes)
{
    static _system = __HTTPCacheSystem();
    
    _system.__cacheDurationMins = max(0, _minutes);
}