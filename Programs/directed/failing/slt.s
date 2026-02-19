#TEST FOR SLT, SLTU - Edgar G.
.globl _start
.text
_start:
    li a0,  3
    li a1, 2
    li a2, -1
    
    # unsigned comparison
    sltu t0, a1, a0 # should output 1
    sltu t1, a2, a1 # should output 0
    
    # signed comparison
    slt t2, a1, a0 # should output 1
    slt t3, a2, a1 # should output 1
    
    nop
    nop
    ebreak