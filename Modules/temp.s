li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 0
sw s0, 0(zero)
li s0, 91
sw s0, 4(zero)
li s0, 82
sw s0, 8(zero)
li s0, -22
sw s0, 12(zero)
li s0, -43
sw s0, 16(zero)
li s0, 92
sw s0, 20(zero)
li s0, -78
sw s0, 24(zero)
li s0, -49
sw s0, 28(zero)
li s0, -26
sw s0, 32(zero)
li s0, 46
sw s0, 36(zero)
li s0, -2
sw s0, 40(zero)
li s0, -43
sw s0, 44(zero)
li s0, 25
sw s0, 48(zero)
li s0, 35
sw s0, 52(zero)
li s0, 8
sw s0, 56(zero)
li s0, 6
sw s0, 60(zero)
li s0, 6
sw s0, 64(zero)
li s0, -51
sw s0, 68(zero)
li s0, -82
sw s0, 72(zero)
li s0, 94
sw s0, 76(zero)
li s0, -56
sw s0, 80(zero)
li s0, -20
sw s0, 84(zero)
li s0, -97
sw s0, 88(zero)
li s0, -91
sw s0, 92(zero)
li s0, 98
sw s0, 96(zero)
li s0, 63
sw s0, 100(zero)
li s0, 20
sw s0, 104(zero)
li s0, -98
sw s0, 108(zero)
li s0, 67
sw s0, 112(zero)
li s0, 26
sw s0, 116(zero)
li s0, -71
sw s0, 120(zero)
li s0, 53
sw s0, 124(zero)
li s0, 60
sw s0, 128(zero)
li s0, 16
sw s0, 132(zero)
li s0, 82
sw s0, 136(zero)
li s0, -7
sw s0, 140(zero)
li s0, -95
sw s0, 144(zero)
li s0, -94
sw s0, 148(zero)
li s0, -52
sw s0, 152(zero)
li s0, -12
sw s0, 156(zero)
li s0, -22
sw s0, 160(zero)
li s0, -28
sw s0, 164(zero)
li s0, 22
sw s0, 168(zero)
li s0, -9
sw s0, 172(zero)
li s0, 59
sw s0, 176(zero)
li s0, 74
sw s0, 180(zero)
li s0, -12
sw s0, 184(zero)
li s0, 85
sw s0, 188(zero)
li s0, 6
sw s0, 192(zero)
li s0, 34
sw s0, 196(zero)
li s0, 83
sw s0, 200(zero)
li s0, 78
sw s0, 204(zero)
li s0, -65
sw s0, 208(zero)
li s0, -34
sw s0, 212(zero)
li s0, 94
sw s0, 216(zero)
li s0, -13
sw s0, 220(zero)
li s0, -2
sw s0, 224(zero)
li s0, -34
sw s0, 228(zero)
li s0, 99
sw s0, 232(zero)
li s0, 41
sw s0, 236(zero)
li s0, -38
sw s0, 240(zero)
li s0, 59
sw s0, 244(zero)
li s0, -55
sw s0, 248(zero)
li s0, 39
sw s0, 252(zero)

li s0, -2017003367
li s1, 888768672
li s2, 1674756338
li s3, 1085877378
li s4, -1105780678
li s5, 26906844
li s6, -274315777
li s7, 896071358
li s8, -799403101
li s9, 965280519
li s10, 1984375333
li s11, -1896690759

jal sp, . + 4
bne zero, t4, . + 20
or a2, s3, s5
jalr ra, sp, 32
ori a4, s11, -1210
jal ra, . + 12
sll a6, s9, s5
addi a7, s6, -1086
xori a5, s3, -1973
blt t1, t0, . + 16
and a1, s9, s2
xor a7, s10, s0
blt t5, t6, . + 4
andi a5, s11, 1299
sll a5, s6, s3
beq t4, t5, . + 12
andi a5, s0, 479
andi a2, s4, 1127
blt t6, t5, . + 16
bge t0, t1, . + 20
bge t6, t5, . + 16
bge t1, t0, . + 16
mul a6, s5, s11
mul a5, s0, s8
addi a6, s1, 1292
ori a3, s0, 1575
addi a0, s11, -1840
srl a3, s6, s4
addi a0, s0, 436
add a6, s2, s10
andi a1, s2, 1118
and a0, s0, s1
andi a1, s10, -1637
mul a0, s3, s0
or a7, s7, s0
or a2, s4, s3
ori a1, s11, -1554
sra a5, s3, s7
addi a4, s9, -67
srl a7, s3, s10
or a4, s4, s2
ori a5, s9, 351
xor a5, s11, s6
bge t4, t5, . + 20
and a1, s0, s4
sra a3, s7, s8
sra a3, s5, s1
srl a2, s4, s11
ori a7, s5, 154
mul a1, s1, s1
add a1, s11, s4
xor a4, s11, s11
xor a5, s2, s5
beq t1, t2, . + 24
sra a4, s1, s3
mul a1, s0, s8
add a2, s8, s8
beq t4, t5, . + 24
xori a4, s2, -941
xori a6, s10, 1097
and a7, s2, s6
xor a0, s8, s11
and a3, s2, s3
ori a5, s10, -140
addi a7, s10, 1568
add a0, s5, s9
srl a3, s3, s6
xori a0, s8, -235
jal ra, . + 24
addi a1, s1, 1131
add a0, s8, s1
srl a6, s6, s3
sll a3, s6, s1
bge t1, t0, . + 16
srl a7, s9, s6
or a5, s6, s0
ori a7, s3, 220
or a6, s4, s4
andi a7, s3, 2005
sll a2, s9, s0
xori a2, s11, -488
and a1, s9, s4
sll a6, s2, s6
ori a4, s4, -399
sra a1, s2, s3
srl a3, s3, s3
xor a3, s2, s2
xori a2, s1, -1682
andi a3, s10, -488
ori a0, s10, 110
xor a4, s8, s10
andi a6, s1, 1098
sll a6, s3, s5
sll a3, s9, s11
beq t4, t5, . + 12
andi a1, s9, -1162
addi a0, s3, -1569
beq t1, t2, . + 24
mul a2, s7, s1
andi a4, s4, 1753
beq zero, t4, . + 16

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
jal zero, .
nop
nop
nop
nop
nop
