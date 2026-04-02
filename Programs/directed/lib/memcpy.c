//does as char's so that its byte by byte
//credit to gpt
#include "drysoup.h"
#include <stddef.h>

//manual definition of memcpy which is called and occasiaonlly by gcc
void *memcpy(void *dest, const void *src, size_t n){
    char *d = (char *)dest;
    const char *s = (const char *)src;

    for (size_t i = 0; i < n; i++) {
        d[i] = s[i];
    }

    return dest;
}