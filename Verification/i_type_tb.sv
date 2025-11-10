/*
TESTING: ADDI, LW

We can have a main TB for the CPU if we really need to, but I like the idea of smaller, seperate TBs for each instruction 
type. In theory, each type will have a similar datapath, so in theory, each type could use a similar verification process,
I'll have to see for sure though.

I have a couple ideas for a TB but I have to figure out the implementation and see if it works. I'll be focused on these 
instructions for now; to others doing verification, please feel free to test the other instructions, thank you!



*/
`timescale 1ns/1ns

module i_type_tb ();
//constants
parameter int CLOCK_PERIOD = 20;
parameter int NUM_INSTRUCTIONS = 2; //Will go up to 14 for all I-type

//declare the buses and signals
logic clk, rst;
reg [31:0] instruction_memory [NUM_INSTRUCTIONS-1:0];

//golden model
int instruction_track; //NOT the program counter, only for verification
//four registers for transferring instructions alongside CPU pipeline
logic [31:0] IF_ID, ID_EX, EX_MEM, MEM_WB;


//instantiate the CPU
// riscv_cpu cpu_dut(.clk(clk), .rst(rst));


//booting the memory and starting
initial begin
    rst = 1'b0; //shut down the CPU during startup
    instruction_track = 0;
    clk = 1'b0;
    // list the instructions here:
    instruction_memory[NUM_INSTRUCTIONS-1:0] = '{32'h11111111, 32'h44444444};
    
    $writememh("instruction_memory.txt", instruction_memory); //transfer to instruction memory of CPU

    #1 //brief delay for setup

    rst = 1'b1; //disable the reset
    forever begin //start the clock
        #CLOCK_PERIOD
        clk = ~clk;
    end
end


//transfering instructions - asynchronous to match CPU registers
//helps verification follow the CPU's pipeline
always@(posedge clk or negedge rst) begin
    if(!rst) begin //resets the pipeline and tracker
        {IF_ID, ID_EX, EX_MEM, MEM_WB} <= '0;
        instruction_track = 0;
    end else begin
        if (instruction_track <= NUM_INSTRUCTIONS-1) begin
            IF_ID <= instruction_memory[instruction_track]; //advances instruction
        end else begin
            IF_ID <= 32'hDEADBEEF; //no more instructions
        end
        //continues advancing instructions
        ID_EX <= IF_ID;
        EX_MEM <= ID_EX;
        MEM_WB <= EX_MEM;
        instruction_track += 1;
    end
end


//start simulation of the CPU
always @(posedge clk) begin
    if(MEM_WB == 32'hDEADBEEF) begin
        $stop(); //program ends after all instructions are completed
    end else if (instruction_track > 4) begin
        //verification begins once first instruction has reached write back stage
        $display("Instructions in pipeline:");
        $display("IF_ID: %h, ID_EX: %h, EX_MEM: %h, MEM_WB: %h\n", IF_ID, ID_EX, EX_MEM, MEM_WB);

        // TO REPLACE WITH VERIFICATION LATER
    end
end


//startup and loading instruction into memory

endmodule