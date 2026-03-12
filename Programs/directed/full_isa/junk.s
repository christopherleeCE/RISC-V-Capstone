	.section .text
	.globl _start
_start:
j main

loop_back:
ret

main:
li t0, 17
li t1, 32
li t2, 32
li t3, 0
li t4, -13
li t5, -13
li t6, -37

li gp, 0x4000

li s0, -43
sw s0, 0(gp)
li s0, 79
sw s0, 4(gp)
li s0, 25
sw s0, 8(gp)
li s0, -83
sw s0, 12(gp)
li s0, 9
sw s0, 16(gp)
li s0, 80
sw s0, 20(gp)
li s0, 75
sw s0, 24(gp)
li s0, -67
sw s0, 28(gp)
li s0, 85
sw s0, 32(gp)
li s0, -76
sw s0, 36(gp)
li s0, 33
sw s0, 40(gp)
li s0, -83
sw s0, 44(gp)
li s0, -71
sw s0, 48(gp)
li s0, 65
sw s0, 52(gp)
li s0, 4
sw s0, 56(gp)
li s0, 6
sw s0, 60(gp)
li s0, -76
sw s0, 64(gp)
li s0, 83
sw s0, 68(gp)
li s0, -14
sw s0, 72(gp)
li s0, 100
sw s0, 76(gp)
li s0, 97
sw s0, 80(gp)
li s0, -39
sw s0, 84(gp)
li s0, 99
sw s0, 88(gp)
li s0, -6
sw s0, 92(gp)
li s0, 83
sw s0, 96(gp)
li s0, 63
sw s0, 100(gp)
li s0, -33
sw s0, 104(gp)
li s0, 13
sw s0, 108(gp)
li s0, -64
sw s0, 112(gp)
li s0, 28
sw s0, 116(gp)
li s0, -49
sw s0, 120(gp)
li s0, 34
sw s0, 124(gp)
li s0, 4
sw s0, 128(gp)
li s0, 86
sw s0, 132(gp)
li s0, -92
sw s0, 136(gp)
li s0, -62
sw s0, 140(gp)
li s0, -39
sw s0, 144(gp)
li s0, 14
sw s0, 148(gp)
li s0, -87
sw s0, 152(gp)
li s0, -7
sw s0, 156(gp)
li s0, 12
sw s0, 160(gp)
li s0, -58
sw s0, 164(gp)
li s0, -53
sw s0, 168(gp)
li s0, 75
sw s0, 172(gp)
li s0, -29
sw s0, 176(gp)
li s0, 2
sw s0, 180(gp)
li s0, 49
sw s0, 184(gp)
li s0, 17
sw s0, 188(gp)
li s0, 76
sw s0, 192(gp)
li s0, -52
sw s0, 196(gp)
li s0, -82
sw s0, 200(gp)
li s0, -47
sw s0, 204(gp)
li s0, 58
sw s0, 208(gp)
li s0, 73
sw s0, 212(gp)
li s0, -16
sw s0, 216(gp)
li s0, -10
sw s0, 220(gp)
li s0, -73
sw s0, 224(gp)
li s0, 72
sw s0, 228(gp)
li s0, -68
sw s0, 232(gp)
li s0, -100
sw s0, 236(gp)
li s0, -98
sw s0, 240(gp)
li s0, -60
sw s0, 244(gp)
li s0, 99
sw s0, 248(gp)
li s0, 53
sw s0, 252(gp)

li s0, 1256908559
li s1, -619798427
li s2, 1718905652
li s3, -1171662457
li s4, 1432063625
li s5, -133353673
li s6, 3300393
li s7, 333919167
li s8, -334121645
li s9, 493469262
li s10, 256029966
li s11, -57730289

li a0, -68
li a1, 158
li a2, 497
li a3, -1199
li a4, 507
li a5, 748
li a6, 575
li a7, 1707

jal sp, . + 4
blt t6, t5, . + 8
remu ra, s3, s4
bne zero, t4, . + 12
jalr ra, zero, 4
sra ra, s10, s7
sll ra, s9, s9
sub ra, s0, s11
div ra, s1, s10
sh s11, 234(gp)
or ra, s11, s9
sub ra, s3, s8
divu ra, s5, s4
mulhsu ra, s3, s2
sw s0, 68(gp)
and ra, s0, s8
div ra, s5, s6
andi ra, s9, -1118
sra ra, s0, s6
bne t1, t2, . + 4
xor ra, s8, s1
lh s9, 110(gp)
bltu t4, t5, . + 16
add ra, s0, s11
bgeu t6, t0, . + 8
lw s6, 204(gp)
bltu t3, t6, . + 8
jalr ra, zero, 4
bgeu t3, t0, . + 12
or ra, s5, s0
sw s1, 220(gp)
sra ra, s1, s9
mulh ra, s7, s1
beq zero, t1, . + 4
srl ra, s5, s11
sh s10, 54(gp)
sltiu ra, a7, 607
bltu t0, t6, . + 4
rem ra, s0, s7
beq zero, t4, . + 8
addi ra, s11, 1507
lhu s2, 252(gp)
mulh ra, s2, s11
bne zero, t1, . + 20
bge t0, t1, . + 8
bltu t0, t6, . + 8
lw s3, 68(gp)
lw s11, 140(gp)
mul ra, s9, s11
mulhu ra, s4, s10
addi ra, s7, 1108
sh s8, 60(gp)
slt ra, s3, s1
or ra, s1, s1
mulhu ra, s4, s10
mulhu ra, s6, s2
srli ra, s7, 24
add ra, s10, s6
auipc ra, 607373
lhu s2, 162(gp)
sw s6, 48(gp)
slti ra, a3, -440
divu ra, s6, s2
sltu ra, s4, s3
lui ra, 772862
sh s5, 128(gp)
lh s0, 96(gp)
sltu ra, s11, s9
div ra, s11, s6
slli ra, s11, 5
lhu s2, 192(gp)
bltu t0, t3, . + 20
lw s2, 236(gp)
sb s1, 69(gp)
lw s0, 204(gp)
and ra, s9, s10
ori ra, s7, -446
xori ra, s2, 1787
mulhsu ra, s1, s11
srli ra, s6, 11
xor ra, s2, s0
addi ra, s4, -725
divu ra, s5, s10
lh s1, 200(gp)
xor ra, s3, s7
slt ra, s9, s6
ori ra, s6, -1352
lw s0, 64(gp)
mulhu ra, s2, s5
jalr ra, sp, 372
and ra, s3, s7
addi ra, s10, 273
or ra, s1, s11
sra ra, s2, s0
ori ra, s4, -131
remu ra, s0, s7
jalr ra, sp, 384
mul ra, s8, s0
mulhsu ra, s0, s0
remu ra, s11, s7
sb s7, 73(gp)
xor ra, s0, s9
lh s5, 172(gp)
sb s8, 1(gp)
rem ra, s10, s0
jal ra, loop_back
bne t4, t5, . + 24
addi ra, s4, -1271
and ra, s7, s8
sub ra, s5, s2
sub ra, s9, s7
sb s7, 216(gp)
mulhsu ra, s2, s2
bltu t6, t0, . + 8
sra ra, s3, s3
jal ra, loop_back
lb s6, 128(gp)
sll ra, s11, s1
mulh ra, s2, s6
slli ra, s6, 7
slt ra, s4, s9
srai ra, s1, 21
remu ra, s7, s8
sw s1, 252(gp)
srl ra, s9, s0
srli ra, s5, 23
lb s3, 119(gp)
lui ra, 774869
lhu s10, 54(gp)
mulh ra, s7, s9
sltiu ra, a2, 872
srli ra, s11, 0
add ra, s2, s11
mulhsu ra, s7, s11
bgeu t4, t5, . + 16
lui ra, 127270
divu ra, s6, s10
lbu s2, 243(gp)
beq t4, t5, . + 4
slti ra, a2, -463
sltiu ra, a7, 635
or ra, s1, s8
xori ra, s4, -174
addi ra, s5, 131
divu ra, s9, s8
xori ra, s0, -1222
or ra, s2, s11
xor ra, s2, s10
bge t1, t2, . + 4
blt t6, t5, . + 12
mul ra, s2, s9
srai ra, s11, 21
and ra, s7, s2
mulhu ra, s7, s0
jalr ra, zero, 4
sw s4, 108(gp)
jalr ra, zero, 4
div ra, s7, s1
divu ra, s10, s9
beq t4, t5, . + 20
sh s6, 46(gp)
auipc ra, 399609
auipc ra, 461027
sb s4, 91(gp)
rem ra, s2, s10
lhu s0, 232(gp)
xor ra, s5, s4
bge t0, t1, . + 4
bne t4, t5, . + 12
sb s10, 121(gp)
srli ra, s1, 23
add ra, s1, s9
mul ra, s9, s11
xor ra, s0, s6
mul ra, s7, s11
slt ra, s10, s4
div ra, s10, s6
srai ra, s7, 19
slli ra, s4, 17
auipc ra, 226900
bgeu t3, t6, . + 20
bltu t4, t5, . + 12
slt ra, s9, s2
blt t1, t0, . + 20
bgeu t1, t2, . + 24
remu ra, s11, s0
or ra, s6, s5
mulh ra, s4, s8
mul ra, s9, s8
add ra, s4, s6
andi ra, s2, -854
lui ra, 388096
rem ra, s9, s4
rem ra, s6, s1
sh s2, 148(gp)
sltu ra, s7, s4
jal ra, . + 20
blt t1, t0, . + 4
or ra, s7, s6
div ra, s2, s7
beq zero, t4, . + 24
div ra, s5, s6
add ra, s9, s7
sll ra, s4, s5
divu ra, s0, s3
bge t0, t1, . + 16
addi ra, s0, 2041
xor ra, s9, s5
lui ra, 995953
slt ra, s7, s9
slti ra, a7, 1172
srli ra, s11, 18
bltu t0, t3, . + 4
mulhu ra, s10, s5
xori ra, s3, 1152
rem ra, s7, s4
slli ra, s6, 2
bne zero, t1, . + 16
sb s0, 66(gp)
lbu s1, 109(gp)
lw s3, 124(gp)
jalr ra, zero, 4
mul ra, s4, s5
mulhsu ra, s4, s0
sub ra, s5, s3
mul ra, s5, s3
divu ra, s9, s2
mul ra, s4, s1
srli ra, s5, 22
jal ra, loop_back
sll ra, s11, s0
sw s4, 116(gp)
remu ra, s10, s2
lb s4, 145(gp)
rem ra, s1, s1
xori ra, s6, 1283
bltu t3, t0, . + 20
andi ra, s9, 704
srli ra, s7, 28
xor ra, s2, s1
sltiu ra, a0, 1009
sw s9, 176(gp)
or ra, s10, s1
addi ra, s10, -1438
sub ra, s7, s0
div ra, s2, s6
div ra, s8, s8
addi ra, s1, -1623
sw s9, 96(gp)
sltiu ra, a4, 1892
xor ra, s1, s11
srai ra, s11, 4
srli ra, s5, 31
bgeu t3, t6, . + 16
xor ra, s9, s5
sw s7, 140(gp)
sltiu ra, a5, 1
and ra, s6, s6
xor ra, s2, s8
lui ra, 399981
rem ra, s10, s9
jalr ra, zero, 4
slli ra, s11, 21
mulh ra, s7, s10
add ra, s0, s0
srai ra, s2, 9
srl ra, s6, s3
auipc ra, 567911
blt t0, t1, . + 16
or ra, s8, s8
slli ra, s6, 20
lhu s11, 136(gp)
mulh ra, s4, s6
bge t4, t5, . + 16
ori ra, s9, 841
sra ra, s0, s8
sra ra, s4, s1
lui ra, 215930
auipc ra, 801569
lh s4, 88(gp)
or ra, s7, s1
sltiu ra, a3, 463
sltu ra, s11, s5
lui ra, 325872
bgeu t1, t2, . + 4
lw s10, 44(gp)
andi ra, s9, 609
andi ra, s0, -958
mulh ra, s8, s4
rem ra, s5, s7
mul ra, s1, s1
bltu t6, t0, . + 4
addi ra, s5, 189
add ra, s5, s10
and ra, s9, s4
lbu s4, 48(gp)
ori ra, s9, -1623
sll ra, s11, s1
jalr ra, zero, 4
lw s5, 4(gp)
xori ra, s5, -1581
lw s1, 156(gp)
xor ra, s7, s11
xori ra, s2, -777
sh s0, 98(gp)
sh s5, 10(gp)
bgeu t0, t6, . + 16
or ra, s6, s5
add ra, s10, s10
sw s8, 20(gp)
lw s7, 44(gp)
remu ra, s6, s2
auipc ra, 190544
div ra, s9, s4
bge t0, t1, . + 16
bgeu t0, t3, . + 12
addi ra, s7, -444
lui ra, 863038
bge t0, t1, . + 12
sb s2, 235(gp)
mul ra, s10, s4
or ra, s10, s7
slt ra, s6, s0
or ra, s4, s3
lh s9, 136(gp)
bge t0, t1, . + 12
or ra, s11, s2
srai ra, s7, 12
or ra, s0, s2
lh s0, 106(gp)
bltu t3, t0, . + 8
andi ra, s5, 921
sh s4, 248(gp)
mulh ra, s0, s4
lui ra, 1025636
ori ra, s7, -399
ori ra, s7, -1204
mulhu ra, s1, s5
bltu t3, t6, . + 24
lb s9, 221(gp)
sw s10, 220(gp)
remu ra, s4, s2
add ra, s8, s3
and ra, s6, s0
div ra, s4, s6
mulhu ra, s2, s1
or ra, s10, s9
beq t1, t2, . + 4
ori ra, s3, 855
lh s1, 204(gp)
sll ra, s0, s3
add ra, s4, s2
beq t4, t5, . + 20
slti ra, a6, 125
remu ra, s2, s6
mul ra, s7, s4
and ra, s7, s7
lh s5, 236(gp)
mul ra, s11, s9
sub ra, s5, s1
divu ra, s0, s8
xori ra, s3, -1377
xori ra, s7, 425
lhu s4, 108(gp)
mulh ra, s11, s5
mulh ra, s7, s4
bne zero, t1, . + 8
and ra, s10, s8
andi ra, s0, 2033
bltu t4, t5, . + 4
slt ra, s0, s8
srl ra, s1, s8
mulhsu ra, s0, s3
lui ra, 52563
jalr ra, sp, 1516
lui ra, 768161
sub ra, s7, s6
ori ra, s8, -102
lhu s1, 40(gp)
xori ra, s0, 775
div ra, s10, s8
xor ra, s0, s9
blt t6, t5, . + 8
sll ra, s5, s1
remu ra, s4, s5
auipc ra, 870038
lh s7, 72(gp)
bltu t0, t3, . + 20
addi ra, s7, 1767
slli ra, s4, 18
andi ra, s4, -1498
rem ra, s3, s1
add ra, s2, s2
jalr ra, zero, 4
bltu t6, t0, . + 4
sb s4, 222(gp)
bne zero, t1, . + 4
mulhsu ra, s5, s2
div ra, s8, s2
bge t6, t5, . + 12
srai ra, s11, 7
beq zero, t1, . + 16
sra ra, s7, s6
sh s10, 208(gp)
srai ra, s8, 12
sw s8, 56(gp)
srai ra, s11, 24
bne t1, t2, . + 12
sll ra, s3, s2
bne t1, t2, . + 8
addi ra, s10, -1766
sub ra, s3, s5
rem ra, s5, s2
xor ra, s3, s5
div ra, s7, s1
jalr ra, zero, 4
mul ra, s10, s3
sltiu ra, a5, -291
blt t5, t6, . + 24
blt t5, t6, . + 16
bltu t6, t0, . + 20
andi ra, s5, 470
bge t6, t5, . + 8
auipc ra, 852203
andi ra, s5, -1844
lw s8, 44(gp)
srli ra, s9, 26
andi ra, s7, 19
sh s4, 152(gp)
sll ra, s6, s1
divu ra, s7, s3
sh s5, 168(gp)
srli ra, s11, 31
sra ra, s2, s4
mulhsu ra, s9, s7
lbu s4, 59(gp)
mulhsu ra, s7, s6
sll ra, s8, s8
xor ra, s2, s11
bltu t1, t2, . + 20
xori ra, s0, 1793
sw s2, 104(gp)
bgeu t6, t0, . + 24
lbu s3, 71(gp)
beq t4, t5, . + 8
bne zero, t1, . + 8
slt ra, s11, s7
divu ra, s10, s5
lh s0, 226(gp)
bne zero, t1, . + 8
ori ra, s5, 284
beq zero, t4, . + 20
srai ra, s7, 16
jalr ra, zero, 4
mul ra, s7, s11
or ra, s11, s5
sub ra, s6, s9
div ra, s6, s11
bge t6, t5, . + 4
bgeu t1, t2, . + 8
div ra, s5, s6
xor ra, s5, s11
and ra, s6, s7
srai ra, s1, 6
slli ra, s2, 4
auipc ra, 766306
divu ra, s1, s10
blt t6, t5, . + 16
xori ra, s6, 648
remu ra, s6, s1
jalr ra, sp, 1896
or ra, s11, s6
auipc ra, 543557
mulhu ra, s5, s8
ori ra, s7, -1760
bltu t4, t5, . + 12
lbu s3, 214(gp)
div ra, s10, s0
srli ra, s5, 12
andi ra, s2, -1090
slti ra, a4, 596
sltiu ra, a7, 736
bge t5, t6, . + 24
beq t1, t2, . + 24
add ra, s9, s1
srai ra, s9, 6
xor ra, s9, s1
sub ra, s5, s8
bltu t4, t5, . + 24
sub ra, s9, s1
add ra, s6, s2
sltiu ra, a5, 253
sll ra, s8, s1
xor ra, s5, s3
sw s11, 8(gp)
bltu t0, t6, . + 16
add ra, s3, s7
jalr ra, sp, 2000
or ra, s1, s8
mulh ra, s7, s1
xori ra, s4, -101
slti ra, a1, -759
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
jal sp, . + 4
sra ra, s4, s6
rem ra, s10, s7
slli ra, s3, 17
lui ra, 443984
sra ra, s2, s6
auipc ra, 790795
add ra, s2, s7
sb s0, 130(gp)
remu ra, s10, s1
lhu s0, 226(gp)
remu ra, s2, s7
andi ra, s6, -1923
andi ra, s10, 937
addi ra, s0, -329
andi ra, s10, -1241
add ra, s6, s3
bgeu t3, t6, . + 8
xor ra, s1, s10
lhu s8, 142(gp)
mulh ra, s1, s7
add ra, s4, s11
slt ra, s1, s5
slli ra, s10, 22
lh s9, 92(gp)
slt ra, s5, s1
sh s6, 198(gp)
mulhu ra, s6, s3
blt t1, t0, . + 20
srl ra, s10, s7
srli ra, s11, 2
xor ra, s9, s9
sh s9, 20(gp)
sra ra, s2, s8
blt t5, t6, . + 24
mulhsu ra, s8, s2
jalr ra, sp, 152
or ra, s10, s4
bltu t6, t0, . + 8
bltu t6, t3, . + 12
lui ra, 152303
lui ra, 1004032
ori ra, s3, 1528
mulhu ra, s8, s2
add ra, s9, s5
srl ra, s10, s6
bltu t0, t3, . + 8
sw s7, 136(gp)
sll ra, s0, s3
sw s4, 144(gp)
mulh ra, s9, s5
bltu t0, t3, . + 12
addi ra, s5, 213
rem ra, s8, s9
xori ra, s10, 1124
mulh ra, s7, s6
jalr ra, zero, 4
lui ra, 45211
rem ra, s7, s1
div ra, s0, s6
jal ra, loop_back
srai ra, s10, 26
sw s10, 164(gp)
lbu s2, 150(gp)
andi ra, s0, 1951
lw s8, 72(gp)
sra ra, s9, s3
sub ra, s7, s7
slti ra, a4, -1866
divu ra, s8, s11
sub ra, s8, s0
sub ra, s8, s2
slti ra, a4, 1068
auipc ra, 876762
mul ra, s0, s3
ori ra, s11, 1023
mulhsu ra, s5, s7
sw s3, 208(gp)
bgeu t3, t0, . + 16
lui ra, 206762
div ra, s0, s8
slti ra, a3, 234
rem ra, s8, s7
srai ra, s4, 31
bge t6, t5, . + 24
mulh ra, s9, s2
remu ra, s10, s10
lhu s7, 58(gp)
blt t5, t6, . + 8
xori ra, s0, -1961
sltu ra, s11, s5
blt t5, t6, . + 8
slli ra, s5, 9
srl ra, s11, s5
blt t5, t6, . + 4
slti ra, a6, -481
sb s0, 157(gp)
srai ra, s7, 2
blt t1, t0, . + 12
lw s3, 60(gp)
sh s5, 248(gp)
srl ra, s8, s1
sltu ra, s9, s6
bltu t0, t3, . + 20
divu ra, s2, s7
srli ra, s11, 16
mulhsu ra, s0, s5
rem ra, s8, s5
jalr ra, sp, 432
xor ra, s6, s1
srli ra, s10, 12
addi ra, s11, -1405
add ra, s6, s8
srli ra, s0, 11
andi ra, s7, 1868
srli ra, s3, 8
slt ra, s8, s11
sra ra, s7, s9
xor ra, s11, s10
blt t1, t0, . + 8
sll ra, s11, s5
sb s8, 203(gp)
andi ra, s4, -2043
slti ra, a6, -1900
slli ra, s9, 11
slt ra, s1, s6
and ra, s8, s11
sw s10, 176(gp)
slli ra, s6, 6
div ra, s4, s9
sb s2, 64(gp)
addi ra, s1, 174
xori ra, s2, 2013
blt t6, t5, . + 16
remu ra, s11, s9
lb s10, 7(gp)
andi ra, s2, 868
bgeu t3, t0, . + 12
sh s9, 26(gp)
bne t4, t5, . + 24
mul ra, s10, s0
sll ra, s3, s10
jal ra, loop_back
ori ra, s1, -554
xori ra, s0, -1514
sltiu ra, a1, -244
mulhu ra, s6, s1
srl ra, s7, s1
rem ra, s8, s3
srai ra, s4, 24
jalr ra, zero, 4
mulhu ra, s7, s0
lw s7, 84(gp)
mul ra, s2, s11
xor ra, s7, s0
jalr ra, zero, 4
lb s9, 146(gp)
sw s8, 100(gp)
lhu s4, 214(gp)
bltu t6, t0, . + 20
div ra, s6, s1
bltu t3, t6, . + 12
srai ra, s6, 21
divu ra, s5, s3
rem ra, s5, s8
rem ra, s0, s2
auipc ra, 539771
bne zero, t4, . + 24
sltu ra, s8, s6
remu ra, s11, s10
sb s6, 221(gp)
mulh ra, s0, s0
sra ra, s0, s8
sra ra, s11, s9
mul ra, s0, s1
bge t0, t1, . + 16
bltu t3, t0, . + 4
mulh ra, s8, s0
srl ra, s3, s8
ori ra, s8, -1688
sltu ra, s6, s1
bltu t0, t6, . + 8
bge t6, t5, . + 12
sw s3, 72(gp)
sltu ra, s5, s5
slli ra, s5, 15
sh s6, 210(gp)
sltu ra, s8, s1
sltu ra, s7, s6
lui ra, 886771
ori ra, s3, 900
mulh ra, s8, s11
sub ra, s7, s2
lui ra, 1045146
bltu t3, t0, . + 24
bne zero, t4, . + 20
mulh ra, s11, s1
and ra, s1, s8
slli ra, s11, 7
lw s8, 80(gp)
rem ra, s8, s0
bltu t0, t3, . + 4
lw s9, 96(gp)
lbu s6, 233(gp)
bltu t4, t5, . + 16
jalr ra, sp, 820
xor ra, s5, s9
beq zero, t1, . + 24
andi ra, s10, -1297
and ra, s4, s6
mulhsu ra, s5, s3
auipc ra, 792106
xori ra, s1, -353
slti ra, a4, 1658
and ra, s6, s6
bne t4, t5, . + 4
blt t5, t6, . + 12
lbu s11, 21(gp)
sub ra, s9, s9
addi ra, s4, -469
slt ra, s4, s8
or ra, s7, s1
xor ra, s0, s4
addi ra, s6, -240
remu ra, s5, s4
sw s0, 116(gp)
or ra, s5, s5
lw s8, 24(gp)
lhu s7, 124(gp)
srl ra, s5, s5
lbu s7, 194(gp)
slt ra, s3, s5
lui ra, 768379
remu ra, s6, s5
ori ra, s11, -1155
lbu s3, 125(gp)
and ra, s1, s4
sh s6, 220(gp)
slti ra, a7, 599
sw s6, 12(gp)
sltu ra, s5, s8
xori ra, s6, -2025
bne zero, t1, . + 20
sw s7, 176(gp)
and ra, s6, s2
jal ra, loop_back
blt t0, t1, . + 4
lhu s1, 244(gp)
blt t0, t1, . + 12
srai ra, s0, 26
jal ra, . + 4
xori ra, s1, -1140
sub ra, s6, s2
auipc ra, 203360
sh s0, 142(gp)
remu ra, s11, s0
auipc ra, 363772
xor ra, s4, s4
xori ra, s3, 204
sb s3, 148(gp)
sub ra, s1, s6
div ra, s3, s1
sw s7, 92(gp)
auipc ra, 147079
and ra, s6, s6
lui ra, 308057
blt t6, t5, . + 4
lh s6, 166(gp)
and ra, s2, s7
and ra, s2, s2
slti ra, a5, 1172
mul ra, s3, s6
slti ra, a5, 755
jal ra, . + 12
bne t1, t2, . + 12
srai ra, s3, 7
divu ra, s6, s0
sb s7, 52(gp)
sltiu ra, a4, 2002
rem ra, s7, s10
div ra, s6, s6
sltu ra, s4, s11
srai ra, s3, 28
rem ra, s6, s6
jalr ra, zero, 4
beq t4, t5, . + 24
sh s0, 90(gp)
slt ra, s1, s7
beq t1, t2, . + 24
lb s3, 201(gp)
and ra, s9, s6
beq t4, t5, . + 24
sra ra, s5, s6
sw s8, 196(gp)
jal ra, loop_back
xor ra, s10, s1
lb s0, 206(gp)
mulhsu ra, s11, s0
addi ra, s7, -1600
sw s0, 124(gp)
bne t4, t5, . + 20
bgeu t6, t0, . + 12
sub ra, s0, s6
sb s2, 70(gp)
div ra, s2, s11
sltu ra, s2, s11
lui ra, 137005
srl ra, s10, s1
remu ra, s11, s8
sra ra, s7, s2
sb s7, 193(gp)
sub ra, s3, s3
sra ra, s0, s6
mul ra, s1, s4
beq zero, t1, . + 20
slt ra, s2, s11
lbu s7, 200(gp)
lhu s2, 14(gp)
sw s6, 32(gp)
lh s11, 180(gp)
xori ra, s4, -36
sh s0, 224(gp)
addi ra, s4, 1571
sll ra, s2, s1
lui ra, 217240
blt t6, t5, . + 24
and ra, s6, s1
andi ra, s11, -1992
bne t1, t2, . + 12
remu ra, s8, s0
jalr ra, sp, 1340
srai ra, s11, 30
sw s5, 84(gp)
mulh ra, s7, s6
bltu t6, t0, . + 16
beq zero, t1, . + 8
rem ra, s4, s9
mul ra, s2, s5
lbu s0, 219(gp)
sub ra, s5, s5
beq zero, t4, . + 4
sltiu ra, a7, 974
jalr ra, zero, 4
remu ra, s6, s5
lh s8, 194(gp)
blt t0, t1, . + 16
xor ra, s0, s1
auipc ra, 73665
bgeu t3, t6, . + 24
srai ra, s7, 20
lbu s5, 198(gp)
beq zero, t4, . + 24
divu ra, s0, s9
andi ra, s10, -1763
ori ra, s4, 1339
mul ra, s0, s1
sll ra, s1, s1
lhu s8, 114(gp)
mulh ra, s8, s4
add ra, s10, s3
or ra, s5, s0
lw s10, 172(gp)
sra ra, s5, s5
srl ra, s7, s1
mulh ra, s5, s11
sltu ra, s4, s6
lbu s4, 188(gp)
rem ra, s0, s0
blt t0, t1, . + 20
slt ra, s10, s0
lhu s5, 92(gp)
mul ra, s5, s0
mul ra, s3, s5
auipc ra, 631641
bgeu t4, t5, . + 12
sh s9, 222(gp)
mulh ra, s10, s2
divu ra, s6, s3
sh s1, 20(gp)
slt ra, s1, s2
bgeu t6, t0, . + 20
bltu t3, t6, . + 4
lw s0, 144(gp)
or ra, s7, s1
lw s8, 72(gp)
rem ra, s4, s4
andi ra, s0, -752
slti ra, a6, -1025
rem ra, s0, s1
bgeu t0, t6, . + 16
sltu ra, s6, s7
xor ra, s2, s3
beq t1, t2, . + 24
mulhsu ra, s8, s4
sltu ra, s6, s5
blt t6, t5, . + 8
rem ra, s7, s7
blt t1, t0, . + 16
divu ra, s10, s8
xori ra, s1, -755
or ra, s3, s7
srai ra, s0, 14
srli ra, s4, 30
xori ra, s2, 661
mulhu ra, s1, s2
xor ra, s3, s10
blt t0, t1, . + 20
div ra, s8, s9
bne t1, t2, . + 16
xori ra, s1, -956
sw s6, 8(gp)
lui ra, 525374
lh s9, 252(gp)
lhu s0, 64(gp)
sb s6, 47(gp)
add ra, s0, s11
ori ra, s5, 1284
lhu s2, 244(gp)
jal ra, loop_back
bne zero, t4, . + 4
bltu t0, t3, . + 16
srli ra, s9, 20
sub ra, s5, s1
jalr ra, sp, 1708
mulh ra, s6, s7
slli ra, s11, 23
sb s1, 23(gp)
slti ra, a0, -1676
bltu t3, t0, . + 4
sltiu ra, a3, 1789
beq zero, t4, . + 12
lbu s11, 134(gp)
add ra, s3, s6
sltiu ra, a4, -170
srli ra, s1, 21
bne zero, t4, . + 4
lhu s7, 228(gp)
sltiu ra, a0, -1530
lbu s9, 150(gp)
remu ra, s7, s11
beq t1, t2, . + 12
bgeu t0, t3, . + 16
srai ra, s5, 12
lh s5, 112(gp)
slt ra, s1, s7
sb s1, 197(gp)
lhu s11, 134(gp)
jalr ra, zero, 4
sub ra, s8, s4
ori ra, s5, 900
remu ra, s6, s10
sltiu ra, a5, 586
slt ra, s0, s2
bltu t6, t0, . + 24
rem ra, s10, s10
bgeu t0, t6, . + 20
remu ra, s8, s5
xori ra, s6, 759
mulhsu ra, s10, s8
slt ra, s7, s0
lbu s9, 125(gp)
rem ra, s7, s9
bltu t0, t6, . + 8
lui ra, 502852
mul ra, s9, s1
add ra, s2, s5
sll ra, s3, s7
remu ra, s4, s8
and ra, s7, s7
sh s3, 74(gp)
sltiu ra, a2, -1573
sll ra, s3, s8
jalr ra, sp, 1908
andi ra, s2, -1968
sub ra, s8, s0
sll ra, s1, s5
lb s8, 182(gp)
divu ra, s9, s8
srl ra, s4, s11
jal ra, loop_back
jalr ra, sp, 1924
sw s1, 0(gp)
rem ra, s9, s1
sll ra, s4, s9
bne t4, t5, . + 12
lh s5, 8(gp)
blt t6, t5, . + 20
mul ra, s10, s3
bne zero, t1, . + 12
mulh ra, s2, s0
bge t4, t5, . + 8
bltu t0, t6, . + 12
blt t1, t0, . + 20
lb s5, 24(gp)
sb s6, 55(gp)
srai ra, s0, 1
lui ra, 528067
mulh ra, s11, s4
lh s1, 10(gp)
and ra, s4, s4
lhu s11, 24(gp)
slli ra, s2, 21
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
jal sp, . + 4
mulhsu ra, s0, s10
sw s4, 80(gp)
slt ra, s1, s10
bne zero, t4, . + 16
or ra, s0, s7
andi ra, s7, 1485
blt t5, t6, . + 20
div ra, s9, s11
sh s2, 160(gp)
lui ra, 781242
mulhu ra, s2, s1
sltiu ra, a3, 1270
slti ra, a2, 1918
remu ra, s1, s3
mulh ra, s5, s7
mulhu ra, s11, s5
divu ra, s6, s11
add ra, s2, s1
andi ra, s0, -1832
lb s7, 53(gp)
sw s1, 152(gp)
jalr ra, zero, 4
lb s3, 145(gp)
lb s2, 116(gp)
mulhu ra, s2, s2
sltiu ra, a0, 1181
auipc ra, 623096
mul ra, s8, s2
jalr ra, zero, 4
sh s0, 40(gp)
auipc ra, 451561
srl ra, s4, s4
mulhu ra, s3, s10
div ra, s1, s5
remu ra, s2, s9
auipc ra, 759667
mulhu ra, s3, s2
bge t4, t5, . + 8
remu ra, s7, s11
mul ra, s5, s9
srli ra, s1, 15
lbu s4, 151(gp)
sb s3, 133(gp)
mulh ra, s3, s4
divu ra, s0, s8
sw s4, 164(gp)
sw s4, 112(gp)
bge t0, t1, . + 20
sltu ra, s7, s2
beq t4, t5, . + 4
bgeu t0, t3, . + 12
sll ra, s7, s6
bgeu t3, t0, . + 8
lh s10, 92(gp)
or ra, s1, s7
and ra, s5, s0
blt t5, t6, . + 12
rem ra, s10, s4
lw s9, 140(gp)
sw s5, 124(gp)
sw s7, 24(gp)
beq zero, t4, . + 20
bne zero, t1, . + 16
bge t6, t5, . + 12
sb s1, 146(gp)
rem ra, s7, s11
sh s8, 64(gp)
lbu s3, 119(gp)
ori ra, s3, 524
lbu s1, 189(gp)
add ra, s6, s11
remu ra, s9, s1
slt ra, s6, s7
remu ra, s6, s5
remu ra, s1, s2
auipc ra, 917804
lb s6, 39(gp)
beq zero, t4, . + 20
lhu s4, 198(gp)
sb s10, 207(gp)
sltiu ra, a6, 961
lw s7, 172(gp)
sh s7, 214(gp)
mulh ra, s11, s4
auipc ra, 34699
sh s11, 180(gp)
rem ra, s2, s11
srl ra, s9, s6
rem ra, s2, s2
lui ra, 834876
bne zero, t4, . + 8
mulhsu ra, s3, s9
ori ra, s10, 1151
andi ra, s2, -1059
or ra, s1, s11
blt t0, t1, . + 24
mulh ra, s10, s10
lhu s5, 164(gp)
sra ra, s0, s2
sltiu ra, a2, 1075
srli ra, s9, 8
beq zero, t4, . + 4
add ra, s8, s2
beq zero, t1, . + 12
lw s10, 180(gp)
mulhu ra, s10, s5
srl ra, s6, s4
bgeu t3, t0, . + 8
bgeu t3, t6, . + 20
lbu s6, 42(gp)
sltu ra, s9, s0
mul ra, s10, s4
sb s9, 239(gp)
divu ra, s5, s11
lhu s0, 38(gp)
auipc ra, 61319
bge t0, t1, . + 12
srl ra, s3, s5
sltu ra, s0, s9
div ra, s10, s9
sra ra, s10, s8
lh s2, 170(gp)
mulh ra, s6, s7
rem ra, s3, s11
andi ra, s1, 1129
sltiu ra, a2, -1191
xor ra, s9, s4
andi ra, s9, -1729
andi ra, s5, 1038
xori ra, s5, 1103
slli ra, s7, 9
sltiu ra, a4, 387
andi ra, s9, -1665
mulh ra, s5, s4
slt ra, s10, s7
xori ra, s4, -369
sll ra, s1, s11
rem ra, s10, s6
lui ra, 899182
srai ra, s5, 12
blt t5, t6, . + 4
sra ra, s0, s8
and ra, s2, s10
lui ra, 402401
andi ra, s7, 772
blt t1, t0, . + 4
srai ra, s6, 12
lb s8, 16(gp)
remu ra, s2, s4
sh s3, 76(gp)
sh s4, 42(gp)
ori ra, s10, 1581
sltu ra, s9, s6
sltu ra, s11, s9
slt ra, s9, s1
andi ra, s0, 1381
bge t1, t2, . + 20
lh s2, 248(gp)
lui ra, 944751
slli ra, s4, 13
mulhsu ra, s11, s7
mul ra, s9, s3
mulh ra, s1, s9
bge t1, t0, . + 24
sltu ra, s11, s0
mulhsu ra, s0, s10
jal ra, . + 8
sll ra, s2, s4
rem ra, s9, s10
divu ra, s11, s4
lbu s10, 17(gp)
beq zero, t1, . + 4
slli ra, s10, 28
jal ra, . + 24
sb s11, 119(gp)
lui ra, 894486
srli ra, s0, 6
bgeu t0, t3, . + 20
remu ra, s5, s6
bne t4, t5, . + 8
mul ra, s2, s0
srai ra, s5, 25
slti ra, a5, 348
remu ra, s6, s4
lh s8, 186(gp)
sltu ra, s4, s7
auipc ra, 933112
sltu ra, s8, s5
bltu t3, t6, . + 16
sb s0, 233(gp)
slli ra, s5, 9
lb s2, 88(gp)
div ra, s8, s4
sltiu ra, a6, 39
bne t1, t2, . + 8
lhu s8, 200(gp)
ori ra, s10, -73
sub ra, s8, s7
sra ra, s6, s2
blt t5, t6, . + 4
lui ra, 881981
sltiu ra, a1, 1540
jalr ra, sp, 824
mul ra, s5, s11
slti ra, a1, 1587
bge t5, t6, . + 8
srli ra, s0, 4
bge t0, t1, . + 24
bgeu t3, t6, . + 8
sltu ra, s4, s2
slt ra, s1, s11
xori ra, s6, -483
sb s0, 253(gp)
ori ra, s0, -505
lhu s6, 198(gp)
beq t1, t2, . + 24
lw s5, 4(gp)
blt t6, t5, . + 20
bne zero, t4, . + 8
sb s9, 58(gp)
remu ra, s7, s2
div ra, s0, s7
mulhsu ra, s10, s11
sb s7, 231(gp)
mulh ra, s1, s9
lhu s10, 158(gp)
jalr ra, zero, 4
blt t6, t5, . + 24
div ra, s10, s10
xori ra, s3, -1269
divu ra, s6, s7
ori ra, s5, 2004
mul ra, s6, s8
lw s11, 84(gp)
slti ra, a1, -2000
divu ra, s8, s8
ori ra, s1, -1152
bltu t0, t6, . + 4
slli ra, s5, 10
ori ra, s8, -1409
beq zero, t1, . + 8
srl ra, s2, s0
ori ra, s1, -815
srai ra, s0, 5
sb s4, 200(gp)
addi ra, s1, 1107
div ra, s1, s10
mulhu ra, s2, s6
or ra, s8, s11
andi ra, s3, 1845
jal ra, . + 12
sltiu ra, a1, -1145
sub ra, s5, s5
lw s6, 180(gp)
andi ra, s4, -1025
mul ra, s3, s10
ori ra, s2, 227
rem ra, s2, s6
mulh ra, s1, s7
lw s11, 236(gp)
or ra, s8, s8
bge t0, t1, . + 12
mulhsu ra, s11, s9
bne zero, t1, . + 24
sltiu ra, a6, -2003
sra ra, s8, s0
lhu s11, 118(gp)
jalr ra, sp, 1084
and ra, s2, s1
bge t1, t2, . + 4
lb s5, 60(gp)
mulh ra, s0, s2
mulh ra, s11, s11
rem ra, s9, s3
mulhu ra, s10, s1
srai ra, s8, 9
sb s5, 191(gp)
sw s11, 200(gp)
srl ra, s1, s11
ori ra, s9, 1285
sub ra, s7, s4
remu ra, s2, s6
sll ra, s8, s4
sh s10, 198(gp)
lbu s0, 21(gp)
sra ra, s10, s9
bgeu t3, t6, . + 20
xor ra, s4, s8
jal ra, loop_back
mulhsu ra, s0, s8
sub ra, s5, s2
sltiu ra, a1, 593
auipc ra, 613534
andi ra, s11, -86
sra ra, s10, s11
srl ra, s10, s1
slli ra, s0, 30
sub ra, s5, s9
xor ra, s6, s3
mul ra, s6, s0
or ra, s3, s2
sltu ra, s8, s10
remu ra, s4, s3
srli ra, s1, 7
sub ra, s9, s1
bltu t0, t3, . + 12
sltiu ra, a0, -477
jal ra, . + 20
sh s8, 164(gp)
srli ra, s5, 10
lw s9, 128(gp)
sltu ra, s7, s0
slli ra, s5, 27
lb s7, 163(gp)
mulh ra, s6, s7
slli ra, s11, 20
mul ra, s7, s6
or ra, s6, s3
rem ra, s10, s10
divu ra, s11, s5
srli ra, s1, 16
mulhu ra, s6, s4
srl ra, s9, s10
lw s10, 28(gp)
lh s3, 108(gp)
sw s2, 160(gp)
sltu ra, s8, s8
rem ra, s1, s6
rem ra, s10, s5
lw s0, 212(gp)
sub ra, s3, s4
mulhsu ra, s5, s7
bge t6, t5, . + 4
sltiu ra, a7, 1350
addi ra, s0, -77
bne zero, t4, . + 24
bgeu t3, t6, . + 20
sll ra, s2, s7
sb s0, 145(gp)
sra ra, s3, s6
lui ra, 834748
slt ra, s7, s1
blt t0, t1, . + 20
mulh ra, s11, s0
sub ra, s9, s9
add ra, s2, s0
sb s1, 178(gp)
lb s5, 94(gp)
addi ra, s1, -487
slt ra, s6, s11
lbu s1, 232(gp)
sb s1, 87(gp)
divu ra, s5, s0
mulh ra, s6, s11
mul ra, s1, s3
lbu s0, 9(gp)
ori ra, s7, 544
jal ra, . + 16
mulh ra, s10, s11
mulhu ra, s5, s3
srai ra, s4, 9
sll ra, s6, s2
srli ra, s4, 18
remu ra, s7, s4
add ra, s8, s0
rem ra, s5, s5
sltu ra, s0, s6
jalr ra, sp, 1472
jalr ra, zero, 4
lbu s2, 214(gp)
mul ra, s3, s3
addi ra, s3, -1844
divu ra, s3, s0
mulhu ra, s2, s9
sltiu ra, a1, 566
mulhsu ra, s7, s0
sub ra, s8, s5
ori ra, s3, -1631
srl ra, s8, s3
mulhu ra, s3, s7
sub ra, s4, s1
sb s1, 207(gp)
srl ra, s6, s5
addi ra, s5, -731
srl ra, s11, s4
lbu s7, 214(gp)
sra ra, s8, s2
srl ra, s7, s9
mulhsu ra, s10, s3
lui ra, 1022925
mul ra, s10, s7
bne t1, t2, . + 16
srli ra, s10, 14
xori ra, s5, -1369
lbu s10, 221(gp)
mulh ra, s9, s3
jal ra, . + 4
andi ra, s1, -505
jalr ra, zero, 4
sub ra, s10, s10
ori ra, s3, 1149
sh s9, 176(gp)
jal ra, loop_back
divu ra, s9, s6
srli ra, s8, 7
lh s11, 178(gp)
bge t4, t5, . + 4
lw s6, 128(gp)
slti ra, a4, -740
div ra, s2, s9
jal ra, . + 4
mul ra, s5, s8
srl ra, s9, s3
auipc ra, 613662
xor ra, s8, s2
sb s1, 202(gp)
sltiu ra, a5, 299
jal ra, loop_back
andi ra, s5, -1917
bltu t3, t0, . + 8
sw s0, 196(gp)
sltu ra, s9, s4
div ra, s1, s10
srl ra, s6, s2
lb s0, 245(gp)
lui ra, 733125
jal ra, . + 20
lw s9, 88(gp)
auipc ra, 637294
srai ra, s2, 10
sltiu ra, a6, 434
sltu ra, s6, s4
slli ra, s1, 31
add ra, s8, s11
andi ra, s10, -1244
or ra, s9, s7
sh s9, 42(gp)
andi ra, s2, -1261
ori ra, s10, -255
bne zero, t1, . + 16
sb s10, 117(gp)
bgeu t3, t6, . + 4
blt t6, t5, . + 4
xor ra, s4, s9
blt t6, t5, . + 16
sh s7, 254(gp)
auipc ra, 63612
xori ra, s1, -1450
lw s6, 144(gp)
mul ra, s1, s2
bgeu t3, t6, . + 12
slti ra, a4, 699
bgeu t0, t6, . + 8
srl ra, s9, s7
ori ra, s3, 1959
sb s11, 37(gp)
rem ra, s4, s7
srl ra, s4, s10
or ra, s7, s4
divu ra, s11, s10
bgeu t3, t6, . + 12
xori ra, s0, -947
lbu s6, 22(gp)
andi ra, s10, -339
lb s7, 190(gp)
beq t4, t5, . + 24
sltu ra, s3, s1
sub ra, s9, s1
bltu t0, t3, . + 8
bltu t4, t5, . + 8
slt ra, s8, s7
and ra, s11, s9
bge t6, t5, . + 20
auipc ra, 302278
xor ra, s5, s9
mulhsu ra, s7, s4
beq t4, t5, . + 12
lb s10, 77(gp)
xori ra, s7, 244
bne zero, t4, . + 20
beq t1, t2, . + 20
mulhsu ra, s0, s9
srl ra, s11, s11
andi ra, s8, 491
beq t4, t5, . + 16
ori ra, s3, 1821
mul ra, s8, s4
div ra, s10, s2
add ra, s11, s11
mulhsu ra, s5, s9
slti ra, a0, -296
ori ra, s1, -974
auipc ra, 892515
bgeu t6, t0, . + 16
sb s7, 225(gp)
bgeu t3, t6, . + 16
xori ra, s0, 1245
or ra, s3, s6
mulhu ra, s3, s3
lbu s1, 85(gp)
srli ra, s10, 30
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
jal sp, . + 4
sw s9, 108(gp)
slli ra, s1, 6
rem ra, s4, s6
bltu t1, t2, . + 16
auipc ra, 912627
sra ra, s7, s2
jalr ra, sp, 48
mulhu ra, s2, s0
sw s0, 152(gp)
rem ra, s8, s10
div ra, s10, s6
blt t5, t6, . + 12
slti ra, a2, 1150
lb s1, 90(gp)
bne zero, t4, . + 16
slti ra, a3, -192
auipc ra, 537771
add ra, s4, s7
mulh ra, s5, s6
bge t0, t1, . + 8
sh s6, 24(gp)
rem ra, s5, s0
mulh ra, s2, s9
sb s6, 243(gp)
add ra, s6, s2
sw s1, 224(gp)
jal ra, loop_back
lui ra, 525908
sw s11, 164(gp)
srl ra, s0, s8
andi ra, s8, -458
lh s7, 40(gp)
addi ra, s1, 505
sh s8, 202(gp)
mulhu ra, s11, s10
andi ra, s2, 142
slti ra, a7, 1926
addi ra, s2, 622
mulh ra, s9, s1
lhu s11, 28(gp)
jalr ra, sp, 184
lui ra, 364053
addi ra, s0, 1300
remu ra, s9, s0
slt ra, s11, s7
andi ra, s9, -388
mul ra, s8, s1
sra ra, s10, s1
div ra, s11, s9
slt ra, s4, s7
lhu s10, 72(gp)
rem ra, s7, s5
or ra, s2, s1
div ra, s8, s11
xori ra, s5, -409
div ra, s1, s2
and ra, s1, s4
sra ra, s3, s11
sltiu ra, a4, -1485
srl ra, s4, s4
sb s11, 241(gp)
xori ra, s1, 1200
ori ra, s9, -1746
auipc ra, 248461
mulhsu ra, s4, s9
mulhsu ra, s5, s1
addi ra, s10, 1574
sll ra, s4, s2
lh s5, 100(gp)
jalr ra, sp, 292
sw s9, 0(gp)
sltiu ra, a4, 592
lh s3, 126(gp)
andi ra, s9, 1237
and ra, s10, s10
bgeu t3, t0, . + 16
blt t5, t6, . + 12
add ra, s7, s3
lh s9, 42(gp)
rem ra, s2, s4
slli ra, s11, 3
add ra, s3, s11
auipc ra, 69046
srl ra, s9, s1
srl ra, s11, s8
blt t0, t1, . + 24
sra ra, s8, s11
div ra, s2, s8
auipc ra, 3968
srli ra, s9, 12
xor ra, s1, s6
mul ra, s4, s0
and ra, s7, s3
add ra, s8, s7
rem ra, s7, s8
bgeu t1, t2, . + 12
or ra, s8, s0
sh s9, 204(gp)
sub ra, s3, s0
auipc ra, 60682
mulhu ra, s8, s10
sh s0, 68(gp)
lui ra, 479964
sra ra, s10, s1
xor ra, s9, s5
beq zero, t4, . + 12
remu ra, s9, s8
divu ra, s5, s2
addi ra, s4, -1234
srai ra, s2, 5
blt t1, t0, . + 12
slt ra, s11, s1
beq t1, t2, . + 20
xor ra, s0, s8
srli ra, s10, 11
srl ra, s3, s0
sub ra, s1, s5
lh s5, 114(gp)
beq t1, t2, . + 20
slt ra, s10, s10
ori ra, s10, -1048
sw s4, 28(gp)
andi ra, s7, 1355
sll ra, s6, s6
sw s11, 108(gp)
sll ra, s8, s10
sra ra, s2, s9
xor ra, s1, s9
lw s4, 124(gp)
sw s0, 136(gp)
slt ra, s6, s0
jal ra, loop_back
and ra, s10, s5
mulh ra, s4, s2
sub ra, s6, s1
mul ra, s1, s7
addi ra, s4, 1842
mulhsu ra, s11, s3
mulhu ra, s4, s7
jalr ra, sp, 564
sltu ra, s1, s1
sb s1, 158(gp)
lhu s11, 240(gp)
sra ra, s8, s5
bgeu t3, t0, . + 4
mul ra, s3, s2
bltu t1, t2, . + 16
addi ra, s0, -2005
jal ra, . + 4
mulhsu ra, s2, s10
and ra, s0, s2
sh s11, 214(gp)
divu ra, s2, s4
sltu ra, s8, s8
mul ra, s1, s10
bltu t6, t3, . + 20
or ra, s1, s10
xor ra, s2, s11
sltu ra, s4, s0
lhu s1, 110(gp)
slti ra, a2, 600
jalr ra, sp, 652
mulh ra, s11, s7
ori ra, s9, -1476
sub ra, s6, s10
addi ra, s11, 1931
mulh ra, s1, s1
slt ra, s3, s2
slti ra, a5, 547
lw s6, 32(gp)
bgeu t3, t0, . + 20
mulhsu ra, s3, s11
bne zero, t4, . + 8
ori ra, s8, 956
sh s11, 92(gp)
or ra, s3, s8
srl ra, s9, s11
mulhu ra, s5, s2
jalr ra, zero, 4
sll ra, s6, s8
bne t4, t5, . + 8
srai ra, s10, 6
bne t4, t5, . + 16
jal ra, loop_back
sw s3, 128(gp)
addi ra, s9, -1725
slt ra, s5, s1
add ra, s7, s5
slti ra, a1, -1292
add ra, s2, s5
bltu t3, t6, . + 24
srl ra, s2, s5
remu ra, s11, s6
srli ra, s3, 3
jal ra, loop_back
lhu s7, 140(gp)
lhu s8, 130(gp)
mulhsu ra, s5, s2
rem ra, s0, s2
bge t6, t5, . + 12
addi ra, s1, -1730
sh s3, 26(gp)
mulhu ra, s11, s1
mulhu ra, s0, s8
slti ra, a1, -473
auipc ra, 1012435
mulhsu ra, s4, s3
beq zero, t4, . + 20
mulhu ra, s2, s4
or ra, s9, s8
sra ra, s8, s3
srl ra, s4, s8
auipc ra, 557748
remu ra, s1, s6
sh s1, 192(gp)
bne t4, t5, . + 12
srai ra, s2, 2
ori ra, s0, -816
bgeu t3, t0, . + 4
divu ra, s5, s10
and ra, s1, s2
remu ra, s6, s3
mulhsu ra, s6, s7
sub ra, s7, s4
slli ra, s2, 9
bne zero, t4, . + 4
and ra, s10, s9
sub ra, s8, s6
jal ra, . + 24
sw s7, 204(gp)
sw s7, 108(gp)
auipc ra, 1038392
slti ra, a4, 1546
addi ra, s9, 2022
divu ra, s11, s2
slti ra, a7, -193
andi ra, s10, -1896
srl ra, s3, s4
slli ra, s10, 17
mulhu ra, s3, s11
sw s8, 36(gp)
slt ra, s5, s8
sll ra, s3, s11
sltu ra, s0, s0
mul ra, s11, s7
srl ra, s4, s8
bge t1, t0, . + 8
mulhsu ra, s0, s0
slli ra, s8, 28
lbu s8, 100(gp)
xor ra, s11, s5
mulhu ra, s3, s7
beq t1, t2, . + 24
lw s6, 232(gp)
srli ra, s6, 13
sltiu ra, a4, -1603
ori ra, s3, 356
bge t5, t6, . + 12
sltiu ra, a6, -1785
auipc ra, 627187
lw s3, 208(gp)
remu ra, s10, s1
sub ra, s10, s9
div ra, s3, s8
srai ra, s11, 26
srai ra, s4, 13
or ra, s7, s2
div ra, s5, s1
sub ra, s7, s7
sw s10, 88(gp)
mulhu ra, s8, s10
mulhu ra, s11, s8
xori ra, s4, 9
slti ra, a7, 1779
blt t5, t6, . + 20
lw s9, 160(gp)
div ra, s1, s9
ori ra, s5, -1092
sh s8, 140(gp)
divu ra, s8, s9
mulh ra, s5, s5
lh s7, 212(gp)
xor ra, s11, s10
mulhsu ra, s10, s1
lbu s0, 125(gp)
sra ra, s10, s0
andi ra, s3, 1246
ori ra, s1, -1918
lui ra, 864458
ori ra, s11, 1642
remu ra, s7, s0
divu ra, s2, s5
andi ra, s5, -1991
slli ra, s1, 19
sw s4, 84(gp)
mulhu ra, s1, s10
jalr ra, sp, 1208
div ra, s1, s5
xori ra, s4, 1093
auipc ra, 1002433
or ra, s0, s7
srl ra, s3, s1
slli ra, s7, 3
bne zero, t4, . + 8
sub ra, s9, s2
jalr ra, sp, 1244
bltu t3, t6, . + 12
add ra, s6, s6
jalr ra, sp, 1248
sh s0, 24(gp)
lbu s6, 109(gp)
xori ra, s5, 1811
bge t1, t2, . + 16
bgeu t0, t6, . + 16
lui ra, 687276
sll ra, s7, s4
sh s10, 84(gp)
xor ra, s9, s9
ori ra, s4, 1911
srai ra, s3, 27
sh s1, 60(gp)
sub ra, s10, s4
mulhsu ra, s11, s7
sw s8, 24(gp)
jal ra, loop_back
xori ra, s9, 1162
rem ra, s3, s7
remu ra, s2, s8
bne t4, t5, . + 4
mulhu ra, s6, s2
mulhsu ra, s9, s10
sltiu ra, a2, 431
slt ra, s7, s7
lui ra, 300897
add ra, s1, s5
remu ra, s1, s10
sw s0, 156(gp)
or ra, s5, s7
slt ra, s1, s5
mulhu ra, s2, s6
add ra, s10, s8
sh s1, 18(gp)
add ra, s6, s2
sw s9, 188(gp)
slli ra, s3, 18
srl ra, s10, s7
rem ra, s2, s4
remu ra, s2, s4
jalr ra, sp, 1408
sb s7, 231(gp)
xor ra, s7, s5
slli ra, s4, 12
or ra, s6, s1
auipc ra, 479020
blt t5, t6, . + 8
sub ra, s11, s10
sltiu ra, a3, -7
mulhu ra, s2, s1
sub ra, s1, s9
slt ra, s8, s0
slti ra, a3, -1463
srl ra, s8, s0
lb s3, 100(gp)
beq t1, t2, . + 20
lhu s2, 76(gp)
slti ra, a3, 267
srli ra, s9, 9
and ra, s2, s6
lh s11, 46(gp)
beq t1, t2, . + 16
sub ra, s3, s6
mulhsu ra, s3, s1
lbu s9, 159(gp)
lb s9, 149(gp)
blt t0, t1, . + 8
bne t4, t5, . + 8
bltu t1, t2, . + 24
andi ra, s3, 1434
sw s1, 64(gp)
mulh ra, s7, s2
bge t0, t1, . + 4
lui ra, 85805
sw s9, 148(gp)
jalr ra, sp, 1552
sltiu ra, a0, -1247
slt ra, s4, s6
lb s6, 4(gp)
beq zero, t1, . + 4
blt t6, t5, . + 8
or ra, s2, s1
lb s2, 1(gp)
sub ra, s8, s4
sub ra, s10, s8
slt ra, s1, s4
blt t5, t6, . + 20
mul ra, s2, s0
divu ra, s4, s4
sub ra, s2, s2
lw s10, 208(gp)
and ra, s3, s10
and ra, s5, s10
andi ra, s2, -788
lw s6, 156(gp)
bge t0, t1, . + 4
blt t6, t5, . + 4
div ra, s0, s8
mulh ra, s6, s11
mulhsu ra, s10, s11
andi ra, s5, 239
remu ra, s11, s4
ori ra, s10, -264
xori ra, s6, 8
bge t1, t0, . + 8
slt ra, s7, s11
div ra, s8, s3
ori ra, s5, 832
bge t6, t5, . + 20
blt t0, t1, . + 4
rem ra, s8, s8
and ra, s11, s6
mul ra, s4, s2
add ra, s0, s10
srai ra, s2, 21
srli ra, s1, 31
slti ra, a4, 1175
sub ra, s11, s0
sh s4, 56(gp)
sub ra, s9, s1
divu ra, s10, s1
mulhu ra, s11, s8
slti ra, a7, 413
sb s3, 196(gp)
slti ra, a4, 322
sra ra, s4, s6
slti ra, a3, -992
sh s5, 90(gp)
add ra, s6, s1
mulhsu ra, s11, s3
xori ra, s3, -267
or ra, s0, s6
rem ra, s10, s3
sh s11, 186(gp)
sra ra, s9, s1
bge t1, t0, . + 16
srli ra, s3, 21
beq zero, t1, . + 20
srli ra, s11, 20
slli ra, s0, 31
srai ra, s1, 8
sra ra, s8, s1
mul ra, s5, s9
lw s9, 28(gp)
mulhsu ra, s10, s0
sb s11, 235(gp)
and ra, s8, s8
mul ra, s11, s4
sh s6, 104(gp)
slli ra, s1, 7
addi ra, s3, -257
sh s7, 114(gp)
xor ra, s11, s4
bgeu t6, t0, . + 4
or ra, s11, s5
lbu s9, 129(gp)
mul ra, s6, s5
sh s8, 166(gp)
mul ra, s3, s11
add ra, s11, s8
bge t6, t5, . + 4
rem ra, s7, s11
lhu s0, 162(gp)
srl ra, s7, s11
sltiu ra, a7, 1810
sltiu ra, a1, -584
divu ra, s4, s5
auipc ra, 312030
beq zero, t4, . + 24
xori ra, s9, 160
bltu t6, t3, . + 24
srl ra, s9, s10
bge t0, t1, . + 24
lhu s5, 254(gp)
slti ra, a6, -996
addi ra, s8, -1070
div ra, s9, s2
lb s9, 26(gp)
bge t1, t0, . + 20
slli ra, s11, 31
rem ra, s7, s10
sra ra, s6, s1
lbu s11, 250(gp)
sub ra, s11, s0
sltiu ra, a0, -1894
andi ra, s1, 1507
sltiu ra, a2, 1125
slt ra, s4, s9
slti ra, a0, -289
sra ra, s4, s5
blt t0, t1, . + 8
sh s0, 238(gp)
rem ra, s1, s10
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
jal sp, . + 4
auipc ra, 853014
bne t1, t2, . + 4
sltiu ra, a5, -1035
sb s7, 103(gp)
or ra, s4, s2
xor ra, s8, s0
bgeu t1, t2, . + 20
divu ra, s4, s9
lh s6, 236(gp)
slt ra, s0, s5
sltu ra, s7, s11
sw s6, 228(gp)
slt ra, s9, s9
slti ra, a5, -784
divu ra, s6, s2
beq zero, t1, . + 12
xori ra, s11, 40
bne t4, t5, . + 12
mulh ra, s7, s5
andi ra, s11, -635
srl ra, s3, s9
slti ra, a6, -959
slti ra, a1, -290
jalr ra, sp, 112
bltu t1, t2, . + 20
rem ra, s6, s2
slt ra, s9, s1
mulh ra, s11, s11
bltu t1, t2, . + 24
div ra, s10, s9
slt ra, s2, s1
blt t6, t5, . + 20
bltu t3, t6, . + 24
and ra, s2, s7
andi ra, s11, 194
div ra, s10, s4
srli ra, s5, 3
slti ra, a1, 1444
slli ra, s6, 28
sltiu ra, a3, -418
xor ra, s5, s2
bltu t3, t0, . + 16
sub ra, s11, s4
mul ra, s0, s5
mul ra, s6, s5
jal ra, loop_back
lh s2, 244(gp)
xori ra, s4, -30
bge t1, t0, . + 4
sltu ra, s9, s7
bge t5, t6, . + 8
beq zero, t4, . + 24
ori ra, s3, 1557
srai ra, s6, 10
and ra, s0, s3
srai ra, s7, 3
mulhu ra, s4, s2
rem ra, s0, s10
bgeu t1, t2, . + 12
andi ra, s10, -255
div ra, s4, s7
bltu t1, t2, . + 12
xor ra, s6, s9
sw s8, 48(gp)
add ra, s4, s5
lb s2, 26(gp)
or ra, s3, s1
xori ra, s1, 213
jalr ra, zero, 4
ori ra, s3, -907
sub ra, s8, s11
xor ra, s7, s5
slli ra, s3, 3
addi ra, s7, -368
sll ra, s7, s1
bgeu t3, t0, . + 16
blt t6, t5, . + 4
bge t0, t1, . + 4
sh s3, 14(gp)
div ra, s7, s8
beq t1, t2, . + 4
divu ra, s0, s3
ori ra, s7, 782
beq t1, t2, . + 8
mul ra, s9, s1
xor ra, s1, s3
lh s11, 168(gp)
jalr ra, zero, 4
lw s0, 176(gp)
slt ra, s8, s8
ori ra, s3, 1076
mulhu ra, s5, s2
divu ra, s9, s6
beq zero, t1, . + 12
bltu t3, t6, . + 8
xor ra, s11, s1
bgeu t3, t0, . + 20
sltiu ra, a7, 1062
xor ra, s6, s1
addi ra, s4, 1164
ori ra, s4, -606
lui ra, 885238
sltu ra, s9, s10
lb s1, 220(gp)
rem ra, s2, s11
addi ra, s1, -1159
beq t1, t2, . + 12
sw s8, 140(gp)
auipc ra, 829473
rem ra, s2, s5
sub ra, s11, s2
srli ra, s11, 22
add ra, s1, s11
srli ra, s7, 2
lbu s2, 114(gp)
add ra, s10, s9
lw s4, 52(gp)
sh s5, 178(gp)
sb s5, 57(gp)
mulhsu ra, s3, s8
srli ra, s0, 0
addi ra, s9, 631
add ra, s9, s10
bgeu t3, t0, . + 24
add ra, s2, s9
sh s0, 184(gp)
lw s9, 8(gp)
bge t0, t1, . + 24
lb s10, 19(gp)
lui ra, 187990
bltu t3, t0, . + 24
ori ra, s9, -242
bne t4, t5, . + 12
or ra, s8, s3
sll ra, s3, s7
blt t5, t6, . + 12
jalr ra, zero, 4
add ra, s10, s2
bne zero, t1, . + 4
blt t6, t5, . + 4
blt t5, t6, . + 20
mul ra, s4, s7
sh s0, 106(gp)
jal ra, . + 4
mul ra, s7, s9
mulhsu ra, s10, s6
div ra, s2, s0
bltu t3, t0, . + 24
srli ra, s1, 15
bgeu t0, t6, . + 4
beq t4, t5, . + 4
sw s0, 20(gp)
sltu ra, s5, s4
lh s9, 78(gp)
blt t1, t0, . + 20
mulh ra, s7, s11
addi ra, s8, 1546
rem ra, s0, s7
lhu s0, 8(gp)
sra ra, s11, s5
add ra, s1, s1
bne t1, t2, . + 4
blt t6, t5, . + 12
mul ra, s7, s2
sw s0, 100(gp)
sw s6, 172(gp)
jal ra, . + 8
sltu ra, s0, s3
sra ra, s8, s9
slt ra, s1, s4
sw s8, 80(gp)
divu ra, s5, s5
bne t4, t5, . + 24
jal ra, . + 12
blt t0, t1, . + 12
beq zero, t1, . + 20
slti ra, a6, 1697
slti ra, a7, 1077
add ra, s6, s6
lb s7, 245(gp)
sh s7, 14(gp)
jalr ra, sp, 736
mulhsu ra, s5, s8
srl ra, s5, s8
sltu ra, s8, s0
slt ra, s4, s8
sltu ra, s6, s7
rem ra, s9, s10
sb s5, 108(gp)
sll ra, s11, s3
bne t1, t2, . + 20
jalr ra, sp, 768
sh s9, 226(gp)
jal ra, . + 20
sw s5, 8(gp)
slti ra, a6, 1369
bne zero, t4, . + 16
srai ra, s4, 16
lhu s11, 168(gp)
bne t1, t2, . + 12
sub ra, s1, s8
slti ra, a4, 1087
sltiu ra, a2, -1126
jal ra, . + 24
bgeu t3, t0, . + 20
lbu s6, 18(gp)
beq zero, t1, . + 16
slt ra, s2, s6
slli ra, s1, 22
bne t4, t5, . + 24
sltiu ra, a5, 1000
sh s7, 68(gp)
beq zero, t4, . + 24
sw s3, 28(gp)
bne zero, t4, . + 12
divu ra, s9, s10
lh s1, 202(gp)
sltiu ra, a2, 1026
bgeu t3, t6, . + 16
divu ra, s7, s5
mulh ra, s8, s9
jalr ra, sp, 900
addi ra, s9, -1284
or ra, s1, s1
slt ra, s3, s1
bgeu t6, t0, . + 24
bge t0, t1, . + 4
auipc ra, 6613
rem ra, s5, s2
andi ra, s5, -1387
lui ra, 293271
andi ra, s3, -34
addi ra, s9, -1183
rem ra, s7, s7
xor ra, s2, s7
slt ra, s2, s4
sltu ra, s8, s2
bltu t0, t6, . + 24
slli ra, s6, 26
sub ra, s10, s1
slti ra, a5, 610
ori ra, s4, 1311
remu ra, s11, s10
lui ra, 939279
jal ra, . + 4
sltu ra, s7, s10
mulh ra, s0, s0
bgeu t0, t6, . + 8
remu ra, s8, s4
slt ra, s5, s5
mulh ra, s7, s4
remu ra, s8, s11
sw s11, 192(gp)
mulhsu ra, s11, s10
sub ra, s10, s8
sw s4, 148(gp)
lui ra, 396872
rem ra, s6, s1
rem ra, s0, s3
ori ra, s6, -500
add ra, s3, s9
lui ra, 80248
blt t6, t5, . + 20
bltu t0, t6, . + 4
remu ra, s1, s5
mulhu ra, s1, s2
div ra, s10, s4
mulh ra, s5, s11
bge t0, t1, . + 12
add ra, s5, s7
bgeu t3, t0, . + 8
beq zero, t4, . + 4
add ra, s6, s8
auipc ra, 867458
sra ra, s2, s4
rem ra, s8, s11
or ra, s9, s6
xor ra, s4, s1
and ra, s0, s2
sltiu ra, a1, 362
blt t6, t5, . + 16
bltu t4, t5, . + 8
srli ra, s10, 22
srl ra, s10, s7
ori ra, s6, -424
mulhu ra, s6, s1
sb s10, 80(gp)
sltiu ra, a7, 1024
ori ra, s11, -1918
mulhu ra, s6, s8
bltu t3, t6, . + 20
slti ra, a1, -818
remu ra, s1, s7
andi ra, s8, -1796
lh s2, 186(gp)
sh s4, 0(gp)
sltu ra, s1, s3
slti ra, a5, 1581
lbu s7, 25(gp)
or ra, s3, s6
divu ra, s4, s10
sll ra, s5, s4
srli ra, s7, 7
sw s8, 224(gp)
lb s6, 177(gp)
mulh ra, s0, s11
bge t0, t1, . + 8
xori ra, s3, 1116
mul ra, s4, s5
lui ra, 251841
xori ra, s8, -44
sb s3, 113(gp)
ori ra, s3, -1542
sltu ra, s5, s6
or ra, s11, s6
lui ra, 256832
lbu s0, 28(gp)
or ra, s11, s11
sltiu ra, a4, 863
bltu t3, t0, . + 20
rem ra, s11, s5
sll ra, s0, s3
sw s3, 184(gp)
sll ra, s6, s7
mulhu ra, s1, s10
bne t4, t5, . + 8
jal ra, . + 12
lh s8, 230(gp)
or ra, s0, s6
lh s9, 22(gp)
bne zero, t1, . + 24
sh s7, 70(gp)
srli ra, s6, 21
lw s0, 64(gp)
srl ra, s9, s6
bne zero, t4, . + 4
lh s3, 176(gp)
lbu s0, 88(gp)
sw s3, 32(gp)
auipc ra, 83657
andi ra, s11, -477
remu ra, s5, s10
sra ra, s2, s10
bne zero, t4, . + 20
and ra, s4, s10
slt ra, s0, s6
div ra, s6, s2
bne t4, t5, . + 8
lui ra, 232915
bne t4, t5, . + 24
sll ra, s0, s2
srai ra, s9, 25
jalr ra, zero, 4
div ra, s5, s4
lbu s0, 202(gp)
sra ra, s4, s8
sub ra, s4, s2
addi ra, s9, -1095
ori ra, s2, 851
xor ra, s5, s9
srai ra, s7, 5
lbu s10, 27(gp)
sw s9, 100(gp)
xor ra, s6, s8
lbu s11, 8(gp)
sw s5, 160(gp)
sltiu ra, a5, 1206
rem ra, s1, s10
addi ra, s1, 1152
lh s5, 246(gp)
divu ra, s3, s6
lbu s2, 153(gp)
sra ra, s0, s5
lh s4, 178(gp)
sra ra, s1, s4
and ra, s2, s9
bge t5, t6, . + 24
addi ra, s0, 1416
mulhu ra, s3, s10
rem ra, s10, s3
xori ra, s5, 332
auipc ra, 440955
lw s5, 160(gp)
sb s8, 249(gp)
sh s9, 202(gp)
bltu t1, t2, . + 20
remu ra, s11, s0
bltu t0, t6, . + 4
sra ra, s10, s6
mulhsu ra, s0, s8
lhu s10, 212(gp)
bge t1, t0, . + 20
sub ra, s4, s5
or ra, s7, s10
divu ra, s5, s3
blt t6, t5, . + 12
sub ra, s0, s8
lb s11, 113(gp)
sll ra, s0, s11
slti ra, a3, -1398
beq zero, t1, . + 24
and ra, s9, s3
mulhsu ra, s5, s0
sb s1, 85(gp)
slt ra, s10, s9
lw s3, 104(gp)
addi ra, s11, 1737
bgeu t3, t6, . + 24
sh s8, 88(gp)
sub ra, s11, s0
lh s0, 52(gp)
lb s11, 135(gp)
mulh ra, s3, s9
bltu t1, t2, . + 4
lhu s4, 28(gp)
mul ra, s0, s5
andi ra, s2, 209
lbu s7, 171(gp)
add ra, s0, s4
sltu ra, s2, s9
sra ra, s8, s8
ori ra, s2, 1829
mul ra, s10, s7
mulhu ra, s6, s0
bgeu t0, t3, . + 4
addi ra, s5, 1101
sltu ra, s4, s9
bltu t6, t0, . + 24
srli ra, s6, 18
sw s6, 168(gp)
add ra, s0, s2
slli ra, s8, 4
sh s8, 104(gp)
or ra, s3, s11
slti ra, a5, -1591
blt t1, t0, . + 8
bne t4, t5, . + 16
addi ra, s4, -1259
srai ra, s10, 8
lw s3, 136(gp)
sb s7, 95(gp)
remu ra, s5, s0
divu ra, s0, s6
slt ra, s3, s3
lh s2, 44(gp)
slli ra, s6, 14
xori ra, s10, -13
jal ra, . + 8
bge t0, t1, . + 12
div ra, s10, s1
ori ra, s6, -1182
lhu s6, 202(gp)
bge t1, t0, . + 24
sll ra, s1, s7
rem ra, s11, s9
sb s9, 66(gp)
or ra, s6, s11
sw s1, 200(gp)
remu ra, s9, s7
slt ra, s5, s10
addi ra, s10, -488
add ra, s1, s4
slli ra, s9, 9
mul ra, s7, s11
lh s6, 114(gp)
xori ra, s10, -366
jalr ra, zero, 4
lui ra, 384542
lh s9, 10(gp)
sb s7, 154(gp)
sh s2, 98(gp)
mulhu ra, s6, s10
lbu s10, 186(gp)
div ra, s7, s6
sltiu ra, a5, -982
jal ra, loop_back
mulhsu ra, s8, s8
bge t5, t6, . + 4
remu ra, s6, s5
mulh ra, s7, s2
ori ra, s0, -335
rem ra, s3, s2
sh s3, 44(gp)
lw s5, 160(gp)
sw s3, 68(gp)
sw s5, 56(gp)
auipc ra, 29052
mulh ra, s6, s1
bgeu t0, t6, . + 16
bne t1, t2, . + 20
or ra, s0, s3
jalr ra, sp, 1988
sltu ra, s7, s1
sll ra, s2, s7
srli ra, s6, 27
divu ra, s3, s2
sw s1, 28(gp)
lb s0, 142(gp)
sb s9, 125(gp)
srai ra, s11, 7
xori ra, s4, -315
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
jal sp, . + 4
add ra, s0, s10
bne zero, t4, . + 16
sw s7, 228(gp)
lw s4, 240(gp)
mulh ra, s6, s2
sra ra, s2, s3
mulh ra, s4, s4
and ra, s9, s0
sh s0, 248(gp)
srai ra, s8, 19
sub ra, s5, s10
bge t0, t1, . + 20
jalr ra, sp, 72
lui ra, 137993
lh s2, 112(gp)
beq zero, t1, . + 20
bgeu t0, t3, . + 24
lui ra, 636234
addi ra, s1, 700
bltu t0, t3, . + 16
remu ra, s0, s11
rem ra, s7, s9
srl ra, s2, s3
srli ra, s4, 11
sra ra, s0, s7
jal ra, . + 12
sll ra, s6, s2
blt t0, t1, . + 20
div ra, s2, s6
bne t1, t2, . + 16
lui ra, 587807
sh s11, 208(gp)
sh s3, 24(gp)
ori ra, s6, 482
div ra, s6, s1
mulhsu ra, s10, s11
sra ra, s4, s11
ori ra, s4, -976
lhu s11, 106(gp)
mulhsu ra, s0, s0
xori ra, s10, 755
slli ra, s9, 15
mulhu ra, s0, s3
lb s8, 25(gp)
mulhsu ra, s3, s8
rem ra, s5, s2
lui ra, 305232
mulhsu ra, s11, s1
lb s1, 92(gp)
lh s8, 108(gp)
sh s4, 186(gp)
srai ra, s4, 9
xor ra, s5, s0
addi ra, s0, 833
rem ra, s7, s4
slt ra, s3, s3
sltu ra, s6, s4
add ra, s1, s6
sub ra, s4, s6
sll ra, s11, s10
sb s8, 230(gp)
lw s10, 132(gp)
xor ra, s3, s11
ori ra, s5, 186
bne t1, t2, . + 24
xor ra, s1, s7
and ra, s11, s9
mulhu ra, s4, s2
slt ra, s5, s8
jalr ra, sp, 288
srl ra, s7, s7
mulhsu ra, s4, s6
xori ra, s10, -1926
lb s5, 221(gp)
rem ra, s2, s1
auipc ra, 628281
sll ra, s6, s11
srl ra, s6, s4
remu ra, s0, s10
bltu t6, t0, . + 16
or ra, s7, s5
slt ra, s8, s0
and ra, s6, s6
bne t4, t5, . + 4
xori ra, s11, -1415
lb s7, 187(gp)
and ra, s1, s7
mulhu ra, s2, s10
rem ra, s3, s6
sw s9, 36(gp)
slt ra, s5, s8
sb s4, 225(gp)
bge t0, t1, . + 12
addi ra, s8, -1383
mulh ra, s3, s5
srli ra, s10, 24
slli ra, s7, 8
ori ra, s5, 1974
sb s5, 240(gp)
lh s4, 140(gp)
sll ra, s0, s2
sltiu ra, a5, -74
jal ra, loop_back
srai ra, s1, 13
div ra, s2, s3
sltu ra, s5, s11
mul ra, s3, s9
and ra, s10, s3
auipc ra, 454725
ori ra, s0, -230
rem ra, s5, s9
srai ra, s0, 21
sb s3, 207(gp)
sb s1, 193(gp)
mul ra, s1, s11
and ra, s3, s5
add ra, s3, s3
addi ra, s2, -622
slli ra, s3, 28
bltu t0, t3, . + 20
sll ra, s11, s3
div ra, s9, s2
jalr ra, zero, 4
lb s4, 79(gp)
sw s9, 40(gp)
xor ra, s7, s8
sh s10, 226(gp)
div ra, s10, s10
sltiu ra, a5, 488
add ra, s4, s5
sltu ra, s1, s8
xor ra, s1, s5
andi ra, s2, 1329
mulh ra, s8, s3
bge t5, t6, . + 8
sw s4, 232(gp)
bltu t3, t6, . + 8
lbu s3, 127(gp)
ori ra, s10, -1079
srai ra, s9, 8
sw s2, 152(gp)
div ra, s7, s3
bge t6, t5, . + 12
lui ra, 919877
add ra, s9, s10
srli ra, s1, 4
srai ra, s7, 1
lb s7, 201(gp)
jal ra, . + 8
sltu ra, s4, s7
beq t1, t2, . + 4
divu ra, s8, s8
slli ra, s3, 4
xor ra, s5, s3
rem ra, s11, s6
slli ra, s10, 24
sh s1, 232(gp)
ori ra, s2, -1646
bltu t1, t2, . + 8
mul ra, s3, s2
ori ra, s6, 18
bgeu t1, t2, . + 24
sub ra, s8, s10
sw s3, 144(gp)
remu ra, s6, s6
beq t4, t5, . + 12
srai ra, s1, 24
sll ra, s3, s9
lh s7, 244(gp)
sltiu ra, a2, -1269
or ra, s3, s2
lui ra, 375919
ori ra, s3, 2041
remu ra, s10, s8
bge t5, t6, . + 12
and ra, s5, s2
srl ra, s6, s8
lh s5, 26(gp)
div ra, s7, s5
srai ra, s7, 2
bne t1, t2, . + 24
bltu t6, t0, . + 20
sw s9, 80(gp)
mulhu ra, s6, s5
and ra, s9, s6
sltu ra, s7, s11
mul ra, s10, s7
bne t1, t2, . + 24
bgeu t3, t6, . + 16
blt t0, t1, . + 8
bgeu t0, t6, . + 4
auipc ra, 553362
bge t0, t1, . + 16
andi ra, s2, -1689
jal ra, loop_back
bge t1, t0, . + 20
addi ra, s6, 1235
srai ra, s10, 25
lh s4, 162(gp)
bge t5, t6, . + 12
rem ra, s8, s6
mulhu ra, s10, s1
div ra, s8, s2
mul ra, s2, s10
sltiu ra, a4, -96
blt t5, t6, . + 20
rem ra, s9, s2
and ra, s2, s3
bgeu t0, t6, . + 16
lbu s2, 189(gp)
sltiu ra, a1, 1813
div ra, s2, s7
blt t1, t0, . + 4
addi ra, s1, 1579
sw s8, 88(gp)
xor ra, s8, s2
sll ra, s4, s5
blt t0, t1, . + 24
auipc ra, 259701
ori ra, s7, -1814
sw s0, 252(gp)
beq zero, t1, . + 20
rem ra, s0, s5
remu ra, s3, s10
divu ra, s0, s2
bgeu t0, t6, . + 4
mulhu ra, s4, s10
bge t1, t2, . + 4
sw s2, 124(gp)
bltu t0, t6, . + 12
auipc ra, 217548
and ra, s6, s0
jal ra, . + 4
sra ra, s11, s8
sw s6, 200(gp)
sub ra, s6, s7
sb s11, 55(gp)
sh s8, 58(gp)
sra ra, s6, s0
lbu s1, 198(gp)
xori ra, s1, -1864
addi ra, s0, 1012
srl ra, s10, s8
bge t5, t6, . + 16
andi ra, s1, -1529
mulhsu ra, s1, s3
sub ra, s9, s0
sw s6, 84(gp)
lhu s0, 140(gp)
ori ra, s1, -1635
and ra, s10, s5
mulh ra, s2, s10
sh s9, 154(gp)
slli ra, s10, 8
jalr ra, zero, 4
bne zero, t1, . + 4
bgeu t3, t0, . + 24
bne zero, t4, . + 12
bltu t3, t6, . + 16
xori ra, s9, -700
sub ra, s8, s6
sw s8, 216(gp)
sub ra, s2, s8
beq t4, t5, . + 20
slti ra, a5, 599
sll ra, s8, s2
lui ra, 919765
or ra, s7, s9
div ra, s9, s1
beq t4, t5, . + 12
mulhsu ra, s11, s7
bltu t4, t5, . + 16
or ra, s5, s0
lhu s8, 154(gp)
sub ra, s0, s11
and ra, s0, s1
slti ra, a3, 404
bne t1, t2, . + 16
jalr ra, zero, 4
mul ra, s5, s11
lhu s4, 76(gp)
bgeu t4, t5, . + 12
ori ra, s6, 235
remu ra, s5, s2
lb s1, 102(gp)
beq t4, t5, . + 12
bgeu t3, t6, . + 4
divu ra, s10, s0
srl ra, s7, s6
sub ra, s8, s7
div ra, s10, s8
mul ra, s3, s6
lb s8, 243(gp)
bne zero, t1, . + 12
andi ra, s1, 1730
xori ra, s0, 608
auipc ra, 989411
srai ra, s2, 13
xori ra, s5, 1551
sltiu ra, a7, -86
mulh ra, s4, s4
bltu t3, t6, . + 4
div ra, s5, s6
mul ra, s10, s11
lbu s2, 40(gp)
beq t4, t5, . + 16
mulh ra, s4, s10
auipc ra, 786099
slli ra, s10, 28
blt t0, t1, . + 8
lw s6, 240(gp)
lui ra, 571777
bge t6, t5, . + 16
srai ra, s1, 28
srli ra, s5, 10
srli ra, s5, 29
sh s3, 80(gp)
div ra, s2, s8
srai ra, s7, 1
remu ra, s5, s3
divu ra, s5, s2
sltiu ra, a3, -1726
sh s5, 4(gp)
or ra, s10, s10
bgeu t0, t3, . + 20
rem ra, s8, s11
slt ra, s5, s2
addi ra, s6, -743
lb s4, 243(gp)
sltiu ra, a6, 1113
sll ra, s5, s7
add ra, s8, s6
ori ra, s0, -1663
lb s4, 42(gp)
sltiu ra, a1, -747
xor ra, s6, s3
xor ra, s6, s7
div ra, s2, s0
srai ra, s11, 15
slli ra, s8, 1
and ra, s7, s0
mulh ra, s2, s6
add ra, s6, s11
andi ra, s5, -988
bge t6, t5, . + 8
div ra, s7, s11
beq t4, t5, . + 20
sw s9, 172(gp)
xori ra, s3, -1993
bltu t3, t6, . + 24
bltu t3, t0, . + 12
slti ra, a1, -1040
bge t0, t1, . + 4
sll ra, s10, s3
add ra, s8, s6
addi ra, s10, -46
sltiu ra, a5, 1863
lw s10, 140(gp)
sw s2, 244(gp)
or ra, s11, s11
mul ra, s7, s0
sb s1, 111(gp)
remu ra, s5, s4
sh s0, 194(gp)
and ra, s3, s2
slt ra, s8, s6
jal ra, . + 8
bne zero, t1, . + 12
lw s10, 84(gp)
srai ra, s10, 26
slli ra, s9, 18
mul ra, s2, s4
mulh ra, s5, s5
sb s11, 179(gp)
sltiu ra, a0, 587
bge t6, t5, . + 8
addi ra, s0, -1950
mul ra, s9, s1
bge t0, t1, . + 8
beq t1, t2, . + 4
and ra, s11, s11
slli ra, s3, 19
addi ra, s3, -627
sub ra, s8, s3
mulh ra, s2, s11
sw s3, 196(gp)
addi ra, s9, -1411
mul ra, s2, s4
lw s0, 136(gp)
divu ra, s9, s7
sra ra, s11, s2
jal ra, . + 12
or ra, s10, s3
sh s9, 26(gp)
bne zero, t4, . + 8
bne t4, t5, . + 12
sh s1, 134(gp)
add ra, s8, s3
add ra, s11, s11
srl ra, s11, s9
lui ra, 50447
sltu ra, s8, s7
xori ra, s8, 1925
jalr ra, zero, 4
bgeu t3, t6, . + 12
srai ra, s8, 31
mulhsu ra, s5, s7
srai ra, s3, 24
mulh ra, s3, s8
mulhu ra, s4, s0
sb s7, 200(gp)
sw s8, 252(gp)
sub ra, s2, s7
ori ra, s8, -1927
bltu t1, t2, . + 12
lhu s5, 122(gp)
slli ra, s1, 31
bgeu t3, t6, . + 12
srai ra, s8, 9
lbu s9, 207(gp)
bne zero, t1, . + 16
slt ra, s1, s5
andi ra, s7, -1132
bne t4, t5, . + 12
divu ra, s1, s6
slt ra, s11, s9
blt t5, t6, . + 16
lui ra, 634181
bne t1, t2, . + 4
srli ra, s0, 18
sra ra, s3, s5
mulhu ra, s0, s1
lb s10, 247(gp)
lw s1, 116(gp)
ori ra, s6, -438
mul ra, s9, s3
sb s1, 176(gp)
bltu t6, t0, . + 12
sh s11, 158(gp)
rem ra, s9, s5
lw s8, 16(gp)
slli ra, s10, 31
srli ra, s3, 5
lb s4, 88(gp)
div ra, s5, s8
lh s3, 34(gp)
div ra, s3, s5
xori ra, s5, 1766
sw s5, 192(gp)
jalr ra, sp, 1808
slli ra, s2, 13
lbu s10, 227(gp)
xori ra, s7, 1605
divu ra, s2, s11
sll ra, s4, s2
slli ra, s9, 10
blt t0, t1, . + 16
srai ra, s7, 18
jal ra, . + 20
sltiu ra, a4, 907
bltu t3, t0, . + 24
xori ra, s10, -1881
srli ra, s4, 8
beq zero, t4, . + 20
sh s2, 66(gp)
jal ra, loop_back
sra ra, s10, s10
jal ra, loop_back
beq zero, t1, . + 20
srl ra, s8, s4
sub ra, s1, s8
beq t1, t2, . + 24
and ra, s4, s11
divu ra, s1, s4
srl ra, s3, s3
rem ra, s8, s11
sub ra, s0, s8
srli ra, s5, 14
slli ra, s6, 1
mul ra, s9, s5
jal ra, loop_back
auipc ra, 412443
jalr ra, zero, 4
mul ra, s8, s4
slt ra, s8, s10
sub ra, s0, s3
divu ra, s10, s6
lbu s9, 86(gp)
slti ra, a3, 1866
sh s3, 180(gp)
div ra, s8, s5
remu ra, s3, s7
sltiu ra, a7, 400
auipc ra, 59847
xor ra, s4, s9
rem ra, s7, s8
bgeu t0, t6, . + 16
mulhu ra, s3, s5
bltu t0, t3, . + 24
add ra, s2, s8
remu ra, s8, s2
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
jal sp, . + 4
mul ra, s1, s1
jalr ra, sp, 20
lhu s10, 44(gp)
mulhu ra, s4, s3
divu ra, s8, s5
bltu t3, t0, . + 8
bltu t6, t3, . + 12
xori ra, s3, 163
sw s2, 100(gp)
or ra, s11, s0
xor ra, s10, s4
mul ra, s9, s3
sltu ra, s11, s7
add ra, s7, s9
remu ra, s9, s4
sra ra, s3, s2
slt ra, s10, s0
jalr ra, zero, 4
xori ra, s2, -257
xor ra, s6, s6
sh s3, 22(gp)
srai ra, s0, 30
slli ra, s2, 5
bne zero, t1, . + 12
bgeu t3, t6, . + 24
add ra, s1, s5
lh s8, 0(gp)
lhu s7, 208(gp)
mulhsu ra, s10, s7
ori ra, s5, -1930
auipc ra, 205580
bltu t3, t0, . + 12
sra ra, s6, s11
srl ra, s11, s11
sub ra, s7, s6
rem ra, s4, s4
remu ra, s8, s2
add ra, s9, s8
bgeu t3, t0, . + 8
lui ra, 783204
sltu ra, s5, s1
lb s1, 0(gp)
bgeu t4, t5, . + 12
sltu ra, s3, s4
slli ra, s0, 30
mulh ra, s3, s4
srli ra, s4, 2
jalr ra, sp, 204
sw s3, 64(gp)
sltiu ra, a6, 530
ori ra, s8, -480
xori ra, s4, -527
xor ra, s5, s5
slli ra, s7, 14
mul ra, s4, s10
lb s4, 35(gp)
xor ra, s2, s2
rem ra, s0, s7
xori ra, s9, -1833
mulhu ra, s8, s8
slli ra, s7, 9
ori ra, s10, -700
bne t1, t2, . + 12
rem ra, s7, s10
srli ra, s5, 1
sltu ra, s7, s2
lui ra, 544921
lb s9, 243(gp)
rem ra, s0, s2
blt t5, t6, . + 24
mul ra, s9, s5
slti ra, a2, -1639
bgeu t3, t0, . + 4
sb s11, 186(gp)
sw s6, 192(gp)
slt ra, s6, s1
bltu t0, t6, . + 24
bgeu t0, t6, . + 16
slti ra, a5, -212
jalr ra, sp, 336
rem ra, s0, s6
lw s8, 24(gp)
add ra, s1, s9
mulhu ra, s5, s1
slt ra, s11, s3
blt t6, t5, . + 4
mulhu ra, s2, s8
mulh ra, s8, s8
srli ra, s1, 7
sub ra, s8, s4
srl ra, s9, s4
jal ra, loop_back
rem ra, s11, s11
lw s10, 220(gp)
sh s9, 84(gp)
srl ra, s10, s4
and ra, s0, s0
or ra, s9, s9
bgeu t0, t6, . + 12
and ra, s8, s8
xor ra, s6, s5
div ra, s8, s7
bltu t3, t0, . + 20
sll ra, s7, s6
srli ra, s8, 0
div ra, s7, s0
or ra, s0, s5
jal ra, loop_back
add ra, s11, s4
jalr ra, sp, 456
addi ra, s10, 1740
divu ra, s3, s8
slli ra, s8, 28
mulhu ra, s4, s10
mul ra, s3, s10
bgeu t0, t6, . + 12
sra ra, s9, s11
beq zero, t1, . + 20
xor ra, s3, s2
bltu t0, t6, . + 8
sra ra, s5, s3
beq t4, t5, . + 20
srli ra, s9, 14
auipc ra, 226806
jalr ra, sp, 508
jalr ra, zero, 4
add ra, s0, s0
bltu t3, t6, . + 20
jalr ra, zero, 4
mulhu ra, s4, s10
lb s3, 6(gp)
srli ra, s9, 3
bge t6, t5, . + 24
slti ra, a0, 73
bne t1, t2, . + 8
slti ra, a3, 1446
sltiu ra, a4, 1155
mulh ra, s6, s1
remu ra, s7, s0
srl ra, s7, s9
xori ra, s11, 362
andi ra, s7, -1703
div ra, s11, s5
bge t5, t6, . + 12
sw s11, 60(gp)
sb s9, 130(gp)
blt t0, t1, . + 20
bge t6, t5, . + 16
mulh ra, s8, s7
bge t6, t5, . + 20
lhu s0, 148(gp)
bne zero, t4, . + 8
srli ra, s7, 5
srl ra, s4, s1
bltu t6, t3, . + 20
sra ra, s8, s1
sw s5, 12(gp)
slli ra, s2, 18
add ra, s10, s9
mulhsu ra, s11, s6
lh s7, 130(gp)
bgeu t4, t5, . + 16
srli ra, s0, 8
div ra, s5, s11
sll ra, s5, s0
ori ra, s8, -478
sw s2, 204(gp)
slli ra, s4, 13
bge t0, t1, . + 12
andi ra, s1, 1999
andi ra, s1, 1058
slti ra, a4, -1470
xori ra, s2, 740
srli ra, s9, 27
sra ra, s11, s0
lbu s11, 15(gp)
lui ra, 887238
and ra, s6, s5
sra ra, s3, s0
and ra, s5, s11
jalr ra, zero, 4
sub ra, s4, s7
sltu ra, s2, s1
xor ra, s8, s1
andi ra, s7, 917
sh s10, 248(gp)
mulhu ra, s4, s8
srai ra, s0, 9
bne t4, t5, . + 24
remu ra, s4, s11
sh s6, 56(gp)
xori ra, s0, 1680
mulhsu ra, s1, s5
mulhu ra, s3, s2
bne t4, t5, . + 16
mulh ra, s6, s11
xor ra, s0, s5
mulhsu ra, s7, s9
and ra, s0, s9
jal ra, loop_back
slli ra, s0, 2
mulhu ra, s10, s2
addi ra, s6, -1375
mulhu ra, s9, s5
slli ra, s0, 14
beq t1, t2, . + 4
sb s2, 35(gp)
srli ra, s10, 6
sb s4, 128(gp)
and ra, s1, s0
sll ra, s3, s8
sub ra, s4, s9
lui ra, 923195
divu ra, s11, s5
rem ra, s1, s4
sll ra, s1, s8
rem ra, s8, s2
divu ra, s8, s7
bne t4, t5, . + 12
srl ra, s1, s7
div ra, s3, s8
sw s7, 216(gp)
mulhsu ra, s10, s4
mul ra, s6, s9
lhu s11, 244(gp)
slli ra, s7, 21
bltu t3, t6, . + 8
blt t5, t6, . + 24
sll ra, s5, s7
sub ra, s3, s10
add ra, s3, s3
xor ra, s1, s6
srl ra, s2, s5
beq zero, t1, . + 8
jal ra, loop_back
slt ra, s10, s10
andi ra, s8, -1412
addi ra, s7, 942
remu ra, s2, s6
slt ra, s4, s8
andi ra, s6, 1689
lui ra, 210058
bgeu t0, t6, . + 12
xor ra, s8, s7
slli ra, s6, 5
bne zero, t1, . + 8
srli ra, s0, 4
and ra, s3, s3
slli ra, s6, 0
mulhsu ra, s0, s0
mulhsu ra, s3, s3
sb s3, 96(gp)
lui ra, 190166
mul ra, s3, s5
bne zero, t4, . + 12
slti ra, a4, 127
bne t4, t5, . + 12
srl ra, s0, s3
bne t1, t2, . + 24
blt t1, t0, . + 12
mul ra, s1, s1
slti ra, a6, 1165
sra ra, s4, s8
lb s5, 116(gp)
add ra, s5, s3
div ra, s7, s4
xori ra, s0, -1890
sh s11, 204(gp)
sra ra, s11, s2
or ra, s8, s6
slti ra, a4, -763
div ra, s6, s1
rem ra, s0, s1
sltiu ra, a4, 1437
divu ra, s0, s1
rem ra, s5, s2
auipc ra, 593320
bne zero, t4, . + 16
or ra, s0, s0
add ra, s1, s1
xor ra, s0, s4
srl ra, s9, s7
mul ra, s3, s4
sub ra, s5, s9
lh s0, 154(gp)
mulh ra, s6, s0
srl ra, s8, s9
xori ra, s6, 665
srl ra, s7, s2
sra ra, s11, s10
sll ra, s8, s7
add ra, s4, s3
and ra, s11, s2
slli ra, s1, 2
rem ra, s9, s3
bltu t6, t3, . + 12
xor ra, s7, s7
sub ra, s0, s0
slti ra, a3, 748
srl ra, s0, s3
rem ra, s4, s5
sltiu ra, a1, 111
divu ra, s7, s3
slt ra, s5, s3
beq t4, t5, . + 4
sh s0, 18(gp)
xori ra, s0, 2030
sltu ra, s10, s11
sltu ra, s10, s0
rem ra, s8, s2
rem ra, s4, s4
slt ra, s9, s9
srli ra, s6, 22
bge t1, t0, . + 8
sll ra, s11, s2
srli ra, s0, 17
add ra, s5, s0
mul ra, s4, s5
lb s10, 107(gp)
add ra, s0, s7
bge t5, t6, . + 20
srai ra, s11, 4
ori ra, s4, 1380
lhu s7, 158(gp)
lh s6, 16(gp)
mul ra, s8, s9
and ra, s8, s9
bne zero, t1, . + 12
bne zero, t4, . + 24
sub ra, s0, s5
slli ra, s4, 10
mulhsu ra, s1, s2
addi ra, s7, 143
rem ra, s3, s8
ori ra, s1, 385
andi ra, s9, 73
xor ra, s10, s5
slli ra, s0, 25
lui ra, 571998
andi ra, s6, 171
slti ra, a6, 975
div ra, s9, s5
auipc ra, 114182
sltiu ra, a4, 597
slti ra, a5, -395
mulh ra, s0, s3
add ra, s10, s6
and ra, s4, s6
div ra, s8, s8
bge t4, t5, . + 20
jal ra, . + 16
slli ra, s3, 18
sub ra, s10, s4
remu ra, s5, s3
mulhu ra, s3, s0
bne zero, t1, . + 20
lb s1, 90(gp)
srl ra, s8, s6
div ra, s7, s1
remu ra, s11, s4
bge t6, t5, . + 8
addi ra, s6, 1678
xor ra, s4, s10
sltu ra, s10, s7
addi ra, s11, 1153
mulh ra, s11, s7
lui ra, 549302
srl ra, s9, s5
beq t1, t2, . + 20
remu ra, s5, s6
sltiu ra, a1, -1394
lbu s11, 115(gp)
slli ra, s0, 27
andi ra, s10, 678
bge t5, t6, . + 20
remu ra, s0, s3
sltu ra, s10, s9
sb s2, 214(gp)
sltiu ra, a7, 878
bgeu t3, t6, . + 12
sltiu ra, a1, 1568
sh s0, 170(gp)
sltu ra, s11, s4
mul ra, s0, s1
mul ra, s1, s11
auipc ra, 573727
jal ra, . + 20
bgeu t1, t2, . + 8
sll ra, s5, s10
jal ra, loop_back
xori ra, s6, -1016
jalr ra, sp, 1572
or ra, s1, s11
add ra, s0, s1
sra ra, s9, s1
beq t4, t5, . + 4
beq zero, t1, . + 12
rem ra, s11, s1
mulhu ra, s8, s3
bne t1, t2, . + 24
bltu t4, t5, . + 16
beq t4, t5, . + 20
mulhsu ra, s4, s2
bgeu t0, t6, . + 16
slt ra, s6, s6
mul ra, s6, s9
remu ra, s3, s6
sltiu ra, a5, 2022
bge t6, t5, . + 24
srl ra, s4, s6
blt t0, t1, . + 8
bge t5, t6, . + 4
ori ra, s0, 1892
jalr ra, sp, 1668
bge t4, t5, . + 4
sltu ra, s2, s8
rem ra, s6, s8
or ra, s10, s5
sh s11, 158(gp)
lui ra, 162103
divu ra, s10, s9
slli ra, s1, 9
bne t4, t5, . + 16
ori ra, s0, -591
bltu t1, t2, . + 24
bge t0, t1, . + 8
rem ra, s0, s10
blt t1, t0, . + 16
bltu t0, t3, . + 16
lui ra, 795377
lui ra, 88247
sltu ra, s3, s9
lhu s0, 246(gp)
sll ra, s6, s8
add ra, s3, s5
mulh ra, s2, s4
lh s8, 116(gp)
slti ra, a5, 1575
mulhsu ra, s10, s3
lb s1, 114(gp)
bltu t0, t6, . + 12
bne zero, t4, . + 24
srl ra, s9, s7
andi ra, s9, 85
and ra, s0, s0
bgeu t1, t2, . + 8
lhu s2, 136(gp)
ori ra, s8, 554
mulh ra, s3, s0
sltu ra, s2, s10
lb s6, 91(gp)
mul ra, s9, s11
mul ra, s11, s9
ori ra, s6, -557
lbu s10, 19(gp)
lhu s10, 38(gp)
slti ra, a4, -363
divu ra, s0, s1
mulh ra, s4, s0
mulh ra, s11, s11
sub ra, s7, s8
sb s7, 178(gp)
lbu s10, 151(gp)
blt t0, t1, . + 12
srai ra, s1, 18
lw s5, 252(gp)
sltiu ra, a2, -183
mulhsu ra, s5, s4
sh s0, 230(gp)
sub ra, s7, s10
sltiu ra, a7, -7
or ra, s9, s7
andi ra, s11, 1318
srl ra, s5, s4
lhu s2, 72(gp)
sll ra, s1, s0
rem ra, s1, s10
slt ra, s10, s10
sltu ra, s9, s7
auipc ra, 433435
rem ra, s1, s4
sb s7, 28(gp)
bltu t3, t6, . + 24
mulhu ra, s10, s1
div ra, s4, s3
div ra, s9, s4
sb s3, 226(gp)
lb s7, 213(gp)
auipc ra, 95504
srl ra, s9, s10
auipc ra, 906953
auipc ra, 894851
sb s6, 108(gp)
divu ra, s0, s3
srai ra, s5, 8
mulhsu ra, s7, s10
lbu s3, 233(gp)
mulhu ra, s0, s7
add ra, s2, s10
jal ra, . + 8
sltu ra, s2, s1
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
jal sp, . + 4
mulhsu ra, s8, s9
xori ra, s3, 508
addi ra, s6, 514
sltiu ra, a1, 1283
xor ra, s1, s11
xor ra, s2, s2
divu ra, s2, s7
xori ra, s9, -72
jalr ra, sp, 52
ori ra, s7, 2032
slli ra, s7, 4
bgeu t6, t3, . + 4
rem ra, s5, s2
andi ra, s0, 1003
lbu s9, 61(gp)
bgeu t4, t5, . + 4
mulhsu ra, s6, s9
sh s0, 56(gp)
jalr ra, sp, 92
srli ra, s6, 20
jalr ra, zero, 4
lui ra, 94016
jalr ra, sp, 104
sw s1, 116(gp)
mulhu ra, s10, s2
slt ra, s0, s8
mul ra, s6, s10
slli ra, s1, 17
lb s6, 13(gp)
bltu t6, t3, . + 4
or ra, s4, s4
mulh ra, s3, s8
srl ra, s4, s1
mulhu ra, s9, s6
sw s8, 56(gp)
addi ra, s3, 227
addi ra, s8, -1920
slt ra, s0, s5
sltiu ra, a1, -960
mul ra, s0, s4
bge t0, t1, . + 20
lui ra, 367140
remu ra, s7, s1
sll ra, s11, s3
div ra, s9, s0
xori ra, s4, 575
lb s1, 77(gp)
mul ra, s8, s4
slt ra, s0, s7
ori ra, s3, -1519
sltu ra, s3, s9
add ra, s6, s4
xori ra, s9, 1636
jal ra, loop_back
slt ra, s8, s1
srai ra, s5, 18
slt ra, s10, s9
jal ra, . + 16
div ra, s11, s5
sh s7, 122(gp)
lbu s3, 209(gp)
mulhsu ra, s6, s10
sh s10, 242(gp)
beq zero, t1, . + 20
sltiu ra, a2, -1433
div ra, s0, s4
sw s9, 132(gp)
mulh ra, s11, s4
srli ra, s1, 14
auipc ra, 176753
sw s11, 252(gp)
slt ra, s1, s0
slti ra, a6, -1879
mulh ra, s5, s3
sub ra, s3, s9
bltu t4, t5, . + 20
xori ra, s5, -77
lhu s4, 26(gp)
div ra, s11, s4
auipc ra, 130436
mulh ra, s6, s1
slli ra, s6, 28
bne zero, t1, . + 20
beq t4, t5, . + 24
srai ra, s8, 26
and ra, s6, s0
lb s11, 75(gp)
sb s4, 57(gp)
remu ra, s10, s4
bltu t3, t0, . + 16
bltu t0, t3, . + 12
div ra, s6, s3
mulhsu ra, s11, s2
bgeu t1, t2, . + 8
sw s6, 236(gp)
lh s7, 180(gp)
slti ra, a6, -1376
lui ra, 803652
lh s0, 114(gp)
lw s11, 116(gp)
bne t4, t5, . + 16
bgeu t4, t5, . + 12
xor ra, s0, s11
sltiu ra, a7, 1317
lbu s9, 101(gp)
addi ra, s8, 497
mulhu ra, s3, s10
sub ra, s10, s0
jal ra, . + 4
sw s4, 8(gp)
add ra, s1, s1
beq t1, t2, . + 12
beq t1, t2, . + 16
addi ra, s1, 738
mulhu ra, s5, s9
andi ra, s11, -1320
bge t0, t1, . + 16
divu ra, s2, s3
ori ra, s7, -183
remu ra, s8, s3
add ra, s1, s3
bgeu t3, t0, . + 24
sh s0, 18(gp)
sltiu ra, a5, -462
sltiu ra, a0, -992
bge t0, t1, . + 16
bgeu t0, t3, . + 24
divu ra, s4, s2
lb s4, 106(gp)
mul ra, s3, s7
lb s6, 100(gp)
mulhsu ra, s4, s0
auipc ra, 536836
sltu ra, s4, s6
sb s4, 110(gp)
bgeu t1, t2, . + 8
slli ra, s2, 15
auipc ra, 440578
sub ra, s11, s10
srl ra, s9, s7
mulh ra, s2, s6
or ra, s3, s10
sb s0, 41(gp)
jal ra, . + 12
sh s11, 90(gp)
sh s1, 232(gp)
bne zero, t1, . + 12
and ra, s0, s0
srli ra, s7, 16
mulhu ra, s10, s11
mulhu ra, s10, s4
andi ra, s8, 1475
lb s1, 245(gp)
divu ra, s5, s6
xor ra, s2, s8
sra ra, s5, s7
srl ra, s10, s8
rem ra, s1, s4
div ra, s5, s5
xor ra, s2, s6
lui ra, 652565
sltu ra, s3, s5
blt t1, t0, . + 20
slti ra, a1, 1028
sb s11, 92(gp)
srl ra, s8, s11
div ra, s2, s1
mulh ra, s6, s9
xor ra, s2, s7
divu ra, s4, s8
sub ra, s4, s3
remu ra, s11, s4
mul ra, s10, s4
slt ra, s11, s2
sll ra, s10, s6
srli ra, s8, 24
srli ra, s11, 29
mulhu ra, s6, s3
xor ra, s1, s9
divu ra, s8, s1
sh s8, 138(gp)
bltu t0, t6, . + 16
lhu s7, 2(gp)
ori ra, s4, 1837
bgeu t0, t3, . + 4
mulhsu ra, s3, s6
lui ra, 823568
beq t1, t2, . + 4
bgeu t4, t5, . + 24
mulh ra, s5, s10
lui ra, 999398
remu ra, s9, s5
beq zero, t1, . + 8
xori ra, s4, -1234
rem ra, s9, s10
sw s1, 24(gp)
mulhu ra, s2, s9
mulhu ra, s9, s2
and ra, s4, s10
xori ra, s7, -405
lhu s8, 224(gp)
mulhsu ra, s0, s10
blt t5, t6, . + 12
mulhu ra, s8, s4
sll ra, s2, s9
sw s11, 148(gp)
blt t1, t0, . + 24
bge t5, t6, . + 4
srai ra, s5, 12
slt ra, s1, s6
mulhsu ra, s1, s0
rem ra, s1, s8
auipc ra, 14014
sll ra, s3, s6
jal ra, . + 12
xori ra, s8, -1741
srai ra, s0, 11
srli ra, s5, 26
sltiu ra, a3, 1070
add ra, s5, s6
beq zero, t4, . + 4
blt t6, t5, . + 24
blt t1, t0, . + 8
bne zero, t1, . + 24
bgeu t6, t0, . + 8
srai ra, s0, 15
sltu ra, s10, s2
bltu t3, t0, . + 4
addi ra, s10, 849
slt ra, s9, s10
bge t0, t1, . + 16
jalr ra, zero, 4
blt t0, t1, . + 8
blt t0, t1, . + 16
sw s6, 96(gp)
lb s6, 238(gp)
slli ra, s6, 0
div ra, s9, s5
ori ra, s6, -389
sb s11, 216(gp)
mul ra, s3, s9
slt ra, s0, s10
slli ra, s3, 10
sw s0, 188(gp)
sra ra, s0, s8
bgeu t6, t0, . + 24
div ra, s7, s4
bgeu t6, t3, . + 16
xori ra, s10, 1300
or ra, s11, s9
xor ra, s9, s4
and ra, s5, s2
sh s2, 70(gp)
jal ra, . + 8
sltu ra, s9, s11
lui ra, 968262
blt t0, t1, . + 20
auipc ra, 701344
bne zero, t1, . + 4
andi ra, s11, 1751
srl ra, s4, s8
add ra, s2, s9
beq zero, t1, . + 24
blt t1, t0, . + 24
srl ra, s6, s3
srli ra, s9, 6
addi ra, s1, -1071
sw s3, 0(gp)
sltu ra, s2, s2
mulhu ra, s6, s6
mul ra, s4, s11
bne zero, t4, . + 24
and ra, s0, s5
sra ra, s11, s5
slli ra, s3, 29
div ra, s5, s3
sb s3, 149(gp)
sb s4, 251(gp)
add ra, s0, s6
andi ra, s7, -1159
rem ra, s3, s3
bltu t3, t6, . + 24
bne t1, t2, . + 8
sll ra, s5, s9
sw s11, 104(gp)
lb s11, 104(gp)
blt t5, t6, . + 16
sb s8, 183(gp)
xori ra, s7, 809
srli ra, s4, 2
sltiu ra, a5, -1743
bgeu t3, t0, . + 12
srl ra, s2, s6

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
