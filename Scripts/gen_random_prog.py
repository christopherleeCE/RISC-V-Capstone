import sys
from re import match, IGNORECASE
from random import randint, choice

INT32_MIN = -2**31
INT32_MAX = 2**31 - 1
INT12_MIN = -2**11
INT12_MAX = 2**11 - 1
INT20_MIN = -2**19
INT20_MAX = 2**19 - 1
UINT20_MIN = 0
UINT20_MAX = 2**20 - 1
RAND_SECTION_LENGTH = 800
CHANCE_OF_NON_BRANCH_INSTR = 80
CHANCE_OF_STORE_LOAD_INSTR = 20
CHANCE_OF_STORE_VS_LOAD = 50
CHANCE_OF_COND_JMP = 80 #verses non conditional branch
CHANCE_OF_BRANCH_TAKEN = 50
CHANCE_OF_JAL_VS_JALR = 50

#instructions implemented so far
arth_instr = ["add", "sub", "xor", "or", "and", "sll", "srl", "sra", "slt", "sltu",
            "mul", "mulh", "mulhsu", "mulhu", "div", "divu", "rem", "remu",
            "addi", "xori", "ori", "andi", "slli", "srli", "srai", "slti", "sltiu",
            "lui", "auipc"]
load_instr = ["lb", "lh", "lw", "lbu", "lhu"]
store_instr = ["sb", "sh", "sw"]
cond_branch_instr = ["beq", "bne", "blt", "bge"]#, "bltu", "bgeu"]
a_regs = ["a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7"]
t_regs = ["t0", "t1", "t2", "t3", "t4", "t5", "t6"]
s_regs = ["s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11"]

R_TYPE  = ["add", "sub", "xor", "or", "and", "sll", "srl", "sra", "slt", "sltu",
        "mul", "mulh", "mulhsu", "mulhu", "div", "divu", "rem", "remu"]
I_TYPE_ARITH = ["addi", "xori", "ori", "andi", "slli", "srli", "srai", "slti", "sltiu"]
U_TYPE = ["lui", "auipc"]

# CHANCE_OF_NON_BRANCH_INSTR
#     !CHANCE_OF_STORE_LOAD_INSTR
#     * <arth instructions
#     *
#     CHANCE_OF_STORE_LOAD_INSTR
#         CHANCE_OF_STORE_VS_LOAD
#
# !CHANCE_OF_NON_BRANCH_INSTR
#     CHANCE_OF_COND_JMP
#     *   CHANCE_OF_BRANCH_TAKEN
#     *   ***               
#     *   !CHANCE_OF_BRANCH_TAKEN
#     ***
#     !CHANCE_OF_COND_JMP

# todo, byte offsets in load and store
# lui, and auipc

def gen_branch_instr(instr:str, taken:bool, pc_offset:int) -> str:
    if(instr == "beq"):
        if(taken):
            return choice((f"beq t1, t2, . + {4*randint(1, 6)}\n",
                           f"beq t4, t5, . + {4*randint(1, 6)}\n"))
        else: #not taken
            return choice((f"beq zero, t1, . + {4*randint(1, 6)}\n",
                           f"beq zero, t4, . + {4*randint(1, 6)}\n"))
        
    elif(instr == "bne"):
        if(taken):
            return choice((f"bne zero, t1, . + {4*randint(1, 6)}\n",
                           f"bne zero, t4, . + {4*randint(1, 6)}\n"))
        else: #not taken
            return choice((f"bne t1, t2, . + {4*randint(1, 6)}\n",
                           f"bne t4, t5, . + {4*randint(1, 6)}\n"))

    elif(instr == "blt"):
        if(taken):
            return choice((f"blt t0, t1, . + {4*randint(1, 6)}\n",
                           f"blt t6, t5, . + {4*randint(1, 6)}\n"))
        else: #not taken
            return choice((f"blt t1, t0, . + {4*randint(1, 6)}\n",
                           f"blt t5, t6, . + {4*randint(1, 6)}\n"))
        
    elif(instr == "bge"):
        if(taken):
            return choice((f"bge t1, t0, . + {4*randint(1, 6)}\n", #greater then
                           f"bge t5, t6, . + {4*randint(1, 6)}\n", #greater then
                           f"bge t1, t2, . + {4*randint(1, 6)}\n", #equal to
                           f"bge t4, t5, . + {4*randint(1, 6)}\n",))#equal to
        else: #not taken
            return choice((f"bge t0, t1, . + {4*randint(1, 6)}\n", #less then
                           f"bge t6, t5, . + {4*randint(1, 6)}\n")) #less then
        
    elif(instr == "bltu"):
        if(taken):
            return choice((f"bltu t3, t0, . + {4*randint(1, 6)}\n", #pos < 0
                           f"bltu t3, t6, . + {4*randint(1, 6)}\n", #neg < 0
                           f"bltu t0, t6, . + {4*randint(1, 6)}\n")) #pos < neg
        else: #not taken
            return choice((f"bltu t0, t3, . + {4*randint(1, 6)}\n", #pos > 0
                           f"bltu t6, t3, . + {4*randint(1, 6)}\n", #neg > 0
                           f"bltu t6, t0, . + {4*randint(1, 6)}\n", #neg > pos
                           f"bltu t1, t2, . + {4*randint(1, 6)}\n", #pos == pos
                           f"bltu t4, t5, . + {4*randint(1, 6)}\n")) #neg == neg

    elif(instr == "bgeu"):
        if(taken):
            return choice((f"bgeu t0, t3, . + {4*randint(1, 6)}\n", #pos > 0
                           f"bgeu t6, t3, . + {4*randint(1, 6)}\n", #neg > 0
                           f"bgeu t6, t0, . + {4*randint(1, 6)}\n", #neg > pos
                           f"bgeu t1, t2, . + {4*randint(1, 6)}\n", #pos == pos
                           f"bgeu t4, t5, . + {4*randint(1, 6)}\n")) #neg == neg
        else: #not taken
            return choice((f"bgeu t3, t0, . + {4*randint(1, 6)}\n", #pos < 0
                           f"bgeu t3, t6, . + {4*randint(1, 6)}\n", #neg < 0
                           f"bgeu t0, t6, . + {4*randint(1, 6)}\n")) #pos < neg
            
    elif(instr == "jal"):
        return f"jal ra, . + {4*randint(1, 6)}\n"

    elif(instr == "jalr"):
        return f"jalr ra, sp, {4*(pc_offset + randint(1, 6))}\n"
    
    else: # no match, for whatever reason
         return f"{instr}: THROW ERROR PLEASE :)\n"

def gen_arth_instr(instr:str, dest_reg:int, src_reg1:int, src_reg2:int) -> str:

    #R-type instructions
    if instr in R_TYPE:
        return f"{instr} {dest_reg}, {src_reg1}, {src_reg2}\n"

    #I-type (arithmetic)
    elif instr in I_TYPE_ARITH:
        if (match(r'sr|sll', instr, IGNORECASE)):
            # for immediate shifts
            return f"{instr} {dest_reg}, {src_reg1}, {randint(0, 31)}\n"
        
        elif(match(r'slti|sltiu', instr, IGNORECASE)):
            #jank way of doing it but i dont feel like adding to the probabilties, uses a regs with different distribution
            return f"{instr} {dest_reg}, {choice(a_regs)}, {randint(INT12_MIN, INT12_MAX)}\n"

        else:
            return f"{instr} {dest_reg}, {src_reg1}, {randint(INT12_MIN, INT12_MAX)}\n"
        
    elif instr in U_TYPE:
        return f"{instr} {dest_reg}, {randint(UINT20_MIN, UINT20_MAX)}\n"
        
    else: # no match, for whatever reason
         return f"{instr}: THROW ERROR PLEASE :)\n"
    
def gen_load_instr(instr:str, dest_reg:int):

    if(instr == "lw"):
        return f"{instr} {dest_reg}, {4*randint(0, 63)}(gp)\n"

    elif(instr == "lh"):
        return f"{instr} {dest_reg}, {2*randint(0, 127)}(gp)\n"

    elif(instr == "lb"):
        return f"{instr} {dest_reg}, {randint(0, 255)}(gp)\n"

    elif(instr == "lhu"):
        return f"{instr} {dest_reg}, {2*randint(0, 127)}(gp)\n"

    elif(instr == "lbu"):
        return f"{instr} {dest_reg}, {randint(0, 255)}(gp)\n"

    else:
        return f"{instr}: THROW ERROR PLEASE :)\n"

def gen_store_instr(instr:str, dest_reg:int):

    if(instr == "sw"):
        return f"{instr} {dest_reg}, {4*randint(0, 63)}(gp)\n"

    elif(instr == "sh"):
        return f"{instr} {dest_reg}, {2*randint(0, 127)}(gp)\n"

    elif(instr == "sb"):
        return f"{instr} {dest_reg}, {randint(0, 255)}(gp)\n"

    else:
        return f"{instr}: THROW ERROR PLEASE :)\n"

def main():

    #pc_offset, excludes labels
    pc_offset = 0

    with open("temp.s", "w") as f:

        f.write("li t0, 17\n")
        f.write("li t1, 32\n")
        f.write("li t2, 32\n")
        f.write("li t3, 0\n") #not used
        f.write("li t4, -13\n")
        f.write("li t5, -13\n")
        f.write("li t6, -37\n")
        f.write("\n")
        f.write("li gp, 0x1000\n")
        f.write("\n")

        for ii in range(64):
            f.write(f"li s0, {randint(-100, 100)}\n")
            f.write(f"sw s0, {4*ii}(gp)\n")
        f.write("\n")

        for reg in s_regs:
            f.write(f"li {reg}, {randint(INT32_MIN, INT32_MAX)}\n")
        f.write("\n")

        for reg in a_regs:
            f.write(f"li {reg}, {randint(INT12_MIN, INT12_MAX)}\n")
        f.write("\n")

        #genarate random instructions either branching or nonbranching
        label_count = 0        
        
        #tags sp with the start of "rand_main:", this gets used as a refrence for the jalr
        f.write(f"jal sp, . + 4\n")
        #no pc_offset inc here

        for ii in range(RAND_SECTION_LENGTH):

            #reset pc offset, and rerwrite sp to avoid going out of bounds of the jalr im bounds
            if(4*pc_offset > 2000):
                pc_offset = 0
                for jj in range(10):
                    f.write(f"nop\n") #its possible that the sp reset gets jumped past, pad with nops to prevent that
                f.write(f"jal sp, . + 4\n")

            #non branch instructions
            if(randint(0, 99) < CHANCE_OF_NON_BRANCH_INSTR):

                if(randint(0, 99) < CHANCE_OF_STORE_LOAD_INSTR):
                    if(randint(0, 99) < CHANCE_OF_STORE_VS_LOAD):
                        f.write(gen_store_instr(choice(store_instr), choice(s_regs)))
                        pc_offset = pc_offset + 1

                    else:
                        f.write(gen_load_instr(choice(load_instr), choice(s_regs)))
                        pc_offset = pc_offset + 1

                else:
                    f.write(gen_arth_instr(choice(arth_instr), "ra",
                                                    choice(s_regs), choice(s_regs)))
                    pc_offset = pc_offset + 1

            else: #branch instructions
                if(randint(0, 99) < CHANCE_OF_COND_JMP):
                    if(randint(0, 99) < CHANCE_OF_BRANCH_TAKEN):

                        f.write(gen_branch_instr(choice(cond_branch_instr), True, pc_offset))
                        pc_offset = pc_offset + 1

                    else:

                        f.write(gen_branch_instr(choice(cond_branch_instr), False, pc_offset))
                        pc_offset = pc_offset + 1

                else:
                    if(randint(0, 99) < CHANCE_OF_JAL_VS_JALR):

                        f.write(gen_branch_instr("jal", True, pc_offset))
                        pc_offset = pc_offset + 1

                    else:

                        f.write(gen_branch_instr("jalr", True, pc_offset))
                        pc_offset = pc_offset + 1
        f.write("\n")

        #end of program

        for jj in range(7):
            f.write(f"nop\n")
        f.write("ebreak\n")
        for kk in range(7):
            f.write(f"nop\n")
        pc_offset = pc_offset + 15


    return 0


main()
