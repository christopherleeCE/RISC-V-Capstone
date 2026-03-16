
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

#replace with nops as not the topfile does a regfile wide check on $finish, the 3 instrs
#after ebreak do get exected by the gold but not the dut, these three instr must be 
#nops to pass the top file
nop #li x16, 16
nop #li x17, 17
nop #li x18, 18
li x19, 19
li x20, 20
li x21, 21

