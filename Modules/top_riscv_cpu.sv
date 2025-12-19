/*
UNVERIFIED/UNSUCCESSFUL: MUL, MULH, MULHSU, MULHU
SUCCESSFUL TESTS: ADDI/NOP, LW, SW, ADD, SUB, BEQ, JAL, JALR, LUI

- Load up a program in the instruction memory along with any contents in the data memory.

- Edgar G.

*/

`timescale 1ns/1ns

module self_checking_cpu_tb ();

    /* OLD CODE */

//PARAMETERS/BUSES----------------------------------------------------------------------------------------------------------
//constants
parameter int CLOCK_PERIOD = 20;
parameter int NUM_INSTRUCTIONS = 32;
parameter int NUM_DATA_WORDS = 32;

//declare the buses and signals
logic clk, rst, ohalt;

`include "sig_declare.inc";
logic [UIP_WIDTH-1:0] UIP;

//golden logic signals


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
    instruction_failure = 0;
    repeat(1)@(posedge clk);
    rst = 1'b1; //disable the reset
end

/*Start of new top file*/

    //golden sginals, these are what the DUT is verfied against, they are stored in a 5x1 array, one or each clk of the execution in the DUT
    logic [31:0] PC [5:0];
    logic [31:0] PC_TARGET [5:0];
    logic [31:0] INSTR_ASYNC;
    logic [31:0] INSTR [5:0];

    logic [4:0] RS1 [5:0];
    logic [4:0] RS2 [5:0];
    logic [31:0] RS1_DATA [5:0];
    logic [31:0] RS2_DATA [5:0];
    logic [31:0] REGFILE [31:0] [5:0]; //address this monstrosity of a array is as follows REGFILE [regnum] [clk cycle (4 through 0)]
                                                    // or REGFILE [regnum] [clk cycle (4 through 0)] [bit]

    logic [31:0] DATA_MEM_IN [5:0];
    logic [31:0] DATA_MEM_IN_ADDR [5:0];
    logic [31:0] DATA_MEM_OUT [5:0];
    logic [31:0] DATA_MEM_OUT_ADDR [5:0];
    logic [31:0] DATA_MEM [ TODO_ENTRY_COUNT ] [5:0];

    //these signals, while being in the IF stage, are more akin to being in the WB stage, thuse they are down here
    //something to think about, maybe we dont actually verify these two signals, but the contents of the regfile itself?
    //like for example in add t0 t1 t2, we just need to check the contents of t0 after the end of the DUT exectution
    //with the calculated result in the regfile in the golden, that being said its kinda wierd cus the regile in two stages
    //at the same time
    logic [4:0] RD_W [5:0];
    logic [31:0] RD_DATA [5:0];
    //REGFILE, declared above


/* borrowed modules, i could think of a beter way to get these signals that didnt make me want to kys so i just borrowed modules
if there is a better way to get these signals (RS1, INSTR, etc.) feel free to replace*/

    //declaration of golden_cpus instr mem, this instansiation should be a perfect mirror of whats instasiated in the DUT (i think)
    //if the DUT.sv's declaration changes, it should be mirrored here
    instruction_memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(32)
    ) instr_mem (
        .read_address(PC[0]),
        .read_data(INSTR_ASYNC)
    );

    UID__ my_uid ( .instr (INSTR_ASYNC), .uip(UIP) );
    US__ my_ustore ( .uip(UIP), .sig(sig) );

    //muxing of reg addrs, and imediates
    id_t my_id_t (
            .instr(INSTR_ASYNC),
            .r_type,
            .i_type,
            .s_type,
            .b_type,
            .u_type,
            .j_type,
            .rs1(RS1_ASYNC),
            .rs2(RS2_ASYNC),
            .rd(RD_ASYNC),
            .im(IM_ASYNC)
        );






//progress 5x5 array
always@(posedge clk) begin

    //progress instrucition snapshot
    PC [1]                              <=PC [0];
    PC_TARGET [1]                       <=PC_TARGET [0];
    INSTR[1]                            <=INSTR[0];
    RS1 [1]                             <=RS1 [0];
    RS2 [1]                             <=RS2 [0];
    RS1_DATA [1]                        <=RS1_DATA [0];
    RS2_DATA [1]                        <=RS2_DATA [0];
    REGFILE [1]   <=REGFILE [0];
    DATA_MEM_IN [1]                     <=DATA_MEM_IN [0];
    DATA_MEM_IN_ADDR [1]                <=DATA_MEM_IN_ADDR [0];
    DATA_MEM_OUT [1]                    <=DATA_MEM_OUT [0];
    DATA_MEM_OUT_ADDR [1]               <=DATA_MEM_OUT_ADDR [0];
    DATA_MEM [TODO_ENTRY_COUNT] [1]     <=DATA_MEM [TODO_ENTRY_COUNT] [0];
    RD_W [1]                            <=RD_W [0];
    RD_DATA [1]                         <=RD_DATA [0];

    PC [2]                              <=PC [1];
    PC_TARGET [2]                       <=PC_TARGET [1];
    INSTR[2]                            <=INSTR[1];
    RS1 [2]                             <=RS1 [1];
    RS2 [2]                             <=RS2 [1];
    RS1_DATA [2]                        <=RS1_DATA [1];
    RS2_DATA [2]                        <=RS2_DATA [1];
    REGFILE [2]   <=REGFILE [1];
    DATA_MEM_IN [2]                     <=DATA_MEM_IN [1];
    DATA_MEM_IN_ADDR [2]                <=DATA_MEM_IN_ADDR [1];
    DATA_MEM_OUT [2]                    <=DATA_MEM_OUT [1];
    DATA_MEM_OUT_ADDR [2]               <=DATA_MEM_OUT_ADDR [1];
    DATA_MEM [TODO_ENTRY_COUNT] [2]     <=DATA_MEM [TODO_ENTRY_COUNT] [1];
    RD_W [2]                            <=RD_W [1];
    RD_DATA [2]                         <=RD_DATA [1];

    PC [3]                              <=PC [2];
    PC_TARGET [3]                       <=PC_TARGET [2];
    INSTR[3]                            <=INSTR[2];
    RS1 [3]                             <=RS1 [2];
    RS2 [3]                             <=RS2 [2];
    RS1_DATA [3]                        <=RS1_DATA [2];
    RS2_DATA [3]                        <=RS2_DATA [2];
    REGFILE [3]   <=REGFILE [2];
    DATA_MEM_IN [3]                     <=DATA_MEM_IN [2];
    DATA_MEM_IN_ADDR [3]                <=DATA_MEM_IN_ADDR [2];
    DATA_MEM_OUT [3]                    <=DATA_MEM_OUT [2];
    DATA_MEM_OUT_ADDR [3]               <=DATA_MEM_OUT_ADDR [2];
    DATA_MEM [TODO_ENTRY_COUNT] [3]     <=DATA_MEM [TODO_ENTRY_COUNT] [2];
    RD_W [3]                            <=RD_W [2];
    RD_DATA [3]                         <=RD_DATA [2];

    PC [4]                              <=PC [3];
    PC_TARGET [4]                       <=PC_TARGET [3];
    INSTR[4]                            <=INSTR[3];
    RS1 [4]                             <=RS1 [3];
    RS2 [4]                             <=RS2 [3];
    RS1_DATA [4]                        <=RS1_DATA [3];
    RS2_DATA [4]                        <=RS2_DATA [3];
    REGFILE [4]   <=REGFILE [3];
    DATA_MEM_IN [4]                     <=DATA_MEM_IN [3];
    DATA_MEM_IN_ADDR [4]                <=DATA_MEM_IN_ADDR [3];
    DATA_MEM_OUT [4]                    <=DATA_MEM_OUT [3];
    DATA_MEM_OUT_ADDR [4]               <=DATA_MEM_OUT_ADDR [3];
    DATA_MEM [TODO_ENTRY_COUNT] [4]     <=DATA_MEM [TODO_ENTRY_COUNT] [3];
    RD_W [4]                            <=RD_W [3];
    RD_DATA [4]                         <=RD_DATA [3];

    //this timestamp might not need to be used
    PC [5]                              <=PC [4];
    PC_TARGET [5]                       <=PC_TARGET [4];
    INSTR[5]                            <=INSTR[4];
    RS1 [5]                             <=RS1 [4];
    RS2 [5]                             <=RS2 [4];
    RS1_DATA [5]                        <=RS1_DATA [4];
    RS2_DATA [5]                        <=RS2_DATA [4];
    REGFILE [5]   <=REGFILE [4];
    DATA_MEM_IN [5]                     <=DATA_MEM_IN [4];
    DATA_MEM_IN_ADDR [5]                <=DATA_MEM_IN_ADDR [4];
    DATA_MEM_OUT [5]                    <=DATA_MEM_OUT [4];
    DATA_MEM_OUT_ADDR [5]               <=DATA_MEM_OUT_ADDR [4];
    DATA_MEM [TODO_ENTRY_COUNT] [5]     <=DATA_MEM [TODO_ENTRY_COUNT] [4];
    RD_W [5]                            <=RD_W [4];
    RD_DATA [5]                         <=RD_DATA [4];

end

//calulate golden signals and store in row zero of 5x5
always@(posedge clk) begin  //TODO I DONT KNOW HOW SEPARATING THIS CODE INTO A SEPARATE ALWAYS BLOCK AFFECT THE ORDER OF EXECUTION OF THESE
                            //ARRAY MOVEMENT, I SEPARATED THEM FOR READABILITY BUT THEY MAY VERY WELL FUCK UP THE ARRAY MOVMENT

    PC [0]                                  <= PC_TARGET[1];    //TODO pay attention to the order of pc[0] -> instr_mem & inst_asyn -> inst, i think as it is the timing is fucked up where pc[0] might be "null" when we fetch the instruction
    PC_TARGET[0]                            <= 
    INSTR[0]                                <= INSTR_ASYNC;
    RS1 [0]                                 <= RS1_ASYNC;
    RS2 [0]                                 <= RS2_ASYNC;
    RS1_DATA [0]                            <=
    RS2_DATA [0]                            <=
    REGFILE [RD_W] [0]                      <= RD_DATA[0]
    DATA_MEM_IN [0]                         <=
    DATA_MEM_IN_ADDR [0]                    <=
    DATA_MEM_OUT [0]                        <=
    DATA_MEM_OUT_ADDR [0]                   <=
    DATA_MEM [TODO_ENTRY_COUNT] [0]         <=
    RD_W [0]                                <=
    RD_DATA [0]                             <=

end


//TODO all of these should be blocking (syncronouse)

/* start of old code */

//DUAL PIPELINE ----------------------------------------------------------------------------------------------------------------
//sequential logic to create the pipeline
always@(posedge clk or negedge rst) begin //async reset

    if(!rst) begin //resets the pipeline and tracker
        {if_id, id_ex, ex_mem, mem_wb, post_wb} <= '0;
        {data_t, data_v, data_x, data_z} <= '0;
    end else begin
        //continues advancing instructions and data through pipelines
        {if_id, id_ex, ex_mem, mem_wb, post_wb} <= {cpu_dut.INSTR_F_FLUSH, cpu_dut.INSTR_D_FLUSH,id_ex, ex_mem, mem_wb};//instr
        {data_t, data_v, data_x, data_z} <= {data_s, data_u, data_w, data_y}; //data
    end

    branched_jumped <= cpu_dut.redirect_pc; //indicates branch/jump in last cycle
end

//combinational logic used to retrieve data from various stages in CPU for verification
always_comb begin
    //ID -------------------------------------------------------------------------------
        data_s = {6{32'hdeadbeef}}; //placeholder values, not significant

    //EX --------------------------------------------------------------------------------
    if(id_ex[6:0] == 7'b1100011 || id_ex[6:0] == 7'b1101111 || id_ex[6:0] == 7'b1100111) begin //---B-TYPE/JAL/JALR
        data_u = {
            data_t[5], //mem
            data_t[4], //next_pc
            cpu_dut.PC_E, //pc
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
            data_v[0] //rd
        };
    end else if(ex_mem[6:0] == 7'b1100011 || ex_mem[6:0] == 7'b1101111 || ex_mem[6:0] == 7'b1100111) begin //--B-TYPE/JAL/JALR
        data_w = {
            data_v[5], //mem
            (branched_jumped)? cpu_dut.PC: cpu_dut.PC_E,  //.PC after flush, PC_E in normal condition
            data_v[3], //pc
            data_v[2], //rs2
            data_v[1], //rs1
            data_v[0] //rd
        };
    end else begin
        data_w = data_v;
    end

    //WB-------------------------------------------------------------------------------
    if(mem_wb[6:0] == 7'b0110011 || mem_wb[6:0] == 7'b0010011) begin //--R-TYPE/I-TYPE (ARITHMETIC)/M-TYPE ---
        data_y = {
            data_x[5], //mem
            data_x[4], //next_pc
            data_x[3], //pc
            cpu_dut.my_reg_file.regs_out[mem_wb[24:20]], //rs2
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
    rd_data = cpu_dut.my_reg_file.regs_out[post_wb[11:7]]; //---ALL-TYPES----------------
    {mem_data, next_pc_data, pc_data, rs2_data, rs1_data} = data_z[5:1]; //unpacking else
end


//VERIFICATION -----------------------------------------------------------------------------------------------------------------
task reg_mem_dump;
    begin
        //CPU REGISTER DUMP - comment/uncomment as needed
        $display("CPU REGISTER DUMP, POST WB:");
        for(int k = 0; k < 32; k++) begin
            $display("\t\tx%d: 0x%h", k, cpu_dut.my_reg_file.regs_out[k]);
        end

        //CPU DATA MEMORY DUMP
        // WARNING: Can be very long, uncomment at your convenience.
        $display("CPU DATA MEMORY DUMP: ");
        for (int k = 0; k < NUM_DATA_WORDS; k++) begin
            $display("\t\t0x%h: 0x%h", k*4, cpu_dut.data_mem.data_mem[k]);
        end
    end
endtask

always @(negedge clk) begin //read on negative edge to give everything time to settle

    if (ohalt == 1'b1) begin //HALT SIGNAL --------------------------------------------------------------
        $display("\nWARNING: Recieved halt signal. Pausing verification.");
        $display("Program counter: %d", cpu_dut.PC);
        reg_mem_dump();
        $stop(); //pauses verification if CPU outputs halt signal

    end else if(instruction_failure == 1) begin //INSTRUCTION FAILURE----------------------------------
        $display("\nWARNING: Mismatch between model and CPU. Pausing verification.");
        $display("\tPlease check for data hazards and issues in this instruction's datapath/control.");
        reg_mem_dump();
        $stop(); //pauses verification if an instruction has failed OR a data hazard has occured.
        instruction_failure = 0; //resets to zero after pause to check other instructions (OPTIONAL).

    end

    //START VERIFICATION -------------------------------------------------------------------------------
    $display("\nInstructions in pipeline:"); //seeing where the instructions are located
    $display("IF/ID: 0x%h, ID/EX: 0x%h, EX/MEM: 0x%h, MEM/WB: 0x%h", if_id, id_ex, ex_mem, mem_wb);
    $display("Currently verifying: 0x%h", post_wb); //instruction in verification stage

    opcode = post_wb[6:0]; //identify the instructions

    if (opcode == 7'b0110011) begin //--------R-TYPE/M-TYPE----------------------------------------------
        {func7, rs2, rs1, func3, rd} = post_wb[31:7];
        $display("\tR/M-Type: func7: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b",
        func7, rs2, rs1, func3, rd, opcode); //instruction info

        //-R-TYPE---------------
        if (func7 == 7'b0000000) begin
            if (func3 == 3'b000) begin //----ADD------------------------------
                $display("\tIdentified as ADD.");
                expected_result = rs1_data + rs2_data;
                assert(rd_data == expected_result) $display("ADD successful.");
                else instruction_failure = 1;//compare contents of model register with CPU register
            end

        end else if (func7 == 7'b0100000) begin     
            if (func3 == 3'b000) begin //----SUB---------------------------
                $display("\tIdentified as SUB.");
                expected_result = rs1_data - rs2_data;
                assert(rd_data == expected_result) $display("SUB successful.");
                else instruction_failure = 1;//compare contents of model register with CPU register
            end

        //-M-TYPE---------------
        end else if (func7 == 7'b0000001) begin
            if (func3 == 3'b000) begin //----MUL------------------------------
                $display("\tIdentified as MUL.");
                product = {{32{rs1_data[31]}}, rs1_data} * {{32{rs2_data[31]}}, rs2_data};
                expected_result = product[31:0];
                assert(rd_data == expected_result) $display("MUL successful.");
                else instruction_failure = 1;//compare contents of model register with CPU register

            end else if (func3 == 3'b001) begin //----MULH------------------------------
                $display("\tIdentified as MULH.");
                product = {{32{rs1_data[31]}}, rs1_data} * {{32{rs2_data[31]}}, rs2_data};
                expected_result = product[63:32];
                assert(rd_data == expected_result) $display("MULH successful.");
                else instruction_failure = 1;//compare contents of model register with CPU register

            end else if (func3 == 3'b010) begin //----MULHSU------------------------------
                $display("\tIdentified as MULHSU.");
                product = {{32{rs1_data[31]}}, rs1_data} * {{32{1'b0}}, rs2_data};
                expected_result = product[63:32];
                assert(rd_data == expected_result) $display("MULHSU successful.");
                else instruction_failure = 1;//compare contents of model register with CPU register

            end else if (func3 == 3'b011) begin //----MULHU------------------------------
                $display("\tIdentified as MULHU.");
                product = {{32{1'b0}}, rs1_data} * {{32{1'b0}}, rs2_data};
                expected_result = product[63:32];
                assert(rd_data == expected_result) $display("MULHU successful.");
                else instruction_failure = 1;//compare contents of model register with CPU register

            end

        end

        //model vs cpu register
        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd, rd_data, expected_result);



    end else if (opcode == 7'b0010011) begin //-----I-TYPE (ARITHMETIC) ---------------------------------
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

    end else if (opcode == 7'b0000011) begin //----I-TYPE (LOADS) ----------------------------------
        {imm_i, rs1, func3, rd} = post_wb[31:7];
        $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1,
        func3, rd, opcode); //instruction info

        if(func3 == 3'b010) begin //----LW------------------------------------
            $display("\tIdentified as LW.");
            assert(rd_data == mem_data) $display("LW successful.");
            else instruction_failure = 1;//compare contents of model register with CPU register

        end

        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd, rd_data, mem_data); //model vs cpu registers

    end else if (opcode == 7'b1100111) begin //---I-TYPE (JALR) ------------------------------------------
        {imm_i, rs1, func3, rd} = post_wb[31:7];
        $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1,
        func3, rd, opcode); //instruction info

        if(func3 == 3'b000) begin //-------JALR-------------------------------
            $display("\tIdentified as JALR.");
            expected_result = rs1_data + {{20{imm_i[11]}}, imm_i};
            if(rd == 5'd0)begin
                additional_result = 32'd0; //jump (no link register)
            end else begin
                additional_result = pc_data + 32'd4; //jump and link register
            end 
            assert(next_pc_data == expected_result && rd_data == additional_result) $display("JALR successful.");
            else instruction_failure = 1; //ensure the PC and rd have changed to appropiate values

        end

        //output the PC and the rd for the CPU and the model
        $display("Value of program counter:\n\tCPU: 0x%h\n\tModel: 0x%h", next_pc_data, expected_result);
        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd, rd_data, additional_result); //model vs cpu registers



    end else if (opcode == 7'b0100011) begin //------S-TYPE----------------------------------
        {imm_s[11:5], rs2, rs1, func3, imm_s[4:0]} = post_wb[31:7];
        $display("\tS-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_s, rs2, rs1,
        func3, opcode); //instruction info
        verification_address = {{20{imm_s[11]}}, imm_s} + rs1_data; //expected address in memory

        if(func3 == 3'b010) begin //----SW-------------------------------------
            $display("\tIdentified as SW.");
            assert(mem_data == rs2_data) $display("SW successful.");
            else instruction_failure = 1;//ensure source register was written to CPU memory

        end

        //compare model vs CPU memory contents
        $display("Contents of data memory at 0x%h:\n\tCPU: 0x%h\n\tModel: 0x%h", verification_address, mem_data, rs2_data);



    end else if (opcode == 7'b1100011) begin //------B-TYPE----------------------------
        {imm_b[12], imm_b[10:5], rs2, rs1, func3, imm_b[4:1], imm_b[11]} = post_wb[31:7];
        imm_b[0] = 1'b0; //LSB is always zero for B-type
        $display("\tB-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_b[12:1], rs2, rs1,
        func3, opcode); //instruction info

        if(func3 == 3'b000) begin //----BEQ------------------------------------------------
            $display("\tIdentified as BEQ.");
            if(rs1_data == rs2_data) begin //if equal
                expected_result = pc_data + {{19{imm_b[12]}}, imm_b}; //determine new PC address
            end else begin
                expected_result = pc_data + 32'd4; //increment PC normally (I think this is right...)
            end
            assert(next_pc_data == expected_result) $display("BEQ successful.");
            else instruction_failure = 1; //ensure the PC has changed to the correct address

        end 

        //compare the model's expected PC value vs the CPU's program counter
        $display("Value of program counter:\n\tCPU: 0x%h\n\tModel: 0x%h", next_pc_data, expected_result);


    
    end else if (opcode == 7'b1101111) begin //---J-TYPE (JAL) ------------------------------------------
        {imm_j[20], imm_j[10:1], imm_j[11], imm_j[19:12], rd} = post_wb[31:7];
        imm_j[0] = 1'b0;
        $display("\tJ-Type: imm: 0b%b, rsd: 0b%b, opcode: 0b%b", imm_j[20:1], rd, opcode); //instruction info

        //----JAL------------
        $display("\tIdentified as JAL.");
        expected_result = pc_data + {{11{imm_j[20]}}, imm_j};
        if(rd == 5'd0)begin
            additional_result = 32'd0; //jump (no link register)
        end else begin
            additional_result = pc_data + 32'd4; //jump and link register
        end 
        assert(next_pc_data == expected_result && rd_data == additional_result) $display("JAL successful.");
        else instruction_failure = 1; //ensure the PC and rd have changed to appropiate values

        //output the PC and the rd for the CPU and the model
        $display("Value of program counter:\n\tCPU: 0x%h\n\tModel: 0x%h", next_pc_data, expected_result);
        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd, rd_data, additional_result); //model vs cpu registers



    end else if (opcode == 7'b0110111) begin  //------U-TYPE-(LUI)-------------------------------
        {imm_u, rd} = post_wb[31:7];
        $display("\tU-Type: imm: 0b%b, rsd: 0b%b, opcode: 0b%b", imm_u, rd, opcode); //instruction info

        //----LUI---------------
        $display("\tIdentified as LUI.");
        expected_result = imm_u <<< 12;
        assert(rd_data == expected_result) $display("LUI successful.");
        else instruction_failure = 1;//compare contents of model register with CPU register

        $display("Contents of register x%d:\n\tCPU: 0x%h\n\tModel: 0x%h", rd, rd_data, expected_result); //model vs cpu registers

    end else begin
        //UNKNOWN ------------------------------
        $display("WARNING: Instruction type not currently recognized by TB.");

    end

end
endmodule