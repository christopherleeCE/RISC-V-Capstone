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

int square(int x) {
    return x * x;
}

int accumulate(int n) {
    int sum = 0;
    for (int i = 0; i < n; i++)
        sum += square(i);
    return sum;
}

int main() {
    int ret = accumulate(5);
    
    #ifdef X86_BUILD
        printf("<%d>\n", ret);
    #endif

    return ret;
}