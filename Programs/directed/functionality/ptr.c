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
    int values[4] = {3, 6, 9, 12};
    int *p = values;
    int sum = 0;

    for (int i = 0; i < 4; i++) {
        sum += *(p + i);
    }

    int ret = sum;
    
    #ifdef X86_BUILD
        printf("<%d>\n", ret);
    #endif

    return ret;
}