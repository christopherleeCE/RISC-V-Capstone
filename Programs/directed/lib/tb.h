#ifndef TB_H
    #define TB_H

    #ifndef X86_BUILD

        //extern unsigned int _estack; dont think its needed

        //init stack point to top of dmem address space, jump to int main, 7 nops to let pipeline settle before calling ebreak
        __attribute__((naked, used))
        void _start(void) {
            __asm__ volatile (
                //write init header for heap
                "la a0, _heap_start\n"
                "la a1, _heap_end\n"
                "sub a2, a1, a0\n"
                "addi a2, a2, -12\n" //calc payload size of init block
                "sw a2, 0(a0)\n"    //write header.size
                "sb zero, 4(a0)\n"   //write header.occupied = 0
                "add a0, a0, a2\n"
                "add a0, a0, 8\n"   //a0 = _heap_start + payload_size + 8 (8 bytes of the header)
                "sw a2, 0(a0)\n"      //write footer.size
                "la sp, _estack\n"

                //jmp to int main
                "jal ra, main\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "ebreak\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "nop\n"
                "nop\n"
            );
        }

        //pass through return value
        static inline int tb_return(int ret) {return ret;}

    #else

        //only include stdio if on x86 build
        #include <stdio.h>

        //print out return for direct_master.ps1 to parse from output
        static inline int tb_return(int ret){
            printf("<%d>\n", ret);
            return ret;
        }

    #endif
#endif