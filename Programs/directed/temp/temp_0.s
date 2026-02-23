li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 59
sw s0, 0(zero)
li s0, -98
sw s0, 4(zero)
li s0, -88
sw s0, 8(zero)
li s0, -40
sw s0, 12(zero)
li s0, 23
sw s0, 16(zero)
li s0, -78
sw s0, 20(zero)
li s0, 91
sw s0, 24(zero)
li s0, 14
sw s0, 28(zero)
li s0, -71
sw s0, 32(zero)
li s0, -44
sw s0, 36(zero)
li s0, -27
sw s0, 40(zero)
li s0, -14
sw s0, 44(zero)
li s0, 72
sw s0, 48(zero)
li s0, 0
sw s0, 52(zero)
li s0, 16
sw s0, 56(zero)
li s0, -92
sw s0, 60(zero)
li s0, -57
sw s0, 64(zero)
li s0, -8
sw s0, 68(zero)
li s0, 8
sw s0, 72(zero)
li s0, 28
sw s0, 76(zero)
li s0, 14
sw s0, 80(zero)
li s0, 67
sw s0, 84(zero)
li s0, -98
sw s0, 88(zero)
li s0, -70
sw s0, 92(zero)
li s0, 38
sw s0, 96(zero)
li s0, -78
sw s0, 100(zero)
li s0, -42
sw s0, 104(zero)
li s0, 17
sw s0, 108(zero)
li s0, 91
sw s0, 112(zero)
li s0, 59
sw s0, 116(zero)
li s0, 14
sw s0, 120(zero)
li s0, -81
sw s0, 124(zero)
li s0, -15
sw s0, 128(zero)
li s0, 4
sw s0, 132(zero)
li s0, -45
sw s0, 136(zero)
li s0, -75
sw s0, 140(zero)
li s0, -8
sw s0, 144(zero)
li s0, -44
sw s0, 148(zero)
li s0, 40
sw s0, 152(zero)
li s0, -1
sw s0, 156(zero)
li s0, -3
sw s0, 160(zero)
li s0, 78
sw s0, 164(zero)
li s0, 95
sw s0, 168(zero)
li s0, -42
sw s0, 172(zero)
li s0, -38
sw s0, 176(zero)
li s0, -74
sw s0, 180(zero)
li s0, -23
sw s0, 184(zero)
li s0, -19
sw s0, 188(zero)
li s0, -60
sw s0, 192(zero)
li s0, -82
sw s0, 196(zero)
li s0, 2
sw s0, 200(zero)
li s0, -5
sw s0, 204(zero)
li s0, 10
sw s0, 208(zero)
li s0, 30
sw s0, 212(zero)
li s0, 25
sw s0, 216(zero)
li s0, 61
sw s0, 220(zero)
li s0, -22
sw s0, 224(zero)
li s0, 5
sw s0, 228(zero)
li s0, -73
sw s0, 232(zero)
li s0, 3
sw s0, 236(zero)
li s0, 52
sw s0, 240(zero)
li s0, -74
sw s0, 244(zero)
li s0, 97
sw s0, 248(zero)
li s0, -85
sw s0, 252(zero)

li s0, -913036015
li s1, 1606941407
li s2, -1114282615
li s3, -339453566
li s4, 1349149328
li s5, -660314729
li s6, -486879768
li s7, 1310650642
li s8, -144348232
li s9, 1418400202
li s10, 1952820245
li s11, 490347559

jal sp, . + 4
bge t6, t5, . + 24
xori a2, s11, 1940
mul a4, s10, s6
addi a3, s6, -110
sltu a0, s6, s1
addi a1, s3, 620
srai a5, s10, 30
xori a2, s1, -889
sltu a1, s4, s9
slti a4, s8, 404
sltu a6, s6, s3
jalr ra, sp, 68
bge t4, t5, . + 4
xori a2, s5, 984
bne t4, t5, . + 20
sltu a2, s11, s3
add a1, s8, s5
sra a5, s4, s4
slli a0, s11, 13
srai a5, s1, 26
sltiu a4, s2, -854
sltiu a7, s0, -697
slt a7, s4, s4
beq zero, t4, . + 24
srl a7, s8, s0
srai a2, s6, 19
jalr ra, sp, 128
sra a2, s4, s7
andi a1, s1, -836
xori a3, s6, -1911
xor a0, s2, s7
and a5, s5, s10
add a7, s8, s1
bge t6, t5, . + 16
srl a5, s6, s11
blt t6, t5, . + 12
jalr ra, sp, 148
add a7, s10, s5
addi a3, s6, 448
sltiu a6, s1, 1370
add a0, s10, s4
sra a1, s1, s9
and a0, s7, s7
andi a5, s5, -520
sll a2, s1, s8
slt a0, s9, s9
xor a7, s8, s11
beq zero, t1, . + 16
srli a6, s0, 3
srl a0, s1, s11
sll a4, s4, s10
jalr ra, sp, 208
jalr ra, sp, 216
andi a1, s3, -1319
srli a4, s6, 13
sll a3, s0, s6
bge t0, t1, . + 12
beq zero, t4, . + 16
addi a5, s0, -1023
xori a2, s3, 14
andi a1, s2, -1139
sltiu a6, s9, 1454
xori a0, s7, -1903
sltu a2, s4, s2
and a5, s2, s6
sra a6, s6, s8
sll a2, s1, s10
beq zero, t1, . + 4
or a2, s10, s11
xor a0, s5, s8
add a2, s8, s3
slti a4, s1, -992
sll a1, s8, s10
slli a7, s10, 30
xor a7, s7, s6
jal ra, . + 20
sra a7, s1, s2
sra a6, s1, s0
sltu a6, s1, s2
bne t4, t5, . + 20
srli a2, s7, 5
and a1, s0, s6
add a1, s3, s11
slli a7, s6, 15
and a3, s8, s1
bge t0, t1, . + 16
bne t1, t2, . + 24
xori a6, s5, 1336
mul a6, s3, s9
sll a5, s7, s5
bge t4, t5, . + 4
slti a7, s9, 1777
srli a2, s4, 1
blt t1, t0, . + 4
srai a2, s5, 29
xor a7, s0, s7
sltiu a7, s10, 48
beq zero, t1, . + 4
blt t1, t0, . + 16
mul a2, s4, s7

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
