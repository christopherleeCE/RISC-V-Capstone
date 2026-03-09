.section .data
num: .word 3

.section .text
.globl _start

_start:
    la   t0, num      # load address of num
    lw   t1, 0(t0)    # t1 = num

    li   t2, 1000
    mul  a0, t1, t2   # a0 = num * 10

end:
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