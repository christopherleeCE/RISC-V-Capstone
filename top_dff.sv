/* 
By Edgar G.
I created this top file to practice writing verification, learn QuestaSim, and test the dff.
*/

`timescale 1ns/1ns // timescale for simulator, 1 ns as time unit, 1ns precision

module top_dff#(parameter int size = 8)();
// adjust the size of the flip-flop and buses
logic [size-1:0] d, q;
logic clk, rst, en;

logic [size] h; // for holding last random value

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

always @(posedge clk) begin
    h <= d;
    #5 // short delay for setup/hold
    unique case (1'b1)
        //check flip-flop doesn't change when disabled
        (rst && !en): assert(h != q) else $error("q changing when dff is disabled");
        //checks flip-flop changes when enabled
        (rst && en): assert(h == q) else $error("dff not accepting values");
        //checks reset is working
        default: assert(q == '0) else $error("dff is not resetting");
    endcase
end

endmodule
