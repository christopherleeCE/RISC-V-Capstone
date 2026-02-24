#going to test the timing of the ebreak, not really a validation
li s0, 10
li s1, 11
li s2, 12
li s3, 13
li s4, 14
li s5, 15
ebreak #supposedly we should only see the regs s0 -> s5 changed
#and the is what happens in the dut, but because of the nature of the way the top file is set up,
#up to i think about s10 gets written to in the golden, which is fine, i dont exactly see that causing
#any issues with validation 
# -chris
li s6, 16
li s7, 17
li s8, 18
li s9, 19
li s10, 20
li s11, 21

