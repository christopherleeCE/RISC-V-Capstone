li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, -18
sw s0, 0(zero)
li s0, 37
sw s0, 4(zero)
li s0, -55
sw s0, 8(zero)
li s0, 10
sw s0, 12(zero)
li s0, 80
sw s0, 16(zero)
li s0, -40
sw s0, 20(zero)
li s0, -99
sw s0, 24(zero)
li s0, 42
sw s0, 28(zero)
li s0, -47
sw s0, 32(zero)
li s0, 13
sw s0, 36(zero)
li s0, 9
sw s0, 40(zero)
li s0, -39
sw s0, 44(zero)
li s0, 17
sw s0, 48(zero)
li s0, -98
sw s0, 52(zero)
li s0, -67
sw s0, 56(zero)
li s0, 73
sw s0, 60(zero)
li s0, -67
sw s0, 64(zero)
li s0, 81
sw s0, 68(zero)
li s0, -89
sw s0, 72(zero)
li s0, 2
sw s0, 76(zero)
li s0, 21
sw s0, 80(zero)
li s0, -91
sw s0, 84(zero)
li s0, 30
sw s0, 88(zero)
li s0, -4
sw s0, 92(zero)
li s0, -18
sw s0, 96(zero)
li s0, -65
sw s0, 100(zero)
li s0, 80
sw s0, 104(zero)
li s0, -2
sw s0, 108(zero)
li s0, -59
sw s0, 112(zero)
li s0, -3
sw s0, 116(zero)
li s0, 40
sw s0, 120(zero)
li s0, -31
sw s0, 124(zero)
li s0, -85
sw s0, 128(zero)
li s0, -55
sw s0, 132(zero)
li s0, -45
sw s0, 136(zero)
li s0, -81
sw s0, 140(zero)
li s0, -56
sw s0, 144(zero)
li s0, -78
sw s0, 148(zero)
li s0, 100
sw s0, 152(zero)
li s0, -88
sw s0, 156(zero)
li s0, -88
sw s0, 160(zero)
li s0, -89
sw s0, 164(zero)
li s0, -74
sw s0, 168(zero)
li s0, -57
sw s0, 172(zero)
li s0, 79
sw s0, 176(zero)
li s0, -10
sw s0, 180(zero)
li s0, -19
sw s0, 184(zero)
li s0, -19
sw s0, 188(zero)
li s0, -100
sw s0, 192(zero)
li s0, 21
sw s0, 196(zero)
li s0, 95
sw s0, 200(zero)
li s0, 23
sw s0, 204(zero)
li s0, 10
sw s0, 208(zero)
li s0, -98
sw s0, 212(zero)
li s0, 57
sw s0, 216(zero)
li s0, 55
sw s0, 220(zero)
li s0, -15
sw s0, 224(zero)
li s0, 70
sw s0, 228(zero)
li s0, 53
sw s0, 232(zero)
li s0, -2
sw s0, 236(zero)
li s0, -71
sw s0, 240(zero)
li s0, 53
sw s0, 244(zero)
li s0, -95
sw s0, 248(zero)
li s0, -58
sw s0, 252(zero)

li s0, -944544436
li s1, -566201490
li s2, -1758286040
li s3, -650661359
li s4, -1168901736
li s5, -1128533938
li s6, -880057941
li s7, -332098568
li s8, -509197221
li s9, 1673590964
li s10, -1153942471
li s11, -927152839

jal sp, . + 4
or a1, s9, s2
jal ra, . + 8
and a6, s4, s2
mul a0, s1, s9
or a7, s6, s8
mul a5, s2, s5
srl a7, s9, s7
jal ra, . + 24
add a1, s0, s3
sra a3, s8, s8
sra a4, s5, s11
xori a4, s10, 1387
xor a1, s8, s1
addi a4, s5, -813
blt t0, t1, . + 8
srl a5, s2, s7
srl a0, s4, s6
xor a4, s2, s7
sll a7, s5, s0
sll a7, s0, s7
beq t4, t5, . + 12
bne t1, t2, . + 20
sra a4, s9, s1
sra a6, s8, s8
add a7, s6, s8
blt t1, t0, . + 4
and a4, s2, s5
andi a5, s10, 1385
mul a4, s7, s2
ori a7, s11, -1402
addi a5, s11, 555
mul a0, s0, s4
and a0, s0, s7
bne zero, t4, . + 12
blt t1, t0, . + 12
mul a2, s10, s11
blt t1, t0, . + 12
mul a4, s10, s6
srl a6, s8, s1
sll a1, s3, s6
srl a0, s5, s8
mul a3, s6, s9
sra a2, s10, s9
xori a7, s1, 457
and a6, s11, s6
beq t1, t2, . + 12
and a6, s10, s0
ori a7, s6, 1692
ori a5, s2, -1493
bge t0, t1, . + 16
jalr ra, sp, 204
sra a0, s6, s2
beq t4, t5, . + 24
xor a6, s7, s5
mul a0, s9, s11
bge t0, t1, . + 12
ori a6, s4, 1043
mul a5, s11, s9
or a3, s5, s7
add a6, s10, s3
bge t5, t6, . + 12
mul a5, s4, s5
addi a4, s0, 36
mul a6, s6, s5
sra a4, s3, s1
andi a1, s4, -888
xor a1, s3, s2
xori a5, s8, 668
andi a1, s7, -1881
add a3, s3, s3
sra a2, s3, s3
xori a6, s2, 560
or a7, s2, s9
sll a7, s3, s0
sra a1, s2, s3
andi a2, s7, 293
xori a0, s11, 1117
xor a1, s11, s10
sll a7, s2, s3
bne t4, t5, . + 4
add a4, s9, s3
ori a3, s0, -1604
ori a7, s7, -260
and a0, s4, s0
or a0, s9, s10
sll a6, s3, s2
xori a2, s6, 1436
add a2, s9, s6
xor a5, s5, s9
add a6, s7, s1
mul a1, s11, s4
xor a4, s8, s11
xori a5, s0, -111
and a4, s4, s10
sra a6, s9, s7
add a2, s10, s9
mul a5, s11, s0
or a7, s1, s9
xor a2, s2, s4
ori a4, s11, 339

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
