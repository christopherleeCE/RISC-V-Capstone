/*
TESTING: ADDI, LW

We can have a main TB for the CPU if we really need to, but I like the idea of smaller, seperate TBs for each instruction 
type. In theory, each type will have a similar datapath, so in theory, each type could use a similar verification process,
I'll have to see for sure though.

I have a couple ideas for a TB but I have to figure out the implementation and see if it works. I'll be focused on these 
instructions for now; to others doing verification, please feel free to test the other instructions, thank you!

- FURTHER UPDATE - I may expand this to other instruction types, but we shall see.

- FINAL UPDATE - Success! The testbech is now fully self-checking and appears to verify the CPU. Halt signal functionality.

*/

`timescale 1ns/1ns

module i_type_tb ();
//constants
parameter int CLOCK_PERIOD = 20;
parameter int NUM_INSTRUCTIONS = 14;
parameter int NUM_DATA_WORDS = 3;

//declare the buses and signals
logic clk, rst, ohalt;
logic [31:0] instruction_memory [NUM_INSTRUCTIONS-1:0];
logic [31:0] data_memory [NUM_DATA_WORDS-1:0];

//golden model
int instruction_track; //NOT the program counter, only for verification
logic [31:0] data_mem_addr; //size of address for data memory - default 32 bit addressing
logic [63:0] inst_and_result; //instruction being performed and ensuing computational result
logic [63:0] if_id, id_ex, ex_mem, mem_wb, post_wb; //transferring instruction and result

//I-type
logic [11:0] imm;
logic [4:0] rs1, rd;
logic [2:0] func3;
logic [6:0] opcode;


//instantiate the CPU
riscv_cpu cpu_dut(.clk(clk), .rst(rst), .ohalt(ohalt));

//CLOCK ------------------------------------------------------------------------------------------------------------------
initial begin
    clk = 1'b0;
    forever begin //start the clock
        #CLOCK_PERIOD
        clk = ~clk;
    end
end

//RESET/MEMORY SETUP ------------------------------------------------------------------------------------------------------
initial begin
    //WARNING - reset could potentially mask bugs, so I will leave it off for now
    rst = 1'b0; //reset the CPU and golden model during startup

    // NOTE: Instead of writing the program to memory, I might write the program in memory and read it into the testbench
    //       Both work, but the format might be a little more user friendly.

    // instruction memory for testbench
    $readmemh("instruction_memory.txt", instruction_memory);

    // data memory for testbench
    $readmemh("data_memory.txt", data_memory);

    //display the contents of the memory
    $display("\nInstructions Passed to Testbench: ");
    for (int i = 0; i < NUM_INSTRUCTIONS; i++) begin
        $display("\t\t%h", instruction_memory[i]);
    end
    $display("Data Passed to Testbench: ");
    for (int i = 0; i < NUM_DATA_WORDS; i++) begin
        $display("\t\t%h", data_memory[i]);
    end
    $display("NOTE: Adjust TB constants to match amount of instructions/data in memory.");

    repeat(1)@(posedge clk);
    rst = 1'b1; //disable the reset
end


//GOLDEN MODEL ----------------------------------------------------------------------------------------------------------------
//pipeline to follow the CPU's pipeline (asynchronous reset too)
always@(posedge clk or negedge rst) begin
    if(!rst) begin //resets the pipeline and tracker
        {inst_and_result, if_id, id_ex, ex_mem, mem_wb} <= '0;
        instruction_track = 0;
    end else begin
        //feed instruction into half of the pipeline bus
        if (instruction_track <= NUM_INSTRUCTIONS-1) begin
            inst_and_result[63:32] = instruction_memory[instruction_track]; //current instruction
        end else begin
            inst_and_result[63:32] = 32'hdeadbeef; //no more instructions
        end

        //breaking instruction into components
        {imm, rs1, func3, rd, opcode} = instruction_memory[instruction_track]; //I-TYPE
        
        //solve the instruction and feed result into the other half of the pipeline bus
        if (opcode == 7'b0000011) begin

           if(func3 == 3'b010) begin //--------LW--------------------------------------------------
            data_mem_addr = cpu_dut.my_reg_file.regs_out[rs1] + {20'b0, imm}; //calculate address
            // $display("memory address for LW: %h", data_mem_addr);
            inst_and_result[31:0] = data_memory[data_mem_addr[31:2]]; //load in word
            // $display("loading in: %h", data_memory[data_mem_addr[31:2]]);

           end
        end else if (opcode == 7'b0010011) begin

            if(func3 == 3'b000) begin //-----ADDI--------------------------------------------------
                inst_and_result[31:0] = cpu_dut.my_reg_file.regs_out[rs1] + {{20{imm[11]}}, imm};
            end

        end else begin
            //UNKNOWN------------------------------------------------------------------------------
            inst_and_result[31:0] = 32'hdeadbeef; //irrelevant result
        end

        //continues advancing instructions and associated results
        if_id <= inst_and_result;
        id_ex <= if_id;
        ex_mem <= id_ex;
        mem_wb <= ex_mem;
        post_wb <= mem_wb;
        instruction_track += 1;

    end
end


//VERIFICATION -----------------------------------------------------------------------------------------------------------------
//start simulation of the CPU
always @(negedge clk) begin

    if (ohalt == 1'b1) begin //HALT SIGNAL --------------------------------------------------------------
        $display("\nWARNING: Recieved halt signal. Pausing verification.");
        $stop(); //pauses verification if CPU outputs halt signal

    end else if(post_wb[63:32] == 32'hdeadbeef) begin //NO MORE INSTRUCTIONS ----------------------------

        //NOTE: This was created before the halt, this section could be removed. Will stop verification
        //      automatically after exceeding specified number of instructions
        $display("\nWARNING: No instructions left in testbench. Pausing verification.");
        $stop(); //program ends after all instructions are completed

    end

    //START VERIFICATION ---------------------------------------------------------------------------------
    //Golden model pipeline - parallel to CPU
    $display("\nInstructions in pipeline:"); //seeing where the instructions are located
    $display("IF/ID: %h, ID/EX: %h, EX/MEM: %h, MEM/WB: %h", if_id[63:32], id_ex[63:32],
    ex_mem[63:32], mem_wb[63:32]);
    $display("Currently verifying: %h", post_wb[63:32]);

    //I-type
    {imm, rs1, func3, rd, opcode} = post_wb[63:32];
    $display("imm: %d, rs1: %d, func3: %d, rd: %d, opcode:%d",
    imm, rs1, func3, rd, opcode);
    
    //REGISTER DUMP - comment/uncomment as needed
    $display("REGISTER DUMP:");
    for(int k = 0; k < 32; k++) begin
        $display("\t\tx%d: %h", k, cpu_dut.my_reg_file.regs_out[k]);
    end

    //identify the instruction and begin verification
    if (opcode == 7'b0000011) begin
        if(func3 == 3'b010) begin //----LW------------------------------------
            $display("Identified as LW.");
            assert(cpu_dut.my_reg_file.regs_out[rd] == post_wb[31:0]) $display("LW successful.");
            else $error("LW failed.");//compare contents
            $display("Contents of x%d:\n   CPU: %h\n   Model: %h",
            rd, cpu_dut.my_reg_file.regs_out[rd], post_wb[31:0]);
        end

    end else if (opcode == 7'b0010011) begin
        if(func3 == 3'b000) begin //-------ADDI-------------------------------
            $display("Identified as ADDI.");
            assert(cpu_dut.my_reg_file.regs_out[rd] == post_wb[31:0]) $display("ADDI successful.");
            else $error("ADDI failed.");//compare contents
            $display("Contents of x%d:\n   CPU: %h\n   Model: %h",
            rd, cpu_dut.my_reg_file.regs_out[rd], post_wb[31:0]);
        end
    end else begin
            //UNKNOWN ------------------------------
        $display("Not an I-type instruction.");
    end

end


endmodule