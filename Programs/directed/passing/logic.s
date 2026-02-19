# Test for AND, OR, ANDI, and ORI - Edgar G.
# Goal - manipulate specific bits
# create the value 0xabababab from 0xffffffff with AND, OR
# create the value 0x000000ab from 0x000000ff with ANDI, ORI
# repeat with both R and I type instructions

#start the program
.global _start
.text 
_start:
	#AND and OR test
	li a0, 0xffffffff #starting value
	
	li a6, 0xaaaaaaaa #load masks
	li a7, 0x0b0b0b0b
	
	and a0, a0, a6 #should create 0xaaaaaaaa
	or a0, a0, a7 #should create 0xabababab
	
	#ANDI and ORI test
	li a1, 0x000000ff #starting value
	andi a1, a1, 0x0aa #should create 0x000000aa
	ori a1, a1, 0x00b #should create 0x000000ab
	
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