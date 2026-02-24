li t0, 0x00000000
li t1, 0x55555555
li t2, 0xAAAAAAAA
li t3, 0xFFFFFFFF

li t4, 0
sll x8, t0, t4
li t4, 1
sll x9, t0, t4
li t4, 4
sll x10, t0, t4
li t4, 7
sll x11, t0, t4
li t4, 30
sll x12, t0, t4
li t4, 31
sll x13, t0, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
sll x14, t0, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
sll x15, t0, t4

li t4, 0
sll x8, t1, t4
li t4, 1
sll x9, t1, t4
li t4, 4
sll x10, t1, t4
li t4, 7
sll x11, t1, t4
li t4, 30
sll x12, t1, t4
li t4, 31
sll x13, t1, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
sll x14, t1, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
sll x15, t1, t4

li t4, 0
sll x8, t2, t4
li t4, 1
sll x9, t2, t4
li t4, 4
sll x10, t2, t4
li t4, 7
sll x11, t2, t4
li t4, 30
sll x12, t2, t4
li t4, 31
sll x13, t2, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
sll x14, t2, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
sll x15, t2, t4

li t4, 0
sll x8, t3, t4
li t4, 1
sll x9, t3, t4
li t4, 4
sll x10, t3, t4
li t4, 7
sll x11, t3, t4
li t4, 30
sll x12, t3, t4
li t4, 31
sll x13, t3, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
sll x14, t3, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
sll x15, t3, t4

##

li t4, 0
srl x8, t0, t4
li t4, 1
srl x9, t0, t4
li t4, 4
srl x10, t0, t4
li t4, 7
srl x11, t0, t4
li t4, 30
srl x12, t0, t4
li t4, 31
srl x13, t0, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
srl x14, t0, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
srl x15, t0, t4

li t4, 0
srl x8, t1, t4
li t4, 1
srl x9, t1, t4
li t4, 4
srl x10, t1, t4
li t4, 7
srl x11, t1, t4
li t4, 30
srl x12, t1, t4
li t4, 31
srl x13, t1, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
srl x14, t1, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
srl x15, t1, t4

li t4, 0
srl x8, t2, t4
li t4, 1
srl x9, t2, t4
li t4, 4
srl x10, t2, t4
li t4, 7
srl x11, t2, t4
li t4, 30
srl x12, t2, t4
li t4, 31
srl x13, t2, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
srl x14, t2, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
srl x15, t2, t4

li t4, 0
srl x8, t3, t4
li t4, 1
srl x9, t3, t4
li t4, 4
srl x10, t3, t4
li t4, 7
srl x11, t3, t4
li t4, 30
srl x12, t3, t4
li t4, 31
srl x13, t3, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
srl x14, t3, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
srl x15, t3, t4

##

li t4, 0
sra x8, t0, t4
li t4, 1
sra x9, t0, t4
li t4, 4
sra x10, t0, t4
li t4, 7
sra x11, t0, t4
li t4, 30
sra x12, t0, t4
li t4, 31
sra x13, t0, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
sra x14, t0, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
sra x15, t0, t4

li t4, 0
sra x8, t1, t4
li t4, 1
sra x9, t1, t4
li t4, 4
sra x10, t1, t4
li t4, 7
sra x11, t1, t4
li t4, 30
sra x12, t1, t4
li t4, 31
sra x13, t1, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
sra x14, t1, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
sra x15, t1, t4

li t4, 0
sra x8, t2, t4
li t4, 1
sra x9, t2, t4
li t4, 4
sra x10, t2, t4
li t4, 7
sra x11, t2, t4
li t4, 30
sra x12, t2, t4
li t4, 31
sra x13, t2, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
sra x14, t2, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
sra x15, t2, t4

li t4, 0
sra x8, t3, t4
li t4, 1
sra x9, t3, t4
li t4, 4
sra x10, t3, t4
li t4, 7
sra x11, t3, t4
li t4, 30
sra x12, t3, t4
li t4, 31
sra x13, t3, t4
li t4, 36 #using this in a shift is equivilent to shift by 4
sra x14, t3, t4
li t4, -17 #and by some random number $unsigned(-17) % 32
sra x15, t3, t4

###############

slli x8, t0, 0
slli x9, t0, 1
slli x10, t0, 4
slli x11, t0, 7
slli x12, t0, 30
slli x13, t0, 31

slli x8, t1, 0
slli x9, t1, 1
slli x10, t1, 4
slli x11, t1, 7
slli x12, t1, 30
slli x13, t1, 31

slli x8, t2, 0
slli x9, t2, 1
slli x10, t2, 4
slli x11, t2, 7
slli x12, t2, 30
slli x13, t2, 31

slli x8, t3, 0
slli x9, t3, 1
slli x10, t3, 4
slli x11, t3, 7
slli x12, t3, 30
slli x13, t3, 31

##

slli x8, t0, 0
slli x9, t0, 1
slli x10, t0, 4
slli x11, t0, 7
slli x12, t0, 30
slli x13, t0, 31

slli x8, t1, 0
slli x9, t1, 1
slli x10, t1, 4
slli x11, t1, 7
slli x12, t1, 30
slli x13, t1, 31

slli x8, t2, 0
slli x9, t2, 1
slli x10, t2, 4
slli x11, t2, 7
slli x12, t2, 30
slli x13, t2, 31

slli x8, t3, 0
slli x9, t3, 1
slli x10, t3, 4
slli x11, t3, 7
slli x12, t3, 30
slli x13, t3, 31

##

srli x8, t0, 0
srli x9, t0, 1
srli x10, t0, 4
srli x11, t0, 7
srli x12, t0, 30
srli x13, t0, 31

srli x8, t1, 0
srli x9, t1, 1
srli x10, t1, 4
srli x11, t1, 7
srli x12, t1, 30
srli x13, t1, 31

srli x8, t2, 0
srli x9, t2, 1
srli x10, t2, 4
srli x11, t2, 7
srli x12, t2, 30
srli x13, t2, 31

srli x8, t3, 0
srli x9, t3, 1
srli x10, t3, 4
srli x11, t3, 7
srli x12, t3, 30
srli x13, t3, 31

##

srai x8, t0, 0
srai x9, t0, 1
srai x10, t0, 4
srai x11, t0, 7
srai x12, t0, 30
srai x13, t0, 31

srai x8, t1, 0
srai x9, t1, 1
srai x10, t1, 4
srai x11, t1, 7
srai x12, t1, 30
srai x13, t1, 31

srai x8, t2, 0
srai x9, t2, 1
srai x10, t2, 4
srai x11, t2, 7
srai x12, t2, 30
srai x13, t2, 31

srai x8, t3, 0
srai x9, t3, 1
srai x10, t3, 4
srai x11, t3, 7
srai x12, t3, 30
srai x13, t3, 31


# End
ebreak


# sll
# srl
# sra
# slli
# srli
# srai



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