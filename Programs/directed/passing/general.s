start:
        addi a0, zero, 0x10
        addi a1, zero, 0x17
        add a2, a0, a1
        lui a3, 0xF
        sub a4, a1, a0
        jal ra, . + 4
        addi t0, t0, 0x30
        addi t1, t1, 0x34
        addi t2, t2, 0x38
        jal ra, label + 4
        addi a5, zero, 0x3C
        addi a5, zero, 0x40
label:
        addi a5, zero, 0x44
        sw a2, 0xC(zero)
        lw a6, 0xC(zero)
        addi a7, zero, 0x40
        nop
        beq t0, zero, beq_label
        sw a0, 0(zero)
        sw a1, 4(zero)
        sw a2, 8(zero)
        sw a3, 12(zero)
        beq a5, zero, beq_label
        lw s8, 0(zero)
        lw s9, 4(zero)
        lw s10, 8(zero)
        lw s11, 16(zero)
beq_label:
        lw s11, 0(zero)
        lw s10, 4(zero)
        lw s9, 8(zero)
        lw s8, 12(zero)
        sw a4, 16(zero)
        sw a5, 20(zero)
        sw a6, 24(zero)
        sw a7, 28(zero)

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