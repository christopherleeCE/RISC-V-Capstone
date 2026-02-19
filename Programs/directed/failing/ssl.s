# SLL Test - Edgar A. Gastelum Martinez
# Simple shift-add multiplier - does not handle overflow
# Choose two numbers to multiply by modifying the constants
# Programs works with negative numbers
# The result is returned in the a0 register

# declare some constants
.equ MULTIPLICAND, 36
.equ MULTIPLIER, -20

.globl _start

.text
_start:
    li a0, MULTIPLICAND # prepare arguments
    li a1, MULTIPLIER
    
    jal shift_add_mult # call the function
    
    nop
    nop
    ebreak # pause the program
    

shift_add_mult: # prepares registers for operation
    addi t0, zero, 0 # will hold the running sum
    addi t1, zero, 1 # will need a one for several things
    addi t2, zero, 31 # a limit to not exceed 32 bits
    j condition

condition: # will evaluate whether to add partial product
    and t3, a1, t1 #isolate rightmost digit of multiplier
    bne t3, t1, advance # only add partial product if bit is one
    add t0, t0, a0
    j advance

advance: # will either advance through multiplier or jump to main func.
    sll a0, a0, t1 # shift the multiplicand left
    srl a1, a1, t1 # shift the multiplier right (no sign extension)
    sub t2, t2, t1 # decrement the number of shifts left
    bne zero, t2, condition # loop until no shifts are left
    add a0, zero, t0 # load the product for return in a0
    jr ra # return back from function