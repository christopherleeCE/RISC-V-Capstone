/*
This program is a test for the following insturcitons

    nop
    addi
    add
    sub
mul
mulh
mulsu
mulu
div
divu
rem
remu
ebreak

and more that will be manually retested in other programs, (lui for example)
*/

#prep registers
li a0, 0x0
li a1, 0xFFFFFFFA
li a2, 0x4
li a3, 0x5
li a4, 0x6
li a5, 0x55555555
li a6, 0xAAAAAAAA

#nop :)
nop
nop
nop
nop
nop

#addi
li s0, 17 #just a nonzero value, probably unessisarry...
li s3, 17 #just a nonzero value, probably unessisarry...
li s7, 17 #just a nonzero value, probably unessisarry...
nop
nop
nop
nop
nop

addi s0, a0, 0 #should write a 0 into the 17
addi s1, a2, 6 #no overflow
addi s2, a1, 4 #no overflow, large number
addi s3, a1, 5 #overflow to 0
addi s4, a1, 6 #overflow to 1

addi s5, a1, -4 #no underflow, large number
addi s6, a3, -4 #no underflow
addi s7, a3, -5 #underflow to 0
addi s8, a3, -6 #underflow to -1

#test for add and sub
li s0, 17 #just a nonzero value, probably unessisarry...
li s3, 17 #just a nonzero value, probably unessisarry...
li s5, 17 #just a nonzero value, probably unessisarry...
li s8, 17 #just a nonzero value, probably unessisarry...
nop
nop
nop
nop
nop

add s0, a0, zero #should write a 0 into the 17
add s1, a2, a4 #no overflow
add s2, a1, a2 #no overflow, large number
add s3, a1, a3 #overflow to 0
add s4, a1, a4 #overflow to 1

sub s5, a0, zero #should write a 0 into the 17
sub s6, a1, a4 #no underflow, large number
sub s7, a3, a2 #no underflow
sub s8, a3, a3 #underflow to 0
sub s9, a3, a4 #underflow to -1

#checkboard
add s10, a6, a5
sub s11, a6, a5


#mul tests (the results in the comment come from gpt, dont trust em TOO much
li a0, 17
li a1, 34
mul s0, a1, a0 # = 578
mulh s1, a1, a0 # = 0
mulhsu s2, a1, a0
mulhsu s3, a0, a1
mulhu s4, a1, a0

li a0, 0xFFFFFFFF
li a1, 0xFFFFFFFF
mul s0, a1, a0 # 1
mulh s1, a1, a0 # 0
mulhsu s2, a1, a0 # 0xFFFFFFFF
mulhsu s3, a0, a1 # 0xFFFFFFFF
mulhu s4, a1, a0 # 0xFFFFFFFE

li a0, 0x80000000 #big neg
li a1, 0x1 #small pos
mul s0, a1, a0 # 0x80000000
mulh s1, a1, a0 # 0xFFFFFFFF
mulhsu s2, a1, a0 # 0x80000000
mulhsu s3, a0, a1 # 0xFFFFFFFF
mulhu s4, a1, a0 # 0

li a0, 0x0FFFFFFF #big pos
li a1, 0xFFFFFFFF #small neg
mul s0, a1, a0 # 0xF0000001
mulh s1, a1, a0 # 0xFFFFFFFF
mulhsu s2, a1, a0 # 0xFFFFFFFF
mulhsu s3, a0, a1 # 0xFFFFFFFE
mulhu s4, a1, a0 # 0xFFFFFFFE

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
#TODO
# div
# divu
# rem
# remu
