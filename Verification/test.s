    .section .text
    .globl _start

_start:

    # ----------------------------
    # Load Immediate
    # ----------------------------
    li x1, 5           # pseudo-instruction → addi x1, x0, 5
    li x2, 10          # pseudo-instruction → addi x2, x0, 10

    # ----------------------------
    # Conditional branch pseudo-instructions
    # ----------------------------
    bgt x2, x1, label1  # pseudo-instruction → blt x1, x2, label1 (branch if x2>x1)
    blt x1, x2, label2  # real instruction

    beq x1, x2, label3  # branch if equal
    bne x1, x2, label4  # branch if not equal

label1:
    # ----------------------------
    # Move pseudo-instruction
    # ----------------------------
    mv x3, x1          # pseudo-instruction → addi x3, x1, 0

label2:
    # ----------------------------
    # Not / Neg pseudo-instructions
    # ----------------------------
    neg x4, x2         # pseudo-instruction → sub x4, x0, x2
    not x5, x1         # pseudo-instruction → xori x5, x1, -1

label3:
    # ----------------------------
    # Set less than pseudo-instructions
    # ----------------------------
    seqz x6, x1        # pseudo-instruction → sltiu x6, x1, 1
    snez x7, x2        # pseudo-instruction → sltu x0, x2, x0; x7 = !zero?

label4:
    j _start           # infinite loop
