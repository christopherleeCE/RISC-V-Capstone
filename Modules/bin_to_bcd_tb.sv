/*
Quick, rough testbench I threw together for the BCD module. Select the bin and bcd size in
parameters, and then choose an upper and lower range in binary values. The output will
be BCD and must be evaluated manually in current implementation.

UPDATE: "For loop" temporarily removed for debugging...

-Edgar G.

*/

`timescale 1ns/1ns
module bin_to_bcd_tb ();

//Parameters
parameter int bin_width = 32;
parameter int bcd_width = 10;

//FOR TESTING
parameter logic [bin_width-1 : 0] upper_limit_s = 32'b0111_1111_1111_1111_1111_1111_1111_1111;
parameter logic [bin_width-1 : 0] lower_limit_s = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
parameter logic [bin_width-1 : 0] upper_limit_u = 32'b1111_1111_1111_1111_1111_1111_1111_1111;
parameter logic [bin_width-1 : 0] lower_limit_u = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
parameter logic sign_en = 1'b1;

//Logic
logic [bin_width-1:0] bin_input;
logic [3:0] bcd_output [bcd_width-1:0];
logic negative_flag;

//Variables
int i;

//instantiate main module
bin_to_bcd #(.bin_width(bin_width), .bcd_width(bcd_width)) bin_to_bcd_dut
(.bin_input(bin_input), .sign_en(sign_en), .bcd_output(bcd_output), .negative_flag(negative_flag));

initial begin
    
    bin_input = upper_limit_s;
    #10 //delay for circuit to settle

    $display("\n\nInput value: %b", bin_to_bcd_dut.bin_input); //before correction for signed
    $display("Input magnitude: %b", bin_to_bcd_dut.bin_magnitude);//after
    
    //alert if signed representation is enabled
    if(sign_en) begin
        $display("Signed representation is...ON");
    end else begin
        $display("Signed representation is...OFF");
    end

    $display("\nThe bcd outputs are:");
    if(negative_flag) begin
        $display("\tSign: -");
    end else begin
        $display("\tSign: +");
    end
    for(i = bcd_width-1; i >= 0; i--) begin
        $display("\t10^%d : %b %d", i, bcd_output[i], bcd_output[i]);
    end


    $stop();
end
endmodule