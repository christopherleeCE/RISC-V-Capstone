//reg file, registers and encoding seen below

/*

x           ABI name
====================
x0          zero
x1          ra
x2          sp
x3          gp
x4          tp
x5          t0
x6          t1
x7          t2

x8          s0/fp
x9          s1
x10         a0
x11         a1
x12         a2
x13         a3
x14         a4
x15         a5

x16         a6
x17         a7
x18         s2
x19         s3
x20         s4
x21         s5
x22         s6
x23         s7

x24         s8
x25         s9
x26         s10
x27         s11
x28         t3
x29         t4
x30         t5
x31         t6

*/

module reg_file #(
    parameter REG_BIT_WIDTH = 32,
    parameter NUM_OF_REGS  = 32,
    parameter REG_ENCODE_WIDTH = $clog2(NUM_OF_REGS)
) (
    input logic     [REG_ENCODE_WIDTH-1:0] rs1_addr,
    input logic     [REG_ENCODE_WIDTH-1:0] rs2_addr,
    output logic    [REG_BIT_WIDTH-1:0] rs1_data,
    output logic    [REG_BIT_WIDTH-1:0] rs2_data,
    input logic            rd_wr_en,
    input logic     [REG_ENCODE_WIDTH-1:0] rd_addr,
    input logic     [REG_BIT_WIDTH-1:0] rd_data,
    input logic            clk, rst
);

    logic [REG_BIT_WIDTH-1:0] regs_out [0:NUM_OF_REGS-1];
    //array of REG_BIT_WIDTH busses with NUM_OF_REGS busses in the array
    //addressing this array works as follows 
    //
    //regs_out[ 'REG WE ARE ADDRESSING' ][ 'BIT FROM REG, LEAVE EMPTY IF WE WANT ALL 32' ]
    //imagine the [REG_BIT_WIDTH-1:0] in the declaration pops out to the end of the declaration
    //so now its regs_out[0:NUM_OF_REGS-1][REG_BIT_WIDTH-1:0] 

    assign rs1_data = regs_out[rs1_addr];
    assign rs2_data = regs_out[rs2_addr];

    //this is a genvar loop, its a tool in sv to use a forloop to generate modules (in this case to generate 31 regs)
    
    // zero register -  a hardcoded zero
    assign regs_out[0] = '0;

    // generate the remaining registers
    genvar ii;
    generate
        for(ii = 1; ii < NUM_OF_REGS; ii++) begin : gen_regs
                dff_async_reset #(.WIDTH(REG_BIT_WIDTH)) 
                reg_ii (.d(rd_data), .clk(clk), .rst(rst), .wr_en(rd_wr_en && (rd_addr == ii)), .q(regs_out[ii]));
        end
    endgenerate

endmodule