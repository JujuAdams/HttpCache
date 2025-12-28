// Feather disable all

function __HTTPCacheSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
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
        }
        catch(_error)
        {
            show_debug_message(json_stringify(_error, true));
            __HTTPTrace("Failed to load cache manifest");
        }
        
        if ((__cacheTimeMap == undefined) || (not ds_exists(__cacheTimeMap, ds_type_map)))
        {
            __cacheTimeMap = ds_map_create();
        }
    }
    
    return _system;
}