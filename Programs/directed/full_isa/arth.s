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

and more that will be manually retested in other programs, (lui for example)
*/

    .section .text
    .globl _start

_start:

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

#div and rem
li a1, 53
li a0, 10
 div s0, a1, a0 # 5
 rem s1, a1, a0 # 3
divu s2, a1, a0 # 5
remu s3, a1, a0 # 3
 div s4, a0, a1 # 0
 rem s5, a0, a1 # 10
divu s6, a0, a1 # 0
remu s7, a0, a1 # 10

li a1, 53
li a0, -10
 div s0, a1, a0 # -5
 rem s1, a1, a0 # 3
divu s2, a1, a0 # 0
remu s3, a1, a0 # 53
 div s4, a0, a1 # 0
 rem s5, a0, a1 # -10
divu s6, a0, a1 # 81,037,118
remu s7, a0, a1 # 32

li a1, -53
li a0, 10
 div s0, a1, a0 # -5
 rem s1, a1, a0 # -3
divu s2, a1, a0 # 429,496,724
remu s3, a1, a0 # 3
 div s4, a0, a1 # 0
 rem s5, a0, a1 # 10
divu s6, a0, a1 # 0
remu s7, a0, a1 # 10

li a1, -53
li a0, -10
 div s0, a1, a0 # 5
 rem s1, a1, a0 # -3
divu s2, a1, a0 # 0
remu s3, a1, a0 # -53
 div s4, a0, a1 # 0
 rem s5, a0, a1 # -10
divu s6, a0, a1 # 1
remu s7, a0, a1 # 43

li a0, 23
li a1, -23
 div s0, a0, zero # -1
 rem s1, a0, zero # 23
divu s2, a0, zero # -1
remu s3, a0, zero # 23
 div s4, a1, zero # -1
 rem s5, a1, zero # -23
divu s6, a1, zero # -1
remu s7, a1, zero # -23
 div s0, zero, a0 # 0
 rem s1, zero, a0 # 0
divu s2, zero, a0 # 0
remu s3, zero, a0 # 0
 div s4, zero, a1 # 0
 rem s5, zero, a1 # 0
divu s6, zero, a1 # 0
remu s7, zero, a1 # 0

li a0, 23
li a1, -23
 div s0, zero, zero # -1
 rem s1, zero, zero # 0
divu s2, zero, zero # -1
remu s3, zero, zero # 0
 div s0, a0, a0 # 1
 rem s1, a0, a0 # 0
divu s2, a0, a0 # 1
remu s3, a0, a0 # 0
 div s4, a1, a1 # 1
 rem s5, a1, a1 # 0
divu s6, a1, a1 # 1
remu s7, a1, a1 # 0

li a1, 0x80000000
li a0, -1
 div s0, a1, a0 # -2147483648
 rem s1, a1, a0 # 0
divu s2, a1, a0 # 0
remu s3, a1, a0 # -2147483648
 div s4, a0, a1 # 0
 rem s5, a0, a1 # -1
divu s6, a0, a1 # 1
remu s7, a0, a1 # 2147483647

li a1, 0x80000000
li a0, 0x7FFFFFFF
 div s0, a1, a0 # -1
 rem s1, a1, a0 # -1
divu s2, a1, a0 # 1
remu s3, a1, a0 # 1
 div s4, a0, a1 # 0
 rem s5, a0, a1 # 2147483647
divu s6, a0, a1 # 0
remu s7, a0, a1 # 2147483647

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

