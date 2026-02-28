    .section .text
    .globl _start

_start:

    li t1, -1
    li t0, 37

    blt t0, t1, fail #37 < -1
    bltu t1, t0, fail #0xFFFFFF < 37
    bge  t1, t0, fail # -1 >= 37
    bgeu t0, t1, fail # 37 >= 0xFFFFFFF
    
    blt t1, t0, label1 # -1 < 37
    nop
    nop
    nop
    nop
    nop
    label1:
    bltu t0, t1, label2 # 37 < 0xFFFFFF
    nop
    nop
    nop
    nop
    nop
    label2:
    bge  t0, t1, label3 #  37 >= -1 
    nop
    nop
    nop
    nop
    nop
    label3:
    bgeu t1, t0, label4 # 0xFFFFFFF >=  37 
    nop
    nop
    nop
    nop
    nop
    label4:

    end:
    nop
    nop
    nop
    nop
    nop
    ebreak

    fail:
    jal fail