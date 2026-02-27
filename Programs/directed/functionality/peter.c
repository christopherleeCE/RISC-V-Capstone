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
    int n = 7, i = 0, t1 = 0, t2 = 1, nextTerm;

    while (i < n) {
        if (i <= 1) {
            nextTerm = i;
        } else {
            nextTerm = t1 + t2;
            t1 = t2;
            t2 = nextTerm;
        }
        i++;
    }

    int ret = nextTerm;

    #ifdef X86_BUILD
        printf("<%d>\n", ret);
    #endif

    return ret;
}