module alu
#(
    parameter WIDTH = 32,
    parameter CONTROL = 3
    )
(
    input logic [WIDTH-1:0] operand_a, operand_b,
    //input logic alu_sel_add,
    //input logic alu_sel_sub,
    //input logic alu_sel_nop,
    //input logic alu_sel_pass1,
    //input logic alu_sel_pass2,
    input logic [CONTROL-1:0] alu_control,
    output logic zero_flag,
    output logic [WIDTH-1:0] result
);

// Consider adding these in the future
// output logic overflow_flag, carryout_flag

//initialize the ALU
/*
always_comb begin
    unique case(1'b1)
    alu_sel_add     :   result = operand_a + operand_b;
    alu_sel_sub     :   result = operand_a - operand_b;
    alu_sel_nop     :   result = '0;
    alu_sel_pass1   :   result = operand_a;
    alu_sel_pass2   :   result = operand_b;
    endcase
end
*/
// ALU control logic
always_comb begin
    unique case(alu_control)
    3'b000 : result = operand_a + operand_b; // ADD
    3'b001 : result = operand_a - operand_b; // SUB
    3'b010 : result = operand_a & operand_b; // AND
    3'b011 : result = operand_a | operand_b; // OR
    3'b101 : result = operand_a < operand_b; // SLT
    endcase
end

// Zero flag logic
assign zero_flag = ( result == '0 );

endmodule