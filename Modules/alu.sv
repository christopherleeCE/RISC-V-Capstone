module alu
#(parameter WIDTH = 32)
(
    input logic [WIDTH-1:0] operand_a, operand_b,
    input logic alu_sel_add,
    input logic alu_sel_sub,
    input logic alu_sel_nop,
    input logic alu_sel_pass1,
    input logic alu_sel_pass2,
    output logic [WIDTH-1:0] result
);

// Consider adding these in the future
// output logic zero_flag, overflow_flag, carryout_flag

//initialize the ALU
always_comb begin
    unique case(1'b1)
    alu_sel_add     :   result = operand_a + operand_b;
    alu_sel_sub     :   result = operand_a - operand_b;
    alu_sel_nop     :   result = '0;
    alu_sel_pass1   :   result = operand_a;
    alu_sel_pass2   :   result = operand_b;
    endcase
end

endmodule