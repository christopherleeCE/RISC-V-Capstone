module alu
#(parameter data_width = 32) // width of input data - default 32 bits for RISC-V
(
    input logic [datawidth-1:0] operand_a, operand_b, // data input
    input logic func3, func7, // control signals
    output logic [datawidth-1:0] result // data output
    
);

endmodule