/*
TESTING: TBD
SUCCESSFUL TESTS: ADDI, LW, SW

- This testbench has been a lot of trial and error, but I'm very happy with it so far. It should hopefully
not be too hard to expand to other instruction type. Not the best, but looks like it gets the job done!
Feel free to run it and let me know if you have any questions.

- Load up a program in the instruction memory along with any contents in the data memory. Please note that you
have to adjust the constants for the testbench to fully cover all instructions and data, or you may get a
false error.

- Edgar

*/

`timescale 1ns/1ns

module self_checking_cpu_tb ();
//constants
parameter int CLOCK_PERIOD = 20;
parameter int NUM_INSTRUCTIONS = 32;
parameter int NUM_DATA_WORDS = 32;

//declare the buses and signals
logic clk, rst, ohalt;

//golden model
int instruction_track; //NOT the program counter, only for verification
int instruction_failure;
logic [31:0] data_mem_addr; //size of address for data memory - default 32 bit addressing
logic [31:0] instruction_memory [NUM_INSTRUCTIONS-1:0];
logic [31:0] data_memory [NUM_DATA_WORDS-1:0];
logic [31:0] instruction, result; //instruction being performed, result of computation
logic [31:0] if_id, id_ex, ex_mem, mem_wb, post_wb; //transferring instruction and result

//instruction components
logic [11:0] imm_i, imm_s, imm_b; //immediate size vary by instruction type
logic [19:0] imm_u, imm_j;
logic [4:0] rs1, rs2, rd;
logic [2:0] func3;
logic [6:0] func7;
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
    //WARNING - reset could potentially mask bugs, your choice.
    rst = 1'b0; //reset the CPU and golden model during startup
    instruction_track = 0;
    instruction_failure = 0;

    // NOTE: Instead of writing the program to memory, I might write the program in memory and read it into the testbench
    //       Both work, but the format might be a little more user friendly.

    // instruction memory for testbench
    $readmemh("instruction_memory.txt", instruction_memory);

    // data memory for testbench
    $readmemh("data_memory.txt", data_memory);

    // //display the contents of the memory. WARNING: Can be very long, uncomment at your convenience.
    // $display("\nInstructions Passed to Testbench: ");
    // for (int i = 0; i < NUM_INSTRUCTIONS; i++) begin
    //     $display("\t\t0x%h", instruction_memory[i]);
    // end
    // $display("Data Passed to Testbench: ");
    // for (int i = 0; i < NUM_DATA_WORDS; i++) begin
    //     $display("\t\t0x%h", data_memory[i]);
    // end

    $display("NOTE: Adjust TB constants to match amount of instructions/data in memory.");
    $display("      This includes for future write operations.");
    repeat(1)@(posedge clk);
    rst = 1'b1; //disable the reset
end


//GOLDEN MODEL ----------------------------------------------------------------------------------------------------------------
//pipeline to follow the CPU's pipeline (asynchronous reset too)
always@(posedge clk or negedge rst) begin
    if(!rst) begin //resets the pipeline and tracker
        {if_id, id_ex, ex_mem, mem_wb} <= '0;
        instruction_track = 0;
    end else begin

        //feed instruction into the pipeline bus
        if (instruction_track <= NUM_INSTRUCTIONS-1) begin
            instruction = instruction_memory[instruction_track]; //current instruction
        end else begin
            instruction = 32'hdeadbeef; //no more instructions
        end

        //continues advancing instructions and associated results
        if_id <= instruction;
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

    end else if(instruction_failure == 1) begin
        $display("\nWARNING: Instruction not executed properly. Pausing verification.");
        $stop(); //pauses verification if CPU outputs halt signal

    end else if(post_wb == 32'hdeadbeef) begin //NO MORE INSTRUCTIONS ----------------------------

        //NOTE: This was created before the halt, this section could be removed. Will stop verification
        //      automatically after exceeding specified number of instructions
        $display("\nWARNING: No instructions left in testbench. Pausing verification.");
        $stop(); //program ends after all instructions are completed

    end

    //START VERIFICATION ---------------------------------------------------------------------------------
    //Golden model pipeline - parallel to CPU
    $display("\nInstructions in pipeline:"); //seeing where the instructions are located
    $display("IF/ID: 0x%h, ID/EX: 0x%h, EX/MEM: 0x%h, MEM/WB: 0x%h", if_id, id_ex, ex_mem, mem_wb);
    $display("Currently verifying: 0x%h", post_wb);

    //identify the instruction and begin verification
    opcode = post_wb[6:0];
    
    if (opcode == 7'b0010011) begin //----- I-TYPE ---------------------------------------

        {imm_i, rs1, func3, rd} = post_wb[31:7]; //breaking the instruction into components
        $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode);

        if(func3 == 3'b000) begin //-------ADDI-------------------------------
            $display("\tIdentified as ADDI.");

            result = cpu_dut.my_reg_file.regs_out[rs1] + {{20{imm_i[11]}}, imm_i};

            assert(cpu_dut.my_reg_file.regs_out[rd] == result) $display("ADDI successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

            $display("Contents of x%d:\n   CPU: 0x%h\n   Model: 0x%h", rd, cpu_dut.my_reg_file.regs_out[rd], result);
        end

    end else if (opcode == 7'b0000011) begin //----I-TYPE----------------------------------

        {imm_i, rs1, func3, rd} = post_wb[31:7]; //breaking the instruction into components
        $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode);

        if(func3 == 3'b010) begin //----LW------------------------------------
            $display("\tIdentified as LW.");

            data_mem_addr = cpu_dut.my_reg_file.regs_out[rs1] + {20'b0, imm_i}; //calculate address
            $display("Reading from data memory at address 0x%h.", data_mem_addr); //display addr
            result = data_memory[data_mem_addr[31:2]]; //load in word

            assert(cpu_dut.my_reg_file.regs_out[rd] == result) $display("LW successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

            $display("Contents of x%d:\n   CPU: 0x%h\n   Model: 0x%h", rd, cpu_dut.my_reg_file.regs_out[rd], result);
        end

    end else if (opcode == 7'b0100011) begin //------S-TYPE----------------------------------

        {imm_s[11:5], rs2, rs1, func3, imm_s[4:0]} = post_wb[31:7]; //breaking the instruction into components
        $display("\tS-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, rs2: 0b%b, opcode: 0b%b", imm_s, rs2, rs1, func3, opcode);

        if(func3 == 3'b010) begin //----SW-------------------------------------
            $display("\tIdentified as SW.");

            data_mem_addr = cpu_dut.my_reg_file.regs_out[rs1] + {20'b0, imm_s}; //calculate address
            $display("Writing to data memory at address 0x%h.", data_mem_addr); //display addr
            result = cpu_dut.my_reg_file.regs_out[rs2]; // pull value out of source register
            data_memory[data_mem_addr[31:2]] <= result; // store in testbench memory, might remove this if not needed

            assert(cpu_dut.data_mem.data_mem[data_mem_addr[31:2]] == result) $display("SW successful.");
            else instruction_failure = 1;//ensure source register was written to CPU memory

            $display("Contents of data memory at 0x%h:\n   CPU: 0x%h\n   Model: 0x%h",
            data_mem_addr, cpu_dut.data_mem.data_mem[data_mem_addr[31:2]], result); //compare memory contents
        end

    end else begin
            //UNKNOWN ------------------------------
        $display("WARNING: Instruction type not currently recognized by TB.");
    end

    //CPU REGISTER DUMP - comment/uncomment as needed
    $display("CPU REGISTER DUMP:");
    for(int k = 0; k < 32; k++) begin
        $display("\t\tx%d: 0x%h", k, cpu_dut.my_reg_file.regs_out[k]);
    end

    // CPU DATA MEMORY DUMP
    // WARNING: Can be very long, uncomment at your convenience.
    $display("CPU DATA MEMORY DUMP: ");
    for (int k = 0; k < NUM_DATA_WORDS; k++) begin
        $display("\t\t0x%h: 0x%h", k*4, cpu_dut.data_mem.data_mem[k]);
    end

end

endmodule