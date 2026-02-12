# chris's test program ##

##breaks top file

# if there is 1 or 2 nobranches b4 a branch (or jump i belive) those no branches fail the verification
# one more thing to investigate is if there a difference between the branch/jump scenario, appears as both do the same
# if jmp is changed to start instead of end, same errors, just repeat cus its an inf loop


# start:
#         li t0, 0x0
#         li t1, 0xF
#         jal zero, label
#         nop
#         nop
#         nop
#         label:
#         nop
#         nop
#         nop


#         beq t0, t1, end
# label_0:        
#         beq t0, t1, end
# label_1:        
#         beq t1, t1, start
#         #jal zero, end
# label_2:        
#         beq t0, t1, end
# label_3:        
#         beq t0, t1, end
# label_4:        
#         beq t0, t1, end
# label_5:        
#         beq t0, t1, end
# label_6:        
#         beq t0, t1, label_12
# label_7:        
#         beq t0, t1, label_13
# label_8:        
#         beq t0, t1, label_14
# label_9:        
#         beq t0, t1, label_15
# label_10:        
#         beq t0, t1, label_16
# label_11:        
#         beq t0, t1, label_17
# label_12:        
#         beq t0, t1, label_18
# label_13:        
#         beq t0, t1, label_19
# label_14:        
#         beq t0, t1, label_20
# label_15:        
#         beq t0, t1, label_16
# label_16:        
#         beq t0, t1, label_17
# label_17:        
#         beq t0, t1, label_18
# label_18:        
#         beq t0, t1, label_19
# label_19:        
#         beq t0, t1, label_20
# label_20:        
#         #jal zero, end_after_end
#         beq t0, t1, end
#         nop
#         nop
#         nop
# end:
#         nop
#         nop
#         nop
# loop:
#         jal zero, loop



# start: #results in warning from vsim, not unique case statement

#         li t0, 0xF3F2F1F0
#         sw t0, 0(zero)
#         li t0, 0x08070605
#         sw t0, 0(zero)

# end:
#         jal zero, end

# start:
#         addi a0, zero, 0x10
#         addi a1, zero, 0x17
#         add a2, a0, a1
#         lui a3, 0xF
#         sub a4, a1, a0
#         jal ra, . + 4
#         addi t0, t0, 0x30
#         addi t1, t1, 0x34
#         addi t2, t2, 0x38
#         jal ra, label + 4
#         addi a5, zero, 0x3C
#         addi a5, zero, 0x40
# label:
#         addi a5, zero, 0x44
#         sw a2, 0xC(zero)
#         lw a6, 0xC(zero)
#         addi a7, zero, 0x40
#         #jalr ra, a7, 0x8
#         # nop
#         # beq a5, zero, beq_label
#         # nop
#         # beq a5, a6, beq_label
#         # nop
#         nop
#         beq t0, zero, beq_label #desync here
#         sw a0, 0(zero)
#         sw a1, 4(zero)
#         sw a2, 8(zero)
#         sw a3, 12(zero)
#         beq a5, zero, beq_label
#         lw s8, 0(zero)
#         lw s9, 4(zero)
#         lw s10, 8(zero)
#         lw s11, 16(zero)
# beq_label:
#         lw s11, 0(zero)
#         lw s10, 4(zero)
#         lw s9, 8(zero)
#         lw s8, 12(zero)
#         sw a4, 16(zero)
#         sw a5, 20(zero)
#         sw a6, 24(zero)
#         sw a7, 28(zero)
# end:
#         jal ra, end
#         nop
#         nop
#         nop


#         # nop #DNR
#         # nop #DNR
#         # nop #DNR
#         # nop #DNR0


# start:

#         li      t0, 0x010      # 16 decimal
#         li      t1, 0x003      # 3 decimal
#         li      t2, -4               # signed negative
#         lui     t2, 0xFFFFF
#         li      t3, 0xFFE       # unsigned large (4294967294)
#         lui     t3, 0xFFFFF

#         # -----------------------
#         mul     a0, t0, t1          #0x30
#         mulh    a1, t2, t1          #0xFFFFFFFF
#         mulhsu  a2, t2, t3          #0xFFFFF000
#         mulhu   a3, t0, t3          #0xF

# end:
#         jal     zero, end

# _start:

#         # Test values
#         li      t0, 0x010      # 16 decimal
#         li      t1, 0x003      # 3 decimal
#         li      t2, -4               # signed negative
#         li      t3, -2         # unsigned 0xFFFFFFFE

#         # -----------------------
#         # MUL: signed * signed -> lower 32 bits
#         mul     a0, t0, t1          # 16 * 3 = 48
#         # Expected a0 = 48

#         # MULH: signed * signed -> upper 32 bits
#         mulh    a1, t2, t1          # -4 * 3 = -12 -> upper 32 bits
#         # Expected a1 = 0xFFFFFFFF (high 32 of -12)

#         # MULHSU: signed * unsigned -> upper 32 bits
#         mulhsu  a2, t2, t3          # -4 * 0xFFFFFFFE
#         # Expected a2 = 0xFFFFFFFF (high 32)

#         # MULHU: unsigned * unsigned -> upper 32 bits
#         mulhu   a3, t0, t3          # 16 * 0xFFFFFFFE
#         # Expected a3 = 0x0000000F (high 32)

#         # End (infinite loop)
# end:
#         jal     zero, end


#Test for AND, OR, ANDI, and ORI - Edgar G.
#Goal - manipulate specific bits
#create the value 0xabababab from 0xffffffff with AND, OR
#create the value 0x000000ab from 0x000000ff with ANDI, ORI
#repeat with both R and I type instructions

# #start the program
# .global _start
# .text 
# _start:
# 	#AND and OR test
# 	li a0, 0xffffffff #starting value
	
# 	li a6, 0xaaaaaaaa #load masks
# 	li a7, 0x0b0b0b0b
	
# 	and a0, a0, a6 #should create 0xaaaaaaaa
# 	or a0, a0, a7 #should create 0xabababab
	
# 	#ANDI and ORI test
# 	li a1, 0x000000ff #starting value
# 	andi a1, a1, 0x0aa #should create 0x000000aa
# 	ori a1, a1, 0x00b #should create 0x000000ab
	
# 	nop #finish all instructions
# 	nop
# 	nop
# 	ebreak #not yet implemented, but should still halt processor


# #TEST FOR XOR and XORI - very simple, room for expansion later
# .global _start
# .text
# _start:
# 	li a0, 0x34a7bc9d #load a random number into a register
# 	xor a0, a0, a0 #performing a xor of a register with itself should clear it
	
# 	#same process, albeit smaller number due to limitations of immediate size
# 	addi a0, a0, 0x3ca
# 	xori a0, a0, 0x3ca #should also clear
	
# 	nop
# 	nop
# 	ebreak


# #TEST FOR BNE, BLT, BGE - Edgar G.
# #This program takes a value and adjusts it to a target
# .eqv TARGET_VALUE, 0xaa # hex value

# .globl _start
# .text

# _start: 
#     # Smaller numbers
#     addi a0, zero, 0x91 # loading the first value as an argument (hex value)
#     addi a1, zero, TARGET_VALUE #loading the target value as argument
#     jal adjust_num # call function
#     mv s0, a0 # save return value
    
#     addi a0, zero, 0xc7 # loading the second value as an argument (hex value)
#     addi a1, zero, TARGET_VALUE #loading the target value as argument
#     jal adjust_num # call function
#     mv s1, a0 # save return value
    
#     nop
#     nop
#     nop
#     ebreak # terminate the program


# adjust_num: #function to adjust the value
#     #create the limits
#     mv t0, a1 #lower limit
#     addi t1, a1, 1 #upper limit

#     blt a0, t0, increment #check if the value is two small
#     bge a0, t1, decrement #check if the value is too big

# increment:
#     addi a0, a0, 1 # increments by 1
#     bne a0, a1, increment # repeat until value hits target
#     jr ra # return to main function

# decrement: # decrements by 1
#     addi a0, a0, -1 # decrements by 1
#     bne a0, a1, decrement # repeat until value hits target
#     jr ra # return to main function


# #TEST FOR SLT, SLTU - Edgar G.
# .globl _start
# .text
# _start:
#     li a0,  3
#     li a1, 2
#     li a2, -1
    
#     # unsigned comparison
#     sltu t0, a1, a0 # should output 1
#     sltu t1, a2, a1 # should output 0
    
#     # signed comparison
#     slt t2, a1, a0 # should output 1
#     slt t3, a2, a1 # should output 1
    
#     nop
#     nop
#     ebreak
    

# # Hamming Distance Calculator - Edgar G.
# # Learned about Hamming Distance when I was searching the web for applications
# # of XOR. This will take two strings/vectors and tell you how many bits are 
# # different between the two.

# # DECLARE CONSTANTS
# .equ V_1, 0x00000001 #first vector
# .equ V_2, 0x8000000f #second vector

# .global _start
# .text
# _start:
# 	li a0, V_1 #load first vector
# 	li a1, V_2 #second vector
# 	jal hamming_dist #jump to function
# 	nop # Hamming distance is returned in a0
# 	nop
# 	ebreak #pause the program
	
# hamming_dist:
# 	add t0, t0, zero #this register tracks shifts needed
# 	addi t1, t1, 32 #limit of shifts (32 bits)
	
# 	xor t2, a0, a1 # xor the two values - will find differences
# 	xor a0, a0, a0 # clear a0 for next step
# 	j shift_add #perform operation
	
# shift_add:
# 	srl t3, t2, t0 #shift the bits to the right (no sign extension)
# 	andi t3, t3, 1 #isolate the rightmost bit
# 	add a0, a0, t3 #keep a running sum of bits that are different
# 	addi t0, t0, 1 #increment the value to sweep through each bit of the XOR result
# 	bne t0, t1, shift_add #repeat until all 32 bits have been scanned
# 	jr ra # end function, return to main program


# SLL, SRA Test - Edgar A. Gastelum Martinez
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