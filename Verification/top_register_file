`timescale 1ns/1ns
module top_register_file#(parameter int width = 32)();

logic [width-1:0] write_data;
logic [31:0] write_addr, read_addr_a, read_addr_b;
logic rf_en, clk, rst;
logic [width-1:0] read_data_a, read_data_b;


// instantiate the module
register_file#(size) dut_register_file(.*);

// create clock signal for register file
initial begin
    clk = 1'b0 ; // start clock signal
    while(1'b1) begin // change the clock
        #20 // 20 nanoseconds is 50 MHz, freq. of DE10 Lite clock
        clk = !clk;
    end
end

// testing the reset
initial begin
    rst = 1'b0; // reset enabled
    repeat(10)@(negedge clk); // reset releases on negative edge
    rst = 1'b1; // reset disabled
end


endmodule
