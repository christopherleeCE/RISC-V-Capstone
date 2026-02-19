li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 15
sw s0, 0(zero)
li s0, -89
sw s0, 4(zero)
li s0, 0
sw s0, 8(zero)
li s0, 46
sw s0, 12(zero)
li s0, 16
sw s0, 16(zero)
li s0, 79
sw s0, 20(zero)
li s0, 69
sw s0, 24(zero)
li s0, 78
sw s0, 28(zero)
li s0, 21
sw s0, 32(zero)
li s0, 96
sw s0, 36(zero)
li s0, 57
sw s0, 40(zero)
li s0, -47
sw s0, 44(zero)
li s0, 20
sw s0, 48(zero)
li s0, -24
sw s0, 52(zero)
li s0, 56
sw s0, 56(zero)
li s0, -9
sw s0, 60(zero)
li s0, 15
sw s0, 64(zero)
li s0, 83
sw s0, 68(zero)
li s0, 81
sw s0, 72(zero)
li s0, 73
sw s0, 76(zero)
li s0, -30
sw s0, 80(zero)
li s0, 54
sw s0, 84(zero)
li s0, -49
sw s0, 88(zero)
li s0, 61
sw s0, 92(zero)
li s0, -25
sw s0, 96(zero)
li s0, 46
sw s0, 100(zero)
li s0, -74
sw s0, 104(zero)
li s0, -59
sw s0, 108(zero)
li s0, -44
sw s0, 112(zero)
li s0, 16
sw s0, 116(zero)
li s0, 40
sw s0, 120(zero)
li s0, -50
sw s0, 124(zero)
li s0, 57
sw s0, 128(zero)
li s0, -54
sw s0, 132(zero)
li s0, 58
sw s0, 136(zero)
li s0, 94
sw s0, 140(zero)
li s0, 37
sw s0, 144(zero)
li s0, -24
sw s0, 148(zero)
li s0, 50
sw s0, 152(zero)
li s0, 16
sw s0, 156(zero)
li s0, 22
sw s0, 160(zero)
li s0, 16
sw s0, 164(zero)
li s0, -19
sw s0, 168(zero)
li s0, 33
sw s0, 172(zero)
li s0, 3
sw s0, 176(zero)
li s0, 74
sw s0, 180(zero)
li s0, 68
sw s0, 184(zero)
li s0, -50
sw s0, 188(zero)
li s0, 66
sw s0, 192(zero)
li s0, 29
sw s0, 196(zero)
li s0, -5
sw s0, 200(zero)
li s0, 61
sw s0, 204(zero)
li s0, 67
sw s0, 208(zero)
li s0, 66
sw s0, 212(zero)
li s0, 9
sw s0, 216(zero)
li s0, 58
sw s0, 220(zero)
li s0, -87
sw s0, 224(zero)
li s0, -40
sw s0, 228(zero)
li s0, 67
sw s0, 232(zero)
li s0, -65
sw s0, 236(zero)
li s0, 1
sw s0, 240(zero)
li s0, -58
sw s0, 244(zero)
li s0, 50
sw s0, 248(zero)
li s0, -57
sw s0, 252(zero)

li s0, 1233415778
li s1, 629375495
li s2, 1070694028
li s3, 1536505127
li s4, 1342338745
li s5, -1718366019
li s6, -1220483947
li s7, -1052556862
li s8, -176005541
li s9, -1727119196
li s10, 615355495
li s11, -396828162

jal sp, . + 4
mul a5, s8, s6
sra a7, s8, s8
or a4, s11, s11
addi a6, s7, -829
xori a7, s7, 1634
bge t4, t5, . + 24
sll a2, s9, s2
ori a3, s6, 1429
sltiu a3, s10, -2012
srli a3, s3, 20
xor a1, s1, s5
blt t5, t6, . + 4
bne t4, t5, . + 24
add a4, s11, s0
slti a4, s8, 490
slli a5, s8, 20
xor a2, s8, s7
slt a5, s3, s9
addi a7, s10, 230
bne zero, t1, . + 8
sltiu a4, s1, 1190
ori a6, s1, -1872
srai a0, s9, 31
sll a5, s8, s11
srl a5, s3, s8
srl a5, s2, s2
add a0, s2, s11
bge t1, t0, . + 16
bge t1, t0, . + 4
addi a0, s2, -328
mul a4, s0, s9
jalr ra, sp, 136
addi a6, s8, -745
srl a4, s8, s0
srl a0, s4, s3
blt t6, t5, . + 24
ori a6, s0, -62
mul a5, s1, s3
andi a6, s4, 288
mul a6, s10, s7
slti a0, s4, 1952
xori a3, s1, 1727
slti a5, s1, -722
xor a4, s4, s5
srai a1, s11, 3
or a6, s5, s4
slli a2, s4, 21
slli a4, s6, 16
and a0, s10, s7
sltu a5, s9, s6
srl a5, s1, s1
add a7, s6, s5
sra a0, s11, s4
jalr ra, sp, 220
slli a4, s4, 11
sltiu a2, s9, -1245
jalr ra, sp, 244
bne zero, t4, . + 4
addi a0, s11, 1456
srli a1, s3, 19
srai a0, s6, 9
andi a2, s0, -317
and a0, s0, s9
srli a4, s3, 14
and a3, s6, s4
ori a3, s10, -1544
xori a0, s9, 356
xor a3, s3, s6
bge t0, t1, . + 12
sltiu a7, s9, -1797
bge t0, t1, . + 24
srai a7, s6, 7
xori a4, s10, -418
slli a4, s9, 27
mul a1, s8, s2
or a7, s2, s1
slt a4, s10, s0
or a6, s10, s11
mul a3, s3, s2
bne zero, t1, . + 12
bne zero, t1, . + 8
xori a7, s2, 190
jalr ra, sp, 348
andi a6, s10, -1692
sltu a7, s3, s8
slt a4, s0, s5
sltu a6, s4, s7
xor a5, s8, s8
xori a6, s6, -1455
beq zero, t1, . + 16
xor a5, s0, s5
sra a1, s3, s7
bne t4, t5, . + 8
blt t5, t6, . + 8
sltu a1, s9, s3
slli a6, s10, 0
add a4, s11, s8
bge t6, t5, . + 4
bge t1, t2, . + 16
and a7, s6, s10

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
