/*
TESTING: ADDI, LW

We can have a main TB for the CPU if we really need to, but I like the idea of smaller, seperate TBs for each instruction 
type. In theory, each type will have a similar datapath, so in theory, each type could use a similar verification process,
I'll have to see for sure though.

I have a couple ideas for a TB but I have to figure out the implementation and see if it works. I'll be focused on these 
instructions for now; to others doing verification, please feel free to test the other instructions, thank you!

- FURTHER UPDATE - I may expand this to other instruction types, but we shall see.

*/

`timescale 1ns/1ns

module i_type_tb ();
//constants
parameter int CLOCK_PERIOD = 20;
parameter int NUM_INSTRUCTIONS = 3; //Will go up
parameter int NUM_DATA_WORDS = 3;

//declare the buses and signals
logic clk, rst;
reg [31:0] instruction_memory [NUM_INSTRUCTIONS-1:0];
reg [31:0] data_memory [NUM_DATA_WORDS-1:0];

//golden model
int instruction_track; //NOT the program counter, only for verification
logic [63:0] inst_and_result; //instruction being performed and ensuing computational result
logic [63:0] if_id, id_ex, ex_mem, mem_wb; //transferring instruction and result

//I-type
logic [11:0] imm;
logic [4:0] rs1, rd;
logic [2:0] func3;
logic [6:0] opcode;


//instantiate the CPU
// riscv_cpu cpu_dut(.clk(clk), .rst(rst));



//MEMORY SETUP ------------------------------------------------------------------------------------------------------------------
//booting the memory and starting
initial begin
    //WARNING - reset could potentially mask bugs, so I will leave it off for now
    // rst = 1'b0; //reset the CPU and golden model during startup
    instruction_track = 0;
    clk = 1'b0;

    // list the instructions here:
    instruction_memory[NUM_INSTRUCTIONS-1:0] = 
    '{
        32'h00000013, //addi x0, x0, 0    nop
        32'h00402283, //lw x5, 4(x0)      lw t0, 4(zero)
        32'h00000013  //addi x0, x0, 0    nop
    };

    //list the data memory here:
    data_memory[NUM_DATA_WORDS-1:0] =
    '{
        32'hdeadbeef, //8
        32'h000000ff, //4
        32'hdeadbeef  //0
    };
    
    $writememh("instruction_memory.txt", instruction_memory); //transfer to instruction memory of CPU
    $writememh("data_memory.txt", data_memory); //transfer to data memory of CPU

    #1 //brief delay for setup
    rst = 1'b1; //disable the reset
    forever begin //start the clock
        #CLOCK_PERIOD
        clk = ~clk;
    end
end


//GOLDEN MODEL ----------------------------------------------------------------------------------------------------------------
//pipeline to follow the CPU's pipeline (asynchronous reset too)
always@(posedge clk or negedge rst) begin
    if(!rst) begin //resets the pipeline and tracker
        {if_id, id_ex, ex_mem, mem_wb} <= '0;
        instruction_track = 0;
    end else begin
        //feed instruction into half of the pipeline bus
        if (instruction_track <= NUM_INSTRUCTIONS-1) begin
            inst_and_result[63:32] <= instruction_memory[instruction_track]; //current instruction
        end else begin
            inst_and_result[63:32] <= 32'hdeadbeef; //no more instructions
        end

        //breaking instruction into components
        {imm, rs1, func3, rd, opcode} = inst_and_result[63:32]; //I-TYPE
        
        //solve the instruction and feed result into the other half of the pipeline bus
        if (opcode == 7'b0000011) begin
           if(func3 == 3'b010) begin
            inst_and_result[31:0] <= 32'haaaaaaaa; //placeholder
           end
        end else begin
            inst_and_result[31:0] <= 32'hdeadbeef; //irrelevant result
        end

        //continues advancing instructions and associated results
        if_id <= inst_and_result;
        id_ex <= if_id;
        ex_mem <= id_ex;
        mem_wb <= ex_mem;
        instruction_track += 1;

    end
end


//VERIFICATION -----------------------------------------------------------------------------------------------------------------
//start simulation of the CPU
always @(negedge clk) begin
    $display("\nInstructions in pipeline:"); //seeing where the instructions are located
    $display("IF: %h, ID: %h, EX: %h, MEM: %h, WB: %h", inst_and_result[63:32], if_id[63:32], id_ex[63:32],
    ex_mem[63:32], mem_wb[63:32]);

    if(mem_wb[63:32] == 32'hdeadbeef) begin
        $display("Verification complete.");
        $stop(); //program ends after all instructions are completed

    end else if (instruction_track > 4) begin
        //verification begins once first instruction has fully executed
        $display("Currently verifying: %h", mem_wb[63:32]);
        $display("Expected result: %h", mem_wb[31:0]);

        //breaking instruction into components
        //we can reuse these wires because they operate on different clock edges
        {imm, rs1, func3, rd, opcode} = mem_wb[63:32]; //I-TYPE
        
        //identify the instruction and begin verification
        if (opcode == 7'b0000011) begin
           if(func3 == 3'b010) begin
                //LW ------------------------------------
                $display("Identified as LW");
                assert()
           end
        end else begin
                //UNKNOWN ------------------------------
            $display("Not an I-type instruction");
        end
    end

end


endmodule