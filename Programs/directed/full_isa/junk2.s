.section .text
    .globl _start

_start:
    /* Test ADDI */
            nop
            nop
            nop
            nop
            nop
            li gp, 0x4000
    		lb a1, 4(gp)
            lb a2, 5(gp)
            lb a3, 6(gp)
            lb a4, 7(gp)
            
            lh a5, 4(gp)
            lh a6, 6(gp)
            
            lw a7, 4(gp)
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
    .word 0xDEADBEEF