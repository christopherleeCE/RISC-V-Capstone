#TEST FOR BNE, BLT, BGE - Edgar G.
#This program takes a value and adjusts it to a target
.eqv TARGET_VALUE, 0xaa # hex value

.globl _start
.text

_start: 
    # Smaller numbers
    addi a0, zero, 0x91 # loading the first value as an argument (hex value)
    addi a1, zero, TARGET_VALUE #loading the target value as argument
    jal adjust_num # call function
    mv s0, a0 # save return value
    
    addi a0, zero, 0xc7 # loading the second value as an argument (hex value)
    addi a1, zero, TARGET_VALUE #loading the target value as argument
    jal adjust_num # call function
    mv s1, a0 # save return value
    
    nop
    nop
    nop
    ebreak # terminate the program


adjust_num: #function to adjust the value
    #create the limits
    mv t0, a1 #lower limit
    addi t1, a1, 1 #upper limit

    blt a0, t0, increment #check if the value is two small
    bge a0, t1, decrement #check if the value is too big

increment:
    addi a0, a0, 1 # increments by 1
    bne a0, a1, increment # repeat until value hits target
    jr ra # return to main function

decrement: # decrements by 1
    addi a0, a0, -1 # decrements by 1
    bne a0, a1, decrement # repeat until value hits target
    jr ra # return to main function