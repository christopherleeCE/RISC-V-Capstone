// minimal_test.c

#ifndef X86_BUILD
__attribute__((naked, used)) 
void _start(void) {
    __asm__ volatile (
        "li sp, 0x100\n"   // initialize stack pointer
        "jal ra, main\n"    // call main, ra points to ebreak
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "ebreak\n"          // stop simulation when main returns
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
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

    int ret = -nextTerm;

    #ifdef X86_BUILD
        printf("<%d>\n", ret);
    #else
        ret = -ret;
    #endif

    return ret;
}