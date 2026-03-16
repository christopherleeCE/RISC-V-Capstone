	.section .text
	.globl _start
_start:
j main

loop_back:
ret

main:
li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

jal sp, . + 4
bgeu t0, t6, . + 12
bgeu t1, t2, . + 4
bltu t0, t6, . + 12
jalr ra, zero, 4
bltu t1, t2, . + 12
bge t4, t5, . + 4
beq zero, t1, . + 24
blt t6, t5, . + 20
bge t6, t5, . + 20
beq t1, t2, . + 8
blt t1, t0, . + 16
bltu t6, t3, . + 16
bgeu t0, t6, . + 24
blt t0, t1, . + 20
jal ra, loop_back
bge t4, t5, . + 20
bne zero, t4, . + 8
beq t4, t5, . + 4
bltu t0, t6, . + 4
bne t1, t2, . + 16
blt t5, t6, . + 8
bne t1, t2, . + 8
bltu t6, t0, . + 20
bltu t6, t3, . + 20
beq t1, t2, . + 24
jal ra, . + 4
beq t1, t2, . + 24
bge t0, t1, . + 12
bltu t0, t6, . + 24
bne t4, t5, . + 8
bltu t4, t5, . + 24
bltu t0, t6, . + 12
beq t4, t5, . + 16
jal ra, . + 8
bgeu t3, t6, . + 20
jalr ra, sp, 148
bne t4, t5, . + 24
beq t1, t2, . + 4
bge t0, t1, . + 20
beq zero, t1, . + 4
bge t0, t1, . + 20
bge t0, t1, . + 8
jal ra, loop_back
bltu t6, t0, . + 20
bltu t0, t3, . + 12
jalr ra, zero, 4
bne zero, t1, . + 4
bgeu t4, t5, . + 12
beq t1, t2, . + 12
bgeu t6, t0, . + 16
jalr ra, sp, 220
blt t6, t5, . + 4
bgeu t3, t6, . + 20
blt t6, t5, . + 4
bgeu t0, t6, . + 12
jalr ra, sp, 232
bltu t6, t0, . + 24
beq t4, t5, . + 12
bne t4, t5, . + 12
bne t4, t5, . + 16
bgeu t6, t0, . + 12
jalr ra, sp, 256
bne t1, t2, . + 24
bne zero, t1, . + 8
bge t5, t6, . + 24
bgeu t3, t6, . + 4
blt t6, t5, . + 4
blt t1, t0, . + 12
blt t5, t6, . + 16
bltu t3, t0, . + 16
beq t4, t5, . + 4
beq zero, t1, . + 4
bltu t4, t5, . + 24
bgeu t3, t6, . + 8
bgeu t4, t5, . + 20
jal ra, . + 24
bne t4, t5, . + 20
bgeu t3, t6, . + 8
bgeu t4, t5, . + 16
bltu t4, t5, . + 24
bgeu t6, t0, . + 12
beq zero, t1, . + 12
bne zero, t4, . + 12
beq zero, t4, . + 24
jal ra, loop_back
jalr ra, zero, 4
jalr ra, sp, 352
blt t6, t5, . + 20
bge t1, t2, . + 24
bgeu t3, t0, . + 12
bge t1, t2, . + 16
blt t6, t5, . + 4
beq t4, t5, . + 8
jalr ra, sp, 384
blt t0, t1, . + 24
bltu t4, t5, . + 8
bge t1, t2, . + 24
jalr ra, zero, 4
jalr ra, zero, 4
blt t5, t6, . + 12
bge t4, t5, . + 8
beq zero, t4, . + 24
bne t1, t2, . + 8
bgeu t3, t0, . + 12
jal ra, . + 8
beq t4, t5, . + 12
blt t0, t1, . + 20
bge t6, t5, . + 4
bne zero, t1, . + 24
blt t1, t0, . + 12
jal ra, . + 4
jal ra, . + 24
bgeu t0, t3, . + 20
bgeu t3, t0, . + 4
beq zero, t1, . + 8
bgeu t6, t0, . + 12
bge t1, t0, . + 16
bne zero, t4, . + 20
bge t6, t5, . + 16
jalr ra, sp, 496
jal ra, loop_back
bltu t6, t3, . + 12
jalr ra, sp, 504
beq zero, t4, . + 4
blt t5, t6, . + 8
bne zero, t1, . + 24
blt t6, t5, . + 12
blt t6, t5, . + 12
jal ra, . + 16
bgeu t0, t6, . + 16
jal ra, loop_back
jal ra, loop_back
beq zero, t4, . + 24
bltu t6, t0, . + 12
beq zero, t1, . + 4
jalr ra, zero, 4
bne t1, t2, . + 16
blt t1, t0, . + 4
bne zero, t1, . + 24
blt t0, t1, . + 20
jal ra, loop_back
beq t4, t5, . + 24
bge t6, t5, . + 4
bgeu t3, t0, . + 16
bltu t3, t0, . + 24
jal ra, . + 8
bne t1, t2, . + 20
jalr ra, zero, 4
beq zero, t1, . + 16
bgeu t4, t5, . + 12
jal ra, loop_back
blt t6, t5, . + 12
jal ra, loop_back
bne zero, t1, . + 24
bgeu t6, t0, . + 12
bgeu t3, t6, . + 16
bge t0, t1, . + 24
bltu t6, t0, . + 4
beq t1, t2, . + 20
beq zero, t1, . + 24
beq zero, t1, . + 20
bge t5, t6, . + 4
blt t6, t5, . + 4
bge t6, t5, . + 16
blt t6, t5, . + 4
bltu t0, t3, . + 20
bltu t3, t6, . + 8
bgeu t4, t5, . + 16
bgeu t0, t3, . + 4
blt t0, t1, . + 16
jalr ra, zero, 4
bne t4, t5, . + 12
bltu t3, t6, . + 24
bge t0, t1, . + 8
bne t4, t5, . + 8
blt t6, t5, . + 24
bge t6, t5, . + 16
jalr ra, sp, 732
jal ra, loop_back
jalr ra, zero, 4
bgeu t4, t5, . + 8
jal ra, . + 4
bltu t6, t3, . + 24
bne t1, t2, . + 16
bne t4, t5, . + 24
bgeu t1, t2, . + 8
bne t1, t2, . + 4
bltu t3, t0, . + 24
bne zero, t4, . + 4
bgeu t3, t0, . + 24
jal ra, loop_back
jal ra, loop_back
jal ra, . + 8
bltu t1, t2, . + 20
jal ra, loop_back
bgeu t0, t6, . + 8
beq zero, t1, . + 12
jalr ra, sp, 800
bne zero, t1, . + 24
jalr ra, zero, 4
bne t4, t5, . + 4
bne zero, t4, . + 12
bltu t0, t6, . + 8
bge t0, t1, . + 24
jal ra, . + 24
bne zero, t4, . + 16
blt t0, t1, . + 24
blt t1, t0, . + 16
bltu t1, t2, . + 8
bge t4, t5, . + 20
bltu t3, t6, . + 24
bne zero, t1, . + 24
blt t5, t6, . + 20
jal ra, . + 16
jalr ra, sp, 864
bge t5, t6, . + 12
bne zero, t1, . + 4
bltu t3, t0, . + 8
bltu t3, t0, . + 16
jalr ra, zero, 4
beq zero, t4, . + 24
blt t5, t6, . + 20
bge t1, t0, . + 4
beq t4, t5, . + 12
bgeu t1, t2, . + 8
bltu t4, t5, . + 8
beq zero, t1, . + 20
jal ra, loop_back
blt t1, t0, . + 4
beq zero, t1, . + 4
bne t4, t5, . + 12
bne t4, t5, . + 4
bgeu t0, t6, . + 12
bge t4, t5, . + 12
jal ra, . + 12
bne t4, t5, . + 4
bne zero, t1, . + 4
beq zero, t4, . + 4
blt t0, t1, . + 24
beq t1, t2, . + 24
bgeu t3, t0, . + 24
blt t1, t0, . + 16
bltu t0, t6, . + 16
beq t1, t2, . + 24
bgeu t6, t3, . + 20
bne zero, t4, . + 16
jal ra, loop_back
bge t1, t2, . + 20
beq zero, t4, . + 8
bltu t6, t3, . + 8
beq t4, t5, . + 12
blt t1, t0, . + 20
jalr ra, sp, 1028
bgeu t0, t6, . + 16
bgeu t3, t6, . + 16
jalr ra, zero, 4
beq zero, t1, . + 12
bltu t6, t3, . + 8
jal ra, . + 20
blt t0, t1, . + 4
bgeu t6, t3, . + 24
jal ra, . + 8
bltu t6, t3, . + 24
bltu t3, t6, . + 4
blt t0, t1, . + 8
bge t5, t6, . + 12
bne zero, t4, . + 8
bgeu t1, t2, . + 20
blt t6, t5, . + 4
bge t0, t1, . + 20
bgeu t6, t3, . + 12
bge t6, t5, . + 20
bge t1, t2, . + 20
blt t6, t5, . + 16
bge t6, t5, . + 12
bne zero, t1, . + 24
bge t5, t6, . + 20
jalr ra, sp, 1124
bge t1, t2, . + 8
beq zero, t1, . + 16
bge t4, t5, . + 16
bne t1, t2, . + 8
beq t1, t2, . + 20
jalr ra, zero, 4
bge t6, t5, . + 12
beq t4, t5, . + 8
blt t0, t1, . + 4
bgeu t4, t5, . + 24
jal ra, . + 16
bge t5, t6, . + 8
blt t1, t0, . + 20
jal ra, . + 8
bne zero, t4, . + 4
beq zero, t1, . + 12
bne t1, t2, . + 16
beq zero, t1, . + 20
jal ra, . + 20
beq zero, t4, . + 12
bne t4, t5, . + 20
blt t1, t0, . + 20
jalr ra, zero, 4
jalr ra, sp, 1224
bne zero, t4, . + 24
bge t6, t5, . + 16
bgeu t0, t6, . + 16
bne t4, t5, . + 12
bgeu t4, t5, . + 4
blt t0, t1, . + 12
blt t6, t5, . + 20
jal ra, loop_back
beq zero, t4, . + 12
bne t1, t2, . + 20
bge t6, t5, . + 4
bne zero, t1, . + 12
beq zero, t1, . + 24
jal ra, loop_back
bgeu t3, t0, . + 20
bltu t3, t6, . + 4
bne t1, t2, . + 4
blt t5, t6, . + 8
bltu t6, t0, . + 20
bgeu t3, t0, . + 4
jalr ra, sp, 1312
bne t1, t2, . + 12
bge t0, t1, . + 12
bgeu t3, t0, . + 4
bltu t0, t6, . + 8
bge t0, t1, . + 4
jal ra, . + 12
jalr ra, sp, 1328
beq t1, t2, . + 24
bge t4, t5, . + 12
jal ra, . + 12
bltu t3, t0, . + 12
beq t4, t5, . + 12
bge t6, t5, . + 20
bgeu t4, t5, . + 12
jal ra, loop_back
bltu t0, t3, . + 12
bne t1, t2, . + 12
bne t1, t2, . + 12
jal ra, . + 8
bltu t3, t6, . + 8
jalr ra, zero, 4
bgeu t3, t6, . + 24
bltu t3, t0, . + 16
beq zero, t4, . + 8
bgeu t0, t6, . + 12
bltu t3, t0, . + 24
bne zero, t4, . + 4
blt t1, t0, . + 8
bge t1, t2, . + 4
bltu t3, t6, . + 16
bge t0, t1, . + 4
bltu t6, t0, . + 12
bne t1, t2, . + 24
beq t4, t5, . + 20
bgeu t1, t2, . + 4
bltu t3, t0, . + 8
blt t5, t6, . + 8
beq zero, t1, . + 8
bge t1, t2, . + 8
bne t4, t5, . + 20
jalr ra, sp, 1464
bgeu t4, t5, . + 12
beq zero, t4, . + 24
jalr ra, sp, 1476
blt t0, t1, . + 16
bgeu t6, t0, . + 24
bne zero, t4, . + 20
blt t0, t1, . + 16
beq t4, t5, . + 16
beq zero, t1, . + 8
jal ra, . + 24
bne zero, t4, . + 24
bge t1, t2, . + 24
bge t6, t5, . + 8
bne t1, t2, . + 16
bne t1, t2, . + 8
beq zero, t1, . + 20
blt t0, t1, . + 16
bge t5, t6, . + 4
bge t1, t2, . + 8
jalr ra, sp, 1540
bgeu t3, t6, . + 20
bgeu t0, t6, . + 20
bgeu t0, t6, . + 12
bge t0, t1, . + 4
bgeu t6, t3, . + 20
bne zero, t1, . + 4
jal ra, loop_back
bge t1, t2, . + 12
bgeu t3, t6, . + 8
jalr ra, zero, 4
bgeu t4, t5, . + 4
bne t4, t5, . + 16
bge t4, t5, . + 4
bltu t0, t6, . + 8
blt t5, t6, . + 8
bne t1, t2, . + 4
jal ra, loop_back
blt t1, t0, . + 4
bge t6, t5, . + 8
bgeu t4, t5, . + 8
jal ra, loop_back
jal ra, . + 20
blt t1, t0, . + 12
blt t6, t5, . + 8
jalr ra, zero, 4
jal ra, . + 20
bltu t6, t3, . + 8
jal ra, . + 4
bgeu t6, t3, . + 4
jal ra, . + 16
jalr ra, sp, 1664
bltu t6, t0, . + 20
bne t1, t2, . + 24
blt t6, t5, . + 4
bgeu t4, t5, . + 12
bltu t6, t3, . + 8
bltu t3, t6, . + 12
jal ra, . + 4
bltu t0, t6, . + 8
bne zero, t1, . + 16
jal ra, . + 4
jalr ra, sp, 1720
jalr ra, zero, 4
bne zero, t4, . + 24
blt t0, t1, . + 20
blt t6, t5, . + 12
jalr ra, zero, 4
bgeu t3, t6, . + 12
jalr ra, sp, 1740
bgeu t6, t3, . + 8
blt t0, t1, . + 12
bge t0, t1, . + 4
beq t4, t5, . + 24
bgeu t3, t0, . + 16
jalr ra, sp, 1756
jal ra, loop_back
beq t1, t2, . + 12
bge t1, t0, . + 16
bge t0, t1, . + 24
blt t0, t1, . + 8
bltu t6, t0, . + 4
beq t1, t2, . + 16
bge t5, t6, . + 16
blt t1, t0, . + 4
bgeu t3, t6, . + 20
bgeu t3, t0, . + 12
jalr ra, zero, 4
bgeu t0, t3, . + 16
jalr ra, sp, 1828
beq t1, t2, . + 8
bgeu t6, t0, . + 16
bltu t3, t0, . + 4
jalr ra, zero, 4
bge t4, t5, . + 8
bgeu t3, t6, . + 8
bne zero, t1, . + 20
bge t1, t2, . + 20
bne t1, t2, . + 24
bne zero, t1, . + 20
beq zero, t4, . + 24
bgeu t0, t6, . + 16
jalr ra, sp, 1872
bgeu t0, t3, . + 20
bgeu t0, t6, . + 16
bne zero, t4, . + 12
beq t4, t5, . + 16
beq t1, t2, . + 16
bge t0, t1, . + 16
jal ra, . + 20
jalr ra, zero, 4
bge t0, t1, . + 4
blt t5, t6, . + 20
beq t4, t5, . + 20
bge t1, t2, . + 20
bltu t6, t3, . + 8
bgeu t4, t5, . + 8
bltu t1, t2, . + 16
jal ra, . + 12
bne zero, t4, . + 20
jal ra, loop_back
beq t1, t2, . + 8
bge t1, t0, . + 8
beq zero, t1, . + 12
bne zero, t4, . + 16
jalr ra, zero, 4
beq zero, t1, . + 20
bgeu t0, t3, . + 16
jalr ra, sp, 1988
bgeu t1, t2, . + 20
bgeu t0, t6, . + 20
jal ra, . + 20
jalr ra, sp, 2004
jalr ra, sp, 2004
jalr ra, zero, 4
bgeu t1, t2, . + 12
beq zero, t4, . + 20
bge t4, t5, . + 20
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jal sp, . + 4
bgeu t3, t6, . + 20
jalr ra, sp, 16
bgeu t3, t0, . + 4
blt t6, t5, . + 4
jal ra, . + 12
bge t4, t5, . + 16
bge t1, t0, . + 16
bne t4, t5, . + 8
bge t5, t6, . + 12
beq t4, t5, . + 16
beq zero, t1, . + 4
bgeu t3, t6, . + 16
bge t0, t1, . + 4
jalr ra, zero, 4
bne t4, t5, . + 4
jalr ra, sp, 80
bge t1, t0, . + 24
beq zero, t1, . + 16
bne zero, t4, . + 16
bgeu t3, t0, . + 8
jalr ra, sp, 88
bne zero, t1, . + 16
jal ra, . + 20
beq t4, t5, . + 4
jalr ra, sp, 108
bltu t6, t3, . + 12
blt t0, t1, . + 20
bltu t4, t5, . + 16
bge t0, t1, . + 24
jal ra, . + 20
blt t0, t1, . + 20
beq zero, t4, . + 8
bne t4, t5, . + 16
bgeu t3, t0, . + 12
bne zero, t1, . + 4
jalr ra, sp, 160
bne t4, t5, . + 20
bne zero, t1, . + 20
jal ra, . + 24
bltu t6, t0, . + 24
beq zero, t1, . + 16
blt t1, t0, . + 20
jal ra, loop_back
bne zero, t4, . + 4
blt t1, t0, . + 24
bltu t3, t0, . + 8
blt t0, t1, . + 16
bgeu t3, t6, . + 12
jal ra, loop_back
bge t0, t1, . + 20
jalr ra, sp, 216
blt t6, t5, . + 20
bgeu t0, t3, . + 24
beq t4, t5, . + 20
beq t1, t2, . + 12
blt t0, t1, . + 24
bltu t3, t6, . + 16
bltu t3, t6, . + 16
blt t6, t5, . + 4
bltu t6, t3, . + 20
jalr ra, zero, 4
bltu t4, t5, . + 12
bne zero, t1, . + 16
bltu t1, t2, . + 20
bltu t3, t0, . + 24
jalr ra, sp, 284
bge t6, t5, . + 16
jal ra, . + 24
bge t6, t5, . + 4
bltu t3, t0, . + 12
beq zero, t4, . + 12
beq zero, t4, . + 24
blt t0, t1, . + 4
blt t1, t0, . + 16
bge t0, t1, . + 20
blt t5, t6, . + 20
beq t4, t5, . + 20
bltu t3, t0, . + 20
bgeu t1, t2, . + 16
beq zero, t1, . + 16
bne t4, t5, . + 24
beq zero, t4, . + 20
beq zero, t1, . + 24
beq t4, t5, . + 24
jalr ra, zero, 4
jal ra, loop_back
bge t6, t5, . + 12
blt t1, t0, . + 4
beq zero, t1, . + 12
blt t1, t0, . + 4
bge t0, t1, . + 24
bne zero, t4, . + 24
beq zero, t4, . + 24
bgeu t6, t3, . + 4
bgeu t1, t2, . + 12
bne t1, t2, . + 4
bltu t3, t0, . + 16
bne zero, t1, . + 8
beq zero, t4, . + 20
bge t4, t5, . + 24
beq t1, t2, . + 16
bge t6, t5, . + 20
bltu t0, t6, . + 12
jal ra, loop_back
beq zero, t1, . + 12
bgeu t6, t3, . + 8
beq zero, t4, . + 8
bge t1, t0, . + 8
bltu t6, t0, . + 12
bge t1, t2, . + 4
jalr ra, sp, 452
beq zero, t1, . + 16
bne t1, t2, . + 12
blt t5, t6, . + 12
bgeu t1, t2, . + 12
bltu t4, t5, . + 24
bne zero, t1, . + 24
jalr ra, zero, 4
blt t0, t1, . + 8
blt t1, t0, . + 8
beq t4, t5, . + 20
beq t4, t5, . + 8
jal ra, loop_back
bltu t4, t5, . + 4
bltu t6, t3, . + 12
jal ra, . + 16
bgeu t3, t6, . + 20
blt t5, t6, . + 8
jalr ra, zero, 4
bge t0, t1, . + 20
beq zero, t1, . + 24
beq zero, t4, . + 12
bne zero, t4, . + 4
bne zero, t1, . + 16
blt t5, t6, . + 12
bgeu t3, t0, . + 20
jal ra, . + 12
bltu t3, t6, . + 24
bgeu t0, t6, . + 4
beq zero, t1, . + 8
bgeu t1, t2, . + 16
blt t0, t1, . + 8
bne zero, t4, . + 12
bgeu t6, t0, . + 12
beq zero, t1, . + 16
bltu t6, t3, . + 16
bne zero, t4, . + 20
jal ra, . + 20
beq t4, t5, . + 24
jalr ra, zero, 4
blt t6, t5, . + 16
beq t1, t2, . + 16
blt t0, t1, . + 16
blt t1, t0, . + 12
beq zero, t1, . + 20
beq zero, t4, . + 24
bltu t3, t0, . + 16
jalr ra, sp, 644
bgeu t0, t6, . + 4
jalr ra, sp, 656
jal ra, . + 12
bgeu t0, t6, . + 20
bge t6, t5, . + 4
jalr ra, zero, 4
bne zero, t4, . + 12
jalr ra, zero, 4
bge t6, t5, . + 12
bgeu t6, t3, . + 4
jalr ra, zero, 4
jalr ra, sp, 700
blt t5, t6, . + 4
jalr ra, sp, 708
bge t4, t5, . + 8
bltu t0, t6, . + 4
jal ra, loop_back
jalr ra, zero, 4
bne zero, t1, . + 8
bgeu t6, t0, . + 12
jal ra, . + 4
bne t4, t5, . + 12
bne t1, t2, . + 4
beq t4, t5, . + 20
bgeu t6, t0, . + 12
beq t4, t5, . + 12
bltu t3, t6, . + 20
bge t1, t0, . + 24
bgeu t3, t0, . + 4
bne t4, t5, . + 24
bne zero, t4, . + 8
blt t6, t5, . + 8
beq t4, t5, . + 16
bgeu t0, t3, . + 20
bne t4, t5, . + 24
jal ra, . + 16
blt t1, t0, . + 16
bltu t0, t6, . + 20
bgeu t1, t2, . + 16
jal ra, . + 20
jal ra, . + 8
bge t6, t5, . + 16
jal ra, loop_back
bgeu t3, t0, . + 12
blt t1, t0, . + 24
bne zero, t4, . + 12
blt t0, t1, . + 24
bgeu t3, t6, . + 12
bne zero, t4, . + 12
bltu t3, t6, . + 20
jalr ra, zero, 4
bne zero, t1, . + 16
bne zero, t4, . + 16
bge t0, t1, . + 8
bge t6, t5, . + 8
blt t5, t6, . + 16
blt t1, t0, . + 20
jal ra, . + 16
bge t6, t5, . + 24
jal ra, . + 12
blt t5, t6, . + 16
bge t0, t1, . + 16
bgeu t1, t2, . + 16
bgeu t0, t3, . + 24
jalr ra, sp, 896
bltu t3, t0, . + 4
beq t1, t2, . + 16
bge t4, t5, . + 8
beq t1, t2, . + 20
blt t5, t6, . + 24
bltu t6, t3, . + 16
jal ra, . + 4
bne t1, t2, . + 24
jalr ra, sp, 940
bgeu t3, t6, . + 20
bne t4, t5, . + 16
jalr ra, sp, 960
bgeu t3, t0, . + 4
bge t6, t5, . + 24
beq t1, t2, . + 20
bne t1, t2, . + 24
bgeu t0, t3, . + 12
bge t4, t5, . + 16
bge t0, t1, . + 20
beq t4, t5, . + 12
blt t1, t0, . + 24
beq zero, t4, . + 24
bltu t3, t0, . + 4
jalr ra, zero, 4
blt t6, t5, . + 24
jalr ra, zero, 4
blt t6, t5, . + 20
bgeu t3, t0, . + 4
beq t1, t2, . + 16
beq zero, t1, . + 20
bge t5, t6, . + 12
bltu t0, t3, . + 4
jalr ra, sp, 1036
bne t4, t5, . + 20
jal ra, . + 12
bgeu t0, t3, . + 4
beq t4, t5, . + 8
bge t1, t0, . + 12
jalr ra, sp, 1052
bne t4, t5, . + 4
jalr ra, sp, 1060
blt t6, t5, . + 16
beq t4, t5, . + 8
jalr ra, zero, 4
bge t0, t1, . + 16
bne t1, t2, . + 16
jal ra, . + 12
bge t1, t0, . + 8
bgeu t6, t0, . + 12
bgeu t4, t5, . + 4
bgeu t0, t3, . + 12
beq t4, t5, . + 4
jalr ra, zero, 4
bgeu t0, t6, . + 4
bge t1, t0, . + 4
jalr ra, sp, 1116
jal ra, loop_back
bge t0, t1, . + 12
bltu t0, t6, . + 20
bne zero, t4, . + 16
bgeu t4, t5, . + 8
bne t4, t5, . + 20
bltu t0, t6, . + 4
blt t0, t1, . + 20
jalr ra, zero, 4
bgeu t4, t5, . + 8
bltu t1, t2, . + 24
bgeu t6, t0, . + 12
bne zero, t4, . + 12
bne t4, t5, . + 12
bgeu t0, t3, . + 12
bge t1, t2, . + 12
bge t6, t5, . + 4
bgeu t6, t0, . + 8
beq zero, t1, . + 4
beq zero, t1, . + 8
bne zero, t1, . + 4
jalr ra, zero, 4
bgeu t6, t3, . + 4
blt t6, t5, . + 24
blt t1, t0, . + 8
blt t6, t5, . + 12
jal ra, loop_back
blt t6, t5, . + 8
bge t5, t6, . + 16
blt t0, t1, . + 20
blt t0, t1, . + 24
jalr ra, zero, 4
bgeu t4, t5, . + 16
blt t1, t0, . + 8
jal ra, loop_back
bge t0, t1, . + 20
blt t0, t1, . + 12
jalr ra, zero, 4
jalr ra, sp, 1288
jalr ra, zero, 4
bne t4, t5, . + 12
bge t1, t0, . + 20
bltu t0, t6, . + 24
bge t1, t0, . + 24
bgeu t4, t5, . + 4
bltu t0, t6, . + 8
jal ra, . + 16
jal ra, . + 8
jal ra, loop_back
bltu t3, t6, . + 16
jalr ra, sp, 1332
bgeu t6, t0, . + 24
beq zero, t1, . + 16
bge t5, t6, . + 16
bltu t1, t2, . + 20
blt t5, t6, . + 16
bltu t4, t5, . + 12
bne zero, t4, . + 12
bne t1, t2, . + 8
bne t4, t5, . + 20
blt t6, t5, . + 8
beq t4, t5, . + 24
jal ra, loop_back
bge t1, t0, . + 16
bge t5, t6, . + 24
bltu t1, t2, . + 12
bge t1, t0, . + 4
bge t6, t5, . + 12
jalr ra, sp, 1392
bgeu t6, t3, . + 24
bgeu t0, t3, . + 16
jalr ra, sp, 1420
blt t5, t6, . + 16
bne t1, t2, . + 16
bge t1, t0, . + 12
bgeu t6, t0, . + 8
bge t6, t5, . + 16
bne zero, t1, . + 24
bltu t1, t2, . + 4
blt t5, t6, . + 16
beq t1, t2, . + 12
bltu t3, t0, . + 4
bge t5, t6, . + 20
jalr ra, zero, 4
beq zero, t4, . + 16
beq t4, t5, . + 20
blt t6, t5, . + 20
bne t4, t5, . + 12
bgeu t4, t5, . + 16
bgeu t3, t6, . + 20
bge t5, t6, . + 24
bgeu t6, t0, . + 24
bltu t3, t6, . + 12
bge t6, t5, . + 16
bge t1, t2, . + 12
jal ra, loop_back
bltu t3, t6, . + 4
bltu t6, t3, . + 8
beq zero, t4, . + 20
bltu t6, t0, . + 12
bgeu t3, t0, . + 16
beq t1, t2, . + 24
bltu t3, t0, . + 4
bge t0, t1, . + 12
jal ra, . + 4
beq zero, t4, . + 16
jalr ra, sp, 1548
bne t4, t5, . + 24
bgeu t3, t6, . + 16
jal ra, . + 20
blt t0, t1, . + 12
jalr ra, sp, 1572
bgeu t3, t6, . + 4
jal ra, . + 4
bltu t4, t5, . + 20
blt t0, t1, . + 4
jalr ra, sp, 1596
bge t1, t2, . + 20
bltu t3, t0, . + 20
beq zero, t1, . + 24
jalr ra, zero, 4
bltu t1, t2, . + 4
jalr ra, zero, 4
jal ra, . + 8
bltu t0, t6, . + 16
bgeu t4, t5, . + 20
beq zero, t4, . + 24
bgeu t0, t3, . + 20
jalr ra, sp, 1640
jal ra, loop_back
bne t1, t2, . + 24
bge t6, t5, . + 16
bge t4, t5, . + 16
bgeu t3, t0, . + 8
bgeu t6, t0, . + 12
jal ra, loop_back
jalr ra, sp, 1672
bne zero, t4, . + 24
bne t1, t2, . + 12
blt t1, t0, . + 4
bgeu t3, t6, . + 16
jal ra, . + 8
bgeu t3, t0, . + 12
jal ra, loop_back
bne t1, t2, . + 12
bltu t3, t6, . + 4
blt t0, t1, . + 16
bgeu t6, t3, . + 12
bne t1, t2, . + 24
bne t1, t2, . + 20
bne t4, t5, . + 8
blt t6, t5, . + 24
bne t1, t2, . + 16
bltu t4, t5, . + 12
bgeu t0, t6, . + 20
blt t6, t5, . + 12
beq t1, t2, . + 20
bgeu t6, t3, . + 20
blt t0, t1, . + 20
jal ra, . + 12
bne zero, t4, . + 12
bge t6, t5, . + 12
bgeu t3, t6, . + 16
jal ra, . + 8
bge t1, t0, . + 12
jalr ra, zero, 4
bge t0, t1, . + 4
bge t6, t5, . + 8
jal ra, loop_back
bltu t1, t2, . + 24
bltu t1, t2, . + 24
beq t1, t2, . + 24
bgeu t0, t3, . + 8
bgeu t3, t0, . + 16
bgeu t3, t6, . + 16
bne zero, t1, . + 20
bltu t0, t6, . + 4
bge t1, t0, . + 24
bge t0, t1, . + 20
blt t0, t1, . + 16
jal ra, . + 12
bltu t0, t6, . + 8
bne zero, t4, . + 24
jal ra, . + 20
beq t4, t5, . + 16
beq zero, t4, . + 24
bne zero, t1, . + 12
bgeu t0, t6, . + 24
blt t5, t6, . + 4
bgeu t3, t6, . + 24
beq t1, t2, . + 4
bge t0, t1, . + 12
jalr ra, sp, 1888
bne t1, t2, . + 20
bne t1, t2, . + 24
bge t6, t5, . + 8
jal ra, loop_back
bgeu t6, t3, . + 16
jalr ra, sp, 1920
beq zero, t4, . + 4
bge t0, t1, . + 8
bgeu t3, t6, . + 16
bge t6, t5, . + 20
beq t4, t5, . + 24
blt t6, t5, . + 16
bge t4, t5, . + 8
jal ra, . + 20
bne zero, t4, . + 16
bge t0, t1, . + 24
bge t1, t2, . + 20
bltu t6, t0, . + 12
bgeu t4, t5, . + 4
jalr ra, zero, 4
bgeu t0, t6, . + 4
bge t6, t5, . + 4
jal ra, loop_back
beq t4, t5, . + 4
bltu t0, t6, . + 20
beq zero, t1, . + 24
jal ra, loop_back
bgeu t6, t3, . + 16
bltu t4, t5, . + 24
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jal sp, . + 4
bgeu t0, t6, . + 16
jal ra, loop_back
bltu t3, t6, . + 16
bne zero, t1, . + 20
jal ra, loop_back
bge t6, t5, . + 8
bltu t6, t3, . + 4
beq t1, t2, . + 4
bltu t3, t0, . + 12
bgeu t4, t5, . + 12
beq zero, t4, . + 12
bge t4, t5, . + 8
bne zero, t1, . + 8
blt t0, t1, . + 8
bltu t3, t6, . + 12
bne t1, t2, . + 16
bne t1, t2, . + 12
bgeu t3, t0, . + 24
bltu t6, t3, . + 8
beq t4, t5, . + 24
blt t6, t5, . + 16
jal ra, loop_back
jalr ra, zero, 4
jalr ra, sp, 108
bgeu t1, t2, . + 16
bne t4, t5, . + 8
blt t1, t0, . + 20
bgeu t3, t0, . + 24
jalr ra, zero, 4
bgeu t1, t2, . + 12
bltu t0, t6, . + 20
jalr ra, zero, 4
bgeu t6, t0, . + 8
bne zero, t4, . + 16
bltu t3, t0, . + 8
bne zero, t4, . + 4
bne zero, t4, . + 8
beq t1, t2, . + 16
bge t1, t2, . + 20
bne zero, t1, . + 24
beq zero, t4, . + 8
bge t1, t2, . + 12
bne t4, t5, . + 4
bge t0, t1, . + 12
bgeu t3, t6, . + 4
bge t1, t0, . + 24
blt t0, t1, . + 20
bge t6, t5, . + 12
bne zero, t4, . + 16
bge t6, t5, . + 20
jalr ra, zero, 4
jal ra, loop_back
blt t0, t1, . + 16
bne zero, t1, . + 24
bne zero, t1, . + 4
bne zero, t4, . + 20
blt t5, t6, . + 20
blt t0, t1, . + 16
blt t1, t0, . + 24
bltu t3, t6, . + 4
blt t1, t0, . + 20
beq t4, t5, . + 24
bge t0, t1, . + 4
jalr ra, zero, 4
bge t6, t5, . + 12
bltu t1, t2, . + 12
jalr ra, sp, 276
jalr ra, sp, 292
blt t5, t6, . + 24
beq zero, t1, . + 16
jalr ra, sp, 292
bge t0, t1, . + 12
beq zero, t4, . + 24
blt t5, t6, . + 16
blt t5, t6, . + 4
beq t4, t5, . + 16
bge t0, t1, . + 24
bge t1, t2, . + 8
bgeu t0, t6, . + 12
beq zero, t1, . + 20
jalr ra, sp, 332
bne t1, t2, . + 24
bne t4, t5, . + 8
bge t4, t5, . + 4
bge t6, t5, . + 16
jalr ra, zero, 4
bge t6, t5, . + 16
blt t6, t5, . + 4
bne zero, t4, . + 8
blt t1, t0, . + 20
bne t4, t5, . + 20
bgeu t0, t6, . + 16
bltu t3, t6, . + 24
beq zero, t1, . + 20
beq zero, t1, . + 12
jal ra, . + 24
beq zero, t4, . + 24
jal ra, . + 16
beq t4, t5, . + 12
jal ra, . + 8
beq t1, t2, . + 12
beq zero, t4, . + 8
bne zero, t1, . + 20
bgeu t0, t6, . + 4
beq zero, t1, . + 12
jalr ra, zero, 4
bne zero, t1, . + 4
bne t4, t5, . + 24
bgeu t4, t5, . + 8
bge t1, t0, . + 20
bgeu t6, t0, . + 12
beq zero, t4, . + 24
blt t6, t5, . + 24
bltu t4, t5, . + 12
bltu t4, t5, . + 20
jalr ra, sp, 476
beq zero, t4, . + 12
jalr ra, sp, 492
bgeu t3, t6, . + 8
bne zero, t4, . + 16
blt t6, t5, . + 4
jal ra, . + 8
bgeu t3, t0, . + 12
blt t5, t6, . + 20
beq zero, t4, . + 8
blt t0, t1, . + 16
bltu t1, t2, . + 16
bge t6, t5, . + 12
jalr ra, sp, 516
bne zero, t4, . + 4
bne zero, t4, . + 16
bne t4, t5, . + 20
jal ra, . + 24
bgeu t4, t5, . + 8
bltu t1, t2, . + 4
jalr ra, zero, 4
bne t4, t5, . + 16
beq t1, t2, . + 20
bgeu t3, t6, . + 16
bne zero, t1, . + 8
jal ra, loop_back
jalr ra, zero, 4
bgeu t0, t6, . + 16
bltu t3, t0, . + 8
bne zero, t1, . + 4
blt t0, t1, . + 24
bgeu t3, t6, . + 16
blt t1, t0, . + 24
blt t5, t6, . + 12
blt t5, t6, . + 4
bne t4, t5, . + 8
bne t1, t2, . + 24
bge t6, t5, . + 12
bltu t0, t6, . + 8
bge t1, t0, . + 20
bne zero, t1, . + 24
bne zero, t4, . + 20
bltu t0, t6, . + 20
bne t1, t2, . + 20
bgeu t3, t0, . + 24
bltu t1, t2, . + 12
bne zero, t1, . + 16
bgeu t1, t2, . + 4
bltu t4, t5, . + 4
bge t6, t5, . + 24
jalr ra, sp, 668
jalr ra, sp, 676
jalr ra, sp, 692
bne t1, t2, . + 16
bge t0, t1, . + 16
bne t4, t5, . + 12
bge t5, t6, . + 12
bge t1, t0, . + 8
jal ra, loop_back
bltu t3, t6, . + 20
jal ra, loop_back
jalr ra, sp, 728
bne t1, t2, . + 24
bge t5, t6, . + 8
blt t5, t6, . + 20
jalr ra, zero, 4
bne zero, t4, . + 16
blt t1, t0, . + 24
bne t4, t5, . + 16
bne zero, t4, . + 16
bne t4, t5, . + 16
jal ra, . + 16
beq zero, t4, . + 24
bne zero, t1, . + 16
bne t1, t2, . + 24
bgeu t0, t6, . + 20
blt t0, t1, . + 20
beq zero, t1, . + 4
bne zero, t1, . + 12
blt t5, t6, . + 8
bge t1, t2, . + 16
jalr ra, sp, 792
beq t1, t2, . + 20
bne zero, t1, . + 8
bltu t3, t6, . + 16
bgeu t3, t0, . + 16
bgeu t6, t3, . + 16
bgeu t0, t6, . + 4
beq zero, t4, . + 20
beq zero, t1, . + 12
jal ra, loop_back
beq t1, t2, . + 20
bltu t3, t6, . + 20
bne zero, t1, . + 12
bge t6, t5, . + 16
blt t1, t0, . + 24
bne zero, t1, . + 20
bge t1, t2, . + 4
bne t1, t2, . + 4
bge t4, t5, . + 12
bgeu t0, t6, . + 4
beq zero, t1, . + 24
bgeu t6, t3, . + 20
bgeu t6, t3, . + 16
jal ra, . + 4
jal ra, . + 12
bgeu t0, t6, . + 12
bltu t6, t0, . + 24
bne zero, t4, . + 4
bltu t3, t6, . + 16
beq zero, t1, . + 12
jal ra, loop_back
blt t6, t5, . + 12
bltu t6, t0, . + 4
bne zero, t4, . + 16
jalr ra, sp, 924
beq zero, t1, . + 24
bge t1, t2, . + 24
bne t1, t2, . + 8
blt t1, t0, . + 20
blt t1, t0, . + 16
bge t4, t5, . + 8
bgeu t6, t0, . + 8
bltu t0, t3, . + 20
blt t5, t6, . + 12
bge t4, t5, . + 24
bne t1, t2, . + 20
jalr ra, sp, 988
bge t0, t1, . + 12
bltu t3, t0, . + 20
beq t4, t5, . + 16
bltu t1, t2, . + 20
jalr ra, sp, 1004
blt t6, t5, . + 12
bgeu t4, t5, . + 4
bne t4, t5, . + 4
beq t4, t5, . + 20
bgeu t4, t5, . + 24
bltu t3, t0, . + 16
jal ra, loop_back
bne t4, t5, . + 12
blt t0, t1, . + 20
beq t4, t5, . + 20
blt t0, t1, . + 4
jalr ra, sp, 1044
bltu t0, t3, . + 24
bltu t3, t6, . + 8
bgeu t3, t6, . + 12
bge t0, t1, . + 8
bltu t3, t6, . + 20
bne zero, t1, . + 4
blt t6, t5, . + 4
bltu t3, t6, . + 4
bne t4, t5, . + 24
bge t4, t5, . + 20
bne t1, t2, . + 24
bge t6, t5, . + 8
bgeu t6, t3, . + 16
blt t5, t6, . + 24
blt t5, t6, . + 20
bne t1, t2, . + 8
blt t5, t6, . + 24
jal ra, loop_back
jalr ra, sp, 1132
bgeu t3, t6, . + 8
beq t4, t5, . + 24
beq zero, t1, . + 8
jalr ra, zero, 4
bne zero, t1, . + 12
blt t5, t6, . + 12
bgeu t3, t6, . + 24
beq t4, t5, . + 20
bgeu t3, t6, . + 16
bgeu t0, t6, . + 20
bge t6, t5, . + 4
beq t1, t2, . + 16
beq t4, t5, . + 4
jalr ra, sp, 1172
beq zero, t4, . + 12
bgeu t0, t6, . + 12
bgeu t6, t3, . + 4
bltu t6, t0, . + 4
bltu t0, t6, . + 4
bltu t3, t6, . + 24
bltu t4, t5, . + 16
bgeu t3, t0, . + 4
jalr ra, sp, 1208
blt t0, t1, . + 16
bge t1, t2, . + 16
blt t5, t6, . + 8
bgeu t1, t2, . + 12
bge t4, t5, . + 20
bge t6, t5, . + 16
bne t4, t5, . + 24
bne t4, t5, . + 24
blt t0, t1, . + 24
bge t1, t2, . + 20
beq zero, t1, . + 8
bge t0, t1, . + 24
bltu t1, t2, . + 20
bge t0, t1, . + 24
blt t0, t1, . + 12
jalr ra, sp, 1272
bne zero, t4, . + 12
beq zero, t4, . + 24
blt t0, t1, . + 8
bltu t3, t0, . + 20
bltu t4, t5, . + 24
jal ra, . + 24
blt t0, t1, . + 24
bgeu t3, t6, . + 8
bgeu t6, t3, . + 20
bgeu t3, t0, . + 8
beq t4, t5, . + 4
beq t4, t5, . + 4
bgeu t0, t3, . + 4
bge t6, t5, . + 8
blt t0, t1, . + 20
jalr ra, zero, 4
blt t5, t6, . + 8
bltu t3, t6, . + 4
jalr ra, zero, 4
blt t0, t1, . + 8
beq t1, t2, . + 4
bge t1, t2, . + 8
blt t6, t5, . + 20
bge t4, t5, . + 12
bge t0, t1, . + 20
blt t5, t6, . + 24
bge t1, t0, . + 4
jal ra, . + 16
blt t6, t5, . + 24
bgeu t1, t2, . + 16
blt t5, t6, . + 16
bgeu t0, t6, . + 12
beq zero, t4, . + 16
bgeu t3, t0, . + 20
bltu t3, t6, . + 16
bge t1, t2, . + 24
blt t1, t0, . + 4
bne zero, t4, . + 8
bge t0, t1, . + 4
bgeu t4, t5, . + 24
jal ra, . + 24
jal ra, loop_back
jalr ra, zero, 4
jalr ra, zero, 4
jal ra, . + 8
bne t4, t5, . + 8
beq t4, t5, . + 12
bltu t3, t6, . + 12
jalr ra, sp, 1484
bgeu t0, t6, . + 24
blt t1, t0, . + 20
bgeu t3, t6, . + 8
bge t4, t5, . + 8
blt t5, t6, . + 8
bne zero, t4, . + 24
beq zero, t4, . + 4
blt t6, t5, . + 16
bne t4, t5, . + 4
beq t1, t2, . + 16
jal ra, loop_back
bgeu t3, t6, . + 4
jal ra, loop_back
bgeu t6, t0, . + 20
beq zero, t4, . + 24
jalr ra, zero, 4
bgeu t1, t2, . + 24
bne t4, t5, . + 16
jal ra, . + 24
bge t4, t5, . + 20
jal ra, loop_back
bge t0, t1, . + 8
jal ra, . + 20
jalr ra, sp, 1576
jalr ra, zero, 4
bge t6, t5, . + 4
bge t6, t5, . + 20
bltu t3, t0, . + 20
beq zero, t1, . + 12
beq t1, t2, . + 4
beq zero, t1, . + 8
bge t6, t5, . + 8
bne zero, t4, . + 8
jal ra, . + 12
bgeu t0, t6, . + 20
bgeu t1, t2, . + 4
bge t6, t5, . + 12
blt t0, t1, . + 20
blt t0, t1, . + 16
jalr ra, sp, 1636
blt t6, t5, . + 20
beq t4, t5, . + 16
bltu t0, t3, . + 20
beq zero, t4, . + 12
blt t1, t0, . + 12
bltu t6, t0, . + 8
bltu t3, t6, . + 24
beq t1, t2, . + 24
beq t4, t5, . + 4
bne zero, t1, . + 16
bge t0, t1, . + 4
bltu t6, t0, . + 16
bgeu t6, t0, . + 20
bltu t0, t3, . + 4
beq zero, t4, . + 24
blt t0, t1, . + 4
beq zero, t1, . + 24
beq t1, t2, . + 12
blt t5, t6, . + 24
bgeu t0, t3, . + 4
bne zero, t4, . + 8
jalr ra, sp, 1716
bltu t0, t3, . + 12
bltu t0, t6, . + 16
bltu t3, t0, . + 12
jal ra, . + 12
blt t1, t0, . + 12
blt t0, t1, . + 8
bne zero, t4, . + 24
bltu t3, t0, . + 24
bgeu t1, t2, . + 4
jal ra, loop_back
bge t0, t1, . + 24
beq zero, t1, . + 8
bne t4, t5, . + 20
bltu t3, t6, . + 12
beq t4, t5, . + 16
bne t1, t2, . + 4
jalr ra, zero, 4
jal ra, loop_back
bge t1, t0, . + 4
jal ra, . + 20
bgeu t3, t6, . + 8
beq t4, t5, . + 20
blt t6, t5, . + 12
blt t0, t1, . + 16
beq zero, t1, . + 16
bgeu t4, t5, . + 4
beq t4, t5, . + 12
jal ra, loop_back
blt t1, t0, . + 8
blt t6, t5, . + 20
jal ra, loop_back
jal ra, . + 20
jal ra, . + 8
bltu t6, t0, . + 24
bgeu t1, t2, . + 8
bltu t4, t5, . + 24
bltu t3, t0, . + 24
bne zero, t4, . + 16
jal ra, loop_back
jal ra, loop_back
bgeu t0, t6, . + 4
bne zero, t4, . + 8
bge t0, t1, . + 16
bltu t0, t6, . + 24
blt t0, t1, . + 8
blt t1, t0, . + 24
jalr ra, zero, 4
beq zero, t1, . + 16
bltu t3, t6, . + 16
bge t0, t1, . + 24
blt t6, t5, . + 4
bne t4, t5, . + 16
bltu t1, t2, . + 4
bgeu t3, t0, . + 8
jal ra, . + 20
blt t6, t5, . + 8
bgeu t6, t3, . + 4
jal ra, loop_back
bgeu t0, t3, . + 24
bltu t6, t0, . + 12
blt t1, t0, . + 8
bltu t0, t3, . + 4
bne t1, t2, . + 20
beq zero, t1, . + 8
bltu t4, t5, . + 16
jal ra, loop_back
bltu t6, t0, . + 16
jalr ra, zero, 4
blt t5, t6, . + 16
blt t1, t0, . + 20
bne zero, t4, . + 16
blt t5, t6, . + 20
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jal sp, . + 4
jalr ra, zero, 4
bltu t3, t6, . + 8
jal ra, . + 24
bge t5, t6, . + 20
bge t0, t1, . + 8
jal ra, . + 4
blt t0, t1, . + 24
blt t0, t1, . + 16
bne t4, t5, . + 20
bgeu t6, t3, . + 12
blt t1, t0, . + 4
blt t1, t0, . + 8
bne zero, t1, . + 4
beq t1, t2, . + 8
beq zero, t4, . + 12
bne zero, t1, . + 4
blt t6, t5, . + 20
blt t5, t6, . + 4
jalr ra, zero, 4
bne t4, t5, . + 24
jalr ra, zero, 4
beq zero, t4, . + 4
bne t4, t5, . + 12
bge t6, t5, . + 20
beq t1, t2, . + 12
jalr ra, sp, 112
beq zero, t4, . + 8
bgeu t4, t5, . + 8
bltu t0, t3, . + 8
jal ra, loop_back
bltu t0, t6, . + 24
blt t0, t1, . + 20
bge t5, t6, . + 20
blt t6, t5, . + 8
bge t6, t5, . + 16
bgeu t0, t3, . + 4
bge t6, t5, . + 4
bge t5, t6, . + 24
bltu t3, t0, . + 8
jal ra, . + 12
blt t6, t5, . + 16
bgeu t0, t3, . + 24
beq zero, t4, . + 20
blt t0, t1, . + 16
bltu t3, t6, . + 8
bge t5, t6, . + 24
blt t5, t6, . + 4
beq zero, t1, . + 12
beq t4, t5, . + 24
jal ra, . + 20
bne t4, t5, . + 8
bge t1, t0, . + 8
blt t1, t0, . + 12
blt t0, t1, . + 16
bltu t3, t6, . + 4
bgeu t0, t6, . + 16
bgeu t0, t6, . + 4
bltu t4, t5, . + 8
bne zero, t1, . + 20
bgeu t0, t3, . + 24
blt t6, t5, . + 20
jalr ra, sp, 268
bge t6, t5, . + 12
blt t1, t0, . + 8
beq t1, t2, . + 12
blt t6, t5, . + 20
jalr ra, sp, 284
jal ra, . + 20
bne zero, t4, . + 20
bge t0, t1, . + 24
bltu t3, t0, . + 24
blt t5, t6, . + 20
jalr ra, zero, 4
bgeu t0, t6, . + 24
bne zero, t4, . + 24
beq zero, t4, . + 4
bltu t6, t3, . + 12
bne zero, t4, . + 24
blt t5, t6, . + 12
jalr ra, zero, 4
blt t0, t1, . + 20
bne zero, t4, . + 12
bge t0, t1, . + 16
bltu t4, t5, . + 8
bgeu t1, t2, . + 16
bge t6, t5, . + 20
bgeu t6, t0, . + 20
bltu t6, t3, . + 16
jal ra, . + 20
bgeu t6, t3, . + 24
bltu t4, t5, . + 20
jal ra, loop_back
bne t4, t5, . + 24
jal ra, . + 20
bgeu t6, t3, . + 12
bne t1, t2, . + 8
bgeu t3, t0, . + 8
bge t6, t5, . + 4
bge t6, t5, . + 16
bgeu t6, t3, . + 20
bltu t0, t6, . + 20
bge t0, t1, . + 8
blt t5, t6, . + 8
bltu t3, t6, . + 4
blt t5, t6, . + 12
bgeu t0, t3, . + 8
bltu t0, t6, . + 4
blt t1, t0, . + 24
bge t1, t2, . + 8
beq t4, t5, . + 20
bge t0, t1, . + 16
bge t6, t5, . + 12
blt t0, t1, . + 4
beq zero, t1, . + 16
bge t1, t0, . + 8
bge t4, t5, . + 4
jalr ra, zero, 4
bltu t0, t3, . + 4
jalr ra, sp, 492
blt t6, t5, . + 4
bge t6, t5, . + 24
bgeu t0, t3, . + 4
bgeu t6, t0, . + 12
bgeu t1, t2, . + 20
bne t4, t5, . + 4
bge t0, t1, . + 12
bltu t0, t6, . + 8
bgeu t3, t0, . + 24
bgeu t3, t6, . + 16
beq zero, t1, . + 12
bgeu t3, t0, . + 20
blt t5, t6, . + 20
blt t5, t6, . + 16
blt t5, t6, . + 16
jalr ra, sp, 540
bne t1, t2, . + 24
bltu t3, t6, . + 12
bne t4, t5, . + 4
jalr ra, zero, 4
bge t5, t6, . + 4
bge t5, t6, . + 20
bgeu t1, t2, . + 16
blt t0, t1, . + 12
blt t6, t5, . + 4
bltu t1, t2, . + 4
blt t6, t5, . + 12
bne zero, t4, . + 4
bltu t3, t0, . + 16
bgeu t0, t6, . + 12
bltu t1, t2, . + 20
bgeu t4, t5, . + 16
bltu t4, t5, . + 12
jalr ra, zero, 4
beq zero, t1, . + 16
bne zero, t4, . + 12
bge t5, t6, . + 20
jalr ra, zero, 4
jalr ra, zero, 4
blt t5, t6, . + 4
jal ra, loop_back
blt t0, t1, . + 16
blt t5, t6, . + 4
blt t1, t0, . + 16
bgeu t3, t6, . + 4
bltu t3, t0, . + 12
blt t0, t1, . + 24
bne zero, t1, . + 12
blt t6, t5, . + 16
jalr ra, zero, 4
bne zero, t4, . + 8
bltu t4, t5, . + 24
bge t4, t5, . + 4
jal ra, . + 4
bgeu t3, t6, . + 20
beq zero, t1, . + 24
bgeu t0, t3, . + 24
jalr ra, sp, 716
bgeu t3, t0, . + 16
jalr ra, sp, 716
beq t1, t2, . + 4
bgeu t3, t0, . + 8
jalr ra, zero, 4
blt t5, t6, . + 24
bne t1, t2, . + 12
bne t4, t5, . + 20
blt t0, t1, . + 20
blt t6, t5, . + 24
beq t4, t5, . + 4
bne zero, t4, . + 4
jalr ra, sp, 772
bgeu t0, t3, . + 24
bne t1, t2, . + 16
blt t1, t0, . + 24
bgeu t6, t0, . + 16
bge t5, t6, . + 4
beq zero, t1, . + 8
beq zero, t1, . + 16
bltu t0, t3, . + 4
jal ra, . + 16
jal ra, . + 12
bgeu t1, t2, . + 8
bltu t3, t6, . + 24
blt t6, t5, . + 12
bltu t3, t0, . + 8
bltu t0, t6, . + 16
bne zero, t1, . + 16
beq zero, t1, . + 12
bge t6, t5, . + 24
bltu t0, t6, . + 12
beq t1, t2, . + 24
jal ra, loop_back
bgeu t3, t0, . + 20
bgeu t3, t6, . + 8
bne t4, t5, . + 24
bge t6, t5, . + 20
jal ra, loop_back
bne t4, t5, . + 8
bge t5, t6, . + 20
bgeu t4, t5, . + 12
bne zero, t1, . + 16
bltu t0, t6, . + 20
jal ra, . + 20
jalr ra, sp, 912
bge t1, t2, . + 24
bgeu t4, t5, . + 4
jalr ra, zero, 4
jal ra, loop_back
blt t5, t6, . + 24
blt t0, t1, . + 12
bge t0, t1, . + 20
beq t1, t2, . + 4
bne zero, t4, . + 8
blt t0, t1, . + 12
beq t1, t2, . + 4
bgeu t6, t3, . + 12
bne t4, t5, . + 8
bge t4, t5, . + 16
bge t6, t5, . + 20
jalr ra, sp, 976
bne zero, t4, . + 12
bne zero, t1, . + 8
bltu t6, t3, . + 8
bne t4, t5, . + 24
bne t1, t2, . + 12
jal ra, . + 20
bltu t6, t0, . + 20
beq zero, t4, . + 8
bltu t6, t3, . + 12
bgeu t0, t6, . + 16
jal ra, . + 12
bne t1, t2, . + 24
bltu t3, t6, . + 16
jal ra, . + 8
jalr ra, zero, 4
jalr ra, zero, 4
jal ra, . + 4
bne zero, t4, . + 20
bne zero, t4, . + 8
blt t0, t1, . + 20
jal ra, loop_back
bne t1, t2, . + 24
bltu t6, t3, . + 24
bgeu t6, t3, . + 16
blt t0, t1, . + 16
jalr ra, sp, 1080
bgeu t3, t6, . + 4
jalr ra, sp, 1072
bne t4, t5, . + 24
bgeu t3, t0, . + 4
bltu t0, t6, . + 4
blt t5, t6, . + 16
bltu t4, t5, . + 4
bltu t0, t6, . + 8
jalr ra, zero, 4
jal ra, loop_back
bge t0, t1, . + 4
bgeu t6, t0, . + 12
bne t4, t5, . + 24
jalr ra, zero, 4
blt t6, t5, . + 24
bgeu t1, t2, . + 20
jalr ra, zero, 4
bgeu t0, t6, . + 16
beq t1, t2, . + 16
bltu t6, t0, . + 4
bltu t3, t6, . + 16
blt t1, t0, . + 12
jal ra, . + 12
blt t6, t5, . + 16
bne t4, t5, . + 4
beq t1, t2, . + 24
blt t6, t5, . + 12
bltu t0, t6, . + 24
bgeu t3, t6, . + 24
bne zero, t1, . + 20
bltu t3, t6, . + 16
beq zero, t1, . + 8
bne t4, t5, . + 20
bgeu t6, t3, . + 16
bltu t0, t6, . + 24
bne zero, t4, . + 12
beq t4, t5, . + 8
jalr ra, sp, 1228
jalr ra, sp, 1216
jalr ra, zero, 4
blt t0, t1, . + 24
bge t0, t1, . + 16
bne t1, t2, . + 4
blt t6, t5, . + 12
jalr ra, zero, 4
blt t0, t1, . + 24
bge t1, t2, . + 12
beq t1, t2, . + 20
blt t1, t0, . + 20
blt t5, t6, . + 4
jalr ra, zero, 4
blt t5, t6, . + 8
bltu t6, t0, . + 16
bne zero, t1, . + 24
bgeu t3, t6, . + 24
bge t6, t5, . + 8
bgeu t3, t6, . + 4
bne t4, t5, . + 4
bge t1, t0, . + 16
bgeu t6, t0, . + 20
bgeu t3, t6, . + 20
bge t4, t5, . + 20
jalr ra, sp, 1324
jal ra, . + 20
bge t5, t6, . + 4
bge t6, t5, . + 4
jalr ra, sp, 1340
bge t1, t2, . + 4
bltu t3, t6, . + 16
jalr ra, zero, 4
bltu t3, t0, . + 12
bltu t0, t6, . + 8
blt t6, t5, . + 20
beq t4, t5, . + 20
bgeu t6, t0, . + 20
blt t1, t0, . + 24
jal ra, . + 4
jal ra, . + 4
beq zero, t4, . + 16
bne t4, t5, . + 4
blt t0, t1, . + 4
bge t0, t1, . + 16
jal ra, . + 4
jal ra, . + 4
bne t4, t5, . + 12
jal ra, . + 12
beq t1, t2, . + 8
blt t0, t1, . + 4
bgeu t3, t6, . + 24
bltu t3, t6, . + 4
bgeu t0, t3, . + 8
bge t1, t0, . + 4
bne t4, t5, . + 4
beq t1, t2, . + 4
bgeu t6, t0, . + 8
bltu t3, t0, . + 24
bltu t1, t2, . + 8
jalr ra, zero, 4
beq zero, t4, . + 12
bltu t0, t3, . + 12
bltu t3, t0, . + 16
bgeu t0, t3, . + 20
bge t1, t0, . + 24
bne zero, t1, . + 16
beq zero, t1, . + 4
beq zero, t4, . + 20
bgeu t1, t2, . + 8
jal ra, . + 16
bge t4, t5, . + 24
blt t6, t5, . + 12
bltu t3, t0, . + 8
bgeu t4, t5, . + 24
blt t1, t0, . + 20
blt t5, t6, . + 16
blt t6, t5, . + 4
bge t0, t1, . + 24
beq zero, t4, . + 16
jal ra, loop_back
jalr ra, zero, 4
bne zero, t4, . + 12
blt t1, t0, . + 4
bge t4, t5, . + 8
bgeu t6, t3, . + 12
blt t5, t6, . + 24
jalr ra, sp, 1568
jalr ra, sp, 1584
blt t0, t1, . + 20
bne zero, t4, . + 24
blt t5, t6, . + 12
blt t1, t0, . + 20
bge t1, t2, . + 20
jalr ra, sp, 1592
jal ra, . + 12
bgeu t6, t0, . + 4
bge t5, t6, . + 12
bltu t1, t2, . + 20
bltu t1, t2, . + 4
bne zero, t1, . + 4
bge t1, t0, . + 16
bltu t3, t0, . + 12
blt t6, t5, . + 8
bltu t3, t6, . + 20
blt t0, t1, . + 4
blt t6, t5, . + 20
bgeu t6, t0, . + 24
bltu t0, t3, . + 12
bge t1, t0, . + 8
bne t4, t5, . + 8
beq t4, t5, . + 16
beq zero, t1, . + 12
jal ra, . + 24
bgeu t6, t3, . + 8
bgeu t0, t6, . + 16
bltu t3, t0, . + 8
bgeu t0, t6, . + 20
bge t1, t2, . + 20
jal ra, loop_back
beq zero, t4, . + 24
bltu t0, t6, . + 4
beq t4, t5, . + 12
bge t0, t1, . + 8
blt t1, t0, . + 20
bgeu t3, t0, . + 20
jalr ra, sp, 1728
blt t6, t5, . + 8
bgeu t3, t0, . + 24
jal ra, . + 8
blt t6, t5, . + 24
bge t0, t1, . + 20
bne t4, t5, . + 16
bltu t1, t2, . + 4
beq t4, t5, . + 4
jalr ra, zero, 4
bltu t0, t6, . + 16
beq zero, t4, . + 12
blt t0, t1, . + 24
beq t1, t2, . + 8
bge t0, t1, . + 24
bltu t3, t0, . + 16
bgeu t4, t5, . + 4
bgeu t3, t6, . + 16
bgeu t1, t2, . + 24
blt t1, t0, . + 16
beq t1, t2, . + 24
beq zero, t1, . + 12
bge t6, t5, . + 8
jalr ra, zero, 4
bge t6, t5, . + 8
jal ra, loop_back
bltu t0, t3, . + 8
beq t1, t2, . + 20
bge t4, t5, . + 20
blt t5, t6, . + 20
blt t5, t6, . + 8
jal ra, . + 20
jalr ra, zero, 4
bgeu t4, t5, . + 12
blt t5, t6, . + 12
beq t4, t5, . + 8
bne zero, t4, . + 16
beq t1, t2, . + 20
bltu t3, t6, . + 20
beq t4, t5, . + 24
bltu t6, t0, . + 20
jal ra, . + 12
bltu t0, t6, . + 8
bltu t0, t6, . + 8
bgeu t3, t0, . + 4
bgeu t6, t3, . + 8
bne t4, t5, . + 12
jal ra, loop_back
bltu t3, t0, . + 16
jalr ra, sp, 1916
blt t0, t1, . + 4
jalr ra, sp, 1920
bne zero, t4, . + 20
bgeu t3, t0, . + 8
jal ra, . + 16
blt t5, t6, . + 16
bgeu t0, t3, . + 4
beq zero, t4, . + 20
bltu t4, t5, . + 24
jalr ra, sp, 1952
blt t1, t0, . + 20
jalr ra, sp, 1980
bne zero, t4, . + 8
jalr ra, zero, 4
jal ra, . + 8
bne t1, t2, . + 8
jal ra, . + 16
bne t4, t5, . + 20
blt t6, t5, . + 24
jalr ra, sp, 2012
bgeu t0, t6, . + 20
bge t6, t5, . + 4
bgeu t1, t2, . + 8
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jal sp, . + 4
bgeu t6, t0, . + 4
bge t1, t0, . + 16
blt t5, t6, . + 16
beq zero, t1, . + 4
blt t0, t1, . + 24
jal ra, . + 20
beq zero, t4, . + 8
bltu t0, t6, . + 16
blt t0, t1, . + 8
bltu t0, t6, . + 4
bge t1, t2, . + 16
bgeu t0, t6, . + 12
bgeu t0, t3, . + 4
bne t4, t5, . + 24
jalr ra, sp, 80
bgeu t3, t6, . + 16
bgeu t0, t6, . + 12
bge t1, t0, . + 8
bne t4, t5, . + 8
bgeu t3, t6, . + 16
beq zero, t4, . + 24
jalr ra, sp, 100
bne t1, t2, . + 8
blt t1, t0, . + 16
bne zero, t4, . + 8
bne t1, t2, . + 24
bge t0, t1, . + 8
bgeu t0, t6, . + 24
bgeu t3, t6, . + 12
bltu t0, t3, . + 8
blt t0, t1, . + 24
bltu t3, t6, . + 12
bltu t0, t3, . + 16
blt t0, t1, . + 12
bge t1, t2, . + 12
beq zero, t1, . + 4
bge t1, t0, . + 12
bne t4, t5, . + 16
bltu t0, t6, . + 24
bgeu t6, t0, . + 12
bne t4, t5, . + 4
blt t6, t5, . + 8
beq t1, t2, . + 8
beq zero, t4, . + 8
bne zero, t4, . + 20
bge t5, t6, . + 20
bltu t0, t6, . + 24
bge t5, t6, . + 16
bge t0, t1, . + 16
jalr ra, sp, 216
blt t5, t6, . + 20
bge t6, t5, . + 4
jal ra, . + 4
beq t4, t5, . + 12
bgeu t3, t0, . + 8
bltu t0, t6, . + 12
bltu t0, t3, . + 24
bge t4, t5, . + 16
bgeu t0, t6, . + 4
jal ra, . + 4
bltu t0, t3, . + 8
bltu t3, t0, . + 8
jalr ra, zero, 4
bne t4, t5, . + 20
beq zero, t1, . + 24
bge t1, t0, . + 12
blt t1, t0, . + 16
blt t0, t1, . + 12
beq t4, t5, . + 12
bltu t0, t3, . + 16
jalr ra, zero, 4
jal ra, . + 8
jalr ra, sp, 308
bgeu t3, t6, . + 20
jal ra, . + 24
bltu t1, t2, . + 24
bne t1, t2, . + 20
bgeu t3, t6, . + 20
jalr ra, zero, 4
jalr ra, sp, 336
blt t1, t0, . + 8
bltu t3, t6, . + 8
bltu t0, t6, . + 20
beq t1, t2, . + 24
bltu t3, t6, . + 24
bgeu t4, t5, . + 4
blt t5, t6, . + 16
bne t1, t2, . + 20
bge t6, t5, . + 12
beq zero, t1, . + 4
bltu t3, t0, . + 16
bne zero, t4, . + 20
bgeu t0, t6, . + 20
blt t5, t6, . + 16
bne t1, t2, . + 16
bne t4, t5, . + 16
bltu t3, t0, . + 20
blt t6, t5, . + 12
bltu t0, t6, . + 20
jal ra, loop_back
bltu t6, t0, . + 20
bne zero, t1, . + 16
bltu t1, t2, . + 4
beq zero, t1, . + 12
blt t5, t6, . + 8
jalr ra, zero, 4
bge t5, t6, . + 4
blt t1, t0, . + 12
bge t1, t2, . + 8
bgeu t3, t0, . + 16
blt t5, t6, . + 24
bne zero, t4, . + 12
jalr ra, zero, 4
bltu t3, t6, . + 20
bgeu t4, t5, . + 4
jal ra, . + 8
bgeu t0, t6, . + 12
bltu t6, t0, . + 16
bgeu t3, t6, . + 20
bge t5, t6, . + 12
bge t4, t5, . + 12
bge t0, t1, . + 12
bne zero, t1, . + 4
bne t4, t5, . + 12
blt t1, t0, . + 4
bltu t4, t5, . + 20
bgeu t3, t0, . + 20
jal ra, . + 20
beq t1, t2, . + 8
bgeu t0, t6, . + 16
bltu t0, t6, . + 20
bgeu t0, t6, . + 24
blt t0, t1, . + 20
blt t0, t1, . + 20
bgeu t4, t5, . + 24
bgeu t3, t6, . + 8
beq t4, t5, . + 20
bgeu t3, t0, . + 20
jal ra, . + 4
bltu t3, t0, . + 8
bltu t6, t0, . + 20
bgeu t3, t0, . + 12
bge t0, t1, . + 20
blt t1, t0, . + 24
bne zero, t1, . + 16
beq zero, t1, . + 20
bltu t4, t5, . + 12
blt t1, t0, . + 8
bltu t0, t6, . + 8
bgeu t3, t0, . + 8
blt t0, t1, . + 12
bgeu t4, t5, . + 24
beq t4, t5, . + 20
jalr ra, sp, 620
bge t1, t0, . + 20
beq zero, t4, . + 12
bne t4, t5, . + 16
jalr ra, sp, 648
bge t5, t6, . + 8
beq zero, t4, . + 20
jal ra, . + 4
jal ra, . + 16
bne t1, t2, . + 8
blt t0, t1, . + 20
jal ra, loop_back
beq t4, t5, . + 16
beq zero, t4, . + 8
beq t4, t5, . + 24
beq t1, t2, . + 20
jal ra, loop_back
bgeu t0, t6, . + 20
bgeu t3, t0, . + 24
jalr ra, zero, 4
bltu t3, t0, . + 12
blt t1, t0, . + 24
bltu t0, t6, . + 12
bgeu t0, t6, . + 24
bgeu t0, t3, . + 16
bne t4, t5, . + 12
jal ra, . + 8
blt t1, t0, . + 24
bne t4, t5, . + 24
jalr ra, sp, 748
bge t5, t6, . + 12
bgeu t6, t3, . + 8
bgeu t6, t0, . + 12
bge t4, t5, . + 4
jalr ra, zero, 4
bgeu t3, t0, . + 12
bne t4, t5, . + 12
jalr ra, sp, 772
beq t4, t5, . + 4
blt t0, t1, . + 8
beq zero, t4, . + 12
bgeu t4, t5, . + 16
jalr ra, zero, 4
bge t5, t6, . + 4
bgeu t3, t6, . + 4
bne zero, t1, . + 12
bne zero, t1, . + 4
bge t0, t1, . + 24
bgeu t6, t3, . + 24
blt t5, t6, . + 24
beq t4, t5, . + 12
beq zero, t4, . + 8
bne zero, t4, . + 24
jalr ra, zero, 4
beq t4, t5, . + 4
beq zero, t4, . + 20
bge t1, t2, . + 24
bltu t6, t3, . + 12
bge t6, t5, . + 20
jal ra, loop_back
bltu t3, t6, . + 4
bne t1, t2, . + 4
jalr ra, sp, 876
bltu t0, t3, . + 24
bge t6, t5, . + 8
beq t4, t5, . + 24
bltu t0, t3, . + 20
jal ra, loop_back
jal ra, . + 12
bge t6, t5, . + 4
bne zero, t1, . + 4
bge t0, t1, . + 16
bltu t1, t2, . + 8
bltu t0, t6, . + 8
blt t0, t1, . + 16
bltu t4, t5, . + 16
bltu t0, t6, . + 16
jal ra, . + 12
bgeu t3, t0, . + 20
jal ra, loop_back
beq zero, t4, . + 24
bne zero, t1, . + 4
jal ra, loop_back
bne zero, t1, . + 4
bltu t0, t3, . + 20
bgeu t0, t3, . + 20
beq zero, t4, . + 16
bne zero, t1, . + 16
bltu t0, t3, . + 12
bne t4, t5, . + 20
bgeu t1, t2, . + 24
jal ra, . + 20
bgeu t1, t2, . + 4
blt t6, t5, . + 12
jalr ra, sp, 1004
bltu t1, t2, . + 4
jalr ra, sp, 1004
bgeu t4, t5, . + 4
bge t4, t5, . + 24
jal ra, loop_back
jalr ra, zero, 4
bne zero, t4, . + 8
jalr ra, sp, 1024
jal ra, loop_back
bge t1, t2, . + 20
jal ra, . + 12
bge t5, t6, . + 20
bne t4, t5, . + 12
bltu t3, t0, . + 4
bgeu t3, t0, . + 8
jal ra, loop_back
bgeu t0, t6, . + 8
bgeu t0, t6, . + 12
bltu t3, t6, . + 4
blt t1, t0, . + 24
bltu t3, t6, . + 12
bgeu t1, t2, . + 24
jal ra, loop_back
blt t6, t5, . + 20
bgeu t3, t0, . + 20
jalr ra, zero, 4
bne t4, t5, . + 12
jal ra, . + 20
bltu t6, t3, . + 4
blt t5, t6, . + 8
beq t4, t5, . + 24
bne t4, t5, . + 20
bne t1, t2, . + 12
bgeu t0, t3, . + 16
bne zero, t4, . + 8
beq t4, t5, . + 20
beq t1, t2, . + 24
blt t6, t5, . + 4
blt t0, t1, . + 4
bltu t4, t5, . + 12
blt t5, t6, . + 20
blt t5, t6, . + 12
bne t1, t2, . + 8
blt t1, t0, . + 4
jalr ra, sp, 1180
bne zero, t4, . + 8
jal ra, . + 4
blt t1, t0, . + 8
bge t5, t6, . + 24
bge t0, t1, . + 24
bltu t1, t2, . + 16
bne zero, t4, . + 16
bge t6, t5, . + 8
bltu t0, t6, . + 12
jal ra, loop_back
bltu t3, t0, . + 20
blt t1, t0, . + 16
beq t4, t5, . + 16
bgeu t3, t0, . + 24
jal ra, . + 20
jal ra, loop_back
beq zero, t1, . + 16
bltu t3, t0, . + 4
jal ra, . + 4
blt t0, t1, . + 4
blt t1, t0, . + 24
beq t1, t2, . + 8
blt t0, t1, . + 24
bltu t3, t0, . + 4
beq zero, t4, . + 24
bltu t3, t0, . + 20
bltu t4, t5, . + 12
bgeu t4, t5, . + 12
bge t1, t2, . + 4
blt t1, t0, . + 4
bltu t3, t0, . + 4
bgeu t6, t3, . + 12
bltu t0, t6, . + 20
bgeu t4, t5, . + 16
jalr ra, sp, 1332
jal ra, loop_back
bge t0, t1, . + 16
blt t1, t0, . + 8
bltu t0, t6, . + 24
beq zero, t4, . + 8
blt t6, t5, . + 4
jalr ra, zero, 4
bge t0, t1, . + 16
bne t4, t5, . + 20
bltu t0, t6, . + 24
beq zero, t1, . + 24
bltu t0, t3, . + 16
blt t5, t6, . + 24
bltu t3, t6, . + 4
jal ra, . + 20
bgeu t4, t5, . + 12
bgeu t0, t6, . + 12
bltu t3, t0, . + 16
bge t1, t2, . + 8
bgeu t3, t6, . + 12
bltu t3, t6, . + 12
beq zero, t1, . + 4
bne zero, t1, . + 24
bge t0, t1, . + 8
blt t1, t0, . + 4
bltu t4, t5, . + 8
bne zero, t1, . + 4
blt t1, t0, . + 24
blt t5, t6, . + 8
beq zero, t4, . + 12
blt t1, t0, . + 16
bne t4, t5, . + 16
jal ra, . + 20
bge t4, t5, . + 8
bge t0, t1, . + 24
bge t4, t5, . + 8
jalr ra, sp, 1480
blt t5, t6, . + 24
beq t4, t5, . + 16
bne t4, t5, . + 4
bge t1, t0, . + 24
bgeu t6, t0, . + 20
jal ra, loop_back
bge t0, t1, . + 4
jalr ra, zero, 4
bltu t3, t0, . + 8
blt t6, t5, . + 24
jalr ra, sp, 1508
jalr ra, zero, 4
bltu t0, t6, . + 16
jalr ra, zero, 4
blt t1, t0, . + 20
bltu t0, t3, . + 8
bltu t3, t0, . + 16
bne zero, t4, . + 24
jalr ra, sp, 1536
beq zero, t4, . + 8
jalr ra, zero, 4
beq t1, t2, . + 24
bgeu t6, t0, . + 12
jal ra, loop_back
bge t0, t1, . + 8
beq t4, t5, . + 4
bne t1, t2, . + 16
blt t5, t6, . + 20
beq t1, t2, . + 24
beq zero, t1, . + 8
beq t1, t2, . + 4
bltu t3, t0, . + 12
bne t1, t2, . + 4
bne t4, t5, . + 8
bne zero, t4, . + 12
bgeu t0, t6, . + 12
beq zero, t1, . + 20
jalr ra, sp, 1624
beq t4, t5, . + 4
jal ra, . + 4
blt t0, t1, . + 4
bgeu t6, t3, . + 8
beq t1, t2, . + 12
beq zero, t4, . + 20
beq zero, t4, . + 16
bne zero, t4, . + 8
beq zero, t4, . + 12
bge t6, t5, . + 24
bne t4, t5, . + 24
bne t4, t5, . + 20
bge t5, t6, . + 24
bne t4, t5, . + 4
bltu t3, t0, . + 20
jal ra, . + 20
bgeu t3, t6, . + 24
bge t0, t1, . + 20
bltu t3, t6, . + 4
bgeu t0, t6, . + 4
jalr ra, zero, 4
beq zero, t4, . + 24
jal ra, . + 12
jal ra, loop_back
bne zero, t4, . + 4
beq zero, t1, . + 4
bge t0, t1, . + 8
jal ra, loop_back
beq zero, t4, . + 4
beq t1, t2, . + 24
jal ra, loop_back
jal ra, . + 16
bgeu t3, t0, . + 24
bne t1, t2, . + 16
beq t1, t2, . + 20
bltu t0, t6, . + 4
bge t1, t0, . + 16
blt t0, t1, . + 16
bltu t3, t0, . + 4
beq zero, t1, . + 12
jal ra, . + 12
bge t5, t6, . + 24
blt t6, t5, . + 12
jalr ra, sp, 1788
bne zero, t4, . + 20
blt t1, t0, . + 24
jalr ra, zero, 4
bltu t4, t5, . + 4
bgeu t3, t0, . + 20
beq zero, t1, . + 24
bgeu t3, t0, . + 12
bgeu t3, t6, . + 20
blt t6, t5, . + 24
jalr ra, zero, 4
bltu t1, t2, . + 4
jal ra, loop_back
beq t1, t2, . + 8
bge t6, t5, . + 12
bge t1, t0, . + 4
bne t4, t5, . + 4
blt t1, t0, . + 4
bgeu t0, t6, . + 12
bgeu t3, t6, . + 12
jalr ra, sp, 1876
beq zero, t4, . + 16
bne t4, t5, . + 24
bgeu t3, t0, . + 16
bltu t4, t5, . + 16
bge t1, t2, . + 24
jalr ra, sp, 1896
bltu t0, t6, . + 20
bgeu t3, t0, . + 24
beq t1, t2, . + 8
beq zero, t1, . + 24
bltu t3, t6, . + 24
bge t1, t2, . + 16
bne t1, t2, . + 12
blt t6, t5, . + 20
beq t1, t2, . + 20
bge t0, t1, . + 8
bltu t3, t0, . + 12
bltu t3, t0, . + 20
beq zero, t1, . + 24
bge t0, t1, . + 24
jal ra, . + 8
bne zero, t1, . + 24
bltu t3, t0, . + 12
bgeu t3, t6, . + 8
beq t1, t2, . + 8
bltu t3, t6, . + 24
bge t0, t1, . + 16
jalr ra, sp, 1992
jal ra, . + 20
jalr ra, zero, 4
beq zero, t4, . + 8
bne t4, t5, . + 20
beq t4, t5, . + 20
bgeu t0, t6, . + 8
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jal sp, . + 4
blt t0, t1, . + 20
bgeu t3, t0, . + 4
bltu t3, t0, . + 20
bgeu t0, t6, . + 24
blt t1, t0, . + 16
jalr ra, sp, 36
bne t4, t5, . + 4
bgeu t0, t6, . + 24
blt t1, t0, . + 12
blt t5, t6, . + 4
beq t1, t2, . + 16
bgeu t6, t0, . + 4
jalr ra, zero, 4
jal ra, loop_back
blt t6, t5, . + 24
jalr ra, zero, 4
bne zero, t1, . + 4
bne t1, t2, . + 4
bge t1, t0, . + 20
bgeu t3, t6, . + 8
beq t4, t5, . + 16
bge t0, t1, . + 24
bgeu t6, t3, . + 4
bne t4, t5, . + 8
jal ra, loop_back
blt t0, t1, . + 4
jal ra, . + 12
jalr ra, zero, 4
jal ra, loop_back
bltu t0, t6, . + 4
bge t0, t1, . + 16
jalr ra, sp, 148
beq zero, t4, . + 12
bne zero, t4, . + 12
bgeu t4, t5, . + 8
bne zero, t4, . + 24
beq zero, t4, . + 8
bge t4, t5, . + 8
bge t0, t1, . + 24
blt t1, t0, . + 12
beq t4, t5, . + 8
jalr ra, zero, 4
blt t6, t5, . + 12
bltu t0, t6, . + 16
bge t6, t5, . + 24
bgeu t0, t3, . + 20
beq zero, t1, . + 20
blt t0, t1, . + 16
bge t0, t1, . + 24
bgeu t3, t6, . + 4
blt t1, t0, . + 4
bgeu t3, t6, . + 8
bgeu t6, t0, . + 20
bne zero, t1, . + 20
beq t1, t2, . + 8
bge t6, t5, . + 12
bgeu t0, t3, . + 4
bgeu t4, t5, . + 8
bltu t4, t5, . + 20
bgeu t0, t3, . + 8
bne t1, t2, . + 20
jal ra, . + 4
bltu t3, t0, . + 12
blt t5, t6, . + 24
beq zero, t4, . + 16
bne t4, t5, . + 12
bgeu t3, t6, . + 20
beq zero, t4, . + 16
jal ra, loop_back
bltu t4, t5, . + 24
bltu t3, t6, . + 20
blt t5, t6, . + 8
beq t1, t2, . + 8
bge t1, t2, . + 20
bge t4, t5, . + 8
blt t6, t5, . + 8
blt t5, t6, . + 8
bge t6, t5, . + 8
bge t6, t5, . + 8
beq zero, t1, . + 24
beq t4, t5, . + 16
bgeu t4, t5, . + 8
jal ra, loop_back
jalr ra, sp, 348
bltu t0, t6, . + 4
bge t5, t6, . + 4
beq zero, t4, . + 24
bltu t0, t6, . + 8
blt t0, t1, . + 4
jal ra, . + 4
bgeu t0, t6, . + 16
blt t0, t1, . + 16
bgeu t6, t3, . + 24
beq t4, t5, . + 20
bne zero, t4, . + 4
beq zero, t4, . + 16
bge t0, t1, . + 20
blt t5, t6, . + 8
blt t1, t0, . + 20
bge t6, t5, . + 20
bge t6, t5, . + 16
bne zero, t4, . + 8
bge t1, t0, . + 8
beq zero, t4, . + 16
blt t0, t1, . + 12
bltu t0, t6, . + 12
bgeu t0, t6, . + 12
blt t6, t5, . + 4
blt t5, t6, . + 8
beq zero, t1, . + 8
jalr ra, sp, 464
bgeu t6, t0, . + 24
jal ra, . + 24
bge t1, t2, . + 16
bltu t1, t2, . + 8
jalr ra, sp, 484
bne t1, t2, . + 16
bltu t3, t6, . + 20
bne t1, t2, . + 20
bgeu t3, t0, . + 16
bne t1, t2, . + 8
bgeu t3, t0, . + 4
bge t0, t1, . + 8
beq zero, t1, . + 20
jal ra, loop_back
jal ra, . + 24
blt t6, t5, . + 8
bgeu t6, t3, . + 12
bne zero, t4, . + 16
bne t1, t2, . + 20
bge t0, t1, . + 8
bltu t1, t2, . + 20
bge t5, t6, . + 8
bltu t0, t3, . + 12
bne t1, t2, . + 12
bgeu t6, t3, . + 20
beq zero, t1, . + 4
blt t5, t6, . + 20
bgeu t6, t0, . + 16
jalr ra, zero, 4
bltu t4, t5, . + 8
bltu t0, t3, . + 16
bge t0, t1, . + 8
blt t6, t5, . + 24
bge t4, t5, . + 20
bne zero, t1, . + 4
bge t0, t1, . + 8
beq zero, t4, . + 20
blt t6, t5, . + 24
jal ra, . + 16
jal ra, loop_back
blt t6, t5, . + 4
bltu t3, t0, . + 16
bge t0, t1, . + 16
bne t1, t2, . + 20
bne zero, t1, . + 16
jal ra, . + 20
bltu t4, t5, . + 12
bge t1, t0, . + 4
jalr ra, sp, 640
bltu t3, t6, . + 24
jalr ra, zero, 4
bltu t6, t0, . + 12
bge t1, t2, . + 8
bne zero, t4, . + 16
jalr ra, sp, 664
blt t5, t6, . + 20
jal ra, loop_back
bne zero, t4, . + 12
bltu t1, t2, . + 12
bgeu t0, t6, . + 16
bltu t3, t0, . + 20
beq t1, t2, . + 8
jalr ra, zero, 4
bge t6, t5, . + 16
jalr ra, zero, 4
jalr ra, sp, 716
blt t1, t0, . + 8
jalr ra, sp, 724
jal ra, . + 24
beq zero, t4, . + 8
bne zero, t1, . + 16
jalr ra, sp, 736
beq zero, t4, . + 20
jalr ra, sp, 756
bge t6, t5, . + 12
jalr ra, zero, 4
bgeu t3, t0, . + 12
jalr ra, zero, 4
bltu t1, t2, . + 24
blt t0, t1, . + 20
bge t5, t6, . + 24
bltu t4, t5, . + 4
jalr ra, zero, 4
bltu t0, t6, . + 16
blt t6, t5, . + 12
blt t1, t0, . + 16
bgeu t3, t0, . + 16
blt t1, t0, . + 8
jalr ra, sp, 816
bgeu t0, t6, . + 12
bne t1, t2, . + 16
bltu t3, t0, . + 24
bne zero, t4, . + 16
jal ra, loop_back
bltu t0, t6, . + 12
jalr ra, sp, 832
beq t1, t2, . + 16
bgeu t0, t3, . + 16
jalr ra, zero, 4
bgeu t0, t6, . + 20
bne zero, t4, . + 20
beq t4, t5, . + 4
bne zero, t4, . + 8
bge t0, t1, . + 8
beq t1, t2, . + 8
bne t4, t5, . + 24
jal ra, . + 20
bgeu t6, t0, . + 24
bge t1, t0, . + 16
blt t5, t6, . + 20
bgeu t3, t6, . + 16
bgeu t0, t6, . + 12
beq t1, t2, . + 4
bge t5, t6, . + 8
bltu t6, t3, . + 12
beq t4, t5, . + 12
bgeu t4, t5, . + 24
bge t1, t2, . + 8
bge t1, t0, . + 12
bgeu t3, t6, . + 8
bge t6, t5, . + 4
bge t4, t5, . + 16
bgeu t3, t0, . + 12
jal ra, . + 12
blt t1, t0, . + 8
bne zero, t1, . + 4
bltu t0, t6, . + 12
bltu t0, t6, . + 4
jal ra, loop_back
blt t5, t6, . + 20
bgeu t0, t3, . + 16
jalr ra, zero, 4
bltu t3, t6, . + 24
blt t5, t6, . + 12
jal ra, loop_back
beq zero, t1, . + 8
jalr ra, zero, 4
bge t0, t1, . + 12
beq t1, t2, . + 12
jalr ra, sp, 1016
bge t0, t1, . + 4
bltu t3, t0, . + 20
bltu t0, t6, . + 16
jal ra, . + 4
bgeu t6, t0, . + 8
jal ra, loop_back
jalr ra, sp, 1032
bltu t4, t5, . + 20
bgeu t6, t3, . + 20
blt t5, t6, . + 8
bltu t0, t6, . + 4
bgeu t0, t3, . + 24
jalr ra, sp, 1056
jal ra, . + 16
bge t5, t6, . + 24
jal ra, . + 12
bltu t0, t6, . + 24
blt t6, t5, . + 12
blt t5, t6, . + 20
bge t4, t5, . + 16
bgeu t1, t2, . + 20
bgeu t6, t0, . + 16
bgeu t4, t5, . + 8
jal ra, loop_back
bltu t1, t2, . + 16
bgeu t3, t6, . + 16
bgeu t4, t5, . + 16
bltu t3, t6, . + 24
bge t0, t1, . + 20
beq zero, t1, . + 4
bltu t6, t3, . + 24
jal ra, . + 8
beq t1, t2, . + 20
bge t6, t5, . + 16
bgeu t4, t5, . + 20
bne zero, t1, . + 4
blt t0, t1, . + 20
bge t5, t6, . + 20
bgeu t6, t0, . + 12
bltu t3, t0, . + 24
bltu t3, t6, . + 8
bgeu t3, t0, . + 12
bgeu t0, t6, . + 12
beq zero, t4, . + 20
jalr ra, sp, 1192
jal ra, . + 4
bltu t0, t3, . + 4
bltu t0, t3, . + 24
bgeu t3, t6, . + 8
bgeu t3, t0, . + 8
jal ra, loop_back
jalr ra, zero, 4
bne t4, t5, . + 12
jalr ra, sp, 1232
bne t1, t2, . + 4
blt t0, t1, . + 8
bltu t3, t0, . + 24
beq zero, t1, . + 24
bge t4, t5, . + 20
jal ra, . + 8
blt t0, t1, . + 20
beq t4, t5, . + 24
jal ra, loop_back
beq t1, t2, . + 12
bltu t3, t0, . + 12
jal ra, loop_back
jalr ra, sp, 1288
bgeu t0, t6, . + 4
jalr ra, zero, 4
bne zero, t4, . + 8
bltu t3, t6, . + 24
bge t1, t0, . + 20
bge t4, t5, . + 8
bltu t0, t3, . + 4
blt t1, t0, . + 24
jalr ra, zero, 4
bltu t4, t5, . + 20
beq zero, t1, . + 24
bge t1, t2, . + 16
blt t5, t6, . + 20
bgeu t3, t0, . + 12
bge t4, t5, . + 24
bgeu t3, t0, . + 24
bge t1, t2, . + 20
bltu t3, t0, . + 24
bltu t3, t6, . + 4
jal ra, . + 16
jalr ra, zero, 4
blt t0, t1, . + 20
jalr ra, sp, 1368
blt t1, t0, . + 4
bgeu t3, t6, . + 8
bne zero, t4, . + 12
jal ra, . + 24
bgeu t0, t6, . + 8
blt t5, t6, . + 8
blt t1, t0, . + 24
bne t4, t5, . + 8
blt t6, t5, . + 12
bltu t0, t6, . + 4
blt t5, t6, . + 24
blt t5, t6, . + 4
jal ra, . + 4
bgeu t1, t2, . + 24
bgeu t0, t3, . + 16
beq t1, t2, . + 12
bge t1, t2, . + 8
bltu t6, t0, . + 4
bgeu t3, t6, . + 16
bltu t3, t0, . + 8
blt t0, t1, . + 24
jalr ra, zero, 4
bgeu t3, t0, . + 24
blt t0, t1, . + 4
bne t4, t5, . + 12
bltu t6, t0, . + 8
bne zero, t4, . + 8
bltu t4, t5, . + 16
jalr ra, zero, 4
bge t1, t0, . + 16
bge t6, t5, . + 4
bge t0, t1, . + 12
bne zero, t1, . + 20
blt t0, t1, . + 16
bne zero, t1, . + 20
jalr ra, sp, 1508
bltu t1, t2, . + 24
jal ra, loop_back
beq zero, t4, . + 12
bne zero, t1, . + 4
beq zero, t1, . + 16
bgeu t3, t6, . + 4
jalr ra, sp, 1556
bne zero, t4, . + 12
jal ra, loop_back
bltu t6, t0, . + 12
blt t6, t5, . + 16
bgeu t0, t6, . + 24
beq t1, t2, . + 4
blt t6, t5, . + 12
bltu t0, t6, . + 20
beq t1, t2, . + 12
bltu t6, t3, . + 8
bne zero, t1, . + 16
blt t1, t0, . + 12
beq zero, t1, . + 12
bltu t3, t6, . + 16
bge t1, t0, . + 4
bge t5, t6, . + 12
jal ra, loop_back
beq t4, t5, . + 8
beq t4, t5, . + 20
bne t4, t5, . + 12
bgeu t3, t6, . + 4
beq t1, t2, . + 8
blt t0, t1, . + 8
bltu t3, t0, . + 24
bgeu t3, t0, . + 16
jalr ra, sp, 1652
jal ra, loop_back
bltu t3, t0, . + 8
bge t0, t1, . + 4
jalr ra, sp, 1664
bne t4, t5, . + 24
bgeu t3, t0, . + 4
bgeu t1, t2, . + 16
bge t4, t5, . + 20
bne t4, t5, . + 12
blt t0, t1, . + 12
jal ra, . + 24
bgeu t0, t3, . + 20
beq t4, t5, . + 20
jalr ra, sp, 1704
jal ra, . + 20
blt t0, t1, . + 4
beq t1, t2, . + 24
jalr ra, zero, 4
bgeu t0, t3, . + 16
bltu t0, t6, . + 12
bne t4, t5, . + 20
bgeu t6, t0, . + 8
beq zero, t1, . + 16
bgeu t3, t0, . + 8
jalr ra, zero, 4
blt t1, t0, . + 20
beq t1, t2, . + 8
bltu t6, t0, . + 4
jal ra, loop_back
bne zero, t1, . + 8
bgeu t4, t5, . + 8
jal ra, . + 4
bge t6, t5, . + 20
bge t0, t1, . + 4
beq t1, t2, . + 12
beq t1, t2, . + 20
blt t6, t5, . + 8
bgeu t0, t3, . + 8
bge t1, t2, . + 4
bge t6, t5, . + 8
beq zero, t4, . + 8
bltu t3, t6, . + 12
jalr ra, sp, 1820
beq t1, t2, . + 16
jal ra, . + 16
bge t1, t2, . + 20
jal ra, loop_back
bltu t0, t6, . + 24
bgeu t3, t0, . + 24
bge t0, t1, . + 20
bgeu t0, t6, . + 8
bltu t3, t0, . + 20
bltu t6, t0, . + 24
beq zero, t1, . + 4
blt t6, t5, . + 8
bge t1, t0, . + 24
bge t1, t2, . + 8
bltu t3, t6, . + 16
bne t4, t5, . + 12
bne t4, t5, . + 8
blt t6, t5, . + 8
bgeu t4, t5, . + 8
bge t1, t0, . + 4
blt t1, t0, . + 20
bltu t6, t0, . + 20
blt t1, t0, . + 12
beq t4, t5, . + 12
bltu t4, t5, . + 24
bne t1, t2, . + 24
bge t5, t6, . + 4
bne t1, t2, . + 4
blt t5, t6, . + 8
bltu t3, t0, . + 4
bgeu t6, t0, . + 20
jalr ra, sp, 1948
jal ra, . + 16
beq t4, t5, . + 20
jal ra, loop_back
bgeu t3, t0, . + 8
bne zero, t1, . + 16
beq t4, t5, . + 20
bgeu t6, t0, . + 24
blt t1, t0, . + 16
beq zero, t4, . + 20
bgeu t3, t0, . + 16
bltu t4, t5, . + 12
bne zero, t4, . + 24
beq zero, t4, . + 24
beq zero, t1, . + 16
bgeu t0, t6, . + 16
bge t6, t5, . + 24
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jal sp, . + 4
bltu t3, t0, . + 20
blt t6, t5, . + 16
bne zero, t4, . + 20
blt t0, t1, . + 24
jal ra, loop_back
blt t1, t0, . + 20
beq zero, t1, . + 24
bltu t3, t6, . + 8
jal ra, . + 8
beq zero, t1, . + 4
bne t4, t5, . + 24
bge t0, t1, . + 4
bltu t3, t6, . + 12
jal ra, . + 20
bgeu t3, t6, . + 8
bltu t4, t5, . + 16
bge t1, t2, . + 24
jal ra, . + 4
bge t0, t1, . + 12
bgeu t0, t3, . + 12
jal ra, . + 24
beq t4, t5, . + 8
blt t5, t6, . + 24
bge t1, t0, . + 24
bgeu t3, t6, . + 20
bge t5, t6, . + 8
beq t1, t2, . + 20
jal ra, . + 16
beq zero, t1, . + 8
bltu t4, t5, . + 4
bgeu t0, t6, . + 24
blt t5, t6, . + 4
beq zero, t4, . + 8
bltu t3, t6, . + 8
jalr ra, zero, 4
bltu t4, t5, . + 20
bltu t6, t3, . + 4
beq zero, t4, . + 8
bgeu t0, t6, . + 4
jalr ra, sp, 160
bge t5, t6, . + 24
jalr ra, sp, 172
bltu t0, t6, . + 16
bne zero, t4, . + 8
beq t1, t2, . + 16
blt t6, t5, . + 4
jalr ra, zero, 4
bge t1, t0, . + 24
beq zero, t1, . + 20
bne t1, t2, . + 24
beq t1, t2, . + 4
bne t4, t5, . + 24
bne t1, t2, . + 4
bgeu t4, t5, . + 4
jalr ra, zero, 4
bltu t6, t0, . + 12
bne t1, t2, . + 8
blt t5, t6, . + 24
jalr ra, zero, 4
bge t1, t2, . + 20
blt t0, t1, . + 8
bltu t3, t6, . + 16
jalr ra, zero, 4
bne zero, t1, . + 8
bne zero, t4, . + 12
bltu t0, t6, . + 12
bne t1, t2, . + 12
jalr ra, zero, 4
jalr ra, zero, 4
bne zero, t1, . + 16
bltu t6, t0, . + 12
beq zero, t4, . + 4
jalr ra, sp, 308
jal ra, loop_back
bltu t3, t6, . + 4
jalr ra, zero, 4
bge t1, t0, . + 20
bltu t3, t0, . + 20
bltu t0, t6, . + 12
bne zero, t1, . + 4
bge t0, t1, . + 4
blt t6, t5, . + 24
bgeu t6, t0, . + 16
bne t1, t2, . + 24
bltu t1, t2, . + 12
jal ra, . + 16
blt t1, t0, . + 20
bge t6, t5, . + 4
blt t5, t6, . + 20
bne t1, t2, . + 4
bgeu t3, t0, . + 20
bgeu t0, t6, . + 4
bltu t4, t5, . + 16
beq t4, t5, . + 8
bgeu t3, t6, . + 4
bltu t6, t3, . + 4
bge t5, t6, . + 20
bgeu t0, t6, . + 16
blt t5, t6, . + 20
bne zero, t4, . + 12
blt t0, t1, . + 12
blt t5, t6, . + 4
beq t4, t5, . + 12
jal ra, . + 16
beq zero, t4, . + 20
bgeu t6, t0, . + 24
blt t5, t6, . + 20
bgeu t6, t0, . + 24
bltu t3, t6, . + 20
blt t1, t0, . + 24
blt t0, t1, . + 16
bne zero, t1, . + 8
beq zero, t1, . + 8
bltu t3, t6, . + 24
jalr ra, sp, 472
bgeu t0, t6, . + 16
blt t0, t1, . + 12
bge t0, t1, . + 12
jalr ra, zero, 4
jalr ra, sp, 488
bltu t3, t6, . + 12
bltu t3, t0, . + 20
jalr ra, zero, 4
beq t4, t5, . + 8
jalr ra, zero, 4
bne t4, t5, . + 12
blt t1, t0, . + 12
jal ra, loop_back
jalr ra, zero, 4
bne t4, t5, . + 4
beq t4, t5, . + 24
bne zero, t1, . + 24
bgeu t3, t0, . + 20
blt t5, t6, . + 8
bltu t4, t5, . + 12
beq t1, t2, . + 12
jal ra, loop_back
jal ra, loop_back
bgeu t0, t6, . + 16
beq zero, t4, . + 24
bne t1, t2, . + 12
bne zero, t4, . + 20
bge t0, t1, . + 20
bne zero, t1, . + 20
beq zero, t1, . + 12
bne t1, t2, . + 4
jal ra, . + 4
bge t0, t1, . + 20
bltu t0, t6, . + 8
blt t0, t1, . + 16
bge t6, t5, . + 4
bgeu t1, t2, . + 4
bge t6, t5, . + 16
bne t4, t5, . + 4
bltu t3, t6, . + 12
beq zero, t4, . + 4
bge t4, t5, . + 4
jal ra, loop_back
jal ra, loop_back
blt t5, t6, . + 16
bne t4, t5, . + 20
bltu t3, t6, . + 16
beq zero, t1, . + 8
bge t1, t2, . + 4
jalr ra, zero, 4
bge t4, t5, . + 8
bge t6, t5, . + 24
bne zero, t1, . + 12
jalr ra, sp, 684
jalr ra, zero, 4
jalr ra, sp, 704
jalr ra, sp, 704
bge t4, t5, . + 8
jalr ra, zero, 4
jalr ra, zero, 4
bgeu t1, t2, . + 8
bgeu t0, t6, . + 4
jal ra, loop_back
bgeu t3, t0, . + 24
bgeu t6, t3, . + 16
bltu t4, t5, . + 24
jal ra, loop_back
jal ra, . + 20
bge t0, t1, . + 4
jalr ra, zero, 4
bltu t4, t5, . + 8
bltu t6, t3, . + 8
bltu t1, t2, . + 8
bge t0, t1, . + 8
blt t5, t6, . + 20
jal ra, loop_back
blt t1, t0, . + 8
beq t1, t2, . + 16
bltu t4, t5, . + 8
bne t1, t2, . + 12
beq zero, t1, . + 16
bne t4, t5, . + 16
jalr ra, sp, 792
bne t4, t5, . + 24
blt t5, t6, . + 8
bltu t6, t0, . + 24
bne t1, t2, . + 4
beq zero, t4, . + 4
bltu t0, t6, . + 12
bgeu t3, t0, . + 4
jalr ra, zero, 4
blt t0, t1, . + 8
bge t1, t0, . + 8
jal ra, loop_back
jal ra, loop_back
blt t5, t6, . + 16
bge t0, t1, . + 16
beq t1, t2, . + 20
bne t1, t2, . + 24
blt t6, t5, . + 16
beq zero, t4, . + 20
bne t1, t2, . + 4
jal ra, . + 16
bge t0, t1, . + 8
jal ra, . + 12
blt t6, t5, . + 8
bltu t3, t0, . + 16
jalr ra, sp, 892
blt t5, t6, . + 24
blt t6, t5, . + 24
blt t0, t1, . + 8
jalr ra, zero, 4
beq t4, t5, . + 24
beq t1, t2, . + 8
jal ra, . + 24
jal ra, loop_back
bge t6, t5, . + 20
jalr ra, zero, 4
jalr ra, sp, 944
bne zero, t4, . + 24
bge t4, t5, . + 4
bltu t3, t6, . + 12
bltu t4, t5, . + 4
bge t4, t5, . + 20
blt t0, t1, . + 12
bge t1, t0, . + 16
bgeu t4, t5, . + 8
bltu t0, t3, . + 24
jalr ra, zero, 4
blt t5, t6, . + 20
beq t1, t2, . + 16
jal ra, . + 4
bltu t3, t6, . + 12
blt t1, t0, . + 12
bge t5, t6, . + 16
bgeu t3, t0, . + 24
blt t6, t5, . + 12
blt t5, t6, . + 16
jal ra, loop_back
bne zero, t4, . + 24
bge t0, t1, . + 4
bgeu t0, t6, . + 24
blt t1, t0, . + 12
blt t6, t5, . + 20
bne zero, t4, . + 8
beq t1, t2, . + 8
bne zero, t1, . + 4
bgeu t6, t0, . + 8
bge t1, t2, . + 8
bgeu t0, t3, . + 8
bne t4, t5, . + 4
bltu t3, t6, . + 8
bgeu t4, t5, . + 24
beq zero, t1, . + 24
bne zero, t1, . + 4
bge t1, t2, . + 8
bge t6, t5, . + 16
bne t1, t2, . + 8
jalr ra, sp, 1096
blt t1, t0, . + 20
beq zero, t4, . + 24
jal ra, . + 8
bne t4, t5, . + 12
bgeu t0, t3, . + 12
jalr ra, zero, 4
beq zero, t4, . + 16
bge t0, t1, . + 8
jalr ra, sp, 1136
bge t0, t1, . + 8
bge t5, t6, . + 4
bgeu t1, t2, . + 16
bgeu t3, t0, . + 16
bne zero, t4, . + 8
beq zero, t4, . + 16
blt t5, t6, . + 8
bge t1, t2, . + 8
bne zero, t1, . + 24
bne t4, t5, . + 12
jalr ra, zero, 4
bne zero, t4, . + 4
jalr ra, sp, 1200
bne t1, t2, . + 4
bltu t3, t0, . + 20
bge t6, t5, . + 16
bltu t3, t0, . + 16
bgeu t3, t0, . + 16
bge t6, t5, . + 20
jalr ra, sp, 1216
bne t4, t5, . + 4
bltu t4, t5, . + 12
bne zero, t1, . + 24
bge t1, t2, . + 8
bge t0, t1, . + 8
bne zero, t1, . + 12
blt t0, t1, . + 8
bgeu t0, t6, . + 12
jalr ra, zero, 4
beq t1, t2, . + 4
jal ra, loop_back
jal ra, . + 4
jalr ra, sp, 1268
bge t0, t1, . + 20
bltu t3, t0, . + 24
bgeu t6, t0, . + 20
bne t1, t2, . + 24
jal ra, . + 24
bltu t6, t0, . + 24
beq zero, t4, . + 4
bne t1, t2, . + 8
jal ra, . + 16
beq t1, t2, . + 24
jal ra, . + 8
beq zero, t1, . + 8
bge t6, t5, . + 8
bgeu t3, t0, . + 20
bne t1, t2, . + 24
beq zero, t1, . + 4
bne zero, t4, . + 20
bltu t3, t6, . + 20
blt t1, t0, . + 16
jalr ra, sp, 1344
bltu t4, t5, . + 24
jalr ra, sp, 1360
bgeu t3, t0, . + 24
bge t1, t0, . + 12
jal ra, loop_back
blt t1, t0, . + 4
bgeu t3, t6, . + 8
bne zero, t4, . + 16
bge t5, t6, . + 16
bne t1, t2, . + 12
bltu t4, t5, . + 8
bne t1, t2, . + 4
bgeu t0, t6, . + 4
bltu t3, t0, . + 8
beq t1, t2, . + 8
bge t5, t6, . + 12
bge t0, t1, . + 16
jalr ra, sp, 1416
beq t4, t5, . + 4
jalr ra, sp, 1428
jalr ra, sp, 1432
beq zero, t4, . + 8
blt t0, t1, . + 16
bge t6, t5, . + 16
bne t1, t2, . + 20
bge t1, t2, . + 24
jal ra, . + 12
bne zero, t4, . + 24
bgeu t6, t0, . + 4
jalr ra, sp, 1476
bge t6, t5, . + 4
bne zero, t4, . + 24
bgeu t6, t0, . + 8
jal ra, loop_back
beq t1, t2, . + 12
beq zero, t4, . + 8
jalr ra, zero, 4
bltu t0, t6, . + 12
bltu t4, t5, . + 4
beq t1, t2, . + 20
bge t4, t5, . + 20
bltu t3, t6, . + 12
blt t0, t1, . + 20
bge t6, t5, . + 16
bgeu t4, t5, . + 8
bge t6, t5, . + 4
bne t4, t5, . + 24
jal ra, . + 24
bgeu t6, t3, . + 4
bgeu t0, t3, . + 24
bgeu t3, t0, . + 8
bge t5, t6, . + 16
bne zero, t1, . + 20
jalr ra, zero, 4
bltu t0, t6, . + 24
bne zero, t4, . + 12
blt t6, t5, . + 24
bne t4, t5, . + 4
bge t6, t5, . + 4
bne zero, t4, . + 8
bgeu t3, t0, . + 8
jal ra, . + 20
bgeu t3, t0, . + 20
bge t1, t2, . + 20
bltu t3, t0, . + 16
bgeu t0, t6, . + 24
blt t5, t6, . + 20
bge t6, t5, . + 12
jalr ra, sp, 1624
jal ra, . + 16
blt t1, t0, . + 24
beq t1, t2, . + 8
bne zero, t1, . + 24
beq zero, t4, . + 20
blt t6, t5, . + 20
blt t1, t0, . + 24
bgeu t1, t2, . + 4
blt t1, t0, . + 24
bgeu t0, t6, . + 24
bgeu t3, t6, . + 4
beq t1, t2, . + 4
jal ra, loop_back
bge t5, t6, . + 4
jalr ra, sp, 1692
beq zero, t4, . + 4
bltu t4, t5, . + 20
bgeu t3, t6, . + 4
beq zero, t1, . + 24
jal ra, loop_back
bge t1, t0, . + 24
bne zero, t1, . + 8
bltu t6, t0, . + 8
beq t4, t5, . + 8
jal ra, . + 20
bgeu t3, t6, . + 8
bge t1, t2, . + 12
jal ra, loop_back
bgeu t0, t6, . + 4
bgeu t1, t2, . + 4
beq t1, t2, . + 24
bge t6, t5, . + 20
jal ra, loop_back
bgeu t0, t6, . + 8
bge t4, t5, . + 20
bge t6, t5, . + 20
jal ra, loop_back
jalr ra, zero, 4
bgeu t0, t6, . + 20
blt t6, t5, . + 20
beq t4, t5, . + 4
bgeu t4, t5, . + 4
bne zero, t1, . + 8
jal ra, loop_back
beq zero, t4, . + 16
jalr ra, sp, 1816
blt t5, t6, . + 8
bgeu t3, t0, . + 12
jalr ra, zero, 4
jalr ra, sp, 1836
bne t1, t2, . + 16
beq zero, t1, . + 12
beq zero, t1, . + 16
blt t0, t1, . + 16
bne zero, t1, . + 20
blt t5, t6, . + 20
bltu t6, t0, . + 4
bgeu t0, t6, . + 12
blt t6, t5, . + 4
bltu t1, t2, . + 20
jalr ra, zero, 4
jalr ra, sp, 1868
bltu t3, t6, . + 4
bltu t0, t3, . + 24
bge t1, t0, . + 16
beq t1, t2, . + 4
bgeu t6, t3, . + 4
bge t4, t5, . + 4
blt t5, t6, . + 8
bne t4, t5, . + 16
bgeu t4, t5, . + 4
beq zero, t4, . + 24
bge t6, t5, . + 16
jalr ra, zero, 4
bltu t3, t6, . + 4
bne t1, t2, . + 12
bne zero, t1, . + 20
blt t5, t6, . + 24
bge t6, t5, . + 4
jalr ra, zero, 4
beq t4, t5, . + 24
jal ra, . + 12
bne t4, t5, . + 20
bgeu t0, t6, . + 12
beq zero, t1, . + 20
jal ra, . + 8
bne zero, t4, . + 20
bne t4, t5, . + 4
blt t5, t6, . + 20
beq t1, t2, . + 16
bgeu t3, t0, . + 20
bne zero, t4, . + 12
jal ra, loop_back
jal ra, . + 24
bgeu t6, t0, . + 8
bne zero, t1, . + 12
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jal sp, . + 4
jalr ra, sp, 20
blt t5, t6, . + 8
jalr ra, sp, 24
beq t4, t5, . + 24
bgeu t3, t6, . + 24
bne zero, t4, . + 8
beq t4, t5, . + 8
beq t4, t5, . + 16
blt t5, t6, . + 20
jal ra, loop_back
bne t1, t2, . + 24
bgeu t6, t3, . + 24
beq zero, t1, . + 4
blt t5, t6, . + 12
bltu t6, t3, . + 8
bge t5, t6, . + 12
bne t4, t5, . + 8
bgeu t1, t2, . + 8
beq t4, t5, . + 4
beq t1, t2, . + 16
beq t4, t5, . + 24
jal ra, . + 4
bge t1, t2, . + 8
bltu t4, t5, . + 4
jal ra, . + 24
beq t1, t2, . + 24
beq zero, t4, . + 12
bne zero, t1, . + 20
bgeu t4, t5, . + 8
bltu t0, t6, . + 12
beq zero, t4, . + 20
bltu t6, t0, . + 8
bltu t3, t0, . + 20
bgeu t6, t3, . + 16
bge t1, t2, . + 8
blt t0, t1, . + 8
blt t5, t6, . + 8
bne t4, t5, . + 4
blt t6, t5, . + 12
jal ra, loop_back
bltu t3, t6, . + 4
bne t1, t2, . + 12
bgeu t0, t6, . + 16
bltu t1, t2, . + 4
bgeu t3, t6, . + 24
blt t6, t5, . + 20
blt t5, t6, . + 16
blt t6, t5, . + 20
bltu t0, t6, . + 12
bgeu t0, t6, . + 8
bne t4, t5, . + 16
bgeu t3, t0, . + 4
bltu t3, t6, . + 8
bge t6, t5, . + 24
bltu t3, t6, . + 20
bgeu t0, t3, . + 4
bge t0, t1, . + 24
blt t5, t6, . + 16
beq zero, t1, . + 12
bge t1, t0, . + 20
jal ra, . + 8
bge t0, t1, . + 4
bge t0, t1, . + 8
jalr ra, zero, 4
bgeu t3, t6, . + 16
jalr ra, sp, 280
bne zero, t1, . + 12
bne zero, t4, . + 4
bgeu t6, t0, . + 24
bge t0, t1, . + 16
bltu t3, t0, . + 8
bne t4, t5, . + 4
bltu t6, t0, . + 12
jalr ra, sp, 308
jal ra, loop_back
bgeu t1, t2, . + 4
jalr ra, zero, 4
jal ra, loop_back
bge t6, t5, . + 20
blt t6, t5, . + 20
beq zero, t1, . + 8
bgeu t6, t3, . + 8
beq zero, t1, . + 12
bne zero, t4, . + 8
bltu t4, t5, . + 24
bgeu t3, t6, . + 8
bltu t6, t0, . + 24
beq t1, t2, . + 4
bge t1, t0, . + 12
bgeu t3, t6, . + 16
bne zero, t4, . + 24
bgeu t1, t2, . + 12
bge t5, t6, . + 8
bge t4, t5, . + 12
beq zero, t4, . + 16
bltu t4, t5, . + 4
blt t0, t1, . + 24
bgeu t4, t5, . + 8
bne t1, t2, . + 24
jalr ra, zero, 4
beq zero, t4, . + 20
jalr ra, sp, 416
jal ra, loop_back
bltu t3, t0, . + 16
jal ra, . + 24
bgeu t0, t3, . + 12
jalr ra, sp, 448
beq t4, t5, . + 20
blt t1, t0, . + 16
bne zero, t1, . + 8
bltu t4, t5, . + 12
blt t5, t6, . + 24
blt t5, t6, . + 16
bgeu t6, t3, . + 4
bltu t3, t0, . + 16
bgeu t6, t0, . + 4
jal ra, loop_back
bne zero, t4, . + 4
bge t0, t1, . + 20
jal ra, loop_back
bge t0, t1, . + 24
bne zero, t4, . + 20
bne zero, t1, . + 16
bltu t3, t0, . + 20
bge t0, t1, . + 8
blt t5, t6, . + 12
jalr ra, sp, 508
blt t0, t1, . + 16
blt t6, t5, . + 4
jal ra, . + 24
bge t1, t2, . + 4
blt t6, t5, . + 12
bne zero, t4, . + 12
beq t4, t5, . + 16
jal ra, . + 12
bge t5, t6, . + 8
bltu t3, t0, . + 20
blt t6, t5, . + 4
bgeu t6, t3, . + 24
bge t6, t5, . + 4
blt t5, t6, . + 16
jalr ra, sp, 568
bge t0, t1, . + 8
blt t0, t1, . + 20
blt t1, t0, . + 4
blt t6, t5, . + 24
bgeu t1, t2, . + 20
blt t5, t6, . + 8
jalr ra, sp, 600
bne zero, t1, . + 20
blt t1, t0, . + 4
beq t1, t2, . + 24
jal ra, . + 20
bltu t0, t6, . + 20
jalr ra, zero, 4
bne t1, t2, . + 20
bgeu t3, t6, . + 12
beq zero, t1, . + 8
bltu t3, t0, . + 4
bge t0, t1, . + 8
jalr ra, zero, 4
jal ra, . + 12
blt t1, t0, . + 4
bge t4, t5, . + 16
jal ra, loop_back
bltu t0, t6, . + 24
blt t0, t1, . + 12
jal ra, . + 4
bltu t6, t3, . + 20
beq t1, t2, . + 20
blt t6, t5, . + 12
bne zero, t4, . + 4
jal ra, loop_back
beq zero, t1, . + 12
jalr ra, sp, 708
blt t0, t1, . + 4
jal ra, . + 12
bne zero, t4, . + 16
jal ra, loop_back
bge t1, t0, . + 16
bltu t0, t6, . + 12
jal ra, loop_back
bge t4, t5, . + 16
bltu t0, t6, . + 24
bltu t6, t0, . + 4
bgeu t0, t6, . + 4
bgeu t6, t3, . + 24
blt t5, t6, . + 16
bgeu t0, t6, . + 8
jalr ra, sp, 768
bne zero, t1, . + 20
bltu t0, t6, . + 20
bltu t3, t0, . + 20
bltu t3, t0, . + 20
jal ra, . + 16
jal ra, loop_back
bgeu t3, t0, . + 20
blt t6, t5, . + 4
bne zero, t4, . + 12
bltu t3, t6, . + 4
bge t1, t2, . + 24
beq t4, t5, . + 16
jal ra, . + 4
bgeu t3, t6, . + 20
beq t4, t5, . + 12
bgeu t0, t3, . + 8
bge t0, t1, . + 4
jal ra, loop_back
beq zero, t1, . + 4
bne t1, t2, . + 12
blt t0, t1, . + 8
beq zero, t4, . + 8
jal ra, loop_back
beq zero, t1, . + 4
bne t1, t2, . + 24
beq zero, t4, . + 8
bgeu t0, t6, . + 12
jalr ra, zero, 4
jalr ra, sp, 892
jalr ra, zero, 4
blt t5, t6, . + 8
bltu t0, t6, . + 20
bgeu t0, t6, . + 16
bltu t3, t6, . + 12
bltu t3, t6, . + 8
bne t4, t5, . + 24
bgeu t3, t6, . + 12
jal ra, . + 20
bne t4, t5, . + 16
jalr ra, sp, 932
jal ra, loop_back
bgeu t0, t6, . + 20
jal ra, loop_back
bltu t3, t6, . + 8
bltu t0, t3, . + 20
jal ra, loop_back
jalr ra, zero, 4
bltu t3, t0, . + 8
blt t5, t6, . + 16
jalr ra, zero, 4
bne zero, t4, . + 8
beq t1, t2, . + 16
bltu t6, t3, . + 24
bne t1, t2, . + 16
bne zero, t1, . + 16
bltu t3, t0, . + 20
bne zero, t4, . + 12
blt t6, t5, . + 24
beq t1, t2, . + 4
bge t4, t5, . + 8
bltu t6, t0, . + 16
bltu t6, t3, . + 12
beq t1, t2, . + 20
jal ra, loop_back
jalr ra, sp, 1020
beq t1, t2, . + 24
bltu t3, t0, . + 12
bgeu t3, t6, . + 4
beq t1, t2, . + 16
blt t6, t5, . + 20
jalr ra, sp, 1052
bgeu t0, t6, . + 16
jalr ra, zero, 4
beq t1, t2, . + 8
bge t0, t1, . + 24
bgeu t4, t5, . + 12
bne zero, t4, . + 4
bge t6, t5, . + 12
beq t4, t5, . + 24
bgeu t6, t3, . + 8
bne zero, t1, . + 24
beq zero, t1, . + 16
bgeu t1, t2, . + 12
bne zero, t4, . + 16
beq zero, t4, . + 20
bge t6, t5, . + 16
bge t0, t1, . + 24
jal ra, . + 8
beq t1, t2, . + 16
bgeu t0, t3, . + 16
beq zero, t1, . + 24
bltu t0, t6, . + 4
bge t1, t2, . + 4
jalr ra, sp, 1152
blt t0, t1, . + 8
bne zero, t1, . + 24
beq zero, t1, . + 4
beq zero, t4, . + 20
beq t1, t2, . + 24
jalr ra, sp, 1168
bltu t0, t6, . + 12
bgeu t0, t6, . + 4
bltu t6, t0, . + 20
beq t1, t2, . + 24
beq t4, t5, . + 20
bne t4, t5, . + 24
bltu t3, t6, . + 16
bltu t6, t0, . + 20
beq t1, t2, . + 4
blt t5, t6, . + 16
blt t5, t6, . + 4
bge t0, t1, . + 20
blt t0, t1, . + 24
bltu t3, t0, . + 16
bltu t6, t0, . + 8
bge t0, t1, . + 12
bgeu t0, t6, . + 24
bltu t6, t3, . + 12
beq zero, t4, . + 24
beq zero, t4, . + 20
bne zero, t1, . + 20
jalr ra, zero, 4
jalr ra, zero, 4
blt t5, t6, . + 4
bgeu t3, t6, . + 16
bltu t0, t6, . + 20
jal ra, . + 24
jal ra, loop_back
beq zero, t1, . + 20
bne t4, t5, . + 20
bltu t3, t6, . + 16
bltu t6, t0, . + 4
beq t4, t5, . + 20
jalr ra, zero, 4
beq t4, t5, . + 16
beq t1, t2, . + 4
bgeu t0, t6, . + 4
beq t4, t5, . + 16
bne t1, t2, . + 8
bge t4, t5, . + 12
bne zero, t1, . + 24
bltu t3, t6, . + 24
bne t4, t5, . + 20
bne t4, t5, . + 20
bgeu t3, t0, . + 24
bltu t0, t3, . + 20
beq zero, t4, . + 8
bge t1, t2, . + 20
jalr ra, zero, 4
bltu t3, t0, . + 20
blt t1, t0, . + 4
jalr ra, zero, 4
beq zero, t1, . + 20
jalr ra, zero, 4
bgeu t6, t3, . + 4
bltu t4, t5, . + 12
bge t1, t2, . + 24
jal ra, loop_back
beq zero, t4, . + 4
jal ra, . + 20
jalr ra, sp, 1420
bne t1, t2, . + 12
beq t1, t2, . + 16
jalr ra, sp, 1432
bltu t6, t0, . + 16
bge t4, t5, . + 20
bltu t3, t6, . + 4
blt t5, t6, . + 12
bltu t3, t0, . + 16
bge t4, t5, . + 4
beq zero, t1, . + 20
bge t0, t1, . + 24
bne zero, t1, . + 20
bne t4, t5, . + 20
bne zero, t1, . + 12
jal ra, . + 16
bge t0, t1, . + 16
bge t6, t5, . + 24
bge t4, t5, . + 16
blt t0, t1, . + 20
beq zero, t1, . + 12
bltu t0, t3, . + 20
bge t0, t1, . + 16
bltu t3, t0, . + 4
bgeu t3, t6, . + 20
beq zero, t4, . + 8
bne zero, t1, . + 8
bne t1, t2, . + 4
beq t1, t2, . + 20
jal ra, loop_back
bne zero, t1, . + 16
bne t1, t2, . + 24
bgeu t0, t3, . + 12
bltu t1, t2, . + 12
bge t1, t0, . + 4
bne t4, t5, . + 16
bge t0, t1, . + 4
blt t0, t1, . + 12
bne t1, t2, . + 20
bge t1, t2, . + 12
jalr ra, zero, 4
blt t1, t0, . + 16
bge t6, t5, . + 12
blt t6, t5, . + 12
beq zero, t1, . + 12
bltu t4, t5, . + 24
jal ra, loop_back
jal ra, loop_back
bge t5, t6, . + 20
bltu t0, t3, . + 16
blt t5, t6, . + 16
bge t4, t5, . + 24
beq zero, t1, . + 16
bge t0, t1, . + 16
beq zero, t4, . + 12
bgeu t4, t5, . + 20
beq t4, t5, . + 20
beq zero, t1, . + 12
bgeu t6, t3, . + 8
bne zero, t1, . + 4
bge t6, t5, . + 24
blt t0, t1, . + 24
jal ra, loop_back
bgeu t3, t0, . + 16
jalr ra, zero, 4
bge t6, t5, . + 4
bge t1, t2, . + 4
bgeu t0, t3, . + 24
blt t0, t1, . + 12
bgeu t3, t6, . + 8
bne t1, t2, . + 24
beq zero, t1, . + 4
jal ra, . + 16
bltu t0, t6, . + 12
bltu t3, t0, . + 4
bltu t3, t6, . + 24
beq t1, t2, . + 12
blt t5, t6, . + 24
beq t4, t5, . + 12
jalr ra, sp, 1732
bltu t3, t0, . + 4
bgeu t6, t3, . + 8
jalr ra, sp, 1740
bge t1, t0, . + 16
jal ra, loop_back
bltu t3, t6, . + 24
bltu t6, t3, . + 12
beq t4, t5, . + 4
jal ra, . + 16
jal ra, . + 24
blt t0, t1, . + 4
bge t4, t5, . + 12
bgeu t6, t0, . + 20

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
