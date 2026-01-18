# chris's test program ##

        li t0, 0xFF
        sw t0, 0(zero)
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

        # addi a0, zero, 0x1
        # addi a0, zero, 0x2
        # addi a0, zero, 0x3
        # addi a0, zero, 0x4
        # addi a0, zero, 0x5
        # addi a0, zero, 0x6
        # addi a0, zero, 0x7
        # addi a0, zero, 0x8
        # addi a0, zero, 0x9
        # addi a0, zero, 0xA
        # #nop


# start:
#         addi a0, zero, 0
#         addi a1, zero, 4
#         addi a2, zero, 8
#         addi a3, zero, 12
#         jal zero, label
#         sub a0, a0, zero
#         sub a1, a1, zero
#         sub a2, a2, zero
#         sub a3, a3, zero
# label:
#         addi a4, a4, 16
#         nop
#         nop
#         nop
#         nop
#         nop
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


        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0


##mul test from chat ##
#         .section .text
#         .globl _start
# _start:

#         # Test values
#         li      t0, 0x010      # 16 decimal
#         li      t1, 0x003      # 3 decimal
#         li      t2, -4               # signed negative
#         lui     t2, 0xFFFFF
#         li      t3, 0xFFE       # unsigned large (4294967294)
#         lui     t3, 0xFFFFF

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
        # jal     zero, end


# start:
#         addi a0, zero, 16
#         addi a1, zero, 32
        
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         jal ra, label0
# label0:
#         addi a2, zero, 72
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100
#         addi a0, zero, 100


