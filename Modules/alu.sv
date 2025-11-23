module alu
#(
    parameter WIDTH = 32
)(
    input logic [WIDTH-1:0] operand_a, operand_b,
    input logic alu_sel_add,
    input logic alu_sel_sub,
    input logic alu_sel_mul,
    input logic alu_sel_mulh,
    input logic alu_sel_mulhsu,
    input logic alu_sel_mulhu,
    input logic alu_sel_and,
    input logic alu_sel_or,
    input logic alu_sel_slt,
    output logic zero_flag,
    output logic [WIDTH-1:0] result
);

// Consider adding these in the future
// output logic overflow_flag, carryout_flag

//initialize the ALU

// Define signed operands
logic signed [WIDTH-1:0] operand_a_s, operand_b_s;
assign operand_a_s = operand_a;
assign operand_b_s = operand_b;

always_comb begin
    unique case(1'b1)
    alu_sel_add : result = operand_a + operand_b; // ADD
    alu_sel_sub : result = operand_a - operand_b; // SUB
    alu_sel_mul : result = ( operand_a * operand_b );                // MUL
    alu_sel_mulh : result = ( operand_a_s * operand_b_s ) >>> WIDTH; // MULH
    alu_sel_mulhsu : result = ( operand_a_s * operand_b ) >>> WIDTH; // MULHSU
    alu_sel_mulhu : result = ( operand_a * operand_b ) >> WIDTH;     // MULHU
    alu_sel_and : result = operand_a & operand_b; // AND
    alu_sel_or : result = operand_a | operand_b; // OR
    alu_sel_slt : result = operand_a < operand_b; // SLT
    default : result = '0;
    endcase
end

// Zero flag logic
assign zero_flag = ( result == '0 );

endmodule