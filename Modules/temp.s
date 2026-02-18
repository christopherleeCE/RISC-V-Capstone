li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, 56
sw s0, 0(zero)
li s0, -1
sw s0, 4(zero)
li s0, 79
sw s0, 8(zero)
li s0, -24
sw s0, 12(zero)
li s0, -31
sw s0, 16(zero)
li s0, 57
sw s0, 20(zero)
li s0, 83
sw s0, 24(zero)
li s0, -61
sw s0, 28(zero)
li s0, -1
sw s0, 32(zero)
li s0, -9
sw s0, 36(zero)
li s0, 99
sw s0, 40(zero)
li s0, -13
sw s0, 44(zero)
li s0, -20
sw s0, 48(zero)
li s0, -76
sw s0, 52(zero)
li s0, 33
sw s0, 56(zero)
li s0, 78
sw s0, 60(zero)
li s0, 93
sw s0, 64(zero)
li s0, 4
sw s0, 68(zero)
li s0, 15
sw s0, 72(zero)
li s0, -4
sw s0, 76(zero)
li s0, 16
sw s0, 80(zero)
li s0, 79
sw s0, 84(zero)
li s0, -35
sw s0, 88(zero)
li s0, -84
sw s0, 92(zero)
li s0, -79
sw s0, 96(zero)
li s0, 77
sw s0, 100(zero)
li s0, 40
sw s0, 104(zero)
li s0, -95
sw s0, 108(zero)
li s0, -29
sw s0, 112(zero)
li s0, 41
sw s0, 116(zero)
li s0, -27
sw s0, 120(zero)
li s0, 66
sw s0, 124(zero)
li s0, 79
sw s0, 128(zero)
li s0, 49
sw s0, 132(zero)
li s0, -16
sw s0, 136(zero)
li s0, 17
sw s0, 140(zero)
li s0, -24
sw s0, 144(zero)
li s0, 82
sw s0, 148(zero)
li s0, -87
sw s0, 152(zero)
li s0, 3
sw s0, 156(zero)
li s0, 79
sw s0, 160(zero)
li s0, 99
sw s0, 164(zero)
li s0, 45
sw s0, 168(zero)
li s0, 56
sw s0, 172(zero)
li s0, -100
sw s0, 176(zero)
li s0, -56
sw s0, 180(zero)
li s0, 27
sw s0, 184(zero)
li s0, 32
sw s0, 188(zero)
li s0, 21
sw s0, 192(zero)
li s0, 21
sw s0, 196(zero)
li s0, 67
sw s0, 200(zero)
li s0, -8
sw s0, 204(zero)
li s0, -20
sw s0, 208(zero)
li s0, -36
sw s0, 212(zero)
li s0, -29
sw s0, 216(zero)
li s0, 76
sw s0, 220(zero)
li s0, 47
sw s0, 224(zero)
li s0, 69
sw s0, 228(zero)
li s0, 60
sw s0, 232(zero)
li s0, -46
sw s0, 236(zero)
li s0, -82
sw s0, 240(zero)
li s0, -3
sw s0, 244(zero)
li s0, 13
sw s0, 248(zero)
li s0, -22
sw s0, 252(zero)

li s0, -571142326
li s1, 946209579
li s2, 424756409
li s3, -904389207
li s4, 787518353
li s5, 1603553436
li s6, -1356401726
li s7, -750097603
li s8, -2136149565
li s9, -545629729
li s10, -934574418
li s11, -1119275968

jal sp, . + 4
slt a2, s3, s8
bne t1, t2, . + 20
ori a4, s3, -1391
bne zero, t4, . + 16
xori a4, s4, -47
srli a5, s5, 27
xor a7, s0, s6
and a6, s7, s4
bne t4, t5, . + 16
add a3, s1, s1
srl a7, s1, s2
xori a2, s7, 1942
mul a0, s7, s0
srl a7, s7, s10
srl a4, s2, s4
jal ra, . + 24
srli a2, s10, 23
srl a4, s2, s2
beq t4, t5, . + 16
sll a0, s2, s8
sltu a3, s1, s7
sltiu a4, s5, 1751
add a5, s11, s2
srai a1, s1, 2
ori a3, s0, -714
srai a3, s4, 28
ori a0, s9, -167
and a4, s1, s5
srai a0, s7, 2
bge t0, t1, . + 16
or a2, s0, s0
beq zero, t4, . + 20
xori a4, s6, -866
ori a6, s0, -317
mul a1, s6, s9
sra a2, s6, s9
blt t5, t6, . + 16
srli a7, s3, 10
bne t1, t2, . + 4
sra a1, s4, s0
srai a5, s10, 5
beq zero, t4, . + 16
sltu a6, s7, s9
sltu a2, s4, s11
slli a6, s2, 22
srai a0, s0, 14
bne t4, t5, . + 8
sltiu a1, s5, -2017
add a4, s4, s1
mul a0, s10, s0
jalr ra, sp, 224
beq t4, t5, . + 4
slli a5, s8, 29
jalr ra, sp, 220
sll a6, s2, s4
jalr ra, sp, 228
sra a5, s10, s4
addi a1, s7, 1862
addi a4, s8, -1374
sll a3, s3, s1
slli a7, s2, 19
xor a5, s5, s6
bne zero, t4, . + 16
xor a4, s6, s10
xor a1, s2, s7
srl a6, s6, s0
sltu a5, s9, s7
add a0, s4, s11
srli a3, s7, 22
slti a1, s10, 1000
srli a0, s5, 8
slli a1, s0, 30
srli a7, s11, 11
srl a0, s7, s8
sltu a6, s3, s6
srli a5, s0, 2
bge t0, t1, . + 4
slt a6, s8, s6
xor a2, s8, s10
ori a0, s3, -113
ori a1, s5, -1768
jal ra, . + 8
or a7, s2, s1
sltiu a6, s11, -1892
sra a1, s0, s2
srli a1, s6, 8
add a1, s0, s9
bne t4, t5, . + 24
sll a6, s7, s5
sltu a5, s3, s10
xori a0, s1, 854
beq zero, t4, . + 16
blt t1, t0, . + 8
slt a6, s10, s3
srl a0, s7, s8
ori a6, s0, 295
andi a1, s5, 1881
bge t0, t1, . + 8
or a2, s2, s1
andi a6, s8, 1252

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
