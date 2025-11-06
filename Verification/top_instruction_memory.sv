`timescale 1ns/1ns 

module top_instruction_memory ();
parameter int CLOCK_PERIOD = 20;

parameter int BIT_WIDTH = 32;
parameter int ENTRY_COUNT = 32;

int byte_addr = 0;
logic [31:0] read_data; // declare the bus sizes
logic clk;

//instantiate the module
instruction_memory #(
    .BIT_WIDTH(BIT_WIDTH),
    .ENTRY_COUNT(ENTRY_COUNT)
) dut_instruction_memory (
    .read_address(byte_addr),
    .read_data(read_data)
);

//start a clock
initial begin
    clk = 1'b0;
    forever begin
        #CLOCK_PERIOD
        clk = !clk;
    end
end

always @(posedge clk) begin 
    byte_addr += 4; //simulate program counter
end

always @(negedge clk) begin
    //retrieve the output of the memory and display
    $display("output at address %d is %h", byte_addr, read_data);
    if(byte_addr/4 == ENTRY_COUNT) begin
        $stop(); //end the simulation after reaching end of memory
    end
end

endmodule