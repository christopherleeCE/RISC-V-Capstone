module top_dff_async_reset
#(parameter data_width = 8)(); //width 1 byte

//create buses of proper width
logic [data_width-1:0] d, q; // data input/out
logic clk, rst, wr_en; //control signals
logic [data_width-1:0] h; //

//Instantiate the dff
dff_async_reset#(.WIDTH(data_width)) dut_dff(.*);

// create clock signal for dff
initial begin
    clk = 1'b0 ; // start clock signal
    while(1'b1) begin // change the clock
        #20 // 20 nanoseconds is 50 MHz, freq. of DE10 Lite clock
        clk = !clk;
    end
end

// golden reference model - expected behavior for dff
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        h <= '0; // reset active
    end else if (wr_en) begin
        h <= d; // reset not active, dff enabled
    end else begin
        h <= h; // reset not active, dff not enabled
    end
end

// reset test - enable reset then disable
initial begin
    //Assume values in register at start are undefined, not zero
    rst = 1'b1; // reset disabled at start
    repeat(100)@(negedge clk);
    rst = 1'b0; // reset test
    repeat(10)@(negedge clk);
    $stop(); //pause simulation, optional
    //$finish() also works, but will prompt to exit Questa
end

// testing the enable - alternate between both states
initial begin
    while (1'b1) begin // cycle indefinitely
        wr_en = 1'b1; // enable the flip-flop
        repeat(5)@(negedge clk); // maintain for several clock cycles
        wr_en = 1'b0; // disable the flip-flop
        repeat(5)@(negedge clk);
    end
end

// creating random values to input into the dff
always @(negedge clk) begin
    d = $random();
end

// evaluating dff output
always @(posedge clk) begin
    #10 // brief delay for setup
    unique case (1'b1)
        // check dff doesn't change when disabled
        (rst && !wr_en): 
                assert(h == q) else $error("q changing when dff is disabled");
        // checks dff changes when enabled
        (rst && wr_en):
                assert(h == q) else $error("dff not accepting values");
        // checks reset is working
        default: assert(q == '0) else $error("dff is not resetting");
    endcase
end

endmodule