li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 29
sw s0, 0(zero)
li s0, 31
sw s0, 4(zero)
li s0, 84
sw s0, 8(zero)
li s0, -58
sw s0, 12(zero)
li s0, -39
sw s0, 16(zero)
li s0, 76
sw s0, 20(zero)
li s0, -49
sw s0, 24(zero)
li s0, 21
sw s0, 28(zero)
li s0, -74
sw s0, 32(zero)
li s0, 85
sw s0, 36(zero)
li s0, 18
sw s0, 40(zero)
li s0, 20
sw s0, 44(zero)
li s0, 4
sw s0, 48(zero)
li s0, 67
sw s0, 52(zero)
li s0, -80
sw s0, 56(zero)
li s0, 11
sw s0, 60(zero)
li s0, 16
sw s0, 64(zero)
li s0, 100
sw s0, 68(zero)
li s0, -82
sw s0, 72(zero)
li s0, 11
sw s0, 76(zero)
li s0, -28
sw s0, 80(zero)
li s0, 8
sw s0, 84(zero)
li s0, -56
sw s0, 88(zero)
li s0, 44
sw s0, 92(zero)
li s0, 0
sw s0, 96(zero)
li s0, 35
sw s0, 100(zero)
li s0, -92
sw s0, 104(zero)
li s0, 82
sw s0, 108(zero)
li s0, 48
sw s0, 112(zero)
li s0, 94
sw s0, 116(zero)
li s0, 55
sw s0, 120(zero)
li s0, -77
sw s0, 124(zero)
li s0, 66
sw s0, 128(zero)
li s0, -11
sw s0, 132(zero)
li s0, 96
sw s0, 136(zero)
li s0, 15
sw s0, 140(zero)
li s0, -87
sw s0, 144(zero)
li s0, 18
sw s0, 148(zero)
li s0, 55
sw s0, 152(zero)
li s0, -25
sw s0, 156(zero)
li s0, -64
sw s0, 160(zero)
li s0, 48
sw s0, 164(zero)
li s0, -29
sw s0, 168(zero)
li s0, -40
sw s0, 172(zero)
li s0, -66
sw s0, 176(zero)
li s0, -97
sw s0, 180(zero)
li s0, -5
sw s0, 184(zero)
li s0, -42
sw s0, 188(zero)
li s0, -21
sw s0, 192(zero)
li s0, -90
sw s0, 196(zero)
li s0, -42
sw s0, 200(zero)
li s0, 95
sw s0, 204(zero)
li s0, 55
sw s0, 208(zero)
li s0, 56
sw s0, 212(zero)
li s0, -15
sw s0, 216(zero)
li s0, 83
sw s0, 220(zero)
li s0, 41
sw s0, 224(zero)
li s0, -7
sw s0, 228(zero)
li s0, 49
sw s0, 232(zero)
li s0, 19
sw s0, 236(zero)
li s0, -69
sw s0, 240(zero)
li s0, 43
sw s0, 244(zero)
li s0, 5
sw s0, 248(zero)
li s0, -33
sw s0, 252(zero)

li s0, -624280544
li s1, 499725287
li s2, 949587112
li s3, -1878135570
li s4, -1601207602
li s5, -176979769
li s6, -1849075171
li s7, 1734068414
li s8, 2048565073
li s9, 464652816
li s10, -1016761567
li s11, -1279189819

jal sp, . + 4
mul a7, s0, s3
or a3, s1, s11
sltu a4, s5, s9
slti a1, s6, -1799
sltiu a5, s9, 141
xori a6, s11, 127
or a0, s7, s6
ori a7, s8, 1827
blt t5, t6, . + 8
srai a5, s11, 22
slli a4, s2, 11
jalr ra, sp, 64
xori a2, s11, -1844
xori a3, s5, 1852
xor a0, s2, s11
ori a5, s1, -425
sra a0, s5, s1
xor a2, s0, s10
jal ra, . + 16
addi a5, s3, -541
blt t0, t1, . + 4
sra a6, s8, s7
slti a0, s2, 390
slli a2, s7, 11
slt a4, s1, s4
sra a0, s1, s5
beq t4, t5, . + 16
beq t1, t2, . + 24
jalr ra, sp, 132
xor a0, s11, s11
sll a6, s11, s8
andi a3, s9, -670
srai a0, s1, 5
xori a3, s9, 17
bne t4, t5, . + 20
slt a4, s8, s2
and a0, s10, s6
blt t5, t6, . + 12
slti a0, s1, 1152
mul a4, s4, s6
add a0, s0, s1
beq zero, t1, . + 4
jalr ra, sp, 176
sltiu a6, s11, 1805
addi a7, s7, 1313
blt t5, t6, . + 4
slt a7, s6, s0
addi a5, s4, 187
bge t6, t5, . + 4
srai a0, s9, 24
and a0, s6, s1
sra a0, s3, s6
blt t6, t5, . + 20
slt a2, s0, s8
sll a2, s10, s8
blt t6, t5, . + 24
add a1, s7, s1
slt a6, s0, s7
mul a5, s9, s2
beq zero, t4, . + 4
jalr ra, sp, 248
or a3, s2, s0
add a6, s7, s11
sltiu a4, s0, -1868
mul a1, s10, s0
and a2, s8, s0
sra a2, s8, s4
andi a5, s8, 720
beq zero, t1, . + 24
slli a6, s8, 22
ori a6, s6, -743
slti a2, s8, -246
or a4, s0, s9
beq t1, t2, . + 20
ori a0, s6, -864
add a5, s8, s4
slti a6, s3, -899
srl a5, s7, s10
slli a0, s3, 30
sra a1, s9, s7
or a2, s6, s11
srli a4, s8, 21
srl a7, s6, s2
bge t6, t5, . + 20
add a2, s9, s1
blt t1, t0, . + 12
jal ra, . + 4
slli a5, s3, 19
slti a4, s9, -304
jalr ra, sp, 368
slt a6, s9, s5
sltiu a5, s6, -904
bge t0, t1, . + 12
jal ra, . + 12
andi a3, s9, -894
and a5, s5, s2
sltiu a4, s11, 297
slt a1, s2, s1
sltiu a3, s4, 265
xor a6, s9, s6

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
