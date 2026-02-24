li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, -14
sw s0, 0(zero)
li s0, 72
sw s0, 4(zero)
li s0, -90
sw s0, 8(zero)
li s0, 67
sw s0, 12(zero)
li s0, 92
sw s0, 16(zero)
li s0, 99
sw s0, 20(zero)
li s0, 66
sw s0, 24(zero)
li s0, 44
sw s0, 28(zero)
li s0, -39
sw s0, 32(zero)
li s0, -28
sw s0, 36(zero)
li s0, 58
sw s0, 40(zero)
li s0, -17
sw s0, 44(zero)
li s0, 14
sw s0, 48(zero)
li s0, 89
sw s0, 52(zero)
li s0, -81
sw s0, 56(zero)
li s0, 78
sw s0, 60(zero)
li s0, -97
sw s0, 64(zero)
li s0, -3
sw s0, 68(zero)
li s0, 75
sw s0, 72(zero)
li s0, 40
sw s0, 76(zero)
li s0, 48
sw s0, 80(zero)
li s0, 56
sw s0, 84(zero)
li s0, 78
sw s0, 88(zero)
li s0, -90
sw s0, 92(zero)
li s0, 77
sw s0, 96(zero)
li s0, 16
sw s0, 100(zero)
li s0, 47
sw s0, 104(zero)
li s0, 97
sw s0, 108(zero)
li s0, 44
sw s0, 112(zero)
li s0, -5
sw s0, 116(zero)
li s0, 33
sw s0, 120(zero)
li s0, -88
sw s0, 124(zero)
li s0, 25
sw s0, 128(zero)
li s0, 84
sw s0, 132(zero)
li s0, 29
sw s0, 136(zero)
li s0, -88
sw s0, 140(zero)
li s0, -38
sw s0, 144(zero)
li s0, -63
sw s0, 148(zero)
li s0, -14
sw s0, 152(zero)
li s0, 75
sw s0, 156(zero)
li s0, -73
sw s0, 160(zero)
li s0, -78
sw s0, 164(zero)
li s0, 95
sw s0, 168(zero)
li s0, -29
sw s0, 172(zero)
li s0, -67
sw s0, 176(zero)
li s0, 40
sw s0, 180(zero)
li s0, 28
sw s0, 184(zero)
li s0, 15
sw s0, 188(zero)
li s0, -92
sw s0, 192(zero)
li s0, 60
sw s0, 196(zero)
li s0, 86
sw s0, 200(zero)
li s0, -77
sw s0, 204(zero)
li s0, -1
sw s0, 208(zero)
li s0, 40
sw s0, 212(zero)
li s0, 76
sw s0, 216(zero)
li s0, 37
sw s0, 220(zero)
li s0, 82
sw s0, 224(zero)
li s0, -24
sw s0, 228(zero)
li s0, -100
sw s0, 232(zero)
li s0, 0
sw s0, 236(zero)
li s0, 16
sw s0, 240(zero)
li s0, -4
sw s0, 244(zero)
li s0, 72
sw s0, 248(zero)
li s0, 18
sw s0, 252(zero)

li s0, 377124592
li s1, -1341620579
li s2, -1993404819
li s3, -1581995072
li s4, 1110602560
li s5, -683174686
li s6, 755520913
li s7, -1928879784
li s8, -1061932386
li s9, 1191864309
li s10, 859304289
li s11, -829463592

jal sp, . + 4
srai a1, s11, 14
or a2, s3, s9
slti a1, s10, -1415
srl a6, s6, s0
jal ra, . + 24
or a6, s6, s9
beq t4, t5, . + 4
ori a3, s5, 894
xori a4, s5, -1387
sltiu a2, s4, -1803
srl a7, s9, s1
slt a2, s4, s7
slti a2, s2, 1157
sltiu a6, s2, 1344
sra a2, s8, s2
slt a5, s1, s1
jalr ra, sp, 80
beq zero, t4, . + 4
sra a6, s7, s5
blt t5, t6, . + 20
slti a2, s0, 1966
addi a2, s5, -1695
ori a7, s10, 442
ori a4, s7, 404
slti a2, s9, 562
or a5, s2, s1
bge t1, t0, . + 16
srai a6, s4, 6
mul a4, s10, s9
mul a1, s7, s0
beq zero, t4, . + 16
xor a6, s9, s9
or a4, s11, s4
xori a2, s8, 1445
sltiu a7, s3, -1575
xori a1, s1, 1959
sra a3, s4, s3
slli a1, s4, 4
blt t0, t1, . + 16
or a5, s3, s0
xori a7, s1, -1910
bne zero, t1, . + 24
xori a6, s5, -1055
slt a4, s6, s9
srl a4, s6, s1
beq zero, t1, . + 8
bge t1, t0, . + 16
srl a2, s0, s5
slli a7, s10, 25
srl a2, s5, s8
slt a7, s1, s8
sltu a6, s1, s2
addi a1, s3, 1717
or a7, s8, s6
bge t0, t1, . + 16
bne zero, t4, . + 8
srl a7, s9, s1
slti a7, s11, 535
sra a2, s1, s11
srli a6, s9, 21
andi a2, s1, 1914
or a7, s11, s9
ori a6, s8, 867
srl a3, s10, s9
sra a2, s5, s8
slt a1, s7, s10
ori a3, s10, -1340
add a2, s10, s4
srli a6, s8, 14
slti a3, s4, 99
andi a2, s5, -2023
sll a7, s2, s11
add a5, s1, s2
ori a7, s11, 1554
add a4, s3, s1
andi a1, s3, -83
xor a5, s3, s7
bne zero, t4, . + 4
ori a2, s2, -1931
sra a5, s4, s4
slti a5, s10, 1415
xori a4, s7, -2037
bne t4, t5, . + 8
sll a3, s5, s8
slt a6, s9, s1
or a2, s2, s10
sltiu a3, s8, 655
slti a7, s0, 569
sltu a7, s0, s4
slli a5, s11, 19
slti a4, s9, 1714
sll a1, s3, s2
xor a0, s2, s8
slt a4, s9, s4
bge t1, t0, . + 12
xor a4, s6, s2
mul a3, s3, s8
sll a7, s11, s2
slli a4, s7, 10
andi a1, s5, -1418

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
