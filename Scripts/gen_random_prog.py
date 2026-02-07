import sys
from random import randint, choice

INT32_MIN = -2**31
INT32_MAX = 2**31 - 1

def main():

    instr = ["add", "sub", "mul", "and", "or", "xor"]
    a_regs = ["a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7"]
    t_regs = ["t0", "t1", "t2", "t3", "t4", "t5", "t6"]
    s_regs = ["s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11"]

    with open("temp.s", "w") as f:

        for reg in a_regs:
            f.write(
                f"li {reg}, {randint(INT32_MIN, INT32_MAX)}\n"
            )

        for ii in range(16):
            f.write(
                f"{choice(instr)} {choice(s_regs)}, {choice(a_regs)}, {choice(a_regs)}\n"
            )

        for jj in range(7):
            f.write(
                "nop\n"
            )

        f.write("end:\njal zero end")
        f.write("nop\nnop\nnop\n")

    return 0


main()


# master.ps1

# python gen random prog

# assemble (called from master.ps1 using wsl) -> program.log

# instrmem.py

# simulate_sv.ps1