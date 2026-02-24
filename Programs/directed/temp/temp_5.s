li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 69
sw s0, 0(zero)
li s0, 52
sw s0, 4(zero)
li s0, -57
sw s0, 8(zero)
li s0, -79
sw s0, 12(zero)
li s0, 77
sw s0, 16(zero)
li s0, 98
sw s0, 20(zero)
li s0, -55
sw s0, 24(zero)
li s0, 10
sw s0, 28(zero)
li s0, -90
sw s0, 32(zero)
li s0, 21
sw s0, 36(zero)
li s0, -94
sw s0, 40(zero)
li s0, 38
sw s0, 44(zero)
li s0, -67
sw s0, 48(zero)
li s0, 35
sw s0, 52(zero)
li s0, 63
sw s0, 56(zero)
li s0, -10
sw s0, 60(zero)
li s0, -51
sw s0, 64(zero)
li s0, -97
sw s0, 68(zero)
li s0, 16
sw s0, 72(zero)
li s0, -46
sw s0, 76(zero)
li s0, 69
sw s0, 80(zero)
li s0, 62
sw s0, 84(zero)
li s0, -93
sw s0, 88(zero)
li s0, 86
sw s0, 92(zero)
li s0, 61
sw s0, 96(zero)
li s0, 51
sw s0, 100(zero)
li s0, 6
sw s0, 104(zero)
li s0, -45
sw s0, 108(zero)
li s0, -7
sw s0, 112(zero)
li s0, 72
sw s0, 116(zero)
li s0, -51
sw s0, 120(zero)
li s0, -86
sw s0, 124(zero)
li s0, 42
sw s0, 128(zero)
li s0, -36
sw s0, 132(zero)
li s0, 93
sw s0, 136(zero)
li s0, 49
sw s0, 140(zero)
li s0, -74
sw s0, 144(zero)
li s0, 67
sw s0, 148(zero)
li s0, -53
sw s0, 152(zero)
li s0, -84
sw s0, 156(zero)
li s0, 17
sw s0, 160(zero)
li s0, -73
sw s0, 164(zero)
li s0, 37
sw s0, 168(zero)
li s0, 77
sw s0, 172(zero)
li s0, 69
sw s0, 176(zero)
li s0, 38
sw s0, 180(zero)
li s0, 65
sw s0, 184(zero)
li s0, -15
sw s0, 188(zero)
li s0, -16
sw s0, 192(zero)
li s0, 21
sw s0, 196(zero)
li s0, 59
sw s0, 200(zero)
li s0, -50
sw s0, 204(zero)
li s0, 75
sw s0, 208(zero)
li s0, -77
sw s0, 212(zero)
li s0, -48
sw s0, 216(zero)
li s0, -5
sw s0, 220(zero)
li s0, 30
sw s0, 224(zero)
li s0, 11
sw s0, 228(zero)
li s0, 46
sw s0, 232(zero)
li s0, 27
sw s0, 236(zero)
li s0, -90
sw s0, 240(zero)
li s0, 99
sw s0, 244(zero)
li s0, -39
sw s0, 248(zero)
li s0, -60
sw s0, 252(zero)

li s0, -1594933352
li s1, -1756709257
li s2, 548236144
li s3, -1835710312
li s4, -938899354
li s5, -1463947787
li s6, 622986613
li s7, -869862325
li s8, -411749178
li s9, 1096734668
li s10, 1773846928
li s11, 827780703

jal sp, . + 4
and a2, s6, s8
srl a2, s2, s1
mul a3, s7, s7
andi a5, s2, -1835
add a6, s7, s4
ori a4, s3, -918
andi a0, s6, -801
addi a7, s10, -219
bge t6, t5, . + 20
srl a1, s1, s5
xor a5, s5, s10
mul a3, s11, s7
andi a2, s7, -1118
add a7, s2, s9
addi a5, s11, 142
sll a3, s10, s5
mul a4, s7, s3
srli a4, s1, 28
andi a7, s8, -680
and a7, s9, s0
sltu a0, s2, s4
add a4, s11, s2
or a0, s0, s4
slli a7, s7, 18
sltiu a0, s4, -1961
add a3, s6, s0
sltiu a7, s8, 1102
addi a1, s8, 208
bne t1, t2, . + 12
slli a1, s2, 19
blt t5, t6, . + 12
bge t1, t0, . + 12
srli a4, s2, 31
or a4, s8, s7
ori a1, s3, 120
srl a4, s1, s11
beq zero, t1, . + 8
slli a4, s2, 7
bge t1, t2, . + 4
add a5, s8, s3
slt a4, s2, s10
xori a3, s8, 1874
bge t6, t5, . + 12
sltiu a0, s0, 1062
or a5, s11, s7
srl a7, s9, s11
xori a1, s11, -683
addi a2, s7, 1350
mul a5, s11, s7
or a0, s1, s10
sltiu a7, s2, 1201
bge t4, t5, . + 20
slti a1, s11, -2041
slli a1, s8, 5
blt t6, t5, . + 8
sra a4, s6, s8
bge t4, t5, . + 20
xor a4, s3, s1
ori a0, s4, 1005
jalr ra, sp, 244
slti a1, s4, 1297
andi a6, s4, 1856
slti a4, s4, -352
slli a3, s2, 6
srl a7, s5, s5
mul a5, s8, s8
srl a3, s10, s10
sltu a4, s3, s8
addi a2, s4, -416
add a2, s8, s5
beq zero, t1, . + 8
sll a1, s1, s7
srli a1, s11, 10
blt t6, t5, . + 4
bge t0, t1, . + 8
sll a5, s1, s5
srl a3, s8, s2
xor a3, s4, s4
and a2, s6, s1
sltu a6, s11, s2
sra a2, s4, s1
addi a1, s10, -1178
slti a2, s7, -2
srl a7, s5, s5
and a5, s0, s8
sra a6, s2, s5
sltu a0, s11, s10
slli a7, s11, 29
andi a0, s1, -286
mul a0, s8, s2
and a1, s11, s5
beq zero, t1, . + 4
or a0, s1, s7
srli a7, s0, 24
xori a7, s0, 1854
bge t5, t6, . + 4
xori a4, s5, -1556
sra a3, s4, s2
sll a0, s11, s8
slt a4, s10, s2

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
