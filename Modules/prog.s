#assembly of instruction_memory.txt from end of F25 semester
    
    addi   a0, x0, 10        # a0 = 10
    addi   t0, x0, 0         # t0 = 0
    nop
    nop
    nop
    jal    ra, loop          # call to loop:
    nop
    nop
    nop
    ecall
loop:
    addi   t0, t0, 1         # t0++
    nop
    nop
    nop
    beq    a0, t0, done      # if (t0 == a0) goto 0x40
    jal    x0, loop          # goto loop:
done:
    jalr   x0, 0(ra)         # return
