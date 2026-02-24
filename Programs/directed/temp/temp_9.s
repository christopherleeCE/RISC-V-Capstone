li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, -88
sw s0, 0(zero)
li s0, 8
sw s0, 4(zero)
li s0, -90
sw s0, 8(zero)
li s0, 21
sw s0, 12(zero)
li s0, 92
sw s0, 16(zero)
li s0, 12
sw s0, 20(zero)
li s0, -34
sw s0, 24(zero)
li s0, -74
sw s0, 28(zero)
li s0, 99
sw s0, 32(zero)
li s0, 47
sw s0, 36(zero)
li s0, 97
sw s0, 40(zero)
li s0, -54
sw s0, 44(zero)
li s0, -99
sw s0, 48(zero)
li s0, 23
sw s0, 52(zero)
li s0, 37
sw s0, 56(zero)
li s0, -75
sw s0, 60(zero)
li s0, 58
sw s0, 64(zero)
li s0, 23
sw s0, 68(zero)
li s0, -15
sw s0, 72(zero)
li s0, -43
sw s0, 76(zero)
li s0, -17
sw s0, 80(zero)
li s0, -43
sw s0, 84(zero)
li s0, -39
sw s0, 88(zero)
li s0, 66
sw s0, 92(zero)
li s0, 38
sw s0, 96(zero)
li s0, 49
sw s0, 100(zero)
li s0, 4
sw s0, 104(zero)
li s0, -49
sw s0, 108(zero)
li s0, 45
sw s0, 112(zero)
li s0, 14
sw s0, 116(zero)
li s0, -20
sw s0, 120(zero)
li s0, -26
sw s0, 124(zero)
li s0, 1
sw s0, 128(zero)
li s0, 3
sw s0, 132(zero)
li s0, 67
sw s0, 136(zero)
li s0, -76
sw s0, 140(zero)
li s0, -94
sw s0, 144(zero)
li s0, 7
sw s0, 148(zero)
li s0, -80
sw s0, 152(zero)
li s0, 44
sw s0, 156(zero)
li s0, 49
sw s0, 160(zero)
li s0, 69
sw s0, 164(zero)
li s0, 9
sw s0, 168(zero)
li s0, 70
sw s0, 172(zero)
li s0, -81
sw s0, 176(zero)
li s0, 30
sw s0, 180(zero)
li s0, -42
sw s0, 184(zero)
li s0, -89
sw s0, 188(zero)
li s0, -51
sw s0, 192(zero)
li s0, -90
sw s0, 196(zero)
li s0, -90
sw s0, 200(zero)
li s0, 14
sw s0, 204(zero)
li s0, -31
sw s0, 208(zero)
li s0, 72
sw s0, 212(zero)
li s0, 68
sw s0, 216(zero)
li s0, -48
sw s0, 220(zero)
li s0, 28
sw s0, 224(zero)
li s0, -72
sw s0, 228(zero)
li s0, 56
sw s0, 232(zero)
li s0, 11
sw s0, 236(zero)
li s0, -87
sw s0, 240(zero)
li s0, -4
sw s0, 244(zero)
li s0, -65
sw s0, 248(zero)
li s0, 52
sw s0, 252(zero)

li s0, -1415436451
li s1, 764931491
li s2, 860943880
li s3, -1847663554
li s4, 377396143
li s5, -746060359
li s6, 16831217
li s7, 1359169314
li s8, 1804194459
li s9, 935279857
li s10, 1392287871
li s11, -1984496416

jal sp, . + 4
xor a4, s2, s11
srl a0, s11, s6
xori a6, s11, 1480
mul a1, s11, s11
sra a5, s6, s9
addi a5, s10, 1516
srli a2, s11, 31
and a5, s4, s3
or a4, s6, s3
blt t1, t0, . + 4
or a0, s9, s3
and a2, s5, s2
ori a4, s2, 1261
ori a4, s7, 640
or a1, s9, s2
jalr ra, sp, 72
srai a1, s4, 30
blt t1, t0, . + 20
slt a4, s0, s9
srl a5, s9, s9
sra a4, s4, s7
slli a2, s8, 26
slti a7, s6, -760
mul a2, s10, s2
srai a0, s0, 4
sll a4, s5, s8
sltiu a0, s9, -750
andi a6, s8, 1474
beq zero, t4, . + 4
slti a4, s5, 1540
sltu a0, s0, s1
sltu a1, s3, s0
add a4, s10, s8
slt a6, s3, s0
mul a1, s11, s10
slli a5, s4, 6
or a5, s4, s2
and a0, s3, s5
slti a4, s10, 1449
xori a3, s0, -498
srai a7, s7, 15
blt t6, t5, . + 20
slti a3, s5, 1297
bne t4, t5, . + 4
sltiu a2, s6, 522
and a2, s2, s9
addi a3, s9, -449
srai a5, s0, 17
sltiu a4, s8, -1170
sltu a3, s11, s9
xori a3, s4, -1166
sll a3, s10, s0
xori a7, s6, 646
blt t5, t6, . + 4
xor a5, s9, s8
bne t4, t5, . + 16
sll a0, s11, s2
add a4, s11, s10
and a6, s2, s10
slli a2, s5, 18
beq zero, t4, . + 4
xori a5, s8, -1694
slli a0, s10, 9
bge t6, t5, . + 20
mul a5, s8, s10
sra a4, s7, s6
slli a6, s2, 16
slti a7, s4, -927
sll a5, s10, s8
srai a1, s5, 16
bge t6, t5, . + 16
sll a2, s1, s4
ori a3, s2, 839
beq t1, t2, . + 20
sra a1, s2, s6
bge t0, t1, . + 12
andi a7, s6, -609
sltiu a7, s7, -53
slt a0, s5, s3
sltu a1, s8, s2
bge t6, t5, . + 20
blt t6, t5, . + 20
bne t4, t5, . + 12
blt t1, t0, . + 12
andi a2, s9, -1479
sra a4, s5, s5
srai a0, s6, 2
srl a7, s4, s7
slti a1, s7, -1009
and a0, s9, s7
bne t4, t5, . + 20
slti a5, s10, -27
srl a5, s10, s6
sra a1, s1, s6
mul a4, s11, s6
beq t1, t2, . + 8
and a2, s0, s1
slli a3, s2, 6
xori a5, s4, -1002
add a4, s6, s7

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
