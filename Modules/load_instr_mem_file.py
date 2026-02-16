import re

# Input objdump file
input_file = "program.log"
output_file = "instruction_memory.txt"

# Regular expression to match the machine code hex
# Example line: 0: 01050513 addi a0,a0,16
hex_pattern = re.compile(r'^\s*[0-9a-f]+:\s+([0-9a-f]{8})', re.IGNORECASE)

with open(input_file, 'r') as f_in, open(output_file, 'w') as f_out:
    for line in f_in:
        match = hex_pattern.match(line)
        if match:
            machine_code = match.group(1)
            f_out.write(machine_code + '\n')

print(f"Machine code written to {output_file}")



# # ALTERNATIVE LOADER ------------------------------------------------------------------------------------------
# # Just a concept I was messing with, idea was to load both instruction and data memory simultaneously along with the
# # address of their contents. I was under the impression this syntax would work for readmemh, but it seems not. I will
# # set this aside for now, might delete later if not useful. - Edgar G.


# # Would have to use the following object file dump command, in order to reveal all sections (including .data)
# # riscv64-unknown-elf-objdump -D program_asm.o | tee program.log

# # Input objdump file, output instruction and data memory
# input_file = "program.log"
# output_text = "instruction_memory.txt"
# output_data = "data_memory.txt"

# # Regular expressions to match the machine code hex and associated address
# # Example line: 0: 01050513 addi a0,a0,16
# addr_pattern = re.compile(r'^\s*([0-9a-f]+):\s+[0-9a-f]{8}',re.IGNORECASE)
# hex_pattern = re.compile(r'^\s*[0-9a-f]+:\s+([0-9a-f]{8})', re.IGNORECASE)

# # Tracking section
# sect_txt, sect_dat = False, False

# # search through the objdump file
# with open(input_file, 'r') as f_i, open(output_text, 'w') as f_o_text, open(output_data, 'w') as f_o_data:

#     for line in f_i:
#         if re.search(r'Disassembly of section .text:', line ,re.IGNORECASE): # switch to .text
#             sect_txt, sect_dat = True, False
#         elif re.search(r'Disassembly of section .data:', line, re.IGNORECASE): # switch to .data
#             sect_txt, sect_dat = False, True
        
#         if sect_txt: # writing to instruction memory
#             match = [addr_pattern.match(line), hex_pattern.match(line)]
#             if (match[0] and match[1]):
#                 address = match[0].group(1) # extract the address and machine code
#                 machine_code = match[1].group(1)
#                 f_o_text.write(f"@{address} {machine_code}\n") # write address and  machine code

#         if sect_dat: # writing to data memory
#             match = [addr_pattern.match(line), hex_pattern.match(line)]
#             if (match[0] and match[1]):
#                 address = match[0].group(1) # extract the address and machine code
#                 machine_code = match[1].group(1)
#                 f_o_data.write(f"@{address} {machine_code}\n") # write address and machine code


# print(f"Machine code written to {output_text}.\nData/constants written to {output_data}.")