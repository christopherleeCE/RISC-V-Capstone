li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, -60
sw s0, 0(zero)
li s0, -71
sw s0, 4(zero)
li s0, -45
sw s0, 8(zero)
li s0, 88
sw s0, 12(zero)
li s0, 85
sw s0, 16(zero)
li s0, -55
sw s0, 20(zero)
li s0, -11
sw s0, 24(zero)
li s0, 55
sw s0, 28(zero)
li s0, -17
sw s0, 32(zero)
li s0, -54
sw s0, 36(zero)
li s0, 82
sw s0, 40(zero)
li s0, -11
sw s0, 44(zero)
li s0, 99
sw s0, 48(zero)
li s0, 95
sw s0, 52(zero)
li s0, -17
sw s0, 56(zero)
li s0, 11
sw s0, 60(zero)
li s0, -44
sw s0, 64(zero)
li s0, -71
sw s0, 68(zero)
li s0, 12
sw s0, 72(zero)
li s0, 85
sw s0, 76(zero)
li s0, -62
sw s0, 80(zero)
li s0, 56
sw s0, 84(zero)
li s0, -34
sw s0, 88(zero)
li s0, 51
sw s0, 92(zero)
li s0, -34
sw s0, 96(zero)
li s0, 25
sw s0, 100(zero)
li s0, 67
sw s0, 104(zero)
li s0, -61
sw s0, 108(zero)
li s0, 93
sw s0, 112(zero)
li s0, -49
sw s0, 116(zero)
li s0, 2
sw s0, 120(zero)
li s0, 57
sw s0, 124(zero)
li s0, -42
sw s0, 128(zero)
li s0, -90
sw s0, 132(zero)
li s0, -15
sw s0, 136(zero)
li s0, 9
sw s0, 140(zero)
li s0, 74
sw s0, 144(zero)
li s0, -57
sw s0, 148(zero)
li s0, 88
sw s0, 152(zero)
li s0, -85
sw s0, 156(zero)
li s0, -98
sw s0, 160(zero)
li s0, 51
sw s0, 164(zero)
li s0, 50
sw s0, 168(zero)
li s0, 56
sw s0, 172(zero)
li s0, 42
sw s0, 176(zero)
li s0, -13
sw s0, 180(zero)
li s0, 71
sw s0, 184(zero)
li s0, -43
sw s0, 188(zero)
li s0, -100
sw s0, 192(zero)
li s0, -81
sw s0, 196(zero)
li s0, 20
sw s0, 200(zero)
li s0, -27
sw s0, 204(zero)
li s0, -63
sw s0, 208(zero)
li s0, 55
sw s0, 212(zero)
li s0, -59
sw s0, 216(zero)
li s0, 60
sw s0, 220(zero)
li s0, 98
sw s0, 224(zero)
li s0, -54
sw s0, 228(zero)
li s0, 91
sw s0, 232(zero)
li s0, 17
sw s0, 236(zero)
li s0, -15
sw s0, 240(zero)
li s0, -21
sw s0, 244(zero)
li s0, -100
sw s0, 248(zero)
li s0, -9
sw s0, 252(zero)

li s0, 1222881902
li s1, 768762481
li s2, -1359194235
li s3, 1275009651
li s4, 138144836
li s5, -212174200
li s6, 1775248442
li s7, -1022805987
li s8, 200641884
li s9, -1134374893
li s10, -1020647235
li s11, -569163821

jal sp, . + 4
xor a4, s8, s8
bne t4, t5, . + 8
and a6, s6, s5
xor a3, s1, s5
bge t0, t1, . + 20
bge t4, t5, . + 12
and a7, s3, s4
slli a5, s1, 24
slli a4, s9, 24
sra a7, s6, s0
xor a5, s0, s0
bne zero, t4, . + 8
addi a7, s10, -554
srli a0, s7, 9
and a2, s6, s6
slt a1, s0, s6
srli a6, s8, 17
andi a1, s0, 877
sll a5, s0, s0
bne t4, t5, . + 20
slt a6, s9, s11
srli a3, s6, 10
or a2, s5, s1
srai a5, s8, 10
mul a4, s11, s5
sll a2, s1, s5
xor a2, s11, s0
slt a2, s3, s3
slti a6, s7, -1856
sltu a5, s11, s2
xori a3, s3, -1656
andi a3, s5, 1651
or a7, s0, s3
add a6, s10, s8
addi a1, s0, 1121
slt a3, s0, s1
bge t6, t5, . + 16
bge t6, t5, . + 16
sll a3, s1, s4
blt t1, t0, . + 16
srl a6, s10, s6
sltiu a0, s5, -1005
slt a0, s1, s4
add a2, s11, s8
sll a3, s4, s4
sra a3, s5, s0
sltiu a1, s9, 89
bne t1, t2, . + 4
bge t0, t1, . + 16
addi a6, s5, 999
xor a7, s1, s4
sltu a1, s3, s6
sll a5, s9, s7
sltu a2, s7, s1
sltu a6, s2, s11
beq zero, t1, . + 20
srli a3, s2, 8
srli a4, s0, 24
xor a3, s3, s2
slli a6, s9, 26
or a6, s0, s4
mul a6, s9, s2
srli a5, s11, 25
blt t1, t0, . + 4
ori a3, s9, -2005
xor a6, s6, s2
srai a0, s6, 24
mul a3, s4, s10
sll a3, s2, s9
xor a6, s7, s5
addi a0, s4, 1434
slti a2, s0, 707
slt a3, s9, s7
bge t1, t2, . + 4
xori a7, s9, 677
srli a5, s3, 27
xori a4, s4, 73
ori a7, s5, 619
sra a2, s6, s9
srai a0, s6, 24
xor a1, s7, s2
sll a4, s6, s2
and a4, s6, s1
or a6, s10, s8
or a2, s8, s7
bne t1, t2, . + 24
blt t5, t6, . + 12
ori a3, s3, 173
addi a3, s8, -1920
mul a3, s0, s0
bge t1, t0, . + 4
xori a6, s0, -1667
bne zero, t4, . + 16
slti a1, s11, 1790
srl a7, s11, s11
addi a1, s3, 1575
add a2, s1, s4
srli a1, s7, 18
beq t4, t5, . + 12
xori a5, s11, 1719

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
