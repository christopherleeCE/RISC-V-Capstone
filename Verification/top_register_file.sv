`timescale 1ns/1ns
module top_register_file#(parameter int width = 32)();

// declaring parameters/inputs
logic [width-1:0] write_data;
logic [4:0] write_addr, read_addr_a, read_addr_b;
logic rf_en, clk, rst;
logic [width-1:0] read_data_a, read_data_b;

// used to create golden model
logic [width-1:0] gold [31:0];

// instantiate the module
register_file#(width) dut_register_file(.*);

// create clock signal for register file
initial begin
    clk = 1'b0 ; // start clock signal
    forever begin // change the clock
        #20 // 20 nanoseconds is 50 MHz, freq. of DE10 Lite clock
        clk = !clk;
    end
end

//create values on the negative clock edge for the DUT and golden model
always @(negedge clk) begin
    write_data = $random();
end

//gold reference standard - an ideal register file
always @(posedge clk) begin

    gold[0] <= '0; //zero register (never changes)

    if (!rst)
        gold <= '{32{'0}}; // reset active
    else if (rf_en && write_addr != 0)
        gold[write_addr] <= write_data; // reset not active, dff enabled
    else
        gold <= gold; // reset not active, dff not enabled
end

// start the test
initial begin
    //Instantiating values
    rst = 1'b0; // reset enabled
    rf_en = 1'b0; // register file not enabled
    {write_addr,read_addr_a,read_addr_b} = 5'd0;
    repeat(10)@(posedge clk); // repeat for a few more clock cycles
    rst = 1'b1; // reset disabled

    // attempt to write data to the register file
    rf_en = 1'b1; //register file enabled
    for(int w = 0; w < 32; w++) begin
        @(posedge clk); //wait for next clock edge
        write_addr = w; // change write address
        $display("All contents in DUT: %p", dut_register_file.rf_out);
    end

    // attempt to overwrite data
    rf_en = 1'b0; //register file disabled
    for(int w = 0; w < 32; w++) begin
        @(posedge clk); //wait for next clock edge
        write_addr = w; // change write address
    end

    // Verify the output
    $display("Contents of DUT and model:");
    // $display("All contents in DUT: %p", dut_register_file.rf_out);
    // $display("All contents in gold model: %p", gold);
    for(int r = 0; r < 32; r++) begin
        @(posedge clk);
        read_addr_a = r; // update the read address
        read_addr_b = r;

        //DIRECT MONITORING: ouputs stored values, comment if not needed
        $display("register: %d, gold: %h, DUT: %h", r, gold[r], dut_register_file.rf_out[r]);
        $display("read address a: %d, read address b: %d", read_addr_a, read_addr_b);

        //EVALUATING
        // check registers
        assert(gold[r] == dut_register_file.rf_out[r]) else $error("Value for register %d does not match model.", r);

        //check muxes
        assert(gold[r] == read_data_a) else $error("Mux A is not routing data from register %d.", r);
        assert(gold[r] == read_data_b) else $error("Mux B is not routing data from register %d.", r);
        $display("read a:%h read b:%h ", read_data_a, read_data_b);
        
    end

    //Reset check
    rst = 1'b0; // reset enabled
    for(int r = 0; r < 32; r++) begin
        @(posedge clk);
        //check reset functionality works
        assert(dut_register_file.rf_out[r] == 0) else $error("Register %d did not reset", r);
        // $display("register: %d, gold: %h, DUT: %h", r, gold[r], dut_register_file.rf_out[r]);
    end
end

endmodule
