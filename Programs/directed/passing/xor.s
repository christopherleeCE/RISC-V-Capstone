#TEST FOR XOR and XORI - very simple, room for expansion later
.global _start
.text
_start:
	li a0, 0x34a7bc9d #load a random number into a register
	xor a0, a0, a0 #performing a xor of a register with itself should clear it
	
	#same process, albeit smaller number due to limitations of immediate size
	addi a0, a0, 0x3ca
	xori a0, a0, 0x3ca #should also clear
	
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ebreak
    nop
    nop
    nop
    nop
    nop
    nop
    nop