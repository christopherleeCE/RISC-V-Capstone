
    .section .text
    .globl _start

_start:

li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

jal sp, . + 4
jalr ra, sp, 4
bge t4, t5, . + 4
beq zero, t1, . + 24
beq t1, t2, . + 16
beq zero, t4, . + 20
blt t0, t1, . + 12
jal ra, . + 24
bne zero, t4, . + 16
blt t0, t1, . + 20
blt t0, t1, . + 20
bge t0, t1, . + 20
bne t4, t5, . + 20
bge t0, t1, . + 8
jal ra, . + 4
blt t0, t1, . + 12
jalr ra, sp, 84
bne zero, t1, . + 8
blt t1, t0, . + 4
bge t6, t5, . + 16
bne zero, t1, . + 24
beq t1, t2, . + 20
blt t1, t0, . + 4
jalr ra, sp, 92
blt t5, t6, . + 16
bne zero, t1, . + 16
bne t1, t2, . + 20
bge t4, t5, . + 4
bne t4, t5, . + 4
bne zero, t4, . + 24
bne t4, t5, . + 12
bge t5, t6, . + 12
blt t6, t5, . + 20
bne zero, t4, . + 8
bge t4, t5, . + 8
beq t1, t2, . + 8
bne zero, t1, . + 16
bge t5, t6, . + 20
blt t0, t1, . + 24
jal ra, . + 4
bne t1, t2, . + 12
jalr ra, sp, 176
bne zero, t4, . + 24
beq zero, t4, . + 12
beq t1, t2, . + 4
blt t0, t1, . + 20
bge t6, t5, . + 16
bge t1, t2, . + 20
blt t5, t6, . + 24
blt t0, t1, . + 20
bne t1, t2, . + 8
jal ra, . + 20
beq t4, t5, . + 12
bge t0, t1, . + 8
jalr ra, sp, 236
bge t1, t0, . + 20
bge t1, t2, . + 16
jal ra, . + 12
bge t4, t5, . + 8
jal ra, . + 16
jal ra, . + 8
bge t5, t6, . + 4
jal ra, . + 24
bne t4, t5, . + 20
bge t6, t5, . + 8
jalr ra, sp, 260
beq zero, t1, . + 24
beq t1, t2, . + 8
beq t1, t2, . + 24
jal ra, . + 8
beq t1, t2, . + 12
bne zero, t4, . + 24
bne zero, t1, . + 24
jal ra, . + 12
beq t1, t2, . + 24
bge t0, t1, . + 24
beq zero, t1, . + 12
beq t4, t5, . + 24
beq zero, t4, . + 16
jal ra, . + 4
bne t4, t5, . + 20
beq zero, t1, . + 16
blt t1, t0, . + 4
bne t1, t2, . + 20
bne zero, t4, . + 16
jal ra, . + 12
beq t1, t2, . + 20
bge t6, t5, . + 8
bne t4, t5, . + 20
bne t4, t5, . + 4
beq zero, t1, . + 8
beq t4, t5, . + 8
blt t0, t1, . + 12
beq t4, t5, . + 16
beq t4, t5, . + 8
jalr ra, sp, 396
beq zero, t4, . + 16
bne t4, t5, . + 20
bne t4, t5, . + 24
jal ra, . + 4
jalr ra, sp, 404
bge t5, t6, . + 16
beq t1, t2, . + 4
bne t4, t5, . + 12
jal ra, . + 16
bne t4, t5, . + 8
beq t1, t2, . + 4
bge t5, t6, . + 8
jal ra, . + 8
beq zero, t1, . + 4
beq zero, t1, . + 8
beq zero, t1, . + 20
jal ra, . + 16
beq t1, t2, . + 12
blt t6, t5, . + 8
bge t4, t5, . + 8
bge t0, t1, . + 4
beq zero, t1, . + 20
blt t6, t5, . + 12
jal ra, . + 16
bne zero, t1, . + 24
bne t1, t2, . + 8
bge t4, t5, . + 8
jal ra, . + 24
bne t4, t5, . + 16
blt t1, t0, . + 16
bne zero, t1, . + 12
jal ra, . + 24
jalr ra, sp, 528
beq t4, t5, . + 12
bne t1, t2, . + 16
bne t1, t2, . + 8
blt t5, t6, . + 12
beq zero, t1, . + 20
bge t1, t0, . + 20
jalr ra, sp, 560
blt t5, t6, . + 24
bne zero, t4, . + 16
bge t5, t6, . + 12
bge t5, t6, . + 16
beq zero, t1, . + 8
beq zero, t1, . + 20
jalr ra, sp, 572
bge t6, t5, . + 4
jal ra, . + 12
jalr ra, sp, 580
beq t1, t2, . + 16
blt t5, t6, . + 12
jal ra, . + 16
jalr ra, sp, 604
beq t1, t2, . + 16
jalr ra, sp, 616
bne zero, t1, . + 4
bne zero, t4, . + 24
bne t1, t2, . + 8
bge t5, t6, . + 8
blt t5, t6, . + 4
bge t0, t1, . + 20
blt t1, t0, . + 24
bge t6, t5, . + 16
bne zero, t1, . + 8
beq zero, t4, . + 4
bge t0, t1, . + 20
jalr ra, sp, 668
jalr ra, sp, 660
jal ra, . + 16
jal ra, . + 8
beq t1, t2, . + 24
beq zero, t1, . + 8
bne zero, t4, . + 12
blt t1, t0, . + 24
bge t6, t5, . + 8
jalr ra, sp, 688
bge t1, t0, . + 8
blt t5, t6, . + 20
beq zero, t4, . + 12
blt t5, t6, . + 20
bne t1, t2, . + 4
blt t6, t5, . + 16
jalr ra, sp, 720
blt t1, t0, . + 4
beq t4, t5, . + 16
blt t1, t0, . + 24
jalr ra, sp, 740
blt t5, t6, . + 20
jal ra, . + 4
bne t4, t5, . + 16
beq zero, t1, . + 24
beq t1, t2, . + 24
bge t6, t5, . + 8
beq t1, t2, . + 8
jalr ra, sp, 768
jalr ra, sp, 768
beq zero, t4, . + 12
jalr ra, sp, 792
jal ra, . + 8
jalr ra, sp, 788
bge t0, t1, . + 16
bne t4, t5, . + 4
bne zero, t1, . + 16
blt t1, t0, . + 16
blt t0, t1, . + 20
blt t0, t1, . + 4
beq t4, t5, . + 20
bne t1, t2, . + 4
blt t0, t1, . + 16
jalr ra, sp, 824
bne zero, t1, . + 4
bge t0, t1, . + 24
beq zero, t1, . + 24
bge t1, t2, . + 16
bne zero, t1, . + 24
bne t1, t2, . + 16
jal ra, . + 8
bne zero, t1, . + 8
bge t0, t1, . + 24
bge t6, t5, . + 8
bne t4, t5, . + 4
bne t1, t2, . + 4
blt t0, t1, . + 16
beq t4, t5, . + 24
bge t5, t6, . + 12
bge t0, t1, . + 12
bne zero, t4, . + 12
bge t6, t5, . + 24
bge t0, t1, . + 12
beq zero, t1, . + 8
jal ra, . + 8
jal ra, . + 12
blt t6, t5, . + 16
bge t4, t5, . + 12
blt t0, t1, . + 12
bge t6, t5, . + 8
beq t4, t5, . + 4
jal ra, . + 4
bne t1, t2, . + 16
bge t0, t1, . + 8
jalr ra, sp, 952
bne zero, t4, . + 4
bne t1, t2, . + 24
bne zero, t4, . + 12
bge t6, t5, . + 16
jal ra, . + 8
blt t6, t5, . + 8
bge t5, t6, . + 8
beq zero, t1, . + 20
beq zero, t1, . + 4
jal ra, . + 12
bge t6, t5, . + 20
bne zero, t1, . + 20
beq t4, t5, . + 20
bge t4, t5, . + 12
blt t0, t1, . + 8
blt t5, t6, . + 20
bne zero, t4, . + 8
beq t1, t2, . + 20
bne zero, t1, . + 16
blt t0, t1, . + 16
jalr ra, sp, 1032
bge t1, t2, . + 20
bne t4, t5, . + 24
beq t4, t5, . + 16
blt t5, t6, . + 24
jalr ra, sp, 1072
blt t6, t5, . + 4
beq t1, t2, . + 8
bge t1, t2, . + 12
blt t6, t5, . + 8
bne zero, t1, . + 4
jal ra, . + 12
bge t4, t5, . + 16
bge t0, t1, . + 16
bge t5, t6, . + 20
bne t4, t5, . + 12
blt t6, t5, . + 24
jalr ra, sp, 1112
jal ra, . + 8
beq zero, t4, . + 20
beq t4, t5, . + 24
bne t1, t2, . + 20
bne zero, t1, . + 24
blt t0, t1, . + 16
beq zero, t4, . + 16
blt t5, t6, . + 24
blt t0, t1, . + 8
blt t1, t0, . + 16
jal ra, . + 20
beq zero, t4, . + 16
bne t4, t5, . + 12
bne zero, t4, . + 16
beq zero, t4, . + 16
bge t0, t1, . + 20
bge t0, t1, . + 20
beq t4, t5, . + 20
blt t1, t0, . + 12
bge t1, t2, . + 16
bne zero, t4, . + 8
blt t5, t6, . + 8
bne zero, t4, . + 16
blt t1, t0, . + 24
jal ra, . + 16
jalr ra, sp, 1204
bne t1, t2, . + 8
jalr ra, sp, 1232
bne zero, t1, . + 8
beq t4, t5, . + 4
bge t4, t5, . + 20
bge t1, t2, . + 24
blt t5, t6, . + 4
bge t0, t1, . + 4
bge t6, t5, . + 4
jal ra, . + 16
bne zero, t4, . + 12
beq t1, t2, . + 24
bne t4, t5, . + 12
jal ra, . + 12
bne t1, t2, . + 16
bge t4, t5, . + 24
bge t5, t6, . + 12
blt t5, t6, . + 24
bne t4, t5, . + 24
blt t0, t1, . + 12
bne t1, t2, . + 8
blt t6, t5, . + 20
blt t1, t0, . + 16
jalr ra, sp, 1316
jal ra, . + 12
bge t1, t0, . + 24
beq zero, t1, . + 16
blt t0, t1, . + 24
beq t4, t5, . + 20
blt t5, t6, . + 16
bne zero, t1, . + 16
beq zero, t1, . + 12
bge t4, t5, . + 12
bge t0, t1, . + 12
blt t1, t0, . + 20
blt t0, t1, . + 8
bne t4, t5, . + 24
blt t1, t0, . + 24
blt t5, t6, . + 16
blt t0, t1, . + 8
bne zero, t1, . + 12
jalr ra, sp, 1380
blt t5, t6, . + 8
bge t4, t5, . + 4
bne zero, t1, . + 20
blt t6, t5, . + 16
bne zero, t1, . + 16
blt t1, t0, . + 12
beq zero, t1, . + 20
jalr ra, sp, 1416
bge t4, t5, . + 16
beq t4, t5, . + 24
blt t6, t5, . + 20
bge t0, t1, . + 16
blt t1, t0, . + 16
beq t4, t5, . + 24
beq zero, t4, . + 20
blt t0, t1, . + 12
blt t5, t6, . + 24
blt t5, t6, . + 4
bne zero, t4, . + 20
bge t6, t5, . + 12
blt t5, t6, . + 8
blt t1, t0, . + 20
jalr ra, sp, 1468
bne t4, t5, . + 20
bne t4, t5, . + 4
blt t6, t5, . + 12
beq zero, t1, . + 12
bge t6, t5, . + 16
bge t0, t1, . + 24
blt t0, t1, . + 20
jalr ra, sp, 1504
bge t0, t1, . + 12
beq t4, t5, . + 4
beq zero, t4, . + 24
blt t5, t6, . + 4
beq t4, t5, . + 24
jal ra, . + 4
blt t0, t1, . + 16
blt t6, t5, . + 8
jal ra, . + 24
bne t4, t5, . + 16
blt t0, t1, . + 4
beq zero, t1, . + 16
beq zero, t1, . + 24
beq zero, t4, . + 20
blt t6, t5, . + 20
jalr ra, sp, 1580
jal ra, . + 12
beq t1, t2, . + 12
bne zero, t1, . + 12
bne zero, t1, . + 4
beq zero, t4, . + 8
bne zero, t1, . + 24
beq zero, t1, . + 24
jalr ra, sp, 1608
jalr ra, sp, 1616
bge t4, t5, . + 12
bne zero, t1, . + 20
blt t6, t5, . + 8
blt t6, t5, . + 12
blt t0, t1, . + 24
blt t5, t6, . + 24
bge t1, t2, . + 12
blt t0, t1, . + 4
bge t4, t5, . + 4
bge t5, t6, . + 12
jal ra, . + 8
bne zero, t4, . + 4
beq zero, t4, . + 16
blt t1, t0, . + 8
beq zero, t4, . + 16
beq t1, t2, . + 12
bge t1, t0, . + 20
jalr ra, sp, 1672
jal ra, . + 20
bge t0, t1, . + 8
bne t1, t2, . + 4
beq t4, t5, . + 12
jal ra, . + 12
blt t1, t0, . + 8
jalr ra, sp, 1708
bne t4, t5, . + 20
beq t1, t2, . + 24
blt t5, t6, . + 20
bne t4, t5, . + 4
jalr ra, sp, 1724
beq t4, t5, . + 16
jal ra, . + 24
bge t0, t1, . + 4
blt t5, t6, . + 4
jal ra, . + 24
jalr ra, sp, 1744
bge t0, t1, . + 4
bne zero, t1, . + 24
bne t1, t2, . + 20
blt t0, t1, . + 24
bne zero, t1, . + 20
bge t1, t0, . + 24
bge t1, t2, . + 16
bge t1, t0, . + 12
blt t6, t5, . + 24
bge t4, t5, . + 4
jalr ra, sp, 1796
bge t0, t1, . + 12
beq zero, t1, . + 4
blt t1, t0, . + 4
bne zero, t1, . + 4
bge t4, t5, . + 12
blt t1, t0, . + 20
blt t5, t6, . + 8
bne zero, t1, . + 20
bge t0, t1, . + 16
bne t1, t2, . + 4
bne t4, t5, . + 24
jal ra, . + 12
bne zero, t4, . + 24
beq zero, t1, . + 24
jal ra, . + 16
bne t1, t2, . + 24
bge t5, t6, . + 12
bge t4, t5, . + 8
blt t6, t5, . + 4
bge t1, t2, . + 24
bge t0, t1, . + 20
beq zero, t4, . + 4
bge t1, t2, . + 8
blt t0, t1, . + 24
blt t0, t1, . + 24
beq t1, t2, . + 8
jal ra, . + 12
blt t0, t1, . + 20
jalr ra, sp, 1916
bge t6, t5, . + 12
jalr ra, sp, 1928
bge t6, t5, . + 12
jal ra, . + 8
bge t5, t6, . + 20
blt t0, t1, . + 12
jal ra, . + 16
beq t4, t5, . + 12
bge t0, t1, . + 4
bne t4, t5, . + 12
beq t4, t5, . + 4
jal ra, . + 16

nop
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
nop
