_start:

    # Test values
    li      t0, 0x010      # 16 decimal
    li      t1, 0x003      # 3 decimal
    li      t2, -4               # signed negative
    li      t3, -2         # unsigned 0xFFFFFFFE

    # -----------------------
    # MUL: signed * signed -> lower 32 bits
    mul     a0, t0, t1          # 16 * 3 = 48
    # Expected a0 = 48

    # MULH: signed * signed -> upper 32 bits
    mulh    a1, t2, t1          # -4 * 3 = -12 -> upper 32 bits
    # Expected a1 = 0xFFFFFFFF (high 32 of -12)

    # MULHSU: signed * unsigned -> upper 32 bits
    mulhsu  a2, t2, t3          # -4 * 0xFFFFFFFE
    # Expected a2 = 0xFFFFFFFF (high 32)

    # MULHU: unsigned * unsigned -> upper 32 bits
    mulhu   a3, t0, t3          # 16 * 0xFFFFFFFE
    # Expected a3 = 0x0000000F (high 32)

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