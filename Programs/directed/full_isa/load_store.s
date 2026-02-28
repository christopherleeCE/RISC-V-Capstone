#TODO, test auipc with pc > 1kb
    .section .data
    .word 0x00000000

    .section .text
    .globl _start

_start:

li a0, 0x00000000
li a1, 0x55555555
li a2, 0xAAAAAAAA
li a3, 0xFFFFFFFF

lui t3, 0x00000
lui t4, 0x55555
lui t5, 0xAAAAA
lui t6, 0xFFFFF

auipc t3, 0x00000
auipc t4, 0x00000
auipc t5, 0x00000
auipc t6, 0x00000
auipc t3, 0x55555
auipc t4, 0x55555
auipc t5, 0x55555
auipc t6, 0x55555
auipc t3, 0xAAAAA
auipc t4, 0xAAAAA
auipc t5, 0xAAAAA
auipc t6, 0xAAAAA
auipc t3, 0xFFFFF #should cause overflow with high enuf pc
auipc t4, 0xFFFFF #should cause overflow with high enuf pc
auipc t5, 0xFFFFF #should cause overflow with high enuf pc
auipc t6, 0xFFFFF #should cause overflow with high enuf pc

li t0, 0x11223344
li x16, 0x11223344
li x17, 0x11223344
li x18, 0x11223344
li x19, 0x11223344
li x20, 0x11223344
li x21, 0x11223344
li x22, 0x11223344
li x23, 0x11223344

li sp, 0x00001008 #testing if forwarding works in grabing the right sp
li sp, 0x00001000
sw t0, 0(sp)
sw t0, 4(sp)
sw t0, 8(sp)
sw t0, 12(sp)
sw t0, 16(sp)
sw t0, 20(sp)
sw t0, 24(sp)
sw t0, 28(sp)
sw t0, 32(sp)
sw t0, 36(sp)
sw t0, 40(sp)
sw t0, 44(sp)


li sp, 0x00001000
sb a0, 0(sp)
sb a1, 1(sp)
sb a2, 2(sp)
sb a3, 3(sp)
sb a3, 4(sp)
sb a0, 5(sp)
sb a1, 6(sp)
sb a2, 7(sp)
sb a2, 8(sp)
sb a3, 9(sp)
sb a0, 10(sp)
sb a1, 11(sp)
sb a1, 12(sp)
sb a2, 13(sp)
sb a3, 14(sp)
sb a0, 15(sp)

li sp, 0x00001010
sh a0, 0(sp)
sh a1, 2(sp)
sh a1, 4(sp)
sh a0, 6(sp)
sh a2, 8(sp)
sh a3, 10(sp)
sh a3, 12(sp)
sh a2, 14(sp)

li sp, 0x00001020
sw a0, 0(sp)
sw a1, 4(sp)
sw a2, 8(sp)
sw a3, 12(sp)

/*
0x00000000
0x00000055
0x000000AA
0x000000FF

0x00000000
0x00005555
0x0000AAAA
0x0000FFFF

0x00000000
0x55555555
0xAAAAAAAA
0xFFFFFFFF
*/

li sp, 0x00001000
lb x16, 0(sp)
lb x17, 5(sp)
lb x18, 10(sp)
lb x19, 15(sp)
lb x20, 1(sp)
lb x21, 6(sp)
lb x22, 11(sp)
lb x23, 12(sp)
lb x16, 2(sp)
lb x17, 7(sp)
lb x18, 8(sp)
lb x19, 13(sp)
lb x20, 3(sp)
lb x21, 4(sp)
lb x22, 9(sp)
lb x23, 14(sp)

lbu x16, 0(sp)
lbu x17, 5(sp)
lbu x18, 10(sp)
lbu x19, 15(sp)
lbu x20, 1(sp)
lbu x21, 6(sp)
lbu x22, 11(sp)
lbu x23, 12(sp)
lbu x16, 2(sp)
lbu x17, 7(sp)
lbu x18, 8(sp)
lbu x19, 13(sp)
lbu x20, 3(sp)
lbu x21, 4(sp)
lbu x22, 9(sp)
lbu x23, 14(sp)

lh x16, 16(sp)
lh x17, 22(sp)
lh x18, 18(sp)
lh x19, 20(sp)
lh x20, 24(sp)
lh x21, 30(sp)
lh x22, 26(sp)
lh x23, 28(sp)

lhu x23, 16(sp)
lhu x22, 22(sp)
lhu x21, 18(sp)
lhu x20, 20(sp)
lhu x19, 24(sp)
lhu x18, 30(sp)
lhu x17, 26(sp)
lhu x16, 28(sp)

lw x16, 32(sp)
lw x17, 36(sp)
lw x18, 40(sp)
lw x19, 44(sp)
lw x20, 0(sp)
lw x21, 4(sp)
lw x22, 8(sp)
lw x23, 12(sp)

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
