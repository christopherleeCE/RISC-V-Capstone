import re

# Input objdump file, output instruction and data memory
input_file = "program.log"
output_text = "instruction_memory.txt"
output_data = "data_memory.txt"

# Regular expressions to match the machine code hex and associated address
# Example line: 0: 01050513 addi a0,a0,16
addr_pattern = re.compile(r'^\s*([0-9a-f]+):\s+[0-9a-f]{8}',re.IGNORECASE)
hex_pattern = re.compile(r'^\s*[0-9a-f]+:\s+([0-9a-f]{8})', re.IGNORECASE)

# Tracking section
sect_txt, sect_dat = False, False

# search through the objdump file
with open(input_file, 'r') as f_i, open(output_text, 'w') as f_o_text, open(output_data, 'w') as f_o_data:

    for line in f_i:
        if re.search(r'Disassembly of section .text:', line ,re.IGNORECASE): # switch to .text
            sect_txt, sect_dat = True, False
        elif re.search(r'Disassembly of section .data:', line, re.IGNORECASE): # switch to .data
            sect_txt, sect_dat = False, True
        
        if sect_txt: # writing to instruction memory
            match = [addr_pattern.match(line), hex_pattern.match(line)]
            if (match[0] and match[1]):
                address = match[0].group(1) # extract the address and machine code
                machine_code = match[1].group(1)
                f_o_text.write(f"@{address} {machine_code}\n") # write address and  machine code

        if sect_dat: # writing to data memory
            match = [addr_pattern.match(line), hex_pattern.match(line)]
            if (match[0] and match[1]):
                address = match[0].group(1) # extract the address and machine code
                machine_code = match[1].group(1)
                f_o_data.write(f"@{address} {machine_code}\n") # write address and machine code

print(f"Machine code written to {output_text}.\nData/constants written to {output_data}.")