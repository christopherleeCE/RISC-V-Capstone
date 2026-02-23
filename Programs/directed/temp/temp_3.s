li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 50
sw s0, 0(zero)
li s0, 49
sw s0, 4(zero)
li s0, -31
sw s0, 8(zero)
li s0, -78
sw s0, 12(zero)
li s0, -93
sw s0, 16(zero)
li s0, -43
sw s0, 20(zero)
li s0, 15
sw s0, 24(zero)
li s0, -34
sw s0, 28(zero)
li s0, -53
sw s0, 32(zero)
li s0, -47
sw s0, 36(zero)
li s0, 41
sw s0, 40(zero)
li s0, -26
sw s0, 44(zero)
li s0, 2
sw s0, 48(zero)
li s0, -33
sw s0, 52(zero)
li s0, 51
sw s0, 56(zero)
li s0, 33
sw s0, 60(zero)
li s0, -3
sw s0, 64(zero)
li s0, -25
sw s0, 68(zero)
li s0, 73
sw s0, 72(zero)
li s0, -4
sw s0, 76(zero)
li s0, -56
sw s0, 80(zero)
li s0, -12
sw s0, 84(zero)
li s0, 28
sw s0, 88(zero)
li s0, 100
sw s0, 92(zero)
li s0, 76
sw s0, 96(zero)
li s0, -34
sw s0, 100(zero)
li s0, -21
sw s0, 104(zero)
li s0, 55
sw s0, 108(zero)
li s0, 50
sw s0, 112(zero)
li s0, 2
sw s0, 116(zero)
li s0, 36
sw s0, 120(zero)
li s0, -36
sw s0, 124(zero)
li s0, 7
sw s0, 128(zero)
li s0, 39
sw s0, 132(zero)
li s0, -61
sw s0, 136(zero)
li s0, -55
sw s0, 140(zero)
li s0, 4
sw s0, 144(zero)
li s0, -10
sw s0, 148(zero)
li s0, -64
sw s0, 152(zero)
li s0, 15
sw s0, 156(zero)
li s0, -13
sw s0, 160(zero)
li s0, 50
sw s0, 164(zero)
li s0, 98
sw s0, 168(zero)
li s0, -15
sw s0, 172(zero)
li s0, -18
sw s0, 176(zero)
li s0, 32
sw s0, 180(zero)
li s0, -87
sw s0, 184(zero)
li s0, 65
sw s0, 188(zero)
li s0, -51
sw s0, 192(zero)
li s0, 6
sw s0, 196(zero)
li s0, -52
sw s0, 200(zero)
li s0, 35
sw s0, 204(zero)
li s0, 14
sw s0, 208(zero)
li s0, -38
sw s0, 212(zero)
li s0, 83
sw s0, 216(zero)
li s0, 69
sw s0, 220(zero)
li s0, 15
sw s0, 224(zero)
li s0, 46
sw s0, 228(zero)
li s0, 97
sw s0, 232(zero)
li s0, 89
sw s0, 236(zero)
li s0, 17
sw s0, 240(zero)
li s0, -32
sw s0, 244(zero)
li s0, -20
sw s0, 248(zero)
li s0, 60
sw s0, 252(zero)

li s0, -1268183751
li s1, -402561183
li s2, -1726726579
li s3, 1689685516
li s4, 527981887
li s5, 320373537
li s6, -1017952381
li s7, 1656100437
li s8, -1734091229
li s9, -1158629640
li s10, -995432777
li s11, 1110543807

jal sp, . + 4
slli a1, s0, 11
sra a2, s7, s11
andi a4, s1, -1568
add a3, s0, s4
andi a3, s7, -289
or a0, s8, s3
sltiu a1, s8, -990
sltu a0, s8, s10
add a7, s2, s3
slt a3, s7, s2
xor a4, s8, s7
sltiu a5, s9, -612
xori a1, s8, -744
bge t1, t0, . + 12
srai a4, s4, 5
beq t1, t2, . + 20
blt t0, t1, . + 4
jalr ra, sp, 76
blt t1, t0, . + 8
or a1, s9, s9
sll a4, s3, s6
xori a7, s7, 1479
bne t4, t5, . + 20
slti a2, s8, 1090
blt t6, t5, . + 12
mul a7, s5, s7
sltiu a5, s7, -1581
xor a0, s0, s8
sltu a3, s4, s6
and a7, s6, s0
slt a6, s9, s6
bne zero, t1, . + 24
add a5, s10, s0
srai a0, s4, 24
xor a2, s5, s8
slt a6, s6, s6
sltiu a7, s4, 1387
slti a4, s10, 946
bge t0, t1, . + 24
sra a6, s11, s2
and a5, s8, s3
srai a4, s8, 13
bge t4, t5, . + 24
addi a2, s6, 977
sltiu a7, s2, -1505
blt t6, t5, . + 20
slli a2, s6, 12
slli a5, s11, 13
blt t1, t0, . + 20
slli a3, s1, 31
beq zero, t1, . + 16
srl a2, s7, s6
addi a4, s1, 1056
sltu a3, s0, s5
slti a3, s1, 1919
sltiu a5, s11, -377
mul a6, s6, s8
and a4, s11, s6
slti a6, s10, -1649
bge t6, t5, . + 4
slli a7, s2, 13
srai a5, s4, 24
xor a4, s8, s8
addi a0, s9, -234
xor a5, s11, s3
srl a1, s4, s1
xori a0, s11, -1698
srai a7, s6, 9
sll a0, s10, s6
srai a7, s6, 8
sltu a6, s11, s8
xor a2, s4, s9
slli a6, s2, 4
sra a1, s5, s7
slli a2, s11, 8
or a5, s4, s4
slti a1, s8, 1882
srai a2, s5, 16
srl a7, s10, s4
and a4, s7, s2
sltu a5, s7, s11
ori a6, s6, 640
jal ra, . + 12
mul a6, s10, s0
srli a1, s0, 18
ori a2, s10, -456
and a6, s9, s0
sltu a1, s6, s6
bne zero, t1, . + 4
slt a1, s10, s2
sra a3, s6, s2
srl a0, s6, s2
blt t5, t6, . + 8
slti a2, s10, 133
addi a0, s4, -2014
ori a7, s6, 279
addi a7, s4, -718
and a4, s9, s4
slti a6, s11, -385
beq t4, t5, . + 20

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
