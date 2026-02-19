# Hamming Distance Calculator - Edgar G.
# Learned about Hamming Distance when I was searching the web for applications
# of XOR. This will take two strings/vectors and tell you how many bits are 
# different between the two.

# DECLARE CONSTANTS
.equ V_1, 0x00000001 #first vector
.equ V_2, 0x8000000f #second vector

.global _start
.text
_start:
	li a0, V_1 #load first vector
	li a1, V_2 #second vector
	jal hamming_dist #jump to function
	nop # Hamming distance is returned in a0
	nop
	ebreak #pause the program
	
hamming_dist:
	add t0, t0, zero #this register tracks shifts needed
	addi t1, t1, 32 #limit of shifts (32 bits)
	
	xor t2, a0, a1 # xor the two values - will find differences
	xor a0, a0, a0 # clear a0 for next step
	j shift_add #perform operation
	
shift_add:
	srl t3, t2, t0 #shift the bits to the right (no sign extension)
	andi t3, t3, 1 #isolate the rightmost bit
	add a0, a0, t3 #keep a running sum of bits that are different
	addi t0, t0, 1 #increment the value to sweep through each bit of the XOR result
	bne t0, t1, shift_add #repeat until all 32 bits have been scanned
	jr ra # end function, return to main program