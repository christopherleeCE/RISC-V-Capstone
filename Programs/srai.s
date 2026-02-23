# Very Simple SRA Test - Edgar G.
# check for sign preservation with division
.globl _start

.text

_start:
    li a0, 32 # positive dividend 
    li a1, -32 # negative dividend
    li a2, -2147483648 # lowest possible signed number

    srai a0, a0, 3 # 32/8 = 4
    srai a1, a1, 3 # -32/8 = -4
    
    srai a2, a2, 31 # -2,147,483,648/2,147,483,648 = -1 
    
    nop # pause the program
    nop
    ebreak
