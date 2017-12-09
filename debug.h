#ifdef DEBUG
#define DEBUG_MODE 1
#else
#define DEBUG_MODE 0
#endif
#define DBG( ... )\
    if (DEBUG_MODE) { __VA_ARGS__; }
