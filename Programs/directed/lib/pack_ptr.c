#include "drysoup.h"
#include <stdint.h>
#include <stdbool.h>

/*
packs pointer (> 16 bits) into lower 16bits, and length of arr into upper 16 bits,
preforms length correction for top_fpga.sv seq_engine based on if its a char arr or a 32bit array,
seq engine only supports 8bit and 32bit arrays, ptr arg is a uint32, should cast the ptr to a uint32_t
when calling this func, but not strictly nessisary. len is the length of the array, remember that strings
include a null pointer, the eziest way to generate len of an array is sizeof(arr)/sizeof(arr[0]), is_string
need to determine whether or to not to preform length correction, if an array (non char) of length 1 is passed
in the seq_engine will underflow and the auto stop will not work
*/
uint32_t pack_ptr(uint32_t* ptr, uint16_t len, bool is_string){
    return (((uint32_t)len - (is_string ? 1 : 2)) << 16) | ((uintptr_t)ptr & 0xFFFF);
}