
    .section .text
    .globl _start

_start:

#going to test the timing of the ebreak, not really a validation
li x10, 10
li x11, 11
li x12, 12
li x13, 13
li x14, 14
li x15, 15
ebreak #supposedly we should only see the regs s0 -> s5 changed
#and the is what happens in the dut, but because of the nature of the way the top file is set up,
#up to i think about s10 gets written to in the golden, which is fine, i dont exactly see that causing
#any issues with validation 
# -chris
li x16, 16
li x17, 17
li x18, 18 #this is the last guy that sees results reflected in the golden
li x19, 19
li x20, 20
li x21, 21

