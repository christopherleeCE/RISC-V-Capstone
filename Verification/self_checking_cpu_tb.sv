/*
TESTING: TBD
SUCCESSFUL TESTS: ADDI/NOP, LW, SW, ADD, SUB

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

//TB memory
logic [31:0] instruction_memory [NUM_INSTRUCTIONS-1:0];
logic [31:0] data_memory [NUM_DATA_WORDS-1:0];

/*
Instruction Pipeline: This syncs up verification with the instructions in the CPU, and drives the data pipeline as
it sweeps through the CPU.
*/
int instruction_track;
logic [31:0] instruction;
logic [31:0] if_id, id_ex, ex_mem, mem_wb, post_wb;

/*
Data Pipeline: This collects the parameters and output for each instruction as the instruction travels through the CPU.
Each instruction type will collect the appropiate data; for example, for LW, the pipeline retrieves the memory value in
the MEM stage and the register value in the WB stage, and transport them to verification where we can simply compare and
confirm they're equal, which means the CPU loaded the correct value to the register from memory.

Data pipeline structure
5 - memory
4 - next_pc
3 - pc
2 - rs2
1 - rs1
0 - rd

*/
logic [5:0] [31:0] data_s, data_t, data_u, data_v, data_w, data_x, data_y, data_z;
logic [31:0] rd_data, rs1_data, rs2_data, pc_data, next_pc_data, mem_data;
logic [31:0] memory_address, verification_address;


//instruction components for verification
int instruction_failure;
logic [11:0] imm_i, imm_s, imm_b;
logic [19:0] imm_u, imm_j;
logic [4:0]  rs1, rs2, rd;
logic [2:0]  func3;
logic [6:0]  func7;
logic [6:0]  opcode;
logic [31:0] data_mem_addr;
logic [31:0] expected_result;


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


    // //display the contents of the memory. WARNING: Can be long, uncomment at your convenience.
    // $display("\nInstructions Passed to Testbench: ");
    // for (int i = 0; i < NUM_INSTRUCTIONS; i++) begin
    //     $display("\t\t0x%h", instruction_memory[i]);
    // end

    $display("NOTE: Adjust TB constants to match amount of instructions/data in memory.");
    $display("      This includes for future write operations.");
    repeat(1)@(posedge clk);
    rst = 1'b1; //disable the reset
end


//DUAL PIPELINE ----------------------------------------------------------------------------------------------------------------
//sequential logic to create the pipeline
always@(posedge clk or negedge rst) begin //async reset

    if(!rst) begin //resets the pipeline and tracker
        {if_id, id_ex, ex_mem, mem_wb, post_wb} <= '0;
        {data_t, data_v, data_x, data_z} <= '0;
        instruction_track = 0;
    end else begin

        //feed instruction into the pipeline bus
        if (instruction_track <= NUM_INSTRUCTIONS-1) begin
            instruction = instruction_memory[instruction_track]; //current instruction
        end else begin
            instruction = 32'hdeadbeef; //no more instructions (failsafe)
        end

        //continues advancing instructions and data through pipelines
        {if_id, id_ex, ex_mem, mem_wb, post_wb} <= {instruction, if_id, id_ex, ex_mem, mem_wb};  //instructions
        {data_t, data_v, data_x, data_z} <= {data_s, data_u, data_w, data_y}; //data
        instruction_track +=1; //increase instruction counter
    end
end

//combinational logic used to retrieve data from various stages in CPU for verification
always_comb begin
    //ID -------------------------------------------------------------------------------
        data_s = {6{32'hdeadbeef}}; //to replace with if-statement for jumps

    //EX --------------------------------------------------------------------------------
    if(id_ex[6:0] == 7'b1100011) begin //---B-TYPE---
        data_u = {
            data_t[5], //mem
            data_t[4], //next_pc
            cpu_dut.PC, //pc
            cpu_dut.my_reg_file.regs_out[id_ex[24:20]], //rs2
            cpu_dut.my_reg_file.regs_out[id_ex[19:15]], //rs1
            data_t[0] //rd
        };
    end else begin
        data_u = data_t;
    end

    //MEM --------------------------------------------------------------------
    if(ex_mem[6:0] == 7'b0100011) begin //---S-TYPE---
        data_w = {
            data_v[5], //mem
            data_v[4], //next_pc
            data_v[3], //pc
            cpu_dut.my_reg_file.regs_out[ex_mem[24:20]], //rs2
            cpu_dut.my_reg_file.regs_out[ex_mem[19:15]], //rs1
            data_t[0] //rd
        };
    end else if(ex_mem[6:0] == 7'b1100011) begin //---B-TYPE---
        data_w = {
            data_v[5], //mem
            cpu_dut.PC, //next_pc
            data_v[3], //pc
            data_v[2], //rs2
            data_v[1], //rs1
            data_t[0] //rd
        };
    end else begin
        data_w = data_v;
    end

    //WB-------------------------------------------------------------------------------
    if(mem_wb[6:0] == 7'b0110011) begin //--R-TYPE----
        data_y = {
            data_x[5], //mem
            data_x[4], //next_pc
            data_x[3], //pc
            cpu_dut.my_reg_file.regs_out[mem_wb[24:20]], //rs2
            cpu_dut.my_reg_file.regs_out[mem_wb[19:15]], //rs1
            data_x[0] //rd
        };
    end else if(mem_wb[6:0] == 7'b0010011) begin //--I-TYPE-(immediates)--
        data_y = {
            data_x[5], //mem
            data_x[4], //next_pc
            data_x[3], //pc
            data_x[2], //rs2
            cpu_dut.my_reg_file.regs_out[mem_wb[19:15]], //rs1
            data_x[0] //rd
        };
    end else if(mem_wb[6:0] == 7'b0000011) begin //--I-TYPE-(loads)--
        memory_address = {{20{mem_wb[31]}}, mem_wb[31:20]} + cpu_dut.my_reg_file.regs_out[mem_wb[19:15]];
        data_y = {
            cpu_dut.data_mem.data_mem[memory_address >> 2], //mem,
            data_x[4], //next_pc
            data_x[3], //pc
            data_x[2], //rs2
            data_x[1], //rs1
            data_x[0] //rd
        };
    end else if(mem_wb[6:0] == 7'b0100011) begin //--S-TYPE--
        memory_address = {{20{mem_wb[31]}}, mem_wb[31:25], mem_wb[11:7]} + data_x[1]; //address used in mem stage
        data_y = {
            cpu_dut.data_mem.data_mem[memory_address >> 2], //mem,
            data_x[4], //next_pc
            data_x[3], //pc
            data_x[2], //rs2
            data_x[1], //rs1
            data_x[0] //rd
        };
    end else begin
        data_y = data_x;
    end

    //VF ---------------------------------------------------------------------------------
    if(post_wb[6:0] == 7'b0110011 || post_wb[6:0] == 7'b0010011 || post_wb[6:0] == 7'b0000011) begin //R, I, and S type
        rd_data = cpu_dut.my_reg_file.regs_out[post_wb[11:7]]; //rd
    end else begin
        rd_data = data_z[0]; //rd
    end
    {mem_data, next_pc_data, pc_data, rs2_data, rs1_data} = data_z[5:1]; //everything else
end


//VERIFICATION -----------------------------------------------------------------------------------------------------------------
always @(negedge clk) begin //read on negative edge to give everything time to settle

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

    //START VERIFICATION -------------------------------------------------------------------------------
    $display("\nInstructions in pipeline:"); //seeing where the instructions are located
    $display("IF/ID: 0x%h, ID/EX: 0x%h, EX/MEM: 0x%h, MEM/WB: 0x%h", if_id, id_ex, ex_mem, mem_wb);
    $display("Currently verifying: 0x%h", post_wb); //instruction in verification stage

    opcode = post_wb[6:0]; //identify the instructions

    if (opcode == 7'b0110011) begin //--------R-TYPE----------------------------------------------
        {func7, rs2, rs1, func3, rd} = post_wb[31:7];
        $display("\tR-Type: func7: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b",
        func7, rs2, rs1, func3, rd, opcode); //instruction info

        if(func3 == 3'b000 && func7 == 7'b0000000) begin //----ADD------------------------------
            $display("\tIdentified as ADD.");
            expected_result = rs1_data + rs2_data;
            assert(rd_data == expected_result) $display("ADD successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end else if (func3 == 3'b000 && func7 == 7'b0100000) begin //----SUB---------------------------
            $display("\tIdentified as SUB.");
            expected_result = rs1_data - rs2_data;
            assert(rd_data == expected_result) $display("SUB successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end

        //model vs cpu register
        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd, rd_data, expected_result);


    end else if (opcode == 7'b0010011) begin //-----I-TYPE ---------------------------------------
        {imm_i, rs1, func3, rd} = post_wb[31:7];
        $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1,
        func3, rd, opcode); //instruction info

        if(func3 == 3'b000) begin //-------ADDI-------------------------------
            if(imm_i == 20'd0 & rs1 == 5'd0 & rd == 5'd0) begin
                $display("\tIdentified as NOP.");
            end else begin
                $display("\tIdentified as ADDI.");
            end
            expected_result = rs1_data + {{20{imm_i[11]}}, imm_i};
            assert(rd_data == expected_result) $display("ADDI/NOP successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end

        //model vs cpu register
        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd, rd_data, expected_result);

    end else if (opcode == 7'b0000011) begin //----I-TYPE----------------------------------
        {imm_i, rs1, func3, rd} = post_wb[31:7];
        $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1,
        func3, rd, opcode); //instruction info

        if(func3 == 3'b010) begin //----LW------------------------------------
            $display("\tIdentified as LW.");
            assert(rd_data == mem_data) $display("LW successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end

        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd, rd_data, mem_data); //model vs cpu registers

    end else if (opcode == 7'b0100011) begin //------S-TYPE----------------------------------
        {imm_s[11:5], rs2, rs1, func3, imm_s[4:0]} = post_wb[31:7];
        $display("\tS-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_s, rs2, rs1,
        func3, opcode); //instruction info
        verification_address = {{20{imm_s[11]}}, imm_s} + rs1_data;

        if(func3 == 3'b010) begin //----SW-------------------------------------
            $display("\tIdentified as SW.");
            assert(mem_data == rs2_data) $display("SW successful.");
            else instruction_failure = 1;//ensure source register was written to CPU memory

        end

        //compare model vs CPU memory contents
        $display("Contents of data memory at 0x%h:\n\tCPU: 0x%h\n\tModel: 0x%h", verification_address, mem_data, rs2_data);

    end else begin

            //UNKNOWN ------------------------------
        $display("WARNING: Instruction type not currently recognized by TB.");

    end

    // //CPU REGISTER DUMP - comment/uncomment as needed
    // $display("CPU REGISTER DUMP, POST WB:");
    // for(int k = 0; k < 32; k++) begin
    //     $display("\t\tx%d: 0x%h", k, cpu_dut.my_reg_file.regs_out[k]);
    // end

    // //CPU DATA MEMORY DUMP
    // // WARNING: Can be very long, uncomment at your convenience.
    // $display("CPU DATA MEMORY DUMP: ");
    // for (int k = 0; k < NUM_DATA_WORDS; k++) begin
    //     $display("\t\t0x%h: 0x%h", k*4, cpu_dut.data_mem.data_mem[k]);
    // end

end
endmodule