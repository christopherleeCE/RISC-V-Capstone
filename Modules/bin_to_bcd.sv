/*
BINARY TO BCD CONVERTER - COMBINATIONAL LOGIC, VERSION 1

This module converts binary to binary-coded decimal. 


The parameters are:
1. Width of the binary value in bits (8-,16-,64-bit, etc.)
   Default is 8-bit.
2. Width of the BCD value, in other words how many BCD digits are desired
   (3 = ones, tens, and hundreds)

To calculate required BCD digits, use log10(2^bits), and round up. For 
proper operation, I would use one of the following pairs as input for the
parameters:

8-bit:     8     3
16-bit:    16    5
32-bit     32    10
64-bit:    64    20
128-bit:   128   39  

The inputs are:
1. The binary value through a multi-bit bus
2. Signed selector - 0 for unsigned, 1 for signed

The outputs are:
1. The binary-coded decimal value as an array of four-bit buses
2. Negative flag (works if signed representation is on) - 0 if positive,
   1 if negative


This module uses the Double Dabble algorithm. The algorithm is adjusted
in representation to allow for the implementation as a circuit with no
sequential logic. This module expands on the implementation of the 8-bit
circuit.

 -Edgar G.

*/

module bin_to_bcd
#(
    parameter int bin_width = 8,
    parameter int bcd_width = 3
)
(
    input logic [bin_width-1:0] bin_input,
    input logic sign_en,
    output logic [3:0] bcd_output [bcd_width-1:0],
    output logic negative_flag
);

//this will hold the magnitude of input binary - this will be unsigned
logic [bin_width-1:0] bin_magnitude;

//this creates a grid of wires to hold the bit values between "stages"
parameter int grid_width = bcd_width*4;
parameter int grid_depth = bin_width-2;
logic [grid_width-1 : 0] main_grid [grid_depth-1 : 0];

//for use in synthesizing repetitive hardware
genvar i;
genvar j;

//INPUT STAGE ---------------------------------------------------------------
//obtain the magnitude before conversion and trip a flag if negative
always_comb begin
    unique case (1'b1)
        sign_en && bin_input[bin_width-1]: bin_magnitude = ~bin_input + 1'b1;
        default: bin_magnitude = bin_input;
    endcase
end

assign negative_flag = sign_en ? bin_input[bin_width-1] : 1'b0; 

//input to grid - binary, padded with zeros after msb
assign main_grid[0] = {'0, bin_magnitude};

//CONVERSION STAGE -------------------------------------------------------
//Converting the binary value to binary-coded decimal using comparators
//and adders in a specific pattern. These are implemented in the generate
//blocks to build the circuit. Most of the values and conditions were
//derived via direct observation of the 8-bit circuit and then some trial
//and error. I might attempt to simplify these expressions, but for now,
//please be very, very careful if changing anything in this section!

generate
    //generate each level of the grid
    for(i = grid_depth-2; i >= 0; i--) begin : grid_assignment

        //need a way to keep track of an offset starting at 0.
        localparam int offset = grid_depth-i-1;

        //adds the comparator and adder units where needed
        //at each level, we implement these four-bit units starting from the
        //offset, until we can't fit any more
        for (j = offset; j < grid_width-4; j += 4) begin : submodule_assignment
            //bus so we don't have to rewrite this repeatedly
            logic [3:0] four_in;
            assign four_in = main_grid[i][j+3:j];

            //create the compare-add "submodule"
            //this is directly from the algorithm
            assign main_grid[i+1][j+3:j] =
            (four_in >= 4'd5) ? four_in + 4'd3 : four_in;
        end

        //links any remaining wires that aren't fed into a submodule
        for (j = 0; j < grid_width; j++) begin : bypass_assignment
            if(j < offset || j >= grid_width - (4 - (offset % 4))) begin
                assign main_grid[i+1][j] = main_grid[i][j];
            end
        end
    end
endgenerate


//OUTPUT STAGE -----------------------------------------------------------
//feed the output from the grid into each bcd output digit
generate
    for(i = 0; i < bcd_width; i++) begin : output_assignment
        assign bcd_output[i] = main_grid[grid_depth-1][(i*4)+3:i*4];
    end
endgenerate

endmodule