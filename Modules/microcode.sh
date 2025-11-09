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

SIG dummy
SIG retire
SIG halt
SIG branch_en
SIG reg_file_wr_en
SIG pipeline_advance
SIG dbus_sel_alu
SIG dbus_sel_data_mem
SIG data_mem_wr_en
SIG alu_use_im
SIG r_type
SIG i_type
SIG s_type
SIG b_type
SIG u_type
SIG j_type
SIG alu_sel_add
SIG alu_sel_sub
SIG alu_sel_and
SIG alu_sel_or
SIG alu_sel_slt

ADD OPCODE ???????_?????_?????_000_?????_0110011
r_type 
alu_sel_add 
reg_file_wr_en

SUB OPCODE 0100000_?????_?????_000_?????_0110011
r_type
alu_sel_sub
reg_file_wr_en

LW  OPCODE ???????_?????_?????_010_?????_0000011
i_type
alu_sel_add
alu_use_im
dbus_sel_data_mem
reg_file_wr_en

SW  OPCODE ???????_?????_?????_010_?????_0100011
s_type
alu_sel_add
alu_use_im
data_mem_wr_en

#
# DO NOT delete this UD_fault microcode
# it will be invoked if the opcode in the IR is illegal
# the mkrom program expects this to be defined
#
UD_fault:
dummy




