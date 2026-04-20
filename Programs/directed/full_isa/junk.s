.section .text
    .globl _start

_start:
    li a0, 5
    li a1, 6
    li a2, 7
    li a3, 8
    li a4, 9
    add t0, a1, a2
    sub t1, a1, a2
    mul t3, a4, a2

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