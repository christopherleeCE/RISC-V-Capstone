#TODO, test auipc with pc > 1kb

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
auipc t3, 0xFFFFF #should 
auipc t4, 0xFFFFF #should 
auipc t5, 0xFFFFF #should 
auipc t6, 0xFFFFF #should 

li sp, 0x10010000
sb a0, 0(sp)
sb a1, 4(sp)
sb a2, 8(sp)
sb a3, 12(sp)

li sp, 0x10010010
sh a0, 0(sp)
sh a1, 4(sp)
sh a2, 8(sp)
sh a3, 12(sp)

li sp, 0x10010020
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

li sp, 0x10010000
lb a4, 0(sp) #0x00000000
lb a5, 4(sp) #0x00000055
lb a6, 8(sp) #0xFFFFFFAA
lb a7, 12(sp) #0xFFFFFFFF
lbu a4, 0(sp) #0x00000000
lbu a5, 4(sp) #0x00000055
lbu a6, 8(sp) #0x000000AA
lbu a7, 12(sp) #0x000000FF

li sp, 0x10010010
lh a4, 0(sp) #0x00000000
lh a5, 4(sp) #0x00005555
lh a6, 8(sp) #0xFFFFAAAA
lh a7, 12(sp) #0xFFFFFFFF
lhu a4, 0(sp) #0x00000000
lhu a5, 4(sp) #0x00005555
lhu a6, 8(sp) #0x0000AAAA
lhu a7, 12(sp) #0x0000FFFF

li sp, 0x10010020
lw a4, 0(sp) #0x00000000
lw a5, 4(sp) #0x55555555
lw a6, 8(sp) #0xAAAAAAAA
lw a7, 12(sp) #0xFFFFFFFF

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
