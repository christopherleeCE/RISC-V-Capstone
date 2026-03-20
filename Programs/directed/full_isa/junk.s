.section .text
    .globl _start

_start:
    /* Test ADDI */
            nop
            nop
            nop
            li a0, 7
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