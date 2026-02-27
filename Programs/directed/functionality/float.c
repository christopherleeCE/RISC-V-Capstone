#ifndef X86_BUILD

extern unsigned int _estack;
__attribute__((naked, used)) 
void _start(void) {
    __asm__ volatile (
        "la sp, _estack\n"   // initialize stack pointer
        "jal ra, main\n"    // call main, ra points to ebreak
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "ebreak\n"          // stop simulation when main returns

    );
}

#else
#include "stdio.h"
#endif

int main() {

    // float pi = 3.14;
    // float r = 2;
    // // float r = 7;
    // // float r = 13.7;

    // int ret = pi*r*r;

    int ret = 0;

    #ifdef X86_BUILD
        ret = ret;
        printf("<%d>\n", ret);
    #endif

    return ret;
}