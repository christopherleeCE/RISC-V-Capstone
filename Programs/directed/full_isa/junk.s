.section .text
    .globl _start

_start:
    /* Test ADDI */

            li x10, 10
            li x11, 11
            li x12, 12
            li x13, 13
            li x14, 14
            li x15, 15
            nop
            nop
            nop
            nop
            nop
			ebreak  
            nop
            nop
            nop
            nop
            nop

.section .data
    .word 0x00004000
    .word 0xCAFEBABE