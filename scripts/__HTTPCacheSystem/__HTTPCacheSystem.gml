// Feather disable all

function __HTTPCacheSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __HTTPCacheTrace("Welcome to HTTP Cache by Juju Adams! This is version 1.0.0, 2025-12-31");
        
        __cacheDirectory = game_save_id + "httpCache/";
        
        __nullMap        = ds_map_create(); //Avoids occasional `ds_map_destroy()` bugs
        __httpRequestMap = ds_map_create();
        __httpFileMap    = ds_map_create();
        
        __cacheDurationMins = 5;
        __cacheTimeMap = undefined;
        
        try
        {
            var _buffer = buffer_load(_system.__cacheDirectory + "manifest.json");
            var _jsonString = buffer_read(_buffer, buffer_text);
            buffer_delete(_buffer);
            
            __cacheTimeMap = json_decode(_jsonString);
            __HTTPCacheTrace($"Loaded cache manifest successfully, {ds_map_size(__cacheTimeMap)} entries in cache");
        }
        catch(_error)
        {
            show_debug_message(json_stringify(_error, true));
            __HTTPCacheTrace("Warning! Failed to load cache manifest");
        }
        
        if ((__cacheTimeMap == undefined) || (not ds_exists(__cacheTimeMap, ds_type_map)))
        {
            __cacheTimeMap = ds_map_create();
        }
        
        var _i = 0;
        var _keyArray = ds_map_keys_to_array(__cacheTimeMap);
        repeat(array_length(_keyArray))
        {
            var _key = _keyArray[_i];
            if (not __HTTPCacheExists(_key))
            {
                var _path = __HTTPCacheGetPath(_key);
                if (file_exists(_path))
                {
                    __HTTPCacheTrace($"Cleaning up old cache entry \"{_key}\"");
                    file_delete(_path);
                }
            }
            
            ++_i;
        }
    }
    
    return _system;
}