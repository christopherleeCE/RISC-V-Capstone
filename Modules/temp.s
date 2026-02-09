li a0, 1492402236
li a1, 532327610
li a2, 435824373
li a3, -1883345365
li a4, -862096507
li a5, 69267737
li a6, -581854143
li a7, 990284176
jal sp, . + 4
xor s3, a4, a6
and s1, a6, a2
beq a0, a0, . + 4
mul s1, a7, a1
or s1, a3, a5
add s5, a5, a3
and s1, a5, a5
sub s9, a5, a6
xor s9, a0, a5
mul s2, a4, a2
beq a0, a0, . + 4
or s6, a1, a1
or s6, a6, a6
beq zero, a0, . + 12
and s5, a6, a4
sub s4, a7, a4
and s2, a5, a2
sub s9, a4, a2
beq zero, a0, . + 8
and s9, a4, a7
beq zero, a0, . + 16
add s8, a1, a2
or s9, a6, a3
xor s0, a1, a1
xor s1, a0, a5
beq zero, a0, . + 4
jalr ra, sp, 112
or s1, a5, a6
and s0, a6, a0
add s0, a1, a1
sub s9, a6, a6
or s3, a2, a6
sub s4, a0, a6
xor s6, a1, a0
sub s7, a0, a0
sub s11, a4, a6
sub s1, a5, a4
sub s8, a3, a7
xor s5, a1, a2
xor s8, a4, a3
or s9, a7, a3
and s4, a6, a5
and s9, a4, a3
add s11, a5, a7
beq zero, a0, . + 8
add s0, a3, a6
beq a0, a0, . + 20
add s11, a3, a7
sub s2, a2, a1
mul s3, a6, a4
and s6, a1, a0
and s11, a2, a6
mul s9, a5, a7
or s11, a2, a6
sub s2, a1, a5
beq a0, a0, . + 12
and s0, a4, a4
sub s3, a0, a6
add s11, a5, a3
or s2, a5, a6
sub s0, a6, a1
or s4, a3, a5
beq zero, a0, . + 24
xor s7, a4, a4
sub s3, a5, a4
sub s10, a0, a6
jal ra, . + 8
mul s3, a4, a7
sub s9, a0, a6
or s11, a3, a6
mul s0, a3, a6
beq zero, a0, . + 12
xor s2, a2, a1
mul s11, a0, a3
sub s5, a2, a5
or s7, a7, a1
xor s2, a1, a7
add s6, a7, a1
xor s4, a6, a6
add s11, a1, a7
mul s10, a6, a0
xor s9, a5, a3
beq zero, a0, . + 24
sub s1, a7, a4
mul s3, a7, a6
xor s9, a1, a7
and s3, a0, a3
or s6, a7, a4
xor s0, a7, a0
mul s6, a5, a4
beq a0, a0, . + 8
sub s3, a0, a6
mul s5, a6, a7
beq a0, a0, . + 24
mul s11, a1, a2
mul s2, a5, a2
and s9, a7, a2
mul s2, a7, a6
add s9, a6, a6
mul s10, a0, a5
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
jal zero, .
nop
nop
nop
nop
nop
