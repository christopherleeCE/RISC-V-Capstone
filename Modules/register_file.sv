module register_file
#(parameter width = 32)
 //width of data flowing into register file. Default is 32 bits for RV32I
(
    input logic [width-1:0] write_data
    input logic [31:0] write_addr, read_addr_a, read_addr_b,
    input logic rf_en, clk, rst,
    output logic [width-1:0] read_data_a, read_data_b

);

//buses and arrays
logic reg_en [31:0]; //enable signal for each register
logic [size-1:0] rf_out [31:0]; //output of all registers


//decoder: enables register for write address
assign reg_en[write_addr] = rf_en ? 1'b1 : 1'b0;

//initializing registers

//mux: read data for read address A
assign read_data_a = rfout[read_addr_a];

//mux: read data for read address B
assign read_data_b = rfout[read_addr_b];

endmodule