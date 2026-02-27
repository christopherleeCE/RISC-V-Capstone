#ifndef WRAPPER_H
#define WRAPPER_H

#ifndef X86_BUILD

    extern unsigned int _estack;

    //init stack point to top of dmem address space, jump to int main, 7 nops to let pipeline settle before calling ebreak
    __attribute__((naked, used))
    void _start(void) {
        __asm__ volatile (
            "la sp, _estack\n"
            "jal ra, main\n"
            "nop\n"
            "nop\n"
            "nop\n"
            "nop\n"
            "nop\n"
            "nop\n"
            "nop\n"
            "ebreak\n"
        );
    }

    //no pass through return value
    static inline int tb_return(int ret) { return ret; }

#else

    //only include stdio if on x86 build
    #include <stdio.h>

    //print out return for direct_master.ps1 to parse from output
    static inline int tb_return(int ret) {
        printf("<%d>\n", ret);
        return ret;
    }

#endif
#endif