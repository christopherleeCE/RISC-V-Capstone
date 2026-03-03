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
    input logic alu_sel_div,
    input logic alu_sel_divu,
    input logic alu_sel_rem,
    input logic alu_sel_remu,
    input logic alu_sel_and,
    input logic alu_sel_or,
    input logic alu_sel_xor,
    input logic alu_sel_sll,
    input logic alu_sel_srl,
    input logic alu_sel_sra,
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

// NOTE - This operator "/" appears to be the most straightforward way to
// do division in SystemVerilog within one-clock cycle. However, it is
// stated the circuit generated during synthesis is particularly resource
// intensive; if any alternatives are known, they might be worth exploring.

always_comb begin
    unique case(1'b1)
    alu_sel_add : result = operand_a + operand_b; // ADD
    alu_sel_sub : result = operand_a - operand_b; // SUB
    alu_sel_mul : result = product_ss[WIDTH-1:0];         // MUL
    alu_sel_mulh : result = product_ss[2*WIDTH-1:WIDTH];  // MULH
    alu_sel_mulhsu : result = product_su[2*WIDTH-1:WIDTH]; // MULHSU
    alu_sel_mulhu : result = product_uu[2*WIDTH-1:WIDTH];  // MULHU

    alu_sel_div : begin // DIV
    if(signed_b == 0)                                                           result = {WIDTH{1'b1}};
    else if(signed_a == {1'b1,{(WIDTH-1){1'b0}}} && signed_b == {WIDTH{1'b1}})  result = signed_a;
    else                                                                        result = signed_a / signed_b;
                end

    alu_sel_divu: begin // DIVU
        if (operand_b == 0) result = {WIDTH{1'b1}};
        else result = operand_a / operand_b;
                end

    alu_sel_rem : begin // REM
    if(signed_b == 0)                                                           result = signed_a;
    else if (signed_a == {1'b1,{(WIDTH-1){1'b0}}} && signed_b == {WIDTH{1'b1}}) result = {WIDTH{1'b0}};
    else                                                                        result = signed_a % signed_b;
                end

    alu_sel_remu: begin // REMU
    if (operand_b == 0) result = operand_a;
    else result = operand_a % operand_b;
    end

    alu_sel_and : result = operand_a & operand_b; // AND
    alu_sel_or : result = operand_a | operand_b; // OR
    alu_sel_xor : result = operand_a ^ operand_b; // XOR
    alu_sel_sll : result = operand_a << operand_b[4:0]; // SLL
    alu_sel_srl : result = operand_a >> operand_b[4:0]; // SRL (zero-extension)
    alu_sel_sra : result = signed_a >>> operand_b[4:0]; // SRA (msb-extension)
    alu_sel_slt : result = {31'b0,slt_result}; // SLT
    alu_sel_sltu : result = {31'b0,sltu_result}; // SLTU
    default : result = '0;
    endcase
end

// Flag assignments
assign zero_flag = ( result == '0 ); 
assign less_than = alu_sel_sltu ? sltu_result : slt_result;

endmodule

/* interesting findings about the / and % operator while fixing a divide by zero error, -chris

there are 4 implemenations i tried for the 4 div instrucitons

    alu_sel_div : result = signed_a / signed_b; // DIV
    alu_sel_divu : result = operand_a / operand_b; //DIVU
    alu_sel_rem : result = signed_a % signed_b; // REM
    alu_sel_remu : result = operand_a % operand_b; //REMU

>>>

    //if dividing by zero, return -1
    alu_sel_div : result = (signed_b == 0) ? {WIDTH{1'b1}} : signed_a / signed_b; // DIV
    alu_sel_divu : result = (operand_b == 0) ? {WIDTH{1'b1}} : operand_a / operand_b; //DIVU

    //if MOD by zero, return dividen (in A % 0, return A)
    alu_sel_rem : result = (signed_b == 0) ? signed_a : signed_a % signed_b; // REM
    alu_sel_remu : result = (operand_b == 0) ? operand_a : operand_a % operand_b; //REMU

>>>

        alu_sel_div: begin
            if (signed_b == 0)
                result = {WIDTH{1'b1}};  // div by zero
            else if (signed_a == {1'b1,{(WIDTH-1){1'b0}}} && signed_b == {WIDTH{1'b1}})
                result = signed_a;       // overflow case: INT_MIN / -1
            else
                result = signed_a / signed_b;
        end

        // DIVU (unsigned)
        alu_sel_divu: begin
            if (operand_b == 0)
                result = {WIDTH{1'b1}};  // div by zero
            else
                result = operand_a / operand_b;
        end

        // REM (signed)
        alu_sel_rem: begin
            if (signed_b == 0)
                result = signed_a;       // mod by zero
            else if (signed_a == {1'b1,{(WIDTH-1){1'b0}}} && signed_b == {WIDTH{1'b1}})
                result = {WIDTH{1'b0}};  // overflow case: INT_MIN % -1
            else
                result = signed_a % signed_b;
        end

        // REMU (unsigned)
        alu_sel_remu: begin
            if (operand_b == 0)
                result = operand_a;      // mod by zero
            else
                result = operand_a % operand_b;
        end

>>>

    and the current one

they go bad, less bad, better and best, the first has all out divide by zero errors, but the weird 
thing is that at some point i think the 32'hxxxxxxxx's that are a result of that error
cause the operands in the alu to switch some how, some sort of questa simulation bull shit,
the better works to fix the num/0 error, however by using a terminary operator in 
a switch statemetn, there is a separate issue, for some reason very valid division like 
POSINT / POSINT resolves to zero, the third option in the comment above doesnt resolve ina 
error however there is an edge case you can see in the current implementation to handle the
single overflow that is possible, 0x80000000 / -1 which results in 2147483648, which is out
of the 32bit bounds so the rv isa calls to return 0x80000000 instead. this does happen even
without the else if in the current implenentation, however that behavior may be simulation 
dependent (according gpt :), so explicitly put it asa case in the iff tree

//i think the operand swap was just cus i was printing out the wrong signal, im too lazy to go back and look at it :)

  here is the program to recreate the results if the need ever arises

  
#div and rem
li a1, 53
li a0, 10
 div x20, a1, a0 # 5
 rem x21, a1, a0 # 3
divu x22, a1, a0 # 5
remu x23, a1, a0 # 3
 div x24, a0, a1 # 0
 rem x25, a0, a1 # 10
divu x26, a0, a1 # 0
remu x27, a0, a1 # 10

li a1, 53
li a0, -10
 div x20, a1, a0 # -5
 rem x21, a1, a0 # 3
divu x22, a1, a0 # 0
remu x23, a1, a0 # 53
 div x24, a0, a1 # 0
 rem x25, a0, a1 # -10
divu x26, a0, a1 # 81,037,118
remu x27, a0, a1 # 32

li a1, -53
li a0, 10
 div x20, a1, a0 # -5
 rem x21, a1, a0 # -3
divu x22, a1, a0 # 429,496,724
remu x23, a1, a0 # 3
 div x24, a0, a1 # 0
 rem x25, a0, a1 # 10
divu x26, a0, a1 # 0
remu x27, a0, a1 # 10

li a1, -53
li a0, -10
 div x20, a1, a0 # 5
 rem x21, a1, a0 # -3
divu x22, a1, a0 # 0
remu x23, a1, a0 # -53
 div x24, a0, a1 # 0
 rem x25, a0, a1 # -10
divu x26, a0, a1 # 1
remu x27, a0, a1 # 43

li a0, 23
li a1, -23
 div x20, a0, zero # -1
 rem x21, a0, zero # 23
divu x22, a0, zero # -1
remu x23, a0, zero # 23
 div x24, a1, zero # -1
 rem x25, a1, zero # -23
divu x26, a1, zero # -1
remu x27, a1, zero # -23
 div x20, zero, a0 # 0
 rem x21, zero, a0 # 0
divu x22, zero, a0 # 0
remu x23, zero, a0 # 0
 div x24, zero, a1 # 0
 rem x25, zero, a1 # 0
divu x26, zero, a1 # 0
remu x27, zero, a1 # 0

li a0, 23
li a1, -23
 div x20, zero, zero # -1
 rem x21, zero, zero # 0
divu x22, zero, zero # -1
remu x23, zero, zero # 0
 div x20, a0, a0 # 1
 rem x21, a0, a0 # 0
divu x22, a0, a0 # 1
remu x23, a0, a0 # 0
 div x24, a1, a1 # 1
 rem x25, a1, a1 # 0
divu x26, a1, a1 # 1
remu x27, a1, a1 # 0

li a1, 0x80000000
li a0, -1
 div x20, a1, a0 # -2147483648
 rem x21, a1, a0 # 0
divu x22, a1, a0 # 0
remu x23, a1, a0 # -2147483648
 div x24, a0, a1 # 0
 rem x25, a0, a1 # -1
divu x26, a0, a1 # 1
remu x27, a0, a1 # 2147483647

li a1, 0x80000000
li a0, 0x7FFFFFFF
 div x20, a1, a0 # -1
 rem x21, a1, a0 # -1
divu x22, a1, a0 # 1
remu x23, a1, a0 # 1
 div x24, a0, a1 # 0
 rem x25, a0, a1 # 2147483647
divu x26, a0, a1 # 0
remu x27, a0, a1 # 2147483647

nop
nop
nop
nop
nop
ebreak
nop
nop
nop
nop
nop

*/