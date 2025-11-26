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

// Define signed products
logic signed [2*WIDTH-1:0] product_ss;   // signed * signed
logic signed [2*WIDTH-1:0] product_su;   // signed * unsigned
logic signed [2*WIDTH-1:0] product_uu;   // unsigned * unsigned

assign product_ss = {{32{operand_a[31]}}, operand_a} * {{32{operand_b[31]}}, operand_b};
assign product_su = {{32{operand_a[31]}}, operand_a} * {{32{1'b0}}, operand_b};
assign product_uu = {{32{1'b0}}, operand_a} * {{32{1'b0}}, operand_b};

// Pre-compute common arithmetic results
logic [WIDTH-1:0] add_result, sub_result;
assign add_result = operand_a + operand_b;
assign sub_result = operand_a - operand_b;
logic eq_flag;
assign eq_flag = (operand_a == operand_b);

always_comb begin
    unique case(1'b1)
    alu_sel_add : result = add_result; // ADD
    alu_sel_sub : result = sub_result; // SUB
    alu_sel_mul : result = product_ss[WIDTH-1:0];         // MUL
    alu_sel_mulh : result = product_ss[2*WIDTH-1:WIDTH];  // MULH
    alu_sel_mulhsu : result = product_su[2*WIDTH-1:WIDTH]; // MULHSU
    alu_sel_mulhu : result = product_uu[2*WIDTH-1:WIDTH];  // MULHU
    alu_sel_and : result = operand_a & operand_b; // AND
    alu_sel_or : result = operand_a | operand_b; // OR
    alu_sel_slt : result = operand_a < operand_b; // SLT
    default : result = '0;
    endcase
end

// Zero flag logic
assign zero_flag = alu_sel_sub ? eq_flag : ( result == '0 );

endmodule