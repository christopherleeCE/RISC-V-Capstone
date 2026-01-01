## chris's test program ##
start:
        addi a0, zero, 0x10
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        addi a1, zero, 0x17
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        add a2, a0, a1
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        lui a3, 0xF
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sub a4, a1, a0
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        jal ra, start #switch back to . + 4
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        addi a5, zero, 0x30
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        addi a5, zero, 0x34
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        addi a5, zero, 0x38
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        jal ra, label + 4
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        addi a5, zero, 0x3C
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        addi a5, zero, 0x40
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
label:
        addi a5, zero, 0x44
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sw a5, 0x0(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        lw a6, 0x0(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        addi a7, zero, 0x40
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        jalr ra, a7, 0x8
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        nop
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        beq a5, zero, beq_label
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        nop
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        beq a5, a6, beq_label
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        nop
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
beq_label:
        sw a0, 0(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sw a1, 1(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sw a2, 2(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sw a3, 3(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sw a4, 4(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sw a5, 5(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sw a6, 6(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0
        sw a7, 7(zero)
        # nop #DNR
        # nop #DNR
        # nop #DNR
        # nop #DNR0

## addi test program ##
# start:
#         addi a0, zero, 0x10
#         addi a1, zero, 0x17
#         addi a5, zero, 0x30     #this is not executing under the dut a5 is not being written to, but it can be written to, if addi a0, a0, 0x10 is changed to addi a5 it will write correclty
#         addi a5, zero, 0x34
#         addi a5, zero, 0x38
#         addi a5, zero, 0x3C
#         addi a5, zero, 0x40
#         addi a5, zero, 0x44
#         addi a5, zero, 0x48
#         addi a5, zero, 0x4C
#         #nop




## mul test from chat ##
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
#         jal     zero, end


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


