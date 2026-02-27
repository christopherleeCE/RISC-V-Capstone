/*
this prog test the following

xor
or
and
xori
ori
andi

*/

    .section .text
    .globl _start

_start:

li a0, 0x00000000
li a1, 0x55555555
li a2, 0xAAAAAAAA
li a3, 0xFFFFFFFF
li a4, 0xFFFF0000
li a5, 0x0000FFFF
li a6, 0x00000000
li a7, 0xDEADBEEF
nop
nop
nop
nop
nop

and s0, a3, a0
and s1, a3, a1
and s2, a3, a2
and s3, a3, a3
and s4, a7, a6
and s5, a7, a5
and s6, a7, a4
and s7, a7, a3

or s0, a3, a0
or s1, a3, a1
or s2, a3, a2
or s3, a3, a3
or s4, a7, a6
or s5, a7, a5
or s6, a7, a4
or s7, a7, a3

xor s0, a3, a0
xor s1, a3, a1
xor s2, a3, a2
xor s3, a3, a3
xor s4, a7, a6
xor s5, a7, a5
xor s6, a7, a4
xor s7, a7, a3

andi s0, a0, -1 #0xFFF
andi s1, a1, -1 #0xFFF
andi s2, a2, -1 #0xFFF
andi s3, a3, -1 #0xFFF
andi s4, a7, -256 #0xF00
andi s5, a7, 0x0F0
andi s6, a7, 0x00F

ori s0, a0, -1 #0xFFF
ori s1, a1, -1 #0xFFF
ori s2, a2, -1 #0xFFF
ori s3, a3, -1 #0xFFF
ori s4, a7, -256 #0xF00
ori s5, a7, 0x0F0
ori s6, a7, 0x00F

xori s0, a0, -1 #0xFFF
xori s1, a1, -1 #0xFFF
xori s2, a2, -1 #0xFFF
xori s3, a3, -1 #0xFFF
xori s4, a7, -256 #0xF00
xori s5, a7, 0x0F0
xori s6, a7, 0x00F

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