module instruction_memory
#(
    parameter int BIT_WIDTH,
    parameter int ENTRY_COUNT,
    parameter int ADDR_WIDTH=32 // byte-addressable memory 
) 
(
    input logic [ADDR_WIDTH-1:0] read_address,
    output logic [BIT_WIDTH-1:0] read_data
);

// Note: Entry count is in bytes currently
logic [BIT_WIDTH-1:0] instr_mem [0:ENTRY_COUNT-1]; //instantiate the instruction memory

initial begin
    $readmemh("instruction_memory.txt", instr_mem); //load the memory
end

assign read_data = instr_mem[read_address[ADDR_WIDTH-1:2]];//read every group of four bytes

endmodule