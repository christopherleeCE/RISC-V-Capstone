/*
instructions working in the golden, all but mul's
*/

`timescale 1ns/1ns

module top_riscv_cpu();

    //PARAMETERS/BUSES----------------------------------------------------------------------------------------------------------
    //constants
    parameter int CLOCK_PERIOD = 20;
    parameter int NUM_INSTRUCTIONS = 32;
    parameter int NUM_DATA_WORDS = 32;
    int instruction_failure;

    //declare the buses and signals
    logic clk, rst, ohalt;
    

    //golden sginals, these are what the DUT is verfied against, they are stored in a 5x1 array, one or each clk of the execution in the DUT
    //TODO many of these are not needed, and will be culled
    logic [31:0] PC [5:0];
    logic [31:0] PC_TARGET [5:0];
    logic [31:0] INSTR [5:0];
    logic [4:0] RS1 [5:0];
    logic [4:0] RS2 [5:0];
    logic [31:0] RS1_DATA [5:0];
    logic [31:0] RS2_DATA [5:0];
    logic [31:0] REGFILE [31:0] [5:0];
    logic [31:0] DATA_MEM_IN [5:0];
    logic [31:0] DATA_MEM_IN_ADDR [5:0];
    logic [31:0] DATA_MEM_OUT [5:0];
    logic [31:0] DATA_MEM_OUT_ADDR [5:0];
    logic [31:0] DATA_MEM           [ 31:0 ] [5:0];
    logic [4:0] RD_W [5:0];
    logic [31:0] RD_DATA [5:0];


    logic [31:0] INSTR_ASYNC;
    logic [31:0] REG_FILE_ASYNC [31:0] = '{default: 32'b0}; // this should not be written to directly, however you can read from it directly 
    logic [31:0] PC_ASYNC;




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
        repeat(1) begin 
            rst = 1'b0; //tbh reset doesnt really do anything i think
            instruction_failure = 0;
            PC_ASYNC <= '0;
            @(posedge clk);
        end

        rst = 1'b1; //disable the reset
    end

    logic [6:0] func7;
    logic [4:0] rs2;
    logic [4:0] rs1;
    logic [4:0] rd;
    logic [2:0] func3;
    logic [6:0] opcode;
    logic [11:0] imm_i, imm_s;
    logic [12:0] imm_b;
    logic [19:0] imm_u;
    logic [20:0] imm_j;

    //declaration of golden_cpus instr mem, this instansiation should be a perfect mirror of whats instasiated in the DUT (i think)
    //if the DUT.sv's declaration changes, it should be mirrored here
    instruction_memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(32)
    ) instr_mem (
        .read_address(PC_ASYNC),
        .read_data(INSTR_ASYNC)
    );

    assign opcode = INSTR_ASYNC[6:0];
  
    //abstracted write access to prevent writing to the zero register
    task automatic write_reg(
        input int unsigned addr,
        input logic [31:0] word
    );

        if (addr != 0)
            REG_FILE_ASYNC[addr] <= word;

    endtask

    //no abstraction needed
    logic [31:0] DATA_MEM_ASYNC [31:0] = '{default: 32'b0};

    always @(posedge clk) begin //golden results calculated on posedge

        logic [63:0] product;

        reg_async_dump();

        $write("\n\n\n");
        $display("========================================================================================");
        $display("\tCurrent PC: %h", PC_ASYNC);
        $display("\tINSTR_ASYNC: %h", INSTR_ASYNC);
        $display("\topcode: %h", opcode);


        if (opcode == 7'b0110011) begin //--------R-TYPE/M-TYPE----------------------------------------------
            {func7, rs2, rs1, func3, rd} = INSTR_ASYNC[31:7];
            $display("\tR/M-Type: func7: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b",
            func7, rs2, rs1, func3, rd, opcode); //instruction info

            //-R-TYPE---------------
            if (func7 == 7'b0000000) begin
                if (func3 == 3'b000) begin //----ADD------------------------------
                    $display("\tIdentified as ADD.");
                    write_reg(rd, REG_FILE_ASYNC[rs2] + REG_FILE_ASYNC[rs1]);
                    PC_ASYNC <= PC_ASYNC + 32'h4;
                    
                end

            end else if (func7 == 7'b0100000) begin     
                if (func3 == 3'b000) begin //----SUB---------------------------
                    $display("\tIdentified as SUB.");
                    write_reg(rd, REG_FILE_ASYNC[rs1] - REG_FILE_ASYNC[rs2]);
                    PC_ASYNC <= PC_ASYNC + 32'h4;
                    
                end

            //-M-TYPE--------------- TODO, the top file fail the test program that chat gave me, not sure if that actually means that its not working, ill go through the math l8r
            end else if (func7 == 7'b0000001) begin
                if (func3 == 3'b000) begin //----MUL------------------------------
                    $display("\tIdentified as MUL.");
                    product = $signed(REG_FILE_ASYNC[rs1]) * $signed(REG_FILE_ASYNC[rs2]);
                    write_reg(rd, product[31:0]);
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                end else if (func3 == 3'b001) begin //----MULH------------------------------
                    $display("\tIdentified as MULH.");
                    product = $signed(REG_FILE_ASYNC[rs1]) * $signed(REG_FILE_ASYNC[rs2]);
                    $display("%h = %h * %h", product, $signed(REG_FILE_ASYNC[rs1]), $signed(REG_FILE_ASYNC[rs2]));
                    write_reg(rd, product[63:32]);
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                end else if (func3 == 3'b010) begin //----MULHSU------------------------------
                    $display("\tIdentified as MULHSU.");
                    product = $signed(REG_FILE_ASYNC[rs1]) * $unsigned(REG_FILE_ASYNC[rs2]);
                                        $display("%h", product);
                    write_reg(rd, product[63:32]);
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                end else if (func3 == 3'b011) begin //----MULHU------------------------------
                    $display("\tIdentified as MULHU.");
                    product = $unsigned(REG_FILE_ASYNC[rs1]) * $unsigned(REG_FILE_ASYNC[rs2]);
                                                            $display("%h", product);
                    write_reg(rd, product[63:32]);
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                end

            end


        end else if (opcode == 7'b0010011) begin //-----I-TYPE (ARITHMETIC) ---------------------------------
            {imm_i, rs1, func3, rd} = INSTR_ASYNC[31:7];
            $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

            if(func3 == 3'b000) begin //-------ADDI-------------------------------
                if(imm_i == 20'd0 & rs1 == 5'd0 & rd == 5'd0) begin
                    $display("\tIdentified as NOP.");
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                end else begin
                    $display("\tIdentified as ADDI.");
                    write_reg(rd, REG_FILE_ASYNC[rs1] + imm_i);
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                end
            end


        end else if (opcode == 7'b0000011) begin //----I-TYPE (LOADS) ----------------------------------
            {imm_i, rs1, func3, rd} = INSTR_ASYNC[31:7];
            $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

            if(func3 == 3'b010) begin //----LW------------------------------------
                $display("\tIdentified as LW.");
                write_reg(rd, DATA_MEM_ASYNC[rs1 + imm_i]);
                PC_ASYNC <= PC_ASYNC + 32'h4;

            end

            

        end else if (opcode == 7'b1100111) begin //---I-TYPE (JALR) ------------------------------------------
            {imm_i, rs1, func3, rd} = INSTR_ASYNC[31:7];
            $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

            if(func3 == 3'b000) begin //-------JALR-------------------------------
                $display("\tIdentified as JALR.");
                write_reg(rd, PC_ASYNC + 4);
                PC_ASYNC <= REG_FILE_ASYNC[rs1] + imm_i;

            end

    

        end else if (opcode == 7'b0100011) begin //------S-TYPE----------------------------------
            {imm_s[11:5], rs2, rs1, func3, imm_s[4:0]} = INSTR_ASYNC[31:7];
            $display("\tS-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_s, rs2, rs1, func3, opcode); //instruction info

            if(func3 == 3'b010) begin //----SW-------------------------------------
                $display("\tIdentified as SW.");
                DATA_MEM_ASYNC[rs1 + imm_s] <= REG_FILE_ASYNC[rs2];
                PC_ASYNC <= PC_ASYNC + 32'h4;

            end



        end else if (opcode == 7'b1100011) begin //------B-TYPE----------------------------
            {imm_b[12], imm_b[10:5], rs2, rs1, func3, imm_b[4:1], imm_b[11]} = INSTR_ASYNC[31:7];
            imm_b[0] = 1'b0; //LSB is always zero for B-type
            $display("\tB-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_b[12:1], rs2, rs1, func3, opcode); //instruction info

            if(func3 == 3'b000) begin //----BEQ------------------------------------------------
                $display("\tIdentified as BEQ.");
                if(REG_FILE_ASYNC[rs1] == REG_FILE_ASYNC[rs2]) begin
                    PC_ASYNC <= PC_ASYNC + imm_b;
                end else begin
                    PC_ASYNC <= PC_ASYNC + 4;
                end
            end 
        
        end else if (opcode == 7'b1101111) begin //---J-TYPE (JAL) ------------------------------------------
            {imm_j[20], imm_j[10:1], imm_j[11], imm_j[19:12], rd} = INSTR_ASYNC[31:7];
            imm_j[0] = 1'b0;
            $display("\tJ-Type: imm: 0b%b, rsd: 0b%b, opcode: 0b%b", imm_j[20:1], rd, opcode); //instruction info

            //----JAL------------
            $display("\tIdentified as JAL.");
            write_reg(rd, PC_ASYNC + 4);
            PC_ASYNC <= PC_ASYNC + imm_j;

        end else if (opcode == 7'b0110111) begin  //------U-TYPE-(LUI)-------------------------------
            {imm_u, rd} = INSTR_ASYNC[31:7];
            $display("\tU-Type: imm: 0b%b, rsd: 0b%b, opcode: 0b%b", imm_u, rd, opcode); //instruction info

            //----LUI---------------
            $display("\tIdentified as LUI.");
            write_reg(rd, {imm_u, REG_FILE_ASYNC[rd][11:0]});
            PC_ASYNC <= PC_ASYNC + 32'h4;

        end else begin
            //UNKNOWN ------------------------------
            $display("\t<### WARNING: Instruction type not currently recognized by TB ###>");

        end

    end






    // //progress 5x5 array
    // always@(posedge clk) begin

    //     //progress instrucition snapshot
    //     PC [1]                              <=PC [0];
    //     PC_TARGET [1]                       <=PC_TARGET [0];
    //     INSTR[1]                            <=INSTR[0];
    //     RS1 [1]                             <=RS1 [0];
    //     RS2 [1]                             <=RS2 [0];
    //     RS1_DATA [1]                        <=RS1_DATA [0];
    //     RS2_DATA [1]                        <=RS2_DATA [0];
    //     REGFILE [1]   <=REGFILE [0];
    //     DATA_MEM_IN [1]                     <=DATA_MEM_IN [0];
    //     DATA_MEM_IN_ADDR [1]                <=DATA_MEM_IN_ADDR [0];
    //     DATA_MEM_OUT [1]                    <=DATA_MEM_OUT [0];
    //     DATA_MEM_OUT_ADDR [1]               <=DATA_MEM_OUT_ADDR [0];
    //     DATA_MEM [31:0] [1]                 <=DATA_MEM [31:0] [0];
    //     RD_W [1]                            <=RD_W [0];
    //     RD_DATA [1]                         <=RD_DATA [0];

    //     PC [2]                              <=PC [1];
    //     PC_TARGET [2]                       <=PC_TARGET [1];
    //     INSTR[2]                            <=INSTR[1];
    //     RS1 [2]                             <=RS1 [1];
    //     RS2 [2]                             <=RS2 [1];
    //     RS1_DATA [2]                        <=RS1_DATA [1];
    //     RS2_DATA [2]                        <=RS2_DATA [1];
    //     REGFILE [2]   <=REGFILE [1];
    //     DATA_MEM_IN [2]                     <=DATA_MEM_IN [1];
    //     DATA_MEM_IN_ADDR [2]                <=DATA_MEM_IN_ADDR [1];
    //     DATA_MEM_OUT [2]                    <=DATA_MEM_OUT [1];
    //     DATA_MEM_OUT_ADDR [2]               <=DATA_MEM_OUT_ADDR [1];
    //     DATA_MEM [31:0] [2]                 <=DATA_MEM [31:0] [1];
    //     RD_W [2]                            <=RD_W [1];
    //     RD_DATA [2]                         <=RD_DATA [1];

    //     PC [3]                              <=PC [2];
    //     PC_TARGET [3]                       <=PC_TARGET [2];
    //     INSTR[3]                            <=INSTR[2];
    //     RS1 [3]                             <=RS1 [2];
    //     RS2 [3]                             <=RS2 [2];
    //     RS1_DATA [3]                        <=RS1_DATA [2];
    //     RS2_DATA [3]                        <=RS2_DATA [2];
    //     REGFILE [3]   <=REGFILE [2];
    //     DATA_MEM_IN [3]                     <=DATA_MEM_IN [2];
    //     DATA_MEM_IN_ADDR [3]                <=DATA_MEM_IN_ADDR [2];
    //     DATA_MEM_OUT [3]                    <=DATA_MEM_OUT [2];
    //     DATA_MEM_OUT_ADDR [3]               <=DATA_MEM_OUT_ADDR [2];
    //     DATA_MEM [31:0] [3]                 <=DATA_MEM [31:0] [2];
    //     RD_W [3]                            <=RD_W [2];
    //     RD_DATA [3]                         <=RD_DATA [2];

    //     PC [4]                              <=PC [3];
    //     PC_TARGET [4]                       <=PC_TARGET [3];
    //     INSTR[4]                            <=INSTR[3];
    //     RS1 [4]                             <=RS1 [3];
    //     RS2 [4]                             <=RS2 [3];
    //     RS1_DATA [4]                        <=RS1_DATA [3];
    //     RS2_DATA [4]                        <=RS2_DATA [3];
    //     REGFILE [4]   <=REGFILE [3];
    //     DATA_MEM_IN [4]                     <=DATA_MEM_IN [3];
    //     DATA_MEM_IN_ADDR [4]                <=DATA_MEM_IN_ADDR [3];
    //     DATA_MEM_OUT [4]                    <=DATA_MEM_OUT [3];
    //     DATA_MEM_OUT_ADDR [4]               <=DATA_MEM_OUT_ADDR [3];
    //     DATA_MEM [31:0] [4]                 <=DATA_MEM [31:0] [3];
    //     RD_W [4]                            <=RD_W [3];
    //     RD_DATA [4]                         <=RD_DATA [3];

    //     //this timestamp might not need to be used
    //     PC [5]                              <=PC [4];
    //     PC_TARGET [5]                       <=PC_TARGET [4];
    //     INSTR[5]                            <=INSTR[4];
    //     RS1 [5]                             <=RS1 [4];
    //     RS2 [5]                             <=RS2 [4];
    //     RS1_DATA [5]                        <=RS1_DATA [4];
    //     RS2_DATA [5]                        <=RS2_DATA [4];
    //     REGFILE [5]   <=REGFILE [4];
    //     DATA_MEM_IN [5]                     <=DATA_MEM_IN [4];
    //     DATA_MEM_IN_ADDR [5]                <=DATA_MEM_IN_ADDR [4];
    //     DATA_MEM_OUT [5]                    <=DATA_MEM_OUT [4];
    //     DATA_MEM_OUT_ADDR [5]               <=DATA_MEM_OUT_ADDR [4];
    //     DATA_MEM [31:0] [5]                 <=DATA_MEM [31:0] [4];
    //     RD_W [5]                            <=RD_W [4];
    //     RD_DATA [5]                         <=RD_DATA [4];

    // end

    // //calulate golden signals and store in row zero of 5x5
    // always@(posedge clk) begin  //TODO I DONT KNOW HOW SEPARATING THIS CODE INTO A SEPARATE ALWAYS BLOCK AFFECT THE ORDER OF EXECUTION OF THESE
    //                             //ARRAY MOVEMENT, I SEPARATED THEM FOR READABILITY BUT THEY MAY VERY WELL FUCK UP THE ARRAY MOVMENT

    //     PC [0]                                  <= PC_TARGET[1];    //TODO pay attention to the order of pc[0] -> instr_mem & inst_asyn -> inst, i think as it is the timing is fucked up where pc[0] might be "null" when we fetch the instruction
    //     PC_TARGET[0]                            <= 
    //     INSTR[0]                                <= INSTR_ASYNC;
    //     RS1 [0]                                 <= RS1_ASYNC;
    //     RS2 [0]                                 <= RS2_ASYNC;
    //     RS1_DATA [0]                            <=
    //     RS2_DATA [0]                            <=
    //     REGFILE [RD_W] [0]                      <= RD_DATA[0]
    //     DATA_MEM_IN [0]                         <=
    //     DATA_MEM_IN_ADDR [0]                    <=
    //     DATA_MEM_OUT [0]                        <=
    //     DATA_MEM_OUT_ADDR [0]                   <=
    //                 DATA_MEM [31:0] [0]         <=
    //     RD_W [0]                                <=
    //     RD_DATA [0]                             <=

    // end


    //TODO all of these should be blocking (syncronouse)


    always @(negedge clk) begin //read on negative edge to give everything time to settle

        if (ohalt == 1'b1) begin //HALT SIGNAL --------------------------------------------------------------
            $display("\nWARNING: Recieved halt signal. Pausing verification.");
            $display("Program counter: %d", cpu_dut.PC);
            reg_async_dump();
            $stop(); //pauses verification if CPU outputs halt signal

        end else if(instruction_failure == 1) begin //INSTRUCTION FAILURE----------------------------------
            $display("\nWARNING: Mismatch between model and CPU. Pausing verification.");
            $display("\tPlease check for data hazards and issues in this instruction's datapath/control.");
            reg_async_dump();
            $stop(); //pauses verification if an instruction has failed OR a data hazard has occured.
            instruction_failure = 0; //resets to zero after pause to check other instructions (OPTIONAL).

        end

    end

    //VERIFICATION -----------------------------------------------------------------------------------------------------------------
    task reg_async_dump();
        begin
            $display("REG_FILE_ASYNC Dump");
            for(int ii = 0; ii < 32; ii++) begin
                $display("\tx%d: 0x%h", ii, REG_FILE_ASYNC[ii]);
            end
        end
    endtask



endmodule