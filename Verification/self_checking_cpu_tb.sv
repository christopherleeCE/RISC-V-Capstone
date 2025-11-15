/*
TESTING: TBD
FAILED TESTS: ADD, SUB
SUCCESSFUL TESTS: ADDI/NOP, LW, SW

- Load up a program in the instruction memory along with any contents in the data memory. Please note that you
have to adjust the constants for the testbench to fully cover all instructions and data, or you may get a
false error.

- Edgar G.

*/

`timescale 1ns/1ns

module self_checking_cpu_tb ();
//PARAMETERS/BUSES----------------------------------------------------------------------------------------------------------
//constants
parameter int CLOCK_PERIOD = 20;
parameter int NUM_INSTRUCTIONS = 32;
parameter int NUM_DATA_WORDS = 32;

//declare the buses and signals
logic clk, rst, ohalt;

//golden model
int instruction_track;
int instruction_failure;
logic [31:0] instruction_memory [NUM_INSTRUCTIONS-1:0];
logic [31:0] data_memory [NUM_DATA_WORDS-1:0];
logic [31:0] if_id, id_ex, ex_mem, mem_wb, post_wb;

//components for computing instruction and verification
logic [31:0] instruction, instruction_v;
logic [11:0] imm_i, imm_i_v, imm_s, imm_s_v, imm_b, imm_b_v;
logic [19:0] imm_u, imm_u_v, imm_j, imm_j_v;
logic [4:0] rs1, rs1_v, rs2, rs2_v, rd, rd_v;
logic [2:0] func3, func3_v;
logic [6:0] func7, func7_v;
logic [6:0] opcode, opcode_v;
logic [31:0] data_mem_addr, data_mem_addr_v;
logic [31:0] result, result_v;


//DUT---------------------------------------------------------------------------------------------------------------------
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
    //WARNING - reset could potentially mask bugs, your choice to comment or uncomment.
    rst = 1'b0; //reset the CPU and golden model during startup
    instruction_track = 0;
    instruction_failure = 0;

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

 /* How does this work? -------------------------------------------------------------------------------------------------------
    The reference computes the instruction before the write back is complete. This helps the reference avoid/identify a data 
    hazard by allowing all previous instructions to write back to the registers/data memory first. The fields and result of
    each instruction is passed to a "post write back" stage, where the actual verification occurs by comparing the model's
    output with the CPU's after writing is complete. The testbench obtains all necessary values by probing the components of
    the CPU.
*/

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
            instruction = 32'hdeadbeef; //no more instructions (failsafe)
        end

        //continues advancing instructions through pipeline
        if_id <= instruction;
        id_ex <= if_id;
        ex_mem <= id_ex;
        mem_wb <= ex_mem;

        //advancing components and results to final verification stage
        post_wb <= mem_wb;
        instruction_v <= instruction;
        {imm_i_v, imm_s_v, imm_b_v, imm_u_v, imm_j_v} <= {imm_i, imm_s, imm_b, imm_u, imm_j};
        {rs1_v, rs2_v, rd_v} <= {rs1, rs2, rd};
        {func3_v, func7_v} <= {func3, func7};
        opcode_v <= opcode;
        result_v <= result;
        data_mem_addr_v <= data_mem_addr;
        instruction_track += 1; 

        if (opcode == 7'b0100011) begin //------RUN
            if(func3 == 3'b010) begin //----SW-------------------------------------
                data_memory[data_mem_addr[31:2]] <= result; // write to data memory of testbench
            end
        end
    end
end

//computation of instruction
always_comb begin
    opcode = mem_wb[6:0]; //identify the instruction during write back

    if (opcode == 7'b0110011) begin //----R-TYPE-------------------------------------------------

        {func7, rs2, rs1, func3, rd} = mem_wb[31:7]; //breaking the instruction into components
        if(func3 == 3'b000 && func7 == 7'b0000000) begin //----ADD------------------------------
            result = cpu_dut.my_reg_file.regs_out[rs1] + cpu_dut.my_reg_file.regs_out[rs2]; //add

        end else if (func3 == 3'b000 && func7 == 7'b0100000) begin //----SUB---------------------------
            result = cpu_dut.my_reg_file.regs_out[rs1] - cpu_dut.my_reg_file.regs_out[rs2]; //subtract

        end

    end else if (opcode == 7'b0010011) begin //----- I-TYPE -------------------------------------

        {imm_i, rs1, func3, rd} = mem_wb[31:7]; //breaking the instruction into components
        if(func3 == 3'b000) begin //-------ADDI-------------------------------
            result = cpu_dut.my_reg_file.regs_out[rs1] + {{20{imm_i[11]}}, imm_i}; //sign extend and add

        end

    end else if (opcode == 7'b0000011) begin //----I-TYPE----------------------------------

        {imm_i, rs1, func3, rd} = mem_wb[31:7]; //breaking the instruction into components
        if(func3 == 3'b010) begin //----LW------------------------------------
            data_mem_addr = cpu_dut.my_reg_file.regs_out[rs1] + {20'b0, imm_i}; //calculate address
            result = data_memory[data_mem_addr[31:2]]; //load in word

        end

    end else if (opcode == 7'b0100011) begin //------S-TYPE----------------------------------

        {imm_s[11:5], rs2, rs1, func3, imm_s[4:0]} = mem_wb[31:7]; //breaking the instruction into components
        if(func3 == 3'b010) begin //----SW-------------------------------------
            data_mem_addr = cpu_dut.my_reg_file.regs_out[rs1] + {20'b0, imm_s}; //calculate address
            result = cpu_dut.my_reg_file.regs_out[rs2]; // pull value out of source register
        end

    end else begin

        result = 32'hdeadbeef; //placeholder value, instruction ignored anyways in verification
    end
end


//VERIFICATION -----------------------------------------------------------------------------------------------------------------
always @(negedge clk) begin

    if (ohalt == 1'b1) begin //HALT SIGNAL --------------------------------------------------------------
        $display("\nWARNING: Recieved halt signal. Pausing verification.");
        $display("Program counter: %d", cpu_dut.PC);
        $stop(); //pauses verification if CPU outputs halt signal

    end else if(instruction_failure == 1) begin //INSTRUCTION FAILURE----------------------------------
        $display("\nWARNING: Mismatch between model and CPU. Pausing verification.");
        $display("\tPlease check for data hazards and issues in instruction datapath/control.");
        $stop(); //pauses verification if an instruction has failed OR a data hazard has occured.

    end else if(post_wb == 32'hdeadbeef) begin //NO MORE INSTRUCTIONS ----------------------------------

        //Older code that is a bit redundant, but it stops the testbench automatically even if the halt signal
        //from the CPU is disabled.
        $display("\nWARNING: No further instructions. Pausing verification.");
        $stop(); //program ends after all instructions are completed

    end

    //START VERIFICATION ---------------------------------------------------------------------------------
    //Golden model pipeline - parallel to CPU
    $display("\nInstructions in pipeline:"); //seeing where the instructions are located
    $display("IF/ID: 0x%h, ID/EX: 0x%h, EX/MEM: 0x%h, MEM/WB: 0x%h", if_id, id_ex, ex_mem, mem_wb);
    $display("Currently verifying: 0x%h", post_wb); //instruction in verification stage

    //NOTE: the variables used here contain "_v"; they are the results from the final stage
    //NOTE: There is some repitatin

    if (opcode_v == 7'b0110011) begin //--------R-TYPE----------------------------------------------

        $display("\tR-Type: func7: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b",
        func7_v, rs2_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

        if(func3_v == 3'b000 && func7_v == 7'b0000000) begin //----ADD------------------------------
            $display("\tIdentified as ADD.");
            assert(cpu_dut.my_reg_file.regs_out[rd_v] == result_v) $display("ADD successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end else if (func3_v == 3'b000 && func7_v == 7'b0100000) begin //----SUB---------------------------
            $display("\tIdentified as SUB.");
            assert(cpu_dut.my_reg_file.regs_out[rd_v] == result_v) $display("SUB successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end

        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd_v, cpu_dut.my_reg_file.regs_out[rd_v],
        result_v); //model vs cpu register


    end else if (opcode_v == 7'b0010011) begin //-----I-TYPE ---------------------------------------

        $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i_v, rs1_v,
        func3_v, rd_v, opcode_v); //instruction info

        if(func3_v == 3'b000) begin //-------ADDI-------------------------------
            if(imm_i_v == 20'd0 & rs1_v == 5'd0 & rd_v == 5'd0) begin
                $display("\tIdentified as NOP.");
            end else begin
                $display("\tIdentified as ADDI.");
            end
            assert(cpu_dut.my_reg_file.regs_out[rd_v] == result_v) $display("ADDI/NOP successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end

        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd_v, cpu_dut.my_reg_file.regs_out[rd_v],
        result_v); //model vs cpu register

    end else if (opcode_v == 7'b0000011) begin //----I-TYPE----------------------------------

        $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i_v, rs1_v,
        func3_v, rd_v, opcode_v); //instruction info

        if(func3_v == 3'b010) begin //----LW------------------------------------
            $display("\tIdentified as LW.");
            $display("Reading from data memory at address 0x%h.", data_mem_addr_v); //display addr
            assert(cpu_dut.my_reg_file.regs_out[rd_v] == result_v) $display("LW successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end

        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd_v, cpu_dut.my_reg_file.regs_out[rd_v],
        result_v); //model vs cpu registers

    end else if (opcode_v == 7'b0100011) begin //------S-TYPE----------------------------------

        $display("\tS-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_s_v, rs2_v, rs1_v,
        func3_v, opcode_v); //instruction info

        if(func3_v == 3'b010) begin //----SW-------------------------------------
            $display("\tIdentified as SW.");
            $display("Writing to data memory at address 0x%h.", data_mem_addr_v); //display addr
            assert(cpu_dut.data_mem.data_mem[data_mem_addr_v[31:2]] == result_v) $display("SW successful.");
            else instruction_failure = 1;//ensure source register was written to CPU memory

        end

        $display("Contents of data memory at 0x%h:\n\tCPU: 0x%h\n\tModel: 0x%h",
        data_mem_addr_v, cpu_dut.data_mem.data_mem[data_mem_addr_v[31:2]], result_v); //compare model vs CPU memory contents

    end else begin

            //UNKNOWN ------------------------------
        $display("WARNING: Instruction type not currently recognized by TB.");

    end

    //CPU REGISTER DUMP - comment/uncomment as needed
    $display("CPU REGISTER DUMP:");
    for(int k = 0; k < 32; k++) begin
        $display("\t\tx%d: 0x%h", k, cpu_dut.my_reg_file.regs_out[k]);
    end

    //CPU DATA MEMORY DUMP
    // WARNING: Can be very long, uncomment at your convenience.
    $display("CPU DATA MEMORY DUMP: ");
    for (int k = 0; k < NUM_DATA_WORDS; k++) begin
        $display("\t\t0x%h: 0x%h", k*4, cpu_dut.data_mem.data_mem[k]);
    end

    // //TB DATA MEMORY DUMP - for comparison
    //  $display("TB DATA MEMORY DUMP: ");
    // for (int k = 0; k < NUM_DATA_WORDS; k++) begin
    //     $display("\t\t0x%h: 0x%h", k*4, data_memory[k]);
    // end

end
endmodule