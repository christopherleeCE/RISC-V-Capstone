

li a0, 17
li a1, -17
li a2, 2147483647  #0x7FFFFFFF
li a3, -2147483648 #0x80000000

#res = 1
slt s0, a1, a0
slt s1, zero, a0
slt s2, a1, zero
slt s3, a3, a2
slt s4, zero, a2
slt s5, a3, zero

#res = 0
slt s0, a0, a1
slt s1, a0, zero
slt s2, zero, a1
slt s3, a2, a3
slt s4, a2, zero
slt s5, zero, a3

#res = 0
li s0, 1 #seting to 1 b4 hand, non nessisary but this program is short anyway
li s1, 1
li s2, 1
li s3, 1
li s4, 1
slt s0, zero, zero 
slt s1, a0, a0
slt s2, a1, a1
slt s3, a2, a2
slt s4, a3, a3

#res = 1
slti s0, a1, 17
slti s1, zero, 17
slti s2, a1, 0
slti s3, a3, 0x7FF
slti s4, zero, 0x7FF
slti s5, a3, 0

#res = 0
slti s0, a0, -17
slti s1, a0, 0
slti s2, zero, -17
slti s3, a2, -2048
slti s4, a2, 0
slti s5, zero, 0

#res = 0
li s0, 1 #seting to 1 b4 hand, non nessisary but this program is short anyway
li s1, 1
li s2, 1
slti s0, zero, 0 
slti s1, a0, 17
slti s2, a1, -17

li s0, 0 #seting to 0 b4 hand, non nessisary but this program is short anyway
li s1, 0
li s2, 0
li s3, 0
li s4, 0
li s5, 0

#res = 1
sltu s0, zero, a0
sltu s1, a0, a1
sltu s2, a2, a1
sltu s3, a2, a3
sltu s4, zero, a1
sltu s5, zero, a3

#res = 0
sltu s0, a0, zero
sltu s1, a1, a0
sltu s2, a1, a2
sltu s3, a3, a2
sltu s4, a1, zero
sltu s5, a3, zero

li s0, 1 #seting to 1 b4 hand, non nessisary but this program is short anyway
li s1, 1
li s2, 1
sltu s0, zero, zero
sltu s1, a0, a0
sltu s2, a1, a1

li s0, 0 #seting to 0 b4 hand, non nessisary but this program is short anyway
li s1, 0
li s2, 0
li s3, 0
li s4, 0
li s5, 0

#res = 1
sltiu s0, zero, 17
sltiu s1, a0, -17
sltiu s2, a2, -17
sltiu s3, zero, -17
li s4, 1
li s5, 1

#res = 0
sltiu s0, a0, 0
sltiu s1, a1, 17
sltiu s2, a1, 2047
sltiu s3, a3, 2047
sltiu s4, a1, 0
sltiu s5, a3, 0

li s0, 1 #seting to 1 b4 hand, non nessisary but this program is short anyway
li s1, 1
li s2, 1
sltiu s0, zero, 0
sltiu s1, a0, 17
sltiu s2, a1, -17


#how comppilers do seq and sne, just "testing" for fun
li a0, 17
li a1, 0
li a2, -17

# 17 == 17
xor t0, a0, a0
sltiu s0, t0, 1        # s0 = 1
# 0 == 0
xor t0, a1, a1
sltiu s1, t0, 1        # s1 = 1
# -17 == -17
xor t0, a2, a2
sltiu s2, t0, 1        # s2 = 1
# 17 != 0
xor t0, a0, a1
sltu s3, zero, t0      # s3 = 1
# 0 != -17
xor t0, a1, a2
sltu s4, zero, t0      # s4 = 1

# 17 == 0
xor t0, a0, a1
sltiu s0, t0, 1        # s0 = 0
# 0 == -17
xor t0, a1, a2
sltiu s1, t0, 1        # s1 = 0
# 17 != 17
xor t0, a0, a0
sltu s2, zero, t0      # s2 = 0
# 0 != 0
xor t0, a1, a1
sltu s3, zero, t0      # s3 = 0
# -17 != -17
xor t0, a2, a2
sltu s4, zero, t0      # s4 = 0

