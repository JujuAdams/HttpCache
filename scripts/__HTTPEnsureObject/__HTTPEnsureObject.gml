// Feather disable all

function __HTTPEnsureObject()
{
    if (not instance_exists(__objHTTPCache))
    {
        instance_create_depth(0, 0, 0, __objHTTPCache);
    }
    
    return __objHTTPCache.id;
}