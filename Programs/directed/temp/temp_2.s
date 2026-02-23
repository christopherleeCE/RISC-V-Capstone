li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 35
sw s0, 0(zero)
li s0, 32
sw s0, 4(zero)
li s0, 49
sw s0, 8(zero)
li s0, -63
sw s0, 12(zero)
li s0, -78
sw s0, 16(zero)
li s0, -100
sw s0, 20(zero)
li s0, -13
sw s0, 24(zero)
li s0, -93
sw s0, 28(zero)
li s0, -24
sw s0, 32(zero)
li s0, 67
sw s0, 36(zero)
li s0, 78
sw s0, 40(zero)
li s0, -64
sw s0, 44(zero)
li s0, 35
sw s0, 48(zero)
li s0, 11
sw s0, 52(zero)
li s0, 2
sw s0, 56(zero)
li s0, 2
sw s0, 60(zero)
li s0, 5
sw s0, 64(zero)
li s0, -10
sw s0, 68(zero)
li s0, 24
sw s0, 72(zero)
li s0, -52
sw s0, 76(zero)
li s0, -75
sw s0, 80(zero)
li s0, 86
sw s0, 84(zero)
li s0, -84
sw s0, 88(zero)
li s0, -53
sw s0, 92(zero)
li s0, 98
sw s0, 96(zero)
li s0, -90
sw s0, 100(zero)
li s0, -88
sw s0, 104(zero)
li s0, -91
sw s0, 108(zero)
li s0, 27
sw s0, 112(zero)
li s0, -20
sw s0, 116(zero)
li s0, 95
sw s0, 120(zero)
li s0, -75
sw s0, 124(zero)
li s0, -27
sw s0, 128(zero)
li s0, -99
sw s0, 132(zero)
li s0, 25
sw s0, 136(zero)
li s0, -34
sw s0, 140(zero)
li s0, -66
sw s0, 144(zero)
li s0, 7
sw s0, 148(zero)
li s0, 23
sw s0, 152(zero)
li s0, 20
sw s0, 156(zero)
li s0, 49
sw s0, 160(zero)
li s0, 10
sw s0, 164(zero)
li s0, -70
sw s0, 168(zero)
li s0, 87
sw s0, 172(zero)
li s0, 13
sw s0, 176(zero)
li s0, 49
sw s0, 180(zero)
li s0, 63
sw s0, 184(zero)
li s0, -31
sw s0, 188(zero)
li s0, -60
sw s0, 192(zero)
li s0, -19
sw s0, 196(zero)
li s0, 5
sw s0, 200(zero)
li s0, -21
sw s0, 204(zero)
li s0, -90
sw s0, 208(zero)
li s0, -98
sw s0, 212(zero)
li s0, 46
sw s0, 216(zero)
li s0, 5
sw s0, 220(zero)
li s0, -16
sw s0, 224(zero)
li s0, 30
sw s0, 228(zero)
li s0, 10
sw s0, 232(zero)
li s0, -2
sw s0, 236(zero)
li s0, 34
sw s0, 240(zero)
li s0, -5
sw s0, 244(zero)
li s0, 39
sw s0, 248(zero)
li s0, 18
sw s0, 252(zero)

li s0, 420841857
li s1, 68461576
li s2, 1681655924
li s3, -594600825
li s4, -404171415
li s5, 1321908924
li s6, -1611415452
li s7, 1934153805
li s8, 978530191
li s9, -71175589
li s10, -581165745
li s11, 1677111975

jal sp, . + 4
add a2, s0, s1
bge t0, t1, . + 16
blt t5, t6, . + 12
sltiu a5, s5, -1623
slti a6, s9, -177
jalr ra, sp, 28
xor a1, s6, s6
beq zero, t1, . + 8
xor a3, s6, s4
or a4, s2, s3
jal ra, . + 16
add a3, s6, s3
blt t5, t6, . + 20
bne zero, t4, . + 4
blt t6, t5, . + 12
sra a2, s8, s4
beq t1, t2, . + 20
sra a6, s7, s1
slt a3, s9, s6
or a4, s8, s11
xor a5, s2, s1
mul a0, s8, s8
xor a1, s3, s1
bge t5, t6, . + 24
addi a5, s6, 1424
jalr ra, sp, 120
jal ra, . + 4
slli a0, s2, 26
and a4, s6, s10
jalr ra, sp, 120
srai a2, s6, 22
and a4, s3, s11
xori a3, s11, -1044
blt t6, t5, . + 8
add a2, s11, s0
and a6, s5, s11
beq zero, t1, . + 16
slli a7, s1, 23
blt t5, t6, . + 12
srli a5, s10, 7
sra a2, s4, s7
xori a7, s6, -438
xori a7, s3, -1743
srl a6, s3, s6
xori a6, s11, 1861
sll a7, s1, s5
addi a0, s4, -1728
add a4, s11, s3
bge t0, t1, . + 12
ori a5, s7, -1398
add a4, s3, s2
slti a7, s7, -1049
ori a2, s2, 1899
or a2, s11, s0
mul a6, s0, s10
blt t5, t6, . + 20
blt t5, t6, . + 20
slli a5, s4, 11
srl a3, s7, s2
or a5, s2, s6
sltiu a1, s4, -201
sll a1, s10, s7
bge t4, t5, . + 8
srli a4, s7, 23
bne t4, t5, . + 12
sra a4, s8, s4
or a1, s10, s5
xor a5, s9, s11
bne zero, t4, . + 4
blt t1, t0, . + 20
slti a3, s8, -1359
jal ra, . + 20
addi a3, s0, 42
mul a3, s7, s0
xori a4, s3, -654
sra a3, s5, s6
blt t5, t6, . + 20
ori a6, s8, 1098
add a6, s11, s1
bge t1, t2, . + 20
xor a5, s4, s3
andi a5, s9, 736
ori a7, s0, -1883
ori a2, s9, 822
and a4, s11, s11
addi a4, s11, 731
mul a3, s4, s1
ori a2, s8, -2042
slti a4, s11, 354
bge t5, t6, . + 20
add a2, s0, s10
addi a0, s7, -913
xori a7, s3, -290
slli a5, s7, 0
srl a4, s11, s7
xori a0, s11, 1120
sra a2, s11, s5
xor a4, s8, s4
srai a1, s7, 20
beq t1, t2, . + 20

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
