.section .text
    .globl _start

_start:
    /* Test ADDI */
    		lb x1, 4(x0)
            lb x2, 5(x0)
            lb x3, 6(x0)
            lb x4, 7(x0)
            
            lh x5, 4(x0)
            lh x6, 6(x0)
            
            lw x7, 4(x0)
			ebreak  

.section .data
    .word 0x00004000
    .word 0xDEADBEEF