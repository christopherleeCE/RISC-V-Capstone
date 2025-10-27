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

//value to check writing to register file works
initial begin
    write_data = 32'hdeadbeef;
end

//gold reference standard - an ideal register file
always @(posedge clk) begin

    gold[0] <= '0; //zero register (never changes)

    if (!rst) begin
        gold <= '{32{'0}}; // reset active
    end else if (rf_en && write_addr != 0) begin
        gold[write_addr] <= write_data; // reset not active, dff enabled
    end else begin
        gold <= gold; // reset not active, dff not enabled
    end
end

int num_registers = 32; //number of registers - 32 for RISC-V 
// start the test
initial begin
    //Instantiating values
    rst = 1'b0; // reset enabled
    rf_en = 1'b0; // register file not enabled
    write_addr = 5'd0;
    read_addr_a = 5'd0;
    read_addr_b = 5'd0;
    repeat(num_registers)@(negedge clk);
    rst = 1'b1; // reset disabled
    repeat(num_registers)@(negedge clk);
    rf_en = 1'b1; //register file enabled
end

// start writing to registers
// change addresses on negative edge for sufficient setup time
int current_address = 0; // initialize the current address
always@(negedge clk) begin
    if(current_address == num_registers) begin
        current_address = 0; //reset after all registers covered
    end
    //cycle write address and read address - for changing data
    //and verification of output
    write_addr = current_address;
    read_addr_a = current_address;
    read_addr_b = current_address;
end

// assert the behavior of register file matches the gold reference
// perform read shortly after positive edge since rf writes on positive edge
always@(posedge clk) begin
    #5 //brief delay for sufficient hold time
    // compare with reference and identify mismatches
    assert(gold == dut_register_file.rf_out) else 
    $error("Write failed for register %d.", current_address);
    assert(gold[current_address] == read_data_a && 
    gold[current_address]== read_data_b) else
    $error("Read failed for address %d.", current_address);

    //increment address after writing and reading completed
    current_address++;
end
endmodule
