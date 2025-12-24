# start:
#         addi a0, a0, 0x10
#         addi a1, a1, 0x17
#         add a2, a0, a1
#         lui a3, 0xF
#         sub a4, a1, a0
#         jal ra, . + 0x4
#         addi a5, zero, 0x30
#         addi a5, zero, 0x34
#         addi a5, zero, 0x38
#         jal ra, label + 4
#         addi a5, zero, 0x3C
#         addi a5, zero, 0x40
# label:
#         addi a5, zero, 0x44
#         sw a5, 0x0(zero)
#         lw a6, 0x0(zero)
#         addi a7, zero, 0x40
#         jalr ra, a7, 0x8
#         nop
#         beq a5, zero, beq_label
#         nop
#         beq a5, a6, beq_label
#         nop
# beq_label:
#         mul a0, a0, a1


        .section .text
        .globl _start
_start:

        # Test values
        li      t0, 0x010      # 16 decimal
        li      t1, 0x003      # 3 decimal
        li      t2, -4               # signed negative
        lui     t2, 0xFFFFF
        li      t3, 0xFFFFFFFE       # unsigned large (4294967294)
        lui     t3, 0xFFFFF

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

        # End (infinite loop)
end:
        jal     zero, end
