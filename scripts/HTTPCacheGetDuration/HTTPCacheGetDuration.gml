// Feather disable all

function HTTPCacheGetDuration()
{
    static _system = __HTTPCacheSystem();
    
    return _system.__cacheDurationMins;
}