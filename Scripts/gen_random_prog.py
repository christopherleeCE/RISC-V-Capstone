import sys
from random import randint, choice

INT32_MIN = -2**31
INT32_MAX = 2**31 - 1
RAND_SECTION_LENGTH = 100
CHANCE_OF_NON_BRANCH_INSTR = 80
CHANCE_OF_COND_JMP = 80 #verses non conditional branch
CHANCE_OF_BRANCH_TAKEN = 50
CHANCE_OF_JAL_VS_JALR = 50

# !CHANCE_OF_NON_BRANCH_INSTR
#     CHANCE_OF_COND_JMP
#     *   CHANCE_OF_BRANCH_TAKEN
#     *   ***               
#     *   !CHANCE_OF_BRANCH_TAKEN
#     ***
#     !CHANCE_OF_COND_JMP

def gen_branch_section(instr:str, taken:bool, pc_offset:int) -> str:
    if(instr == "beq"):
        if(taken):
            return f"beq a0, a0, . + {4*randint(1, 6)}\n"
        else: #not taken
            return f"beq zero, a0, . + {4*randint(1, 6)}\n"
    
    if(instr == "jal"):
        return f"jal ra, . + {4*randint(1, 6)}\n"

    if(instr == "jalr"):
        return f"jalr ra, sp, {4*(pc_offset + randint(1, 6))}\n"

def main():

    #pc_offset, excludes labels
    pc_offset = 0

    non_branch_instr = ["add", "sub", "mul", "and", "or", "xor"]
    branch_instr = ["beq"]
    a_regs = ["a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7"]
    t_regs = ["t0", "t1", "t2", "t3", "t4", "t5", "t6"]
    s_regs = ["s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11"]

    with open("temp.s", "w") as f:

        for reg in a_regs:
            f.write(f"li {reg}, {randint(INT32_MIN, INT32_MAX)}\n")

        #genarate random instructions either branching or nonbranching
        label_count = 0        
        
        #tags sp with the start of "rand_main:", this gets used as a refrence for the jalr
        f.write(f"jal sp, . + 4\n")
        #no pc_offset inc here

        for ii in range(RAND_SECTION_LENGTH):

            #non branch instructions
            if(randint(0, 99) < CHANCE_OF_NON_BRANCH_INSTR):

                f.write(f"{choice(non_branch_instr)} {choice(s_regs)}, {choice(a_regs)}, {choice(a_regs)}\n")
                pc_offset = pc_offset + 1

            else: #branch instructions
                if(randint(0, 99) < CHANCE_OF_COND_JMP):
                    if(randint(0, 99) < CHANCE_OF_BRANCH_TAKEN):

                        f.write(gen_branch_section(choice(branch_instr), True, pc_offset))
                        pc_offset = pc_offset + 1

                    else:

                        f.write(gen_branch_section(choice(branch_instr), False, pc_offset))
                        pc_offset = pc_offset + 1

                else:
                    if(randint(0, 99) < CHANCE_OF_JAL_VS_JALR):

                        f.write(gen_branch_section("jal", True, pc_offset))
                        pc_offset = pc_offset + 1

                    else:

                        f.write(gen_branch_section("jalr", True, pc_offset))
                        pc_offset = pc_offset + 1


        #end of program

        for jj in range(10):
            f.write(f"nop\n")
        f.write(f"jal zero, .\n")
        f.write(f"nop\nnop\nnop\nnop\n")
        pc_offset = pc_offset + 12
        f.write(f"nop\n")
        pc_offset = pc_offset + 1


    return 0


main()


# master.ps1

# python gen random prog

# assemble (called from master.ps1 using wsl) -> program.log

# instrmem.py

# simulate_sv.ps1