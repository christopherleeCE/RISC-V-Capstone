li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li s0, -54
sw s0, 0(zero)
li s0, -27
sw s0, 4(zero)
li s0, -2
sw s0, 8(zero)
li s0, 60
sw s0, 12(zero)
li s0, 82
sw s0, 16(zero)
li s0, 73
sw s0, 20(zero)
li s0, -51
sw s0, 24(zero)
li s0, -74
sw s0, 28(zero)
li s0, 16
sw s0, 32(zero)
li s0, 50
sw s0, 36(zero)
li s0, -93
sw s0, 40(zero)
li s0, 4
sw s0, 44(zero)
li s0, -67
sw s0, 48(zero)
li s0, 33
sw s0, 52(zero)
li s0, -76
sw s0, 56(zero)
li s0, -93
sw s0, 60(zero)
li s0, -9
sw s0, 64(zero)
li s0, 6
sw s0, 68(zero)
li s0, -12
sw s0, 72(zero)
li s0, -83
sw s0, 76(zero)
li s0, 21
sw s0, 80(zero)
li s0, -48
sw s0, 84(zero)
li s0, 14
sw s0, 88(zero)
li s0, -83
sw s0, 92(zero)
li s0, 34
sw s0, 96(zero)
li s0, -24
sw s0, 100(zero)
li s0, -55
sw s0, 104(zero)
li s0, 63
sw s0, 108(zero)
li s0, 14
sw s0, 112(zero)
li s0, 54
sw s0, 116(zero)
li s0, -80
sw s0, 120(zero)
li s0, 55
sw s0, 124(zero)
li s0, 74
sw s0, 128(zero)
li s0, -30
sw s0, 132(zero)
li s0, 41
sw s0, 136(zero)
li s0, 74
sw s0, 140(zero)
li s0, -18
sw s0, 144(zero)
li s0, 57
sw s0, 148(zero)
li s0, 47
sw s0, 152(zero)
li s0, -19
sw s0, 156(zero)
li s0, -57
sw s0, 160(zero)
li s0, -30
sw s0, 164(zero)
li s0, -67
sw s0, 168(zero)
li s0, -29
sw s0, 172(zero)
li s0, 88
sw s0, 176(zero)
li s0, -80
sw s0, 180(zero)
li s0, 26
sw s0, 184(zero)
li s0, -68
sw s0, 188(zero)
li s0, 19
sw s0, 192(zero)
li s0, -7
sw s0, 196(zero)
li s0, 71
sw s0, 200(zero)
li s0, -77
sw s0, 204(zero)
li s0, 42
sw s0, 208(zero)
li s0, 7
sw s0, 212(zero)
li s0, -71
sw s0, 216(zero)
li s0, 67
sw s0, 220(zero)
li s0, 21
sw s0, 224(zero)
li s0, 46
sw s0, 228(zero)
li s0, 56
sw s0, 232(zero)
li s0, -57
sw s0, 236(zero)
li s0, 83
sw s0, 240(zero)
li s0, -4
sw s0, 244(zero)
li s0, 61
sw s0, 248(zero)
li s0, -66
sw s0, 252(zero)

li s0, -1587415510
li s1, 270756992
li s2, 1674247266
li s3, -1561401812
li s4, 704482434
li s5, -497835664
li s6, 837953018
li s7, -901841414
li s8, -1488941582
li s9, -388896130
li s10, -1180432786
li s11, -829990695

jal sp, . + 4
xor a2, s0, s1
and a1, s5, s0
xor a3, s2, s7
srl a0, s2, s6
mul a1, s3, s9
xor a4, s3, s2
sra a7, s5, s8
xori a0, s2, -1879
addi a5, s4, 1358
srl a2, s7, s4
xor a3, s6, s4
sll a0, s0, s3
addi a0, s2, 514
and a3, s9, s3
xori a6, s8, 32
bne t1, t2, . + 16
xor a7, s4, s10
bge t6, t5, . + 24
mul a6, s2, s9
sra a5, s10, s5
sra a0, s3, s4
add a7, s9, s7
ori a7, s6, 835
blt t5, t6, . + 12
bne t4, t5, . + 20
ori a7, s4, -1325
sll a0, s10, s0
or a2, s6, s10
mul a6, s0, s5
and a3, s1, s6
mul a1, s2, s4
beq zero, t1, . + 16
addi a0, s2, -1978
or a4, s8, s10
andi a4, s4, 632
bne t1, t2, . + 16
add a0, s7, s1
beq zero, t4, . + 20
bne t4, t5, . + 24
add a7, s5, s2
bge t1, t0, . + 16
srl a0, s9, s11
sll a6, s9, s8
sll a2, s11, s0
xor a7, s10, s7
beq t1, t2, . + 16
and a4, s3, s0
xor a3, s8, s11
mul a2, s5, s0
ori a3, s1, -172
ori a6, s0, -2025
mul a1, s0, s0
addi a2, s1, -701
bne t1, t2, . + 24
ori a3, s4, 417
xori a7, s4, -333
bge t6, t5, . + 12
or a0, s11, s10
or a7, s11, s2
andi a3, s11, 995
jalr ra, sp, 264
beq t1, t2, . + 20
sra a7, s5, s4
srl a7, s6, s4
andi a2, s8, -1427
blt t1, t0, . + 20
xori a3, s9, 405
srl a1, s2, s3
or a2, s2, s3
jalr ra, sp, 288
blt t1, t0, . + 16
beq zero, t1, . + 24
beq zero, t1, . + 8
jal ra, . + 16
add a7, s4, s1
sll a7, s11, s1
ori a7, s9, 978
addi a6, s8, 1456
and a4, s8, s10
ori a7, s9, -767
mul a1, s9, s4
sra a6, s10, s9
addi a2, s1, -1397
andi a1, s0, 778
mul a5, s2, s10
andi a1, s2, 979
or a5, s8, s2
or a2, s8, s0
xori a7, s0, -735
and a2, s10, s6
blt t5, t6, . + 16
andi a5, s2, -1918
jal ra, . + 16
ori a4, s10, -1747
blt t1, t0, . + 16
ori a5, s9, -175
or a7, s10, s2
mul a1, s1, s3
xori a3, s1, -794
sll a3, s3, s4

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
