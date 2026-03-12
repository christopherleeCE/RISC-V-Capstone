    .section .text
    .globl _start

_start:
li gp, 0x4000
li a0, 0x40302010
li a1, 0x41312111
li a2, 0x42322212
li a3, 0x43332313
li a4, 0x44342414
li a5, 0x45352515
li a6, 0x46362616
nop
sw a0, 0(gp)
sw a1, 4(gp)
sw a2, 8(gp)
sw a3, 12(gp)
sw a4, 16(gp)
sw a5, 20(gp)
sw a6, 24(gp)
nop
lw s0, 0(gp)
lw s1, 4(gp)
lw s2, 8(gp)
lw s3, 12(gp)
lw s4, 16(gp)
lw s5, 20(gp)
lw s6, 24(gp)
nop
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
nop

    .section .data
    .word 0xFFFFFFFF
    .word 0xEEEEEEEE
    .word 0xDDDDDDDD
    .word 0xCCCCCCCC
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF
