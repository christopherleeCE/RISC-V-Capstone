
    .section .text
    .globl _start

_start:
    li sp, 0x1000
    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    j end

end:
    nop
    nop
    nop
    nop
    nop
    ebreak

    .section .data
    .word 0xDEADBEEF
    .word 0xCAFEBABE
    .word 0x12345678