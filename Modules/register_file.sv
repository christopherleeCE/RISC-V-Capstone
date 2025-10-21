module register_file
#(parameter size = 32) //address width of the register file
(
    input logic [size-1:0] data_in, write_addr, read_addr_a, read_addr_b,
    input logic rf_en,
    input logic clk,
    input logic rst,
    output logic [size-1:0] data_a_out, data_b_out

);



endmodule