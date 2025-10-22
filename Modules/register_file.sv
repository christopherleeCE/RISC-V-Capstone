module register_file
#(parameter width = 32)
 //width of data flowing into register file. Default is 32 bits for RV32I
(
    input logic [width-1:0] write_data,
    input logic [4:0] write_addr, read_addr_a, read_addr_b,
    input logic rf_en, clk, rst,
    output logic [width-1:0] read_data_a, read_data_b
);

//buses and arrays
logic [31:0] reg_en; //enable signal for each register
logic [width-1:0] rf_out [31:0]; //output array of buses from each register


// //decoder: enables register based on write address
assign reg_en = rf_en ? 32'b1 << write_addr : '0;

//initializing 32 registers for the register files
dff#(width) registers[31:0] (.d(write_data), .clk, .rst, .en(reg_en), .q(rf_out));

//mux: read out data for read address A
assign read_data_a = rf_out[read_addr_a];

//mux: read out data for read address B
assign read_data_b = rf_out[read_addr_b];

endmodule