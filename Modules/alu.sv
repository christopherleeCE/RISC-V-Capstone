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
    input logic alu_sel_sltu,
    output logic zero_flag,
    output logic negative_flag,
    output logic overflow_flag,
    output logic carryout_flag,
    output logic [WIDTH-1:0] result
);

// Signed operands for signed operations
logic signed [WIDTH-1:0] signed_a, signed_b, fake_signed_b;
assign signed_a = operand_a;
assign signed_b = operand_b;

// Define signed products (64 bit results)
logic [2*WIDTH-1:0] product_ss;   // signed * signed
logic [2*WIDTH-1:0] product_su;   // signed * unsigned
logic [2*WIDTH-1:0] product_uu;   // unsigned * unsigned

assign product_ss = signed_a * signed_b;
assign product_uu = operand_a * operand_b;

// When you do 'su' multiply, the '*' operator treats both operands as unsigned instead.

// To Fix, when the unsigned version of b is negative as a signed number, 
// do 2's complement on unsigned b to change it to what it would be if positive, then store as signed value. 
// If b is already positive as both signed or unsigned, just change it to signed immediately.

assign fake_signed_b = (operand_b[WIDTH-1]) ? ( ~(operand_b) + 1'b1 ) :  signed_b; 
assign product_su = signed_a * fake_signed_b;

// Pre-compute common arithmetic results (Due to use of flags, result is stored as a 33-bit value first)
logic [WIDTH:0] add_result, sub_result;
assign add_result = operand_a + operand_b;
assign sub_result = operand_a - operand_b;

// Pre-compute comparisons (These are initially 1 bit values)
logic slt_result, sltu_result;
assign slt_result = signed_a < signed_b;
assign sltu_result = operand_a < operand_b;

always_comb begin
    unique case(1'b1)
    alu_sel_add : result = add_result[WIDTH-1:0]; // ADD
    alu_sel_sub : result = sub_result[WIDTH-1:0]; // SUB
    alu_sel_mul : result = product_ss[WIDTH-1:0];         // MUL
    alu_sel_mulh : result = product_ss[2*WIDTH-1:WIDTH];  // MULH
    alu_sel_mulhsu : result = product_su[2*WIDTH-1:WIDTH]; // MULHSU
    alu_sel_mulhu : result = product_uu[2*WIDTH-1:WIDTH];  // MULHU
    alu_sel_and : result = operand_a & operand_b; // AND
    alu_sel_or : result = operand_a | operand_b; // OR
    alu_sel_slt : result = {31'b0,slt_result}; // SLT
    alu_sel_sltu : result = {31'b0,sltu_result}; // SLTU
    default : result = '0;
    endcase
end

// Flag assignments
assign zero_flag = ( result == '0 );
assign negative_flag = result[WIDTH-1];
assign overflow_flag = ( alu_sel_add && ( operand_a[WIDTH-1] == operand_b[WIDTH-1] ) && ( result[WIDTH-1] != operand_a[WIDTH-1] )  )  
                        || 
                        ( alu_sel_sub && ( operand_a[WIDTH-1] != operand_b[WIDTH-1] ) && ( result[WIDTH-1] != operand_a[WIDTH-1] )   );
assign carryout_flag = ( alu_sel_add && ( add_result[WIDTH] ) ) ||
                       ( alu_sel_sub && ( sub_result[WIDTH] ) );

endmodule