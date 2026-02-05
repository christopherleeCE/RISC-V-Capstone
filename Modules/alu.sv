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
    input logic alu_sel_xor,
    input logic alu_sel_slt,
    input logic alu_sel_sltu,
    output logic zero_flag,
    output logic less_than,
    output logic [WIDTH-1:0] result
);

// Signed operands for signed operations
logic signed [WIDTH-1:0] signed_a, signed_b;
assign signed_a = operand_a;
assign signed_b = operand_b;

// Define signed products (64 bit results)
logic [2*WIDTH-1:0] product_ss;   // signed * signed
logic [2*WIDTH-1:0] product_su, pre_product_su;   // signed * unsigned
logic [2*WIDTH-1:0] product_uu;   // unsigned * unsigned

// Fix for signed-unsigned multiplication
logic [31:0] su_fix;

assign product_ss = signed_a * signed_b;
assign product_uu = operand_a * operand_b;
assign pre_product_su = signed_a * operand_b;

// When you do 'su' multiply, the '*' operator treats both operands as unsigned instead.
// This means operand_a is incorrectly treated as a large positive number when it's actually negative.

// To fix, add the two's complement of operand_b to only the upper 32 bits of the pre-product
// I currently do not know why this works, but it does. Just something I noticed while testing.
assign su_fix = pre_product_su[2*WIDTH-1:WIDTH] + ( ~(operand_b) + 1'b1 );

// Only apply the fix if operand_a is negative as a signed number
assign product_su = (operand_a[WIDTH-1]) ? { su_fix, pre_product_su[WIDTH-1:0] } : pre_product_su;

// Pre-compute comparisons (These are initially 1 bit values)
logic slt_result, sltu_result;
assign slt_result = signed_a < signed_b;
assign sltu_result = operand_a < operand_b;

always_comb begin
    unique case(1'b1)
    alu_sel_add : result = operand_a + operand_b; // ADD
    alu_sel_sub : result = operand_a - operand_b; // SUB
    alu_sel_mul : result = product_ss[WIDTH-1:0];         // MUL
    alu_sel_mulh : result = product_ss[2*WIDTH-1:WIDTH];  // MULH
    alu_sel_mulhsu : result = product_su[2*WIDTH-1:WIDTH]; // MULHSU
    alu_sel_mulhu : result = product_uu[2*WIDTH-1:WIDTH];  // MULHU
    alu_sel_and : result = operand_a & operand_b; // AND
    alu_sel_or : result = operand_a | operand_b; // OR
    alu_sel_xor : result = operand_a ^ operand_b; // XOR
    alu_sel_slt : result = {31'b0,slt_result}; // SLT
    alu_sel_sltu : result = {31'b0,sltu_result}; // SLTU
    default : result = '0;
    endcase
end

// Flag assignments
assign zero_flag = ( result == '0 ); 
assign less_than = ( ( result == '1 ) && alu_sel_slt );

endmodule