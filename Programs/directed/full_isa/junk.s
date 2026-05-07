.section .text
    .globl _start

_start:

    li a0, 0x11
    li a1, 0x22
    li a2, 0x33
    li a3, 0x44
    li gp, 0x18000
    sb a0, 12(gp)
    sb a1, 13(gp)
    sb a2, 14(gp)
    sb a3, 15(gp)
    li a0, 0xAAAA
    li a1, 0xFFFF
    sh a0, 16(gp)
    sh a1, 18(gp)
    li a0, 0xBEAFCAFE
    sw a0, 20(gp)
    # li a0, 0
    # li gp, 0x18000

    # li t0, 0
    # li t1, 0x800
    # for_begin:  #for(ii = 0; ii < 0x1000; ii++)
    #     bge t0, t1, for_end

    #     sh a0, 0(gp)    #write to vram
    #     addi a0, a0, 1  #increment write_val
    #     addi gp, gp, 2  #increment vram ptr

    #     addi t0, t0, 1  #inc ii
    #     j for_begin
    # for_end:


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
