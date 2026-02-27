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

int fact(int n) {
    if (n <= 1)
        return 1;
    return n * fact(n - 1);
}

int main() {
    int ret = fact(5);
    
    #ifdef X86_BUILD
        printf("<%d>\n", ret);
    #endif

    return ret;
}