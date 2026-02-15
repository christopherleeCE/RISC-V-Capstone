li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 56
sw s0, 0(zero)
li s0, -42
sw s0, 4(zero)
li s0, -89
sw s0, 8(zero)
li s0, -26
sw s0, 12(zero)
li s0, -54
sw s0, 16(zero)
li s0, 72
sw s0, 20(zero)
li s0, 1
sw s0, 24(zero)
li s0, 19
sw s0, 28(zero)
li s0, -88
sw s0, 32(zero)
li s0, 38
sw s0, 36(zero)
li s0, 40
sw s0, 40(zero)
li s0, 29
sw s0, 44(zero)
li s0, -36
sw s0, 48(zero)
li s0, 55
sw s0, 52(zero)
li s0, 76
sw s0, 56(zero)
li s0, -56
sw s0, 60(zero)
li s0, -75
sw s0, 64(zero)
li s0, -51
sw s0, 68(zero)
li s0, -13
sw s0, 72(zero)
li s0, -57
sw s0, 76(zero)
li s0, 94
sw s0, 80(zero)
li s0, 11
sw s0, 84(zero)
li s0, 75
sw s0, 88(zero)
li s0, 30
sw s0, 92(zero)
li s0, 25
sw s0, 96(zero)
li s0, 62
sw s0, 100(zero)
li s0, 100
sw s0, 104(zero)
li s0, -97
sw s0, 108(zero)
li s0, -24
sw s0, 112(zero)
li s0, -53
sw s0, 116(zero)
li s0, 65
sw s0, 120(zero)
li s0, -34
sw s0, 124(zero)
li s0, -87
sw s0, 128(zero)
li s0, -35
sw s0, 132(zero)
li s0, 31
sw s0, 136(zero)
li s0, 45
sw s0, 140(zero)
li s0, 45
sw s0, 144(zero)
li s0, -11
sw s0, 148(zero)
li s0, -39
sw s0, 152(zero)
li s0, 50
sw s0, 156(zero)
li s0, 98
sw s0, 160(zero)
li s0, -92
sw s0, 164(zero)
li s0, 61
sw s0, 168(zero)
li s0, -46
sw s0, 172(zero)
li s0, 78
sw s0, 176(zero)
li s0, 92
sw s0, 180(zero)
li s0, -73
sw s0, 184(zero)
li s0, -18
sw s0, 188(zero)
li s0, 37
sw s0, 192(zero)
li s0, 28
sw s0, 196(zero)
li s0, 57
sw s0, 200(zero)
li s0, -90
sw s0, 204(zero)
li s0, 8
sw s0, 208(zero)
li s0, 90
sw s0, 212(zero)
li s0, 17
sw s0, 216(zero)
li s0, -71
sw s0, 220(zero)
li s0, -70
sw s0, 224(zero)
li s0, -18
sw s0, 228(zero)
li s0, -44
sw s0, 232(zero)
li s0, -11
sw s0, 236(zero)
li s0, -20
sw s0, 240(zero)
li s0, 81
sw s0, 244(zero)
li s0, 93
sw s0, 248(zero)
li s0, 56
sw s0, 252(zero)

li s0, -1691669496
li s1, -729414597
li s2, 1841797039
li s3, 1428630282
li s4, -1860185013
li s5, -802854376
li s6, 150503001
li s7, 1692375684
li s8, -681451311
li s9, 1205891413
li s10, 1500864234
li s11, -794132129

jal sp, . + 4
beq t1, t2, . + 24
xor a1, s1, s0
xori a5, s3, -183
mul a7, s2, s1
addi a1, s5, -401
lbu s0, 188(zero)
add a7, s10, s9
andi a0, s1, -478
bne t1, t2, . + 24
add a1, s2, s6
sb s1, 112(zero)
and a4, s9, s6
mul a6, s2, s8
mul a3, s10, s4
lh s1, 72(zero)
sb s6, 116(zero)
lbu s0, 16(zero)
xori a0, s10, 28
xori a2, s4, 779
add a0, s4, s2
blt t1, t0, . + 8
bge t6, t5, . + 12
srl a2, s5, s0
lhu s1, 148(zero)
xori a6, s4, -438
mul a3, s0, s1
sw s3, 144(zero)
sb s2, 176(zero)
bne zero, t1, . + 8
lbu s2, 140(zero)
andi a0, s7, 1453
beq zero, t1, . + 4
or a3, s0, s5
beq zero, t4, . + 24
beq t1, t2, . + 24
xor a6, s1, s11
or a1, s3, s5
xori a4, s1, 265
srl a3, s11, s9
bge t0, t1, . + 12
bne zero, t1, . + 12
and a1, s0, s7
xor a2, s0, s7
beq zero, t1, . + 24
sw s2, 232(zero)
bne zero, t4, . + 24
xor a7, s9, s0
lh s8, 116(zero)
bne zero, t4, . + 8
or a4, s8, s3
lh s4, 16(zero)
lw s5, 48(zero)
and a3, s5, s7
beq zero, t1, . + 8
sll a3, s2, s11
add a0, s8, s10
blt t1, t0, . + 24
jal ra, . + 12
bge t0, t1, . + 16
jalr ra, sp, 204
andi a0, s1, 530
addi a3, s0, -185
srl a6, s9, s0
xor a3, s3, s2
xor a2, s9, s10
lw s8, 160(zero)
add a1, s1, s5
xor a6, s6, s11
blt t0, t1, . + 4
lb s2, 184(zero)
blt t0, t1, . + 4
and a0, s3, s0
or a7, s4, s8
sra a6, s5, s11
srl a0, s3, s3
add a7, s6, s8
andi a3, s1, -217
ori a7, s2, -208
blt t6, t5, . + 24
bge t6, t5, . + 4
add a1, s1, s2
or a7, s0, s8
xor a6, s9, s3
xor a0, s8, s4
and a2, s11, s9
lhu s0, 192(zero)
xor a3, s1, s4
add a0, s6, s0
bge t1, t2, . + 12
mul a4, s4, s4
sh s3, 184(zero)
srl a4, s5, s5
andi a3, s2, -1580
and a0, s7, s6
and a6, s2, s0
sh s4, 216(zero)
blt t5, t6, . + 20
andi a6, s11, -1974
or a7, s2, s0
andi a6, s1, 219

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
