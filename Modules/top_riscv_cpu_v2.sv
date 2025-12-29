/*
TODO for the arth instruciton compare the whole regfile instead
just the destination register, you cant just do regdut == reggold[4],
cause according to chat, if there is an x in the structure, even in 
reggold[1] for example the assertion fails, so you need to do a for loop,
and doing that is prob easier to do in a task/func but ill do that l8r

TODO there is an issue in the golden calulation where 
# start:
#         addi a0, zero, 0x10
#         addi a1, zero, 0x17
#         addi a5, zero, 0x30
#         addi a5, zero, 0x34
#         addi a5, zero, 0x38
#         addi a5, zero, 0x3C
#         addi a5, zero, 0x40
#         addi a5, zero, 0x44
#         addi a5, zero, 0x48
#         addi a5, zero, 0x4C
#         #nop

of nop is commented out (not present) then that last addi doesnt execute in the golden,
specifically the last instruction of any program doesnt calculate correclty


TODO fix??? (maybe dont) issue with addi when forwarding doesnt seem to work, maybe just get golden issue above fixed, or more features for top

TODO negedge block IS NOT DONE

TODOTODOTODO next TODO
implement stalling on gold model baseed on dut.pcredirect (i thin thats the signal)

*/

`timescale 1ns/1ns

module top_riscv_cpu_v2();

    //PARAMETERS/BUSES----------------------------------------------------------------------------------------------------------
    //constants
    parameter int CLOCK_PERIOD = 20;
    int instruction_failure;

    //dumb way to get around default output of verify_row task, TODO find better way to do this, maybe switch from task to func?
    static int def0 = 0;
    static int def1 = 0;
    static int def2 = 0;
    static int def3 = 0;
    static int def4 = 0;
    static int def5 = 0;

    //cpu ports
    logic clk, rst, ohalt;

    //golden instruction decoded declarations
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


    //golden sginals for matrix, these are what the DUT is verfied against, they are stored in a 5x1 array, one or each clk of the execution in the DUT
    /* golden[0], one clk delay, golden[1], two clk delays, etc. */
    /* I THINK that...
  ASYCN -> if
    [0] -> id
    [1] -> ex
    [2] -> mem
    [3] -> w
    [4] -> post writeback TODO WRONG!!!
    */
    logic [31:0] PC [5:1];
    logic [31:0] PC_TARGET [5:1];
    logic [31:0] INSTR [5:1];
    logic [4:0] RS1 [5:1];
    logic [4:0] RS2 [5:1];
    logic [4:0] RD [5:1];
    logic [31:0] REG_FILE [5:1] [31:0] = '{default: 32'b0};;
    logic [31:0] DATA_MEM_ADDR [5:1];
    logic [31:0] DATA_MEM_IN [5:1];
    logic [31:0] DATA_MEM_OUT [5:1];
    logic [31:0] DATA_MEM [5:1] [31:0];

    //the "async" of the golden signals, they are calculated in the always block bellow, then the relevent signals are fed into the matrix
    logic [31:0] INSTR_ASYNC;
    logic [31:0] REG_FILE_ASYNC [31:0] = '{default: 32'b0}; // this should not be written to directly, however you can read from it directly 
    logic [31:0] PC_ASYNC;



    //DUT---------------------------------------------------------------------------------------------------------------------
    //instantiate the CPU
    riscv_cpu_v2 cpu_dut(.clk(clk), .rst(rst), .ohalt(ohalt));

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
        repeat(3) begin 
            rst = 1'b0; //tbh reset doesnt really do anything i think
            @(posedge clk);
        end

        rst = 1'b1; //disable the reset
    end

    //declaration of golden_cpus instr mem, this instansiation should be a perfect mirror of whats instasiated in the DUT (i think)
    //if the DUT.sv's declaration changes, it should be mirrored here
    instruction_memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(512)
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
            REG_FILE[1][addr] <= word;

    endtask

    //no abstraction needed
    logic [31:0] DATA_MEM_ASYNC [31:0] = '{default: 32'b0};



    always_ff @(posedge clk) begin //golden results calculated on posedge

        logic [63:0] product;

        if (!rst) begin

            $display("\n\n\n<* rst = 0, intializing *>");
            PC_ASYNC <= '0;
            instruction_failure <= 0;

        end else if(1) begin

            //$display("posedgedump");
            //reg_gold_postwb_dump();
            //data_mem_async_dump();
            //display_golden_singals_history();

            // /* DO NOT REMOVE : DEBUG GOLD */ $write("\n\n\n");
            // /* DO NOT REMOVE : DEBUG GOLD */ $display("Posedge block output");
            // /* DO NOT REMOVE : DEBUG GOLD */ $display("========================================================================================");
            // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tPC_ASYNC: %h", PC_ASYNC);
            // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tINSTR_ASYNC: %h", INSTR_ASYNC);
            // /* DO NOT REMOVE : DEBUG GOLD */ $display("\topcode: %h", opcode);


            if (opcode == 7'b0110011) begin //--------R-TYPE/M-TYPE----------------------------------------------
                {func7, rs2, rs1, func3, rd} = INSTR_ASYNC[31:7];
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tR/M-Type: func7: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", func7, rs2, rs1, func3, rd, opcode); //instruction info

                //first entry in the matrix
                PC[1] <= PC_ASYNC;
                PC_TARGET[1] <= PC_ASYNC + 32'h4;
                INSTR[1] <= INSTR_ASYNC;
                RS1[1] <= rs1;
                RS2[1] <= rs2;
                RD[1] <= rd;
                DATA_MEM_ADDR[1] <= 'x;
                DATA_MEM_IN[1] <= 'x;
                DATA_MEM_OUT[1] <= 'x;
                DATA_MEM[1] <= DATA_MEM_ASYNC;

                //-R-TYPE---------------
                if (func7 == 7'b0000000) begin
                    if (func3 == 3'b000) begin //----ADD------------------------------
                        // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as ADD.");
                        write_reg(rd, REG_FILE[1][rs2] + REG_FILE[1][rs1]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;
                        
                    end

                end else if (func7 == 7'b0100000) begin     
                    if (func3 == 3'b000) begin //----SUB---------------------------
                        // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as SUB.");
                        write_reg(rd, REG_FILE[1][rs1] - REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;
                        
                    end

                //-M-TYPE---------------
                end else if (func7 == 7'b0000001) begin
                    if (func3 == 3'b000) begin //----MUL------------------------------
                        // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as MUL.");
                        product = $signed(REG_FILE[1][rs1]) * $signed(REG_FILE[1][rs2]);
                        write_reg(rd, product[31:0]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b001) begin //----MULH------------------------------
                        // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as MULH.");
                        product = $signed(REG_FILE[1][rs1]) * $signed(REG_FILE[1][rs2]);
                        write_reg(rd, product[63:32]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b010) begin //----MULHSU------------------------------
                        // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as MULHSU.");
                        product = $signed(REG_FILE[1][rs1]) * $unsigned(REG_FILE[1][rs2]);
                        write_reg(rd, product[63:32]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b011) begin //----MULHU------------------------------
                        // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as MULHU.");
                        product = $unsigned(REG_FILE[1][rs1]) * $unsigned(REG_FILE[1][rs2]);
                        write_reg(rd, product[63:32]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end

                end


            end else if (opcode == 7'b0010011) begin //-----I-TYPE (ARITHMETIC) ---------------------------------
                {imm_i, rs1, func3, rd} = INSTR_ASYNC[31:7];
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

                //first entry in the matrix
                PC[1] <= PC_ASYNC;
                PC_TARGET[1] <= PC_ASYNC + 32'h4;
                INSTR[1] <= INSTR_ASYNC;
                RS1[1] <= rs1;
                RS2[1] <= 'x;
                RD[1] <= rd;
                DATA_MEM_ADDR[1] <= 'x;
                DATA_MEM_IN[1] <= 'x;
                DATA_MEM_OUT[1] <= 'x;
                DATA_MEM[1] <= DATA_MEM_ASYNC;

                if(func3 == 3'b000) begin //-------ADDI-------------------------------
                    if(imm_i == 20'd0 & rs1 == 5'd0 & rd == 5'd0) begin
                        // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as NOP.");
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else begin
                        // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as ADDI.");
                        //$display("data: %h | rd: %d | rs1: %d", REG_FILE[1][rs1] + imm_i, rd, rs1);
                        write_reg(rd, REG_FILE[1][rs1] + imm_i);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end
                end


            end else if (opcode == 7'b0000011) begin //----I-TYPE (LOADS) ----------------------------------
                {imm_i, rs1, func3, rd} = INSTR_ASYNC[31:7];
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

                if(func3 == 3'b010) begin //----LW------------------------------------
                    // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as LW.");
                    write_reg(rd, DATA_MEM_ASYNC[rs1 + imm_i]);
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                    //first entry in the matrix
                    PC[1] <= PC_ASYNC;
                    PC_TARGET[1] <= PC_ASYNC + 32'h4;
                    INSTR[1] <= INSTR_ASYNC;
                    RS1[1] <= rs1;
                    RS2[1] <= 'x;
                    RD[1] <= rd;
                    DATA_MEM_ADDR[1] <= rs1 + imm_i;
                    DATA_MEM_IN[1] <= 'x;
                    DATA_MEM_OUT[1] <= DATA_MEM_ASYNC[rs1 + imm_i];
                    DATA_MEM[1] <= DATA_MEM_ASYNC;

                end

                

            end else if (opcode == 7'b1100111) begin //---I-TYPE (JALR) ------------------------------------------
                {imm_i, rs1, func3, rd} = INSTR_ASYNC[31:7];
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

                if(func3 == 3'b000) begin //-------JALR-------------------------------
                    // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as JALR.");
                    write_reg(rd, PC_ASYNC + 4);
                    PC_ASYNC <= REG_FILE[1][rs1] + {{20{imm_j[11]}}, imm_j[11:0]};

                    //first entry in the matrix
                    PC[1] <= PC_ASYNC;
                    PC_TARGET[1] <= REG_FILE[1][rs1] + {{20{imm_j[11]}}, imm_j[11:0]};
                    INSTR[1] <= INSTR_ASYNC;
                    RS1[1] <= rs1;
                    RS2[1] <= 'x;
                    RD[1] <= rd;
                    DATA_MEM_ADDR[1] <= 'x;
                    DATA_MEM_IN[1] <= 'x;
                    DATA_MEM_OUT[1] <= 'x;
                    DATA_MEM[1] <= DATA_MEM_ASYNC;

                end

        

            end else if (opcode == 7'b0100011) begin //------S-TYPE----------------------------------
                {imm_s[11:5], rs2, rs1, func3, imm_s[4:0]} = INSTR_ASYNC[31:7];
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tS-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_s, rs2, rs1, func3, opcode); //instruction info

                if(func3 == 3'b010) begin //----SW-------------------------------------
                    // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as SW.");
                    DATA_MEM_ASYNC[rs1 + imm_s] <= REG_FILE[1][rs2];
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                    //first entry in the matrix
                    PC[1] <= PC_ASYNC;
                    PC_TARGET[1] <= PC_ASYNC + 32'h4;
                    INSTR[1] <= INSTR_ASYNC;
                    RS1[1] <= rs1;
                    RS2[1] <= rs2;
                    RD[1] <= 'x;
                    DATA_MEM_ADDR[1] <= rs1 + imm_s;
                    DATA_MEM_IN[1] <= REG_FILE[1][rs2];
                    DATA_MEM_OUT[1] <= 'x;
                    DATA_MEM[1] <= DATA_MEM_ASYNC;

                end



            end else if (opcode == 7'b1100011) begin //------B-TYPE----------------------------
                {imm_b[12], imm_b[10:5], rs2, rs1, func3, imm_b[4:1], imm_b[11]} = INSTR_ASYNC[31:7];
                imm_b[0] = 1'b0; //LSB is always zero for B-type
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tB-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_b[12:1], rs2, rs1, func3, opcode); //instruction info

                if(func3 == 3'b000) begin //----BEQ------------------------------------------------
                    // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as BEQ.");
                    if(REG_FILE[1][rs1] == REG_FILE[1][rs2]) begin
                        PC_ASYNC <= PC_ASYNC + imm_b;

                        PC_TARGET[1] <= PC_ASYNC + imm_b;
                    end else begin
                        PC_ASYNC <= PC_ASYNC + 4;

                        PC_TARGET[1] <= PC_ASYNC + 4;
                    end

                    //first entry in the matrix
                    PC[1] <= PC_ASYNC;
                    INSTR[1] <= INSTR_ASYNC;
                    RS1[1] <= rs1;
                    RS2[1] <= rs2;
                    RD[1] <= 'x;
                    DATA_MEM_ADDR[1] <= 'x;
                    DATA_MEM_IN[1] <= 'x;
                    DATA_MEM_OUT[1] <= 'x;
                    DATA_MEM[1] <= DATA_MEM_ASYNC;
                    
                end 
            
            end else if (opcode == 7'b1101111) begin //---J-TYPE (JAL) ------------------------------------------
                {imm_j[20], imm_j[10:1], imm_j[11], imm_j[19:12], rd} = INSTR_ASYNC[31:7];
                imm_j[0] = 1'b0;
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tJ-Type: imm: 0b%b, rsd: 0b%b, opcode: 0b%b", imm_j[20:1], rd, opcode); //instruction info

                //----JAL------------
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as JAL.");
                write_reg(rd, PC_ASYNC + 4);
                PC_ASYNC <= PC_ASYNC + {{11{imm_j[20]}}, imm_j[20:0]};

                //first entry in the matrix
                PC[1] <= PC_ASYNC;
                PC_TARGET[1] <= PC_ASYNC + imm_j;
                INSTR[1] <= INSTR_ASYNC;
                RS1[1] <= 'x;
                RS2[1] <= 'x;
                RD[1] <= rd;
                DATA_MEM_ADDR[1] <= 'x;
                DATA_MEM_IN[1] <= 'x;
                DATA_MEM_OUT[1] <= 'x;
                DATA_MEM[1] <= DATA_MEM_ASYNC;

            end else if (opcode == 7'b0110111) begin  //------U-TYPE-(LUI)-------------------------------
                {imm_u, rd} = INSTR_ASYNC[31:7];
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tU-Type: imm: 0b%b, rsd: 0b%b, opcode: 0b%b", imm_u, rd, opcode); //instruction info

                //----LUI---------------
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\tIdentified as LUI.");
                write_reg(rd, {imm_u, REG_FILE[1][rd][11:0]});
                PC_ASYNC <= PC_ASYNC + 32'h4;

                //first entry in the matrix
                PC[1] <= PC_ASYNC;
                PC_TARGET[1] <= PC_ASYNC + 4;
                INSTR[1] <= INSTR_ASYNC;
                RS1[1] <= 'x;
                RS2[1] <= 'x;
                RD[1] <= rd;
                DATA_MEM_ADDR[1] <= 'x;
                DATA_MEM_IN[1] <= 'x;
                DATA_MEM_OUT[1] <= 'x;
                DATA_MEM[1] <= DATA_MEM_ASYNC;

            end else begin
                //UNKNOWN ------------------------------
                // /* DO NOT REMOVE : DEBUG GOLD */ $display("\t<### WARNING: Instruction type not currently recognized by TB ###>");

            end

            for (int ii = 5; ii > 1; ii--) begin
                PC[ii]            <= PC[ii-1];
                PC_TARGET[ii]     <= PC_TARGET[ii-1];
                INSTR[ii]         <= INSTR[ii-1];
                RS1[ii]           <= RS1[ii-1];
                RS2[ii]           <= RS2[ii-1];
                RD[ii]            <= RD[ii-1];
                REG_FILE[ii]      <= REG_FILE[ii-1];
                DATA_MEM_ADDR[ii] <= DATA_MEM_ADDR[ii-1];
                DATA_MEM_IN[ii]   <= DATA_MEM_IN[ii-1];
                DATA_MEM_OUT[ii]  <= DATA_MEM_OUT[ii-1];
                DATA_MEM[ii]      <= DATA_MEM[ii-1];
            end
        end
    end





    always @(negedge clk) begin //read on negative edge to give everything time to settle

        $write("\n\n\n");
        $display("Negedge block output");
        $display("========================================================================================");
        $display("\tPC_ASYNC: %h", PC_ASYNC);
        $display("\tINSTR_ASYNC: %h", INSTR_ASYNC);
        $display("\topcode: %h", opcode);

        dut_dump();
        reg_dut_dump();
        //reg_gold_postwb_dump();
        //data_mem_async_dump();
        display_golden_singals_history();

        //def# is a werid way to get an output of a task, at this point its not even used
        verify_row(1, def1);
        verify_row(2, def2);
        verify_row(3, def3);
        verify_row(4, def4);
        verify_row(5, def5);


        if (ohalt == 1'b1) begin //HALT SIGNAL --------------------------------------------------------------
            $display("\nWARNING: Recieved halt signal. Pausing verification.");
            $display("Program counter: %d", cpu_dut.PC);
            reg_gold_postwb_dump();
            $stop(); //pauses verification if CPU outputs halt signal

        end else if(instruction_failure == 1) begin //INSTRUCTION FAILURE----------------------------------
            $display("\nWARNING: Mismatch between model and CPU. Pausing verification.");
            $display("\tPlease check for data hazards and issues in this instruction's datapath/control.");
            reg_gold_postwb_dump();
            $stop(); //pauses verification if an instruction has failed OR a data hazard has occured.

        end

    end

    //VERIFICATION -----------------------------------------------------------------------------------------------------------------

    task dut_dump;
        begin
            $display("================================================================================================");
            $display("Cycle @ time %0t", $time);

            // --------------------------------
            // IF stage
            // --------------------------------
            $display("[IF ] PC              = 0x%08h", cpu_dut.PC);
            $display("[IF ] INSTR_F         = 0x%08h", cpu_dut.INSTR_F);
            $display("[IF ] INSTR_F_FLUSH   = 0x%08h", cpu_dut.INSTR_F_FLUSH);

            // --------------------------------
            // ID stage
            // --------------------------------
            $display("[ID ] PC_D            = 0x%08h", cpu_dut.PC_D);
            $display("[ID ] INSTR_D         = 0x%08h", cpu_dut.INSTR_D);
            $display("[ID ] INSTR_D_FLUSH   = 0x%08h", cpu_dut.INSTR_D_FLUSH);
            $display("[ID ] RS1=%0d RS2=%0d RD=%0d", cpu_dut.RS1, cpu_dut.RS2, cpu_dut.RD);
            $display("[ID ] RS1_DATA    = 0x%08h", cpu_dut.RS1_DATA_FWD);
            $display("[ID ] RS2_DATA    = 0x%08h", cpu_dut.RS2_DATA_FWD);
            $display("[ID ] IM          = 0x%08h", cpu_dut.IM);

            // --------------------------------
            // EX stage
            // --------------------------------
            $display("[EX ] PC_E        = 0x%08h", cpu_dut.PC_E);
            $display("[EX ] RS1_E_DATA  = 0x%08h", cpu_dut.RS1_DATA_E_FWD);
            $display("[EX ] RS2_E_DATA  = 0x%08h", cpu_dut.RS2_DATA_E_FWD);
            $display("[EX ] ALU_OUT     = 0x%08h", cpu_dut.ALU);
            $display("[EX ] ZERO_FLAG   = %0b",    cpu_dut.zero_flag);
            $display("[EX ] BR_TAKEN    = %0b",    cpu_dut.branch_taken);
            $display("[EX ] JMP_TAKEN   = %0b",    cpu_dut.jump_taken);
            $display("[EX ] PC_TARGET   = 0x%08h", cpu_dut.PC_target);

            // --------------------------------
            // MEM stage
            // --------------------------------
            $display("[MEM] ALU_M       = 0x%08h", cpu_dut.ALU_M);
            $display("[MEM] RS2_M_DATA  = 0x%08h", cpu_dut.RS2_DATA_M);
            $display("[MEM] DMEM_OUT   = 0x%08h", cpu_dut.DATA_MEM_OUT);
            $display("[MEM] MEM_WR_EN  = %0b",    cpu_dut.data_mem_wr_en_M);

            // --------------------------------
            // WB stage
            // --------------------------------
            $display("[WB ] ALU_W       = 0x%08h", cpu_dut.ALU_W);
            $display("[WB ] DMEM_W     = 0x%08h", cpu_dut.DATA_MEM_OUT_W);
            $display("[WB ] RD_W=%0d   DATA=0x%08h  WR_EN=%0b",
                    cpu_dut.RD_W,
                    cpu_dut.RD_DATA,
                    cpu_dut.reg_file_wr_en_W);

            // --------------------------------
            // Halt / pipeline status
            // --------------------------------
            $display("[CTL] halt_D=%0b halt_E=%0b halt_M=%0b halt_W=%0b ohalt=%0b",
                    cpu_dut.halt_D,
                    cpu_dut.halt_E,
                    cpu_dut.halt_M,
                    cpu_dut.halt_W,
                    cpu_dut.ohalt);

            $display("================================================================================================");
        end
    endtask

    task reg_dut_dump();
        begin
            $write("\nREG_FILE_DUT Dump");
            for (int ii = 0; ii < 32; ii++) begin
                if(ii % 8 == 0) begin //i know i should just use 2nd for loop shut up
                    $write("\n\t");
                end
                $write("%08h ", cpu_dut.my_reg_file.regs_out[ii]);
            end
        end
    endtask

    task reg_gold_postwb_dump();
        begin
            $write("\nREG_FILE[1] Dump");
            for(int ii = 0; ii < 32; ii++) begin
                if(ii % 8 == 0) begin //i know i should just use 2nd for loop shut up
                    $write("\n\t");
                end
                $write("%08h ", REG_FILE[1][ii]);
            end
        end
    endtask

    task data_mem_async_dump();
        begin
            $display("DATA_MEM_ASYNC Dump");
            for(int ii = 0; ii < 32; ii++) begin
                $display("\tx%d: 0x%h", ii, DATA_MEM_ASYNC[ii]);
            end
        end
    endtask

    task display_golden_singals_history();
        // loop variables
        integer c;  // column / cycle
        integer r;  // register index for REG_FILE

        begin
            $write("\n\n----- Golden Signals History -----");

            for (c = 1; c < 6; c = c + 1) begin
                $display("\ngolden_history[%0d]:", c);
                $display("\tPC        = 0x%08h", PC[c]);
                $display("\tPC_TARGET = 0x%08h", PC_TARGET[c]);
                $display("\tINSTR     = 0x%08h", INSTR[c]);
                $display("\tRS1       = %0d", RS1[c]);
                $display("\tRS2       = %0d", RS2[c]);
                $display("\tRD        = %0d", RD[c]);

                $write("\tREG_FILE");
                for (r = 0; r < 32; r = r + 1) begin
                    if(r % 8 == 0) begin //i know i should just use 2nd for loop shut up
                        $write("\n\t");
                    end

                    $write("%08h ", REG_FILE[c][r]);
                end
                $display("");
            end

            $display("========================================================================================");

        end
    endtask


    task automatic verify_row(
        input int row,
        output int local_instruction_failure
    );
        begin

            logic [6:0] func7_v;
            logic [4:0] rs2_v;
            logic [4:0] rs1_v;
            logic [4:0] rd_v;
            logic [2:0] func3_v;
            logic [6:0] opcode_v;
            logic [11:0] imm_i_v, imm_s_v;
            logic [12:0] imm_b_v;
            logic [19:0] imm_u_v;
            logic [20:0] imm_j_v;

            opcode_v = INSTR[row][6:0];

            /* DO NOT REMOVE : DEBUG VERIFY */ $write("\n\n");
            /* DO NOT REMOVE : DEBUG VERIFY */ $display("verify_row(%0d) output", row);
            /* DO NOT REMOVE : DEBUG VERIFY */ $display("========================================================================================");
            if (opcode_v == 7'b0110011) begin //--------R-TYPE/M-TYPE----------------------------------------------
                {func7_v, rs2_v, rs1_v, func3_v, rd_v} = INSTR[row][31:7];
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tR/M-Type: func7_v: 0b%b, rs2_v: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, rd_v: 0b%b, opcode_v: 0b%b", func7_v, rs2_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

                //-R-TYPE---------------
                if (func7_v == 7'b0000000) begin
                    if (func3_v == 3'b000) begin //----ADD------------------------------
                        /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as ADD:");
                        if(row == 5) begin

                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); local_instruction_failure = 1; end

                        end
                    end

                end else if (func7_v == 7'b0100000) begin     
                    if (func3_v == 3'b000) begin //----SUB---------------------------
                        /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as SUB:");
                        if(row == 5) begin

                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); local_instruction_failure = 1; end

                        end
                    end

                //-M-TYPE---------------
                end else if (func7_v == 7'b0000001) begin
                    if (func3_v == 3'b000) begin //----MUL------------------------------
                        /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as MUL:");
                        if(row == 5) begin

                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); local_instruction_failure = 1; end

                        end

                    end else if (func3_v == 3'b001) begin //----MULH------------------------------
                        /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as MULH:");
                        if(row == 5) begin

                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); local_instruction_failure = 1; end

                        end

                    end else if (func3_v == 3'b010) begin //----MULHSU------------------------------
                        /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as MULHSU:");
                        if(row == 5) begin

                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); local_instruction_failure = 1; end

                        end

                    end else if (func3_v == 3'b011) begin //----MULHU------------------------------
                        /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as MULHU:");
                        if(row == 5) begin

                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); local_instruction_failure = 1; end

                        end

                    end

                end

            end else if (opcode_v == 7'b0010011) begin //-----I-TYPE (ARITHMETIC) ---------------------------------
                {imm_i_v, rs1_v, func3_v, rd_v} = INSTR[row][31:7];
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tI-Type: imm: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, rd_v: 0b%b, opcode_v: 0b%b", imm_i_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

                if(func3_v == 3'b000) begin //-------ADDI-------------------------------
                    if(imm_i_v == 20'd0 & rs1_v == 5'd0 & rd_v == 5'd0) begin
                        /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tIdentified as NOP.");
                        //TODO, do a reg by reg and data by data comparasion for validation, 
                        //assert() $display(" Success");
                        //else begin $display(" FAILURE"); local_instruction_failure = 1; end



                    end else begin
                        
                        //$display("rd_v: ", rd_v);
                        //$display("dut:%d gold:%d", cpu_dut.my_reg_file.regs_out[rd_v], REG_FILE[5][rd_v]);
                        /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as ADDI:");
                        if(row == 5) begin

                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); local_instruction_failure = 1; end

                        end
                    end

                    
                end

            end else if (opcode_v == 7'b0000011) begin //----I-TYPE (LOADS) ----------------------------------
                {imm_i_v, rs1_v, func3_v, rd_v} = INSTR[row][31:7];
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tI-Type: imm: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, rd_v: 0b%b, opcode_v: 0b%b", imm_i_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

                if(func3_v == 3'b010) begin //----LW------------------------------------
                    /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as LW:");
                    if(row == 5) begin

                        assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                        else begin $display(" FAILURE"); local_instruction_failure = 1; end

                    end
                end

            end else if (opcode_v == 7'b1100111) begin //---I-TYPE (JALR) ------------------------------------------
                {imm_i_v, rs1_v, func3_v, rd_v} = INSTR[row][31:7];
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tI-Type: imm: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, rd_v: 0b%b, opcode_v: 0b%b", imm_i_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

                if(func3_v == 3'b000) begin //-------JALR-------------------------------
                    /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as JALR:");
                    if(row == 3) begin

                        assert(cpu_dut.pc_reg.q == PC[3]) $display(" Success");
                        else begin $display(" FAILURE"); local_instruction_failure = 1; end

                    end
                    // else local_instruction_failure = 1; //ensure the PC and rd_v have changed to appropiate values

                end

            end else if (opcode_v == 7'b0100011) begin //------S-TYPE----------------------------------
                {imm_s_v[11:5], rs2_v, rs1_v, func3_v, imm_s_v[4:0]} = INSTR[row][31:7];
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tS-Type: imm: 0b%b, rs2_v: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, opcode_v: 0b%b", imm_s_v, rs2_v, rs1_v, func3_v, opcode_v); //instruction info

                if(func3_v == 3'b010) begin //----SW-------------------------------------
                    /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tIdentified as SW.");

                    // else local_instruction_failure = 1;//ensure source register was written to CPU memory

                end

            end else if (opcode_v == 7'b1100011) begin //------B-TYPE----------------------------
                {imm_b_v[12], imm_b_v[10:5], rs2_v, rs1_v, func3_v, imm_b_v[4:1], imm_b_v[11]} = INSTR[row][31:7];
                imm_b_v[0] = 1'b0; //LSB is always zero for B-type
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tB-Type: imm: 0b%b, rs2_v: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, opcode_v: 0b%b", imm_b_v[12:1], rs2_v, rs1_v, func3_v, opcode_v); //instruction info

                if(func3_v == 3'b000) begin //----BEQ------------------------------------------------
                    /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tIdentified as BEQ.");

                    // else local_instruction_failure = 1; //ensure the PC has changed to the correct address

                end
            
            end else if (opcode_v == 7'b1101111) begin //---J-TYPE (JAL) ------------------------------------------
                {imm_j_v[20], imm_j_v[10:1], imm_j_v[11], imm_j_v[19:12], rd_v} = INSTR[row][31:7];
                imm_j_v[0] = 1'b0;
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tJ-Type: imm: 0b%b, rsd: 0b%b, opcode_v: 0b%b", imm_j_v[20:1], rd_v, opcode_v); //instruction info
$display("cpu_dut.pc_reg.q: %h PC[%0d]: %h", cpu_dut.pc_reg.q, row, PC[row-1]);
                //----JAL------------
                /* DO NOT REMOVE : DEBUG VERIFY */ $write("\tIdentified as JAL:");
                if(row == 3) begin
                    
                    assert(cpu_dut.pc_reg.q == PC[3]) $display(" Success");
                    else begin $display(" FAILURE"); local_instruction_failure = 1; end

                end

            end else if (opcode_v == 7'b0110111) begin  //------U-TYPE-(LUI)-------------------------------
                {imm_u_v, rd_v} = INSTR[row][31:7];
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tU-Type: imm: 0b%b, rsd: 0b%b, opcode_v: 0b%b", imm_u_v, rd_v, opcode_v); //instruction info

                //----LUI---------------
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("\tIdentified as LUI.");

                // else local_instruction_failure = 1;

            end else begin
                //UNKNOWN ------------------------------
                /* DO NOT REMOVE : DEBUG VERIFY */ $display("WARNING: Instruction type not currently recognized by TB.");

            end

            if(local_instruction_failure == 1) begin 

                $display("\nError: Mismatch between model and CPU.");
                //reg_dut_dump();
                //display_golden_singals_history();
                //$stop();

            end
        end
    endtask
endmodule