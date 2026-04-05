#ifndef DRYSOUP_H
#define DRYSOUP_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

//note that in directed_master.ps1, there are possible conflicts with memcpy and memset when the x86 is ran,
//it seems that right now gcc uses the glib version and not ours, howver that alse may cause an issue as our
//2 code runs are actually running different c code, however if you think about it we are really just verifying
//that our lib is correct (that is complete and utter copium, the correct thing to do is to put the #include drysoup.h
//inside and #ifndef X86_BUILD, but that is less asthetic and i refuse to recomend that unless it really becomes an issue)

void* memcpy(void *dest, const void *src, size_t n);
void* memset(void *s, int c, size_t n);
uint32_t pack_ptr(uint32_t ptr, uint16_t len, bool is_string);
int rf2i(float);
void* malloc(size_t payload_size);

#endif

