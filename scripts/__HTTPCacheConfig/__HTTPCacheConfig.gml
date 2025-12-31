// Feather disable all

// Whether to report process information to the output log. Warnings and errors will still be shown
// even if this macro is set to `false`. This macro is intended to assist with debugging and is not
// intended for use in production builds.
#macro HTTP_CACHE_VERBOSE  false

// Whether to execute `HTTPCacheClear()` when the game boots up. This is helpful for testing or for
// aggressive disk space management.
#macro HTTP_CACHE_CLEAR_ON_BOOT  false

// Whether to execute `HTTPCacheClear()` when the game exits. This is not guaranteed to always
// execute and something like a crash will not allow HTTPCache to delete files on disk.
#macro HTTP_CACHE_CLEAR_ON_EXIT  false