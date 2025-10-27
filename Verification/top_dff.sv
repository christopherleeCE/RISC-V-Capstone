`timescale 1ns/1ns // timescale for simulator, 1 ns as time unit, 1ns precision

module top_dff#(parameter int size = 8)();
// adjust the size of the flip-flop and buses
logic [size-1:0] d, q;
logic clk, rst, en;

logic [size] h; // used to model ideal flip flop (golden model)

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

// reset test - enable reset then disable
initial begin
    rst = 1'b0; // reset enabled for several clock cycles
    repeat(10)@(negedge clk); // repeat for a few more clock cycles
    rst = 1'b1; // reset disabled
end

// testing the enable - alternate between both states
initial begin
    while (1'b1) begin // cycle indefinitely
        en = 1'b1; // enable the flip-flop
        repeat(5)@(negedge clk);
        en = 1'b0; // disable the flip-flop
        repeat(5)@(negedge clk);
    end
end

// creating random values to input into the dff
always @(negedge clk) begin
    d = $random();
end

// golden reference model - expected behavior for dff
always @(posedge clk) begin
    if (!rst) begin
        h <= '0; // reset active
    end else if (en) begin
        h <= d; // reset not active, dff enabled
    end else begin
        h <= h; // reset not active, dff not enabled
    end
end

// evaluating dff output
always @(posedge clk) begin
    #10 // brief delay for setup
    unique case (1'b1)
        // check dff doesn't change when disabled
        (rst && !en): 
                assert(h == q) else $error("q changing when dff is disabled");
        // checks dff changes when enabled
        (rst && en):
                assert(h == q) else $error("dff not accepting values");
        // checks reset is working
        default: assert(q == '0) else $error("dff is not resetting");
    endcase
end

endmodule
