#
#simplecpu
#  a very simple machine--- not quite simplest, but simple
#  Created March 2017 by Seth Abraham
#  modified October 2017 by SA for 498 class demo
#  modified March 2018 by SA for spring 333 class
#  modified October 2018 by SA for fall 333 class
#  modified Jan 2019 by SA for spring 333 class
#  modified Mar 2020 by SA for Spring 333 class
#
# format
#    SIG    name [ name ]*
#    SIGd   name [ name ]*
#  Notes:
#    signal order is significant
#    SIG is the same as SIG1, a 1 bit signal
#    name can be an _ which is a 0 bit signal non-unique name inserted for readability
#
#    CONST   name [ name ]      # defines constants 0, 1, ...
#
#   using signals:  name   or name=num
#     signal ranges are not checked, num can be a number or a defined constant
#     order of using signals is irrelevant
#     signal list end at EOL (end of line)
#     upc is advanced at EOL
#     
#
#   mnemonic OPCODE  <bit pattern>
#    bit pattern must be casex acceptible (with ? and _)
#
#    label: <EOL>    # defines a uaddr constant with value of upc
#
# Note that symbols with names starting with UC_ will have their
# names and values written to the sig_declare file
# If you want a microcode address constant, this is how you access
# it from verilog. (other than the constants in the instruction decoder)
#
#
# Signals:
#

#only some signals are defined for you already
#You must add whatever microcode signals you use
#

#SIG dummy

#SIG retire was initially used to show the status of the CPU
#after all the microcycles of an instruction had been processed
#we could probably find a way to use it in a pipeline sense
#for now, i'll leave it commented

#SIG retire

SIG halt
SIG branch_en
SIG jump_en
SIG reg_file_wr_en
SIG dbus_sel_alu
SIG dbus_sel_data_mem
SIG dbus_sel_pc_plus_4
SIG data_mem_wr_en
SIG alu_use_im
SIG alu_sel_add
SIG alu_sel_sub
SIG alu_sel_mul
SIG alu_sel_mulh
SIG alu_sel_mulhsu
SIG alu_sel_mulhu
SIG alu_sel_and
SIG alu_sel_or
SIG alu_sel_xor
SIG alu_sel_slt
SIG alu_sel_sltu

ADD OPCODE 000_0000____?_????____?_????____000____?_????____011_0011
alu_sel_add
dbus_sel_alu 
reg_file_wr_en

SUB OPCODE 010_0000____?_????____?_????____000____?_????____011_0011
alu_sel_sub
dbus_sel_alu
reg_file_wr_en

XOR OPCODE 000_0000____?_????____?_????____100____?_????____011_0011
alu_sel_xor
dbus_sel_alu
reg_file_wr_en

OR OPCODE 000_0000____?_????____?_????____110____?_????____011_0011
alu_sel_or
dbus_sel_alu
reg_file_wr_en

AND OPCODE 000_0000____?_????____?_????____111____?_????____011_0011
alu_sel_and
dbus_sel_alu
reg_file_wr_en

SLT OPCODE 000_0000____?_????____?_????____010____?_????____011_0011
alu_sel_slt
dbus_sel_alu
reg_file_wr_en

SLTU OPCODE 000_0000____?_????____?_????____011____?_????____011_0011
alu_sel_sltu
dbus_sel_alu
reg_file_wr_en

MUL OPCODE 000_0001____?_????____?_????____000____?_????____011_0011
alu_sel_mul
dbus_sel_alu
reg_file_wr_en

MULH OPCODE 000_0001____?_????____?_????____001____?_????____011_0011
alu_sel_mulh
dbus_sel_alu
reg_file_wr_en

MULHSU OPCODE 000_0001____?_????____?_????____010____?_????____011_0011
alu_sel_mulhsu
dbus_sel_alu
reg_file_wr_en

MULHU OPCODE 000_0001____?_????____?_????____011____?_????____011_0011
alu_sel_mulhu
dbus_sel_alu
reg_file_wr_en

LW  OPCODE ???_????____?_????____?_????____010____?_????____000_0011
alu_sel_add
alu_use_im
dbus_sel_data_mem
reg_file_wr_en

SW  OPCODE ???_????____?_????____?_????____010____?_????____010_0011
alu_sel_add
alu_use_im
data_mem_wr_en

BEQ OPCODE ???_????____?_????____?_????____000____?_????____110_0011
alu_sel_sub
branch_en

ADDI OPCODE ???_????____?_????____?_????____000____?_????____001_0011
alu_sel_add 
alu_use_im
dbus_sel_alu
reg_file_wr_en

ORI OPCODE ???_????____?_????____?_????____110____?_????____001_0011
alu_sel_or 
alu_use_im
dbus_sel_alu
reg_file_wr_en

XORI OPCODE ???_????____?_????____?_????____100____?_????____001_0011
alu_sel_xor 
alu_use_im
dbus_sel_alu
reg_file_wr_en

ANDI OPCODE ???_????____?_????____?_????____111____?_????____001_0011
alu_sel_and 
alu_use_im
dbus_sel_alu
reg_file_wr_en

# ---------------------- U-TYPE -------------------------------------------
# (should we organize by types to reduce clutter?)
LUI OPCODE ???_????____?_????____?_????____???____?_????____011_0111
alu_sel_add
alu_use_im
dbus_sel_alu
reg_file_wr_en

JAL OPCODE ???_????____?_????____?_????____???____?_????____110_1111
jump_en
dbus_sel_pc_plus_4
reg_file_wr_en

JALR OPCODE ???_????____?_????____?_????____000____?_????____110_0111
jump_en
alu_sel_add
alu_use_im
dbus_sel_pc_plus_4
reg_file_wr_en

# DUMMY OPCODE ???_????____?_????____?_????____010____?_????____000_0000
# dummy

#
# DO NOT delete this UD_fault microcode
# it will be invoked if the opcode in the IR is illegal
# the mkrom program expects this to be defined
#
UD_fault:
halt




