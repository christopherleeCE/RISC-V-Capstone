/* 
By Edgar G.

I created this top file to practice writing verification, learn QuestaSim, and test the dff.
I was able to visually confirm the flip-flop works by generating waveforms. However, the flip-flop
is a simple design, and assert statements would be better for more complex designs in the future.

*/

`timescale 1ns/1ns // timescale for simulator, 1 ns as time unit, 1ns precision

module top_dff#(parameter int size = 8)();
// adjust the size of the flip-flop and buses
logic [size-1:0] d, q;
logic clk, rst, en;

// instantiate the module
dff#(size) my_dff(.*);

// create clock signal for dff
initial begin
    clk = 1'b0 ; // start clock signal
    while(1'b1) begin // change the clock
        #20 // 20 nanoseconds is 50 MHz, freq. of DE10 Lite clock
        clk = !clk;
    end
end

// Note the signals changing on the falling edge.
// This takes the set-up and hold time of the dff into account.
// testing the reset
initial begin
    rst = 1'b0; // reset enabled
    repeat(10)@(negedge clk); // reset releases on negative edge
    rst = 1'b1; // reset disabled
end

//testing the enable
initial begin
    while (1'b1) begin
        en = 1'b1; // enable the flip-flop
        repeat(5)@(negedge clk);
        en = 1'b0; // disable the flip-flop
        repeat(5)@(negedge clk);
    end
end

//creating random values to input into the flip-flop
always @(negedge clk) begin
    d = $random();
end

endmodule
