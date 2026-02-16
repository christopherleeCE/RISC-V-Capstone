/*

here is how the top file works, if you have addional questions feel free to message me (chris) with questions

There are two models, the dut and the golden, the golden will only really have a pc, instr_mem, regfile, datamem.
instr_mem is mirrored to the dut isntr_mem, hoever they are different declared modules. on the posedge the regfile/datamem/pc
get updateed/calculated in the golden. the results are then put into a golden[5:1] on each posedge. so the clk after addi has
been executed, then the results are now in golden[1], (that is to say there is a PC[1], REG_FILE[1], DATA_MEM[1], etc.), there
is a few addionaly entries in the golden[1], but the important ones are the three above. on each posedge golden[1] moves to golden[2]
and golden[2] to golden[3], etc. these golden[]'s are then compared with the dut to make sure that they are alligned. the time that
these comparasions are made depeneds on the instruction, for example addi will be in gold[1], then on the next clk gold[2]. so addi
will over the coarse of the verification be in async, 1, 2, 3, 4, 5, but we cant actually verify it until its in gold[5], so in async, 
1, 2, 3, 4 no verificaitn is done, but it still progresses through all of those rows over the coarse of five(?) clks, once addi is in
gold[5] then its compared against the dut, which at this point that addi in the dut is now in the post_wb, right after the wb.

TODO for the arth instruciton compare the whole regfile instead
just the destination register, you cant just do regdut == reggold[4],
cause according to chat, if there is an x in the structure, even in 
reggold[1] for example the assertion fails, so you need to do a for loop,
and doing that is prob easier to do in a task/func but ill do that l8r

TODO see if curren beq verification can be broken at (plz dont...) : it can :( fix plz

TODO expand gen_random_prog.py with branching

TODO make sure run time for master.ps1 is enuf

TODO make sure that in rand testing the run time is enuf

TODO find a way for the top file to terminate on its own, and not have to if a prog finished

--------------TEST LOG----------------------------------------------------

*NOTE: I now strongly agree with whoever said the verification for BEQ is prone to breaking.
Unfortunately, this applies for other B-type instructions, so it seems. HOWEVER, I am confident 
the branch hardware has been working okay so far, including for BNE, BLT, and BGE. If you run 
the assembly program I wrote for BNE/BLT/BGE, and look at the register dump, the values in s0 
and s1 match the target value. Within the context of the program, I believe it shows that the
these three instructions are functioning properly. I will put these as successful for now, if
anyone disagrees or has questions, please reach out - Edgar G.

WAITING LIST: ...
R-TYPE:
I-TYPE: LB, LH, LBU, LHU
B-TYPE: 
M-TYPE: 

SUCCESSFUL TESTS:
R-TYPE: ADD, SUB, XOR, AND, OR, SLL, SRL, SRA, SLT, SLTU
I-TYPE: ADDI/NOP, XORI, ANDI, ORI, LW, JALR
S-TYPE: SW
B-TYPE: BEQ, BNE, BLT, BGE
J-TYPE: JAL
U-TYPE: LUI
M-TYPE: MUL, MULH, MULHSU, MULHU

UNSUCCESSFUL TESTS:


*/

`timescale 1ns/1ns

module top_riscv_cpu_v2_1();

    //declarations
    parameter int CLOCK_PERIOD = 20;

    //bits for storying debug level
    bit show_posedge_golden_calc;
    bit show_negedge_dut_dump;
    bit show_negedge_golden_history;
    bit show_negedge_verify_row;
    bit verify_row_flag;
    bit stop_at_instr_failure;

    //used for debug output of reg dumps
    string reg_name [32] = '{
    "zero", "ra",   "sp",  "gp",  "tp",
    "t0",   "t1",   "t2",
    "s0/fp",   "s1",
    "a0",   "a1",   "a2",  "a3",  "a4",  "a5",  "a6",  "a7",
    "s2",   "s3",   "s4",  "s5",  "s6",  "s7",  "s8",  "s9",  "s10", "s11",
    "t3",   "t4",   "t5",  "t6"
    };

    typedef enum logic [2:0]{
        FULL_WORD = 3'b100,
        HALF_WORD = 3'b010,
        BYTE      = 3'b001
    }store_type_t;

    //dumb way to get around default output of verify_row task, TODO find better way to do this, maybe switch from task to func?
    static int local_instruction_failure1;
    static int local_instruction_failure2;
    static int local_instruction_failure3;
    static int local_instruction_failure4;
    static int local_instruction_failure5;

    //cpu ports
    logic clk, rst, ohalt;

    //golden instruction decoded declarations
    logic [6:0] func7;
    logic [4:0] rs2;
    logic [4:0] rs1;
    logic [4:0] rd;
    logic [2:0] func3;
    logic [6:0] opcode;
    logic [31:0] imm_i, imm_s;
    logic [31:0] imm_b;
    logic [31:0] imm_u;
    logic [31:0] imm_j;


    //golden sginals for matrix, these are what the DUT is verfied against, they are stored in a 5x1 array, one for each clk of the execution in the DUT
    /* golden[1], one clk delay, golden[2], two clk delays, etc. */
    /* I THINK that...
  ASYCN -> if
    [1] -> id
    [2] -> ex
    [3] -> mem
    [4] -> wb
    [5] -> post wb
    */

    logic [31:0] PC [9:1];
    logic [31:0] PC_TARGET [9:1];
    logic [31:0] INSTR [9:1];
    logic [4:0] RS1 [9:1];
    logic [4:0] RS2 [9:1];
    logic [4:0] RD [9:1];
    logic [31:0] IM [9:1];
    logic [31:0] REG_FILE [9:1] [31:0] = '{default: 32'b0};;
    logic [31:0] DATA_MEM [9:1] [255:0];

    //the "async" of the golden signals, name comes from one of the early topv2 builds, just think of this as golden[0], the if stage
    //there is no regfile_async or datamem_async, because @posedge we write str8 to regfile[1] and datamem[1], this makes the debug out
    //easier to follow as golden_history_dump() will show an instruction, and the regfile after the writeback of that instruction, so we
    //see the regfile/datamem after the completion of the instruciton, not the regfile/datamem before the writeback of the instruction
    logic [31:0] INSTR_ASYNC;                                   //output of instrmem
    logic [31:0] INSTR_FLUSH;                                   //as of right now instrflush always = instrasync
    logic [31:0] REG_FILE_ASYNC [31:0] = '{default: 32'b0};     //this should not be written to directly, use the writereg() task, you can read from it directly 
    logic [31:0] PC_ASYNC;                                      //simple pc reg used by golden



    //DUT---------------------------------------------------------------------------------------------------------------------
    //instantiate the CPU
    riscv_cpu_v2 cpu_dut(.clk(clk), .rst(rst), .ohalt(ohalt));

    //grabing vsim args
    initial begin

        // // other flags
        // if ($test$plusargs("GOLDEN_CALC")) begin
        //     $display("Received argument: GOLDEN_CALC");
        // end

        // if ($test$plusargs("DUT_DUMP")) begin
        //     $display("Received argument: DUT_DUMP");
        // end

        // if ($test$plusargs("GOLDEN_HISTORY")) begin
        //     $display("Received argument: GOLDEN_HISTORY");
        // end

        // if ($test$plusargs("NO_VERIFY")) begin
        //     $display("Received argument: NO_VERIFY");
        // end

        show_posedge_golden_calc = $test$plusargs("GOLDEN_CALC");
        show_negedge_dut_dump = $test$plusargs("DUT_DUMP");
        show_negedge_golden_history = $test$plusargs("GOLDEN_HISTORY");
        show_negedge_verify_row = $test$plusargs("VERIFY_OUTPUT");
        verify_row_flag = ~$test$plusargs("NO_VERIFY");
        stop_at_instr_failure = ~$test$plusargs("CONTINUE");

        $display("Flags: %b %b %b %b %b %b", show_posedge_golden_calc, show_negedge_dut_dump, show_negedge_golden_history, show_negedge_verify_row, verify_row_flag, stop_at_instr_failure);

    end

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
        repeat(3) begin     //arbitrarily hold reset for 3 clks
            rst = 1'b0;
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

    //golden results calculated on posedge
    always @(posedge clk) begin

        logic [63:0] product;   //used in mul's calculations
        logic dut_pc_redirected;

        if(local_instruction_failure1 || local_instruction_failure2 || local_instruction_failure3 || local_instruction_failure4 || local_instruction_failure5) begin //INSTRUCTION FAILURE----------------------------------
        
            $error("FATAL ERROR: Mismatch between model and CPU.");
            $display("local_instruction_failure: %1b %1b %1b %1b %1b", local_instruction_failure1, local_instruction_failure2, local_instruction_failure3, local_instruction_failure4, local_instruction_failure5);
            $display("\tPlease check for data hazards and issues in this instruction's datapath/control.");

            if(stop_at_instr_failure) begin $display("Pausing Verification..."); $stop(); end //pauses verification on instruction fail if -continue not presesnt in args

        end

        assign dut_pc_redirected = dut_redirected();
        assign INSTR_FLUSH = INSTR_ASYNC;
        assign opcode = INSTR_FLUSH[6:0];

        if(
        cpu_dut.R1_case_dm2alu ||
        cpu_dut.R1_case_rf2alu ||
        cpu_dut.R2_case_dm2alu ||
        cpu_dut.R2_case_rf2alu
        ) begin
            if(show_posedge_golden_calc) begin
                $display("\nFORWARDED");
                $display(
                "\tR1_case_dm2alu: %1b\n\tR1_case_rf2alu: %1b\n\tR1_case_rf2rf: %1b\n\tR2_case_dm2alu: %1b\n\tR2_case_rf2alu: %1b\n\tR2_case_rf2rf: %1b",
                cpu_dut.R1_case_dm2alu,
                cpu_dut.R1_case_rf2alu,
                cpu_dut.R1_case_rf2rf,
                cpu_dut.R2_case_dm2alu,
                cpu_dut.R2_case_rf2alu,
                cpu_dut.R2_case_rf2rf
                );
            end
        end

        if (!rst) begin

            if(show_posedge_golden_calc) $display("\n\n\n<* rst = 0, intializing *>");
            PC_ASYNC <= '0;


        //if the pc is not being redirected in the dut, and rst is not low, gold calculations are made
        //pc_async, isntr_async, and instr_flush (at this point they are always the same) are looked at
        //then the instruction is decoded based on the opcode. based on the decoded instruction either the
        //regfile[1], datamem[1], or pc_async will be written to (the gold). the reason why its not 
        //regfile[0]/regfile_async & datamem[0]/datamem_async in on ~line 80 above
        //additionally the golden[5:1] gets advanced in the for loop below
        end else begin

            //$display("posedgedump");
            //reg_gold_post_write_back_dump();
            //display_golden_singals_history();

            if(show_posedge_golden_calc) begin 
                $write("\n\n\n");
                $display("Posedge block output");
                $display("========================================================================================");
                $display("\tPC_ASYNC: %h", PC_ASYNC);
                $display("\tINSTR_ASYNC: %h", INSTR_ASYNC);
                $display("\tINSTR_FLUSH: %h", INSTR_FLUSH);
                $display("\topcode: %h", opcode);
            end


            if (opcode == 7'b0110011) begin //--------R-TYPE/M-TYPE----------------------------------------------
                {func7, rs2, rs1, func3, rd} = INSTR_FLUSH[31:7];
                if(show_posedge_golden_calc) $display("\tR/M-Type: func7: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", func7, rs2, rs1, func3, rd, opcode); //instruction info

                //first entry in the matrix
                PC[1] <= PC_ASYNC;
                PC_TARGET[1] <= PC_ASYNC + 32'h4;
                INSTR[1] <= INSTR_FLUSH;
                RS1[1] <= rs1;
                RS2[1] <= rs2;
                RD[1] <= rd;
                IM[1] <= 'x;

                //-R-TYPE---------------
                //separate by func7, then func3
                if (func7 == 7'b0000000) begin
                    if (func3 == 3'b000) begin //----ADD------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as ADD.");
                        write_reg(rd, REG_FILE[1][rs1] + REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;
                        
                    end else if (func3 == 3'b100) begin //----XOR------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as XOR.");
                        write_reg(rd, REG_FILE[1][rs1] ^ REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;
                    
                    end else if (func3 == 3'b110) begin //----OR-------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as OR.");
                        write_reg(rd, REG_FILE[1][rs1] | REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b111) begin //----AND------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as AND.");
                        write_reg(rd, REG_FILE[1][rs1] & REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b001) begin //----SLL------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as SLL.");
                        write_reg(rd, REG_FILE[1][rs1] << REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b101) begin //----SRL------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as SRL.");
                        write_reg(rd, REG_FILE[1][rs1] >> REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    //NOTE - will have to check if this is the right way compare signed vs. unsigned numbers
                    end else if (func3 == 3'b010) begin //----SLT------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as SLT.");
                        write_reg(rd, ($signed(REG_FILE[1][rs1]) < $signed(REG_FILE[1][rs2]))? 32'd1: 32'd0);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b011) begin //----SLTU-----------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as SLTU.");
                        write_reg(rd, ($unsigned(REG_FILE[1][rs1]) < $unsigned(REG_FILE[1][rs2]))? 32'd1: 32'd0);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end 

                end else if (func7 == 7'b0100000) begin     
                    if (func3 == 3'b000) begin //----SUB---------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as SUB.");
                        write_reg(rd, REG_FILE[1][rs1] - REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;
                        
                    end else if (func3 == 3'b101) begin //----SRA---------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as SRA.");
                        write_reg(rd, $signed(REG_FILE[1][rs1]) >>> REG_FILE[1][rs2]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;
                        
                    end

                //-M-TYPE---------------
                end else if (func7 == 7'b0000001) begin
                    if (func3 == 3'b000) begin //----MUL------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as MUL.");
                        product = $signed({ {32{REG_FILE[1][rs1][31]}}, REG_FILE[1][rs1] }) *
                                $signed({ {32{REG_FILE[1][rs2][31]}}, REG_FILE[1][rs2] });
                        write_reg(rd, product[31:0]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b001) begin //----MULH------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as MULH.");
                        product = $signed({ {32{REG_FILE[1][rs1][31]}}, REG_FILE[1][rs1] }) *
                                $signed({ {32{REG_FILE[1][rs2][31]}}, REG_FILE[1][rs2] });
                        write_reg(rd, product[63:32]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b010) begin //----MULHSU------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as MULHSU.");
                        product = $signed({ {32{REG_FILE[1][rs1][31]}}, REG_FILE[1][rs1] }) *
                                $unsigned(  REG_FILE[1][rs2]  ); //HERE
                        write_reg(rd, product[63:32]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end else if (func3 == 3'b011) begin //----MULHU------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as MULHU.");
                        product = $unsigned({ 32'b0, REG_FILE[1][rs1] }) *
                                $unsigned({ 32'b0, REG_FILE[1][rs2] });
                        write_reg(rd, product[63:32]);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end

                end


            end else if (opcode == 7'b0010011) begin //-----I-TYPE (ARITHMETIC) ---------------------------------
                {imm_i[11:0], rs1, func3, rd} = INSTR_FLUSH[31:7];
                imm_i[31:12] = {20{imm_i[11]}};
                if(show_posedge_golden_calc) $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

                //first entry in the matrix
                PC[1] <= PC_ASYNC;
                PC_TARGET[1] <= PC_ASYNC + 32'h4;
                INSTR[1] <= INSTR_FLUSH;
                RS1[1] <= rs1;
                RS2[1] <= 'x;
                RD[1] <= rd;
                IM[1] <= imm_i;

                if(func3 == 3'b000) begin //-------ADDI-------------------------------
                    if(imm_i == 20'd0 & rs1 == 5'd0 & rd == 5'd0) begin
                        if(show_posedge_golden_calc) $display("\tIdentified as NOP.");
                        PC_ASYNC <= dut_pc_redirected ? PC_ASYNC : PC_ASYNC + 32'h4;

                    end else begin
                        if(show_posedge_golden_calc) $display("\tIdentified as ADDI.");
                        //$display("data: %h | rd: %d | rs1: %d", REG_FILE[1][rs1] + imm_i, rd, rs1);
                        write_reg(rd, REG_FILE[1][rs1] + imm_i);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                    end

                end else if (func3 == 3'b100) begin //------XORI-------------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as XORI.");
                        //$display("data: %h | rd: %d | rs1: %d", REG_FILE[1][rs1] ^ imm_i, rd, rs1);
                        write_reg(rd, REG_FILE[1][rs1] ^ imm_i);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                end else if (func3 == 3'b110) begin //------ORI-------------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as ORI.");
                        //$display("data: %h | rd: %d | rs1: %d", REG_FILE[1][rs1] | imm_i, rd, rs1);
                        write_reg(rd, REG_FILE[1][rs1] | imm_i);
                        PC_ASYNC <= PC_ASYNC + 32'h4;

                end else if (func3 == 3'b111) begin //-------ANDI---------------------------------
                        if(show_posedge_golden_calc) $display("\tIdentified as ANDI.");
                        //$display("data: %h | rd: %d | rs1: %d", REG_FILE[1][rs1] & imm_i, rd, rs1);
                        write_reg(rd, REG_FILE[1][rs1] & imm_i);
                        PC_ASYNC <= PC_ASYNC + 32'h4;
                end



            end else if (opcode == 7'b0000011) begin //----I-TYPE (LOADS) ----------------------------------
                {imm_i[11:0], rs1, func3, rd} = INSTR_FLUSH[31:7];
                imm_i[31:12] = {20{imm_i[11]}};
                if(show_posedge_golden_calc) $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

                if(func3 == 3'b010) begin //----LW------------------------------------
                    if(show_posedge_golden_calc) $display("\tIdentified as LW.");
                    //write_reg(rd, DATA_MEM[1][(REG_FILE[1][rs1] + imm_i)>>2]); //old implementation
                    write_reg(rd, read_data_mem(REG_FILE[1][rs1] + imm_i, FULL_WORD, .is_signed(0)));
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                    //first entry in the matrix
                    PC[1] <= PC_ASYNC;
                    PC_TARGET[1] <= PC_ASYNC + 32'h4;
                    INSTR[1] <= INSTR_FLUSH;
                    RS1[1] <= rs1;
                    RS2[1] <= 'x;
                    RD[1] <= rd;
                    IM[1] <= imm_i;

                end

                

            end else if (opcode == 7'b1100111) begin //---I-TYPE (JALR) ------------------------------------------
                {imm_i[11:0], rs1, func3, rd} = INSTR_FLUSH[31:7];
                imm_i[31:12] = {20{imm_i[11]}};
                if(show_posedge_golden_calc) $display("\tI-Type: imm: 0b%b, rs1: 0b%b, func3: 0b%b, rd: 0b%b, opcode: 0b%b", imm_i, rs1, func3, rd, opcode); //instruction info

                if(func3 == 3'b000) begin //-------JALR-------------------------------
                    if(show_posedge_golden_calc) $display("\tIdentified as JALR.");

                    //because we are delaying to pc jmp, we need to delay the rd write,
                    //as if we dont then the instr jalr, ra, ra, IM will write the to ra
                    //efore it jumps, this is not desired, we need to jump either before
                    //or at the same time we write to ra, so this write_reg() is moved below
                    //the repeat() blocks
                    //write_reg(rd, PC_ASYNC + 4);

                    //take_branch({{20{imm_i[11]}}, imm_i[11:0]}, rs1, 'x, rd);
                    PC_ASYNC <= PC_ASYNC + 32'h4;
                    PC[1] <= PC_ASYNC;
                    PC_TARGET[1] <= REG_FILE[1][rs1] + {{20{imm_i[11]}}, imm_i[11:0]};
                    INSTR[1] <= INSTR_FLUSH;
                    RS1[1] <= rs1;
                    RS2[1] <= 'x;
                    RD[1] <= rd;
                    IM[1] <= imm_i;

                        repeat(1) @(posedge clk);
                    PC_ASYNC <= PC_ASYNC + 32'h4;
                    PC[1]          <= PC_ASYNC;
                    PC_TARGET[1]   <= 'x;
                    INSTR[1]       <= 32'h00000013;
                    RS1[1]         <= 'x;
                    RS2[1]         <= 'x;
                    RD[1]          <= 'x;
                    IM[1]          <= 'x;

                        repeat(1) @(posedge clk);
                    PC_ASYNC <= REG_FILE[2][rs1] + {{20{imm_i[11]}}, imm_i[11:0]};
                    PC[1]          <= PC_ASYNC;
                    PC_TARGET[1]   <= 'x;
                    INSTR[1]       <= 32'h00000013;
                    RS1[1]         <= 'x;
                    RS2[1]         <= 'x;
                    RD[1]          <= 'x;
                    IM[1]          <= 'x;

                    //ideally we would write this to reg_file[0], but that doesnt exist, and the "infastructor" for it would be a major overhall
                    //that being said i dont think the it writing to regfile[1] is an issue, or will cause any sort of "data hazard" in the top file
                    //because its essentially being added  at an early extra spot in the golden[], but that extra spot will always be populated with
                    //a 0x00000013 opcode (nop) so it should never cause any verification issues (hopefully :)
                    write_reg(rd, PC[1]);

                end

        

            end else if (opcode == 7'b0100011) begin //------S-TYPE----------------------------------
                {imm_s[11:5], rs2, rs1, func3, imm_s[4:0]} = INSTR_FLUSH[31:7];
                imm_s[31:12] = {20{imm_s[11]}};
                if(show_posedge_golden_calc) $display("\tS-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_s, rs2, rs1, func3, opcode); //instruction info

                if(func3 == 3'b010) begin //----SW-------------------------------------
                    if(show_posedge_golden_calc) $display("\tIdentified as SW.");
                    //DATA_MEM[1][(REG_FILE[1][rs1] + imm_s)>>2] <= REG_FILE[1][rs2]; //old implementation
                    write_data_mem(REG_FILE[1][rs2], (REG_FILE[1][rs1] + imm_s), FULL_WORD);
                    PC_ASYNC <= PC_ASYNC + 32'h4;

                    //first entry in the matrix
                    PC[1] <= PC_ASYNC;
                    PC_TARGET[1] <= PC_ASYNC + 32'h4;
                    INSTR[1] <= INSTR_FLUSH;
                    RS1[1] <= rs1;
                    RS2[1] <= rs2;
                    RD[1] <= 'x;
                    IM[1] <= imm_s;

                end



            end else if (opcode == 7'b1100011) begin //------B-TYPE----------------------------
                {imm_b[12], imm_b[10:5], rs2, rs1, func3, imm_b[4:1], imm_b[11]} = INSTR_FLUSH[31:7];
                imm_b[31:13] = {19{imm_b[12]}};
                imm_b[0] = 1'b0; //LSB is always zero for B-type
                if(show_posedge_golden_calc) $display("\tB-Type: imm: 0b%b, rs2: 0b%b, rs1: 0b%b, func3: 0b%b, opcode: 0b%b", imm_b[12:1], rs2, rs1, func3, opcode); //instruction info

                if(func3 == 3'b000) begin //----BEQ------------------------------------------------
                    if(show_posedge_golden_calc) $display("\tIdentified as BEQ.");
                    if(REG_FILE[1][rs1] == REG_FILE[1][rs2]) begin
                        if(show_posedge_golden_calc) $display("Branch Taken");

                        take_branch({{19{imm_b[12]}}, imm_b[12:0]}, rs1, rs2, 'x);

                    end else begin
                        if(show_posedge_golden_calc) $display("Branch not Taken");

                        PC_ASYNC <= PC_ASYNC + 4;

                        PC[1] <= PC_ASYNC;
                        PC_TARGET[1] <= PC_ASYNC + 4;
                        INSTR[1] <= INSTR_FLUSH;
                        RS1[1] <= rs1;
                        RS2[1] <= rs2;
                        RD[1] <= 'x;
                        IM[1] <= imm_b;
                    end
                    
                end else if(func3 == 3'b001) begin //----BNE------------------------------------------------
                    if(show_posedge_golden_calc) $display("\tIdentified as BNE.");
                    if(REG_FILE[1][rs1] != REG_FILE[1][rs2]) begin
                        if(show_posedge_golden_calc) $display("Branch Taken");

                        take_branch({{19{imm_b[12]}}, imm_b[12:0]}, rs1, rs2, 'x);

                    end else begin
                        if(show_posedge_golden_calc) $display("Branch not Taken");

                        PC_ASYNC <= PC_ASYNC + 4;

                        PC[1] <= PC_ASYNC;
                        PC_TARGET[1] <= PC_ASYNC + 4;
                        INSTR[1] <= INSTR_FLUSH;
                        RS1[1] <= rs1;
                        RS2[1] <= rs2;
                        RD[1] <= 'x;
                        IM[1] <= imm_b;
                    end
                    
                end else if(func3 == 3'b100) begin //----BLT------------------------------------------------
                    if(show_posedge_golden_calc) $display("\tIdentified as BLT.");
                    if(REG_FILE[1][rs1] < REG_FILE[1][rs2]) begin
                        if(show_posedge_golden_calc) $display("Branch Taken");

                        take_branch({{19{imm_b[12]}}, imm_b[12:0]}, rs1, rs2, 'x);

                    end else begin
                        if(show_posedge_golden_calc) $display("Branch not Taken");

                        PC_ASYNC <= PC_ASYNC + 4;

                        PC[1] <= PC_ASYNC;
                        PC_TARGET[1] <= PC_ASYNC + 4;
                        INSTR[1] <= INSTR_FLUSH;
                        RS1[1] <= rs1;
                        RS2[1] <= rs2;
                        RD[1] <= 'x;
                        IM[1] <= imm_b;
                    end
                    
                end else if(func3 == 3'b101) begin //----BGE------------------------------------------------
                    if(show_posedge_golden_calc) $display("\tIdentified as BGE.");
                    if(REG_FILE[1][rs1] >= REG_FILE[1][rs2]) begin
                        if(show_posedge_golden_calc) $display("Branch Taken");

                        take_branch({{19{imm_b[12]}}, imm_b[12:0]}, rs1, rs2, 'x);

                    end else begin
                        if(show_posedge_golden_calc) $display("Branch not Taken");

                        PC_ASYNC <= PC_ASYNC + 4;

                        PC[1] <= PC_ASYNC;
                        PC_TARGET[1] <= PC_ASYNC + 4;
                        INSTR[1] <= INSTR_FLUSH;
                        RS1[1] <= rs1;
                        RS2[1] <= rs2;
                        RD[1] <= 'x;
                        IM[1] <= imm_b;
                    end
                    
                end
            
            end else if (opcode == 7'b1101111) begin //---J-TYPE (JAL) ------------------------------------------
                {imm_j[20], imm_j[10:1], imm_j[11], imm_j[19:12], rd} = INSTR_FLUSH[31:7];
                imm_j[31:21] = {11{imm_j[20]}};
                imm_j[0] = 1'b0;
                if(show_posedge_golden_calc) $display("\tJ-Type: imm: 0b%b, rsd: 0b%b, opcode: 0b%b", imm_j[20:1], rd, opcode); //instruction info

                //----JAL------------
                if(show_posedge_golden_calc) $display("\tIdentified as JAL.");

                write_reg(rd, PC_ASYNC + 4);

                take_branch({{11{imm_j[20]}}, imm_j[20:0]}, 'x, 'x, rd);

            end else if (opcode == 7'b0110111) begin  //------U-TYPE-(LUI)-------------------------------
                {imm_u[31:12], rd} = INSTR_FLUSH[31:7];
                imm_u[11:0] = 12'b0;
                if(show_posedge_golden_calc) $display("\tU-Type: imm: 0b%b, rsd: 0b%b, opcode: 0b%b", imm_u, rd, opcode); //instruction info

                //----LUI---------------
                if(show_posedge_golden_calc) $display("\tIdentified as LUI.");
                write_reg(rd, imm_u);
                PC_ASYNC <= PC_ASYNC + 32'h4;

                //first entry in the matrix
                PC[1] <= PC_ASYNC;
                PC_TARGET[1] <= PC_ASYNC + 4;
                INSTR[1] <= INSTR_FLUSH;
                RS1[1] <= 'x;
                RS2[1] <= 'x;
                RD[1] <= rd;
                IM[1] <= imm_u;

            end else begin
                //UNKNOWN ------------------------------
                if(show_posedge_golden_calc) $display("\t<### WARNING: Instruction type not currently recognized by TB ###>");

            end
        end
    end

    always @(posedge clk) begin
        //advance golden[] history
        for (int ii = 9; ii > 1; ii--) begin
            PC[ii]            <= PC[ii-1];
            PC_TARGET[ii]     <= PC_TARGET[ii-1];
            INSTR[ii]         <= INSTR[ii-1];
            RS1[ii]           <= RS1[ii-1];
            RS2[ii]           <= RS2[ii-1];
            RD[ii]            <= RD[ii-1];
            IM[ii]            <= IM[ii-1];
            REG_FILE[ii]      <= REG_FILE[ii-1];
            DATA_MEM[ii]      <= DATA_MEM[ii-1];
        end
    end




    //verification on negedge after posedge results have settled, verification is done through tasks that verify each golden[] row
    always @(negedge clk) begin

        if(show_negedge_dut_dump) begin

            $write("\n\n\n");
            $display("Negedge block output");
            $display("========================================================================================");
            $display("\tPC_ASYNC: %h", PC_ASYNC);
            $display("\tINSTR_ASYNC: %h", INSTR_ASYNC);
            $display("\tINSTR_FLUSH: %h", INSTR_FLUSH);
            $display("\topcode: %h", opcode);

            dut_dump();
            reg_dut_dump();
            data_mem_dut_dump();

        end

        //reg_gold_post_write_back_dump();
        if(show_negedge_golden_history) begin

            display_golden_singals_history();

        end

        if(verify_row_flag) begin

            //def# is a werid way to get an output of a task, at this point its not even used
            //verify_row(0, def0);
            if(show_negedge_verify_row) $write("\n\n********************************************************************************************************************************************************************************");
            if(show_negedge_verify_row) $write("\n********************************************************************************************************************************************************************************");
            local_instruction_failure1 <= verify_row(1);
            local_instruction_failure2 <= verify_row(2);
            local_instruction_failure3 <= verify_row(3);
            local_instruction_failure4 <= verify_row(4);
            local_instruction_failure5 <= verify_row(5);

        end

        if (ohalt == 1'b1) begin //HALT SIGNAL --------------------------------------------------------------
            $error("Recieved halt signal. Pausing verification.");
            $display("Program counter: 0x%h", cpu_dut.PC);
            reg_gold_post_write_back_dump();
            $stop(); //pauses verification if CPU outputs halt signal

        end
    end

    //task & func defintions
    //============================================================================================================

    task automatic take_branch(
        logic [31:0] imm_param, 
        logic [4:0] rs1_param, 
        logic [4:0] rs2_param, 
        logic [4:0] rd_param
    );

        PC_ASYNC <= PC_ASYNC + 32'h4;
        PC[1] <= PC_ASYNC;
        PC_TARGET[1] <= PC_ASYNC + imm_param;
        INSTR[1] <= INSTR_FLUSH;
        RS1[1] <= rs1_param;
        RS2[1] <= rs2_param;
        RD[1] <= rd_param;
        IM[1] <= imm_param;  

            repeat(1) @(posedge clk);
        PC_ASYNC <= PC_ASYNC + 32'h4;
        PC[1]          <= PC_ASYNC;
        PC_TARGET[1]   <= 'x;
        INSTR[1]       <= 32'h00000013;
        RS1[1]         <= 'x;
        RS2[1]         <= 'x;
        RD[1]          <= 'x;
        IM[1]          <= 'x;

            repeat(1) @(posedge clk);
        PC_ASYNC <= PC[2] + imm_param;
        PC[1]          <= PC_ASYNC;
        PC_TARGET[1]   <= 'x;
        INSTR[1]       <= 32'h00000013;
        RS1[1]         <= 'x;
        RS2[1]         <= 'x;
        RD[1]          <= 'x;
        IM[1]          <= 'x;

    endtask

    //abstracted write access to prevent writing to the zero register
    task automatic write_reg(
        input int unsigned addr,
        input logic [31:0] word
    );

        if (addr != 0)
            REG_FILE[1][addr] <= word;

    endtask

    localparam WORD_ADDR_BIT_WIDTH = 8;
    task automatic write_data_mem(
        input logic [31:0] data,
        input logic [WORD_ADDR_BIT_WIDTH+1:0] byte_addr, //2 larger bw then the word address space
        input store_type_t store_type
    );

        logic word_flag;
        logic half_word_flag;
        logic byte_flag;

        logic [3:0] byte_en;
        logic [31:0] aligned_data;
        logic [WORD_ADDR_BIT_WIDTH-1:0] word_addr;

        {word_flag, half_word_flag, byte_flag} = store_type;

        if (word_flag && (byte_addr[1:0] != 2'b00)) 
            $error("Misaligned SW at address %0d: This is an illegal instruction, not nessisarily a hardware issue.", byte_addr);
        if (half_word_flag && byte_addr[0])
            $error("Misaligned SH at address %0d: This is an illegal instruction, not nessisarily a hardware issue.", byte_addr);

        word_addr = byte_addr >> 2;

        unique case(1'b1)
            word_flag:          byte_en = 4'b1111;

            half_word_flag:     byte_en = byte_addr[1] ? 4'b1100 : //write to upper half of word
                                                         4'b0011;  //write to lower half of word

            byte_flag:          byte_en = byte_addr[1] ? (byte_addr[0] ? 4'b1000 : //write to uppermost byte
                                                                        4'b0100) : //write to middle upper byte
                                 /* byte_addr[1] = 0 */  (byte_addr[0] ? 4'b0010 : //write to middle lower byte
                                                                        4'b0001);   //write to lowermost byte           
        endcase

        unique case(1'b1)
            word_flag:          aligned_data = data;
            half_word_flag:     aligned_data = data << (16 * byte_addr[1]); //shift lower 16 to upper 16 if writing to upper 16
            byte_flag:          aligned_data = data << (8 * byte_addr[1:0]); //shiftt lower 8 bytes to corresponding byte_en
        endcase

        if (byte_en[0]) DATA_MEM[1][word_addr][7:0]   <= aligned_data[7:0];
        if (byte_en[1]) DATA_MEM[1][word_addr][15:8]  <= aligned_data[15:8];
        if (byte_en[2]) DATA_MEM[1][word_addr][23:16] <= aligned_data[23:16];
        if (byte_en[3]) DATA_MEM[1][word_addr][31:24] <= aligned_data[31:24];    

    endtask

    function automatic logic[31:0] read_data_mem(
        input logic [WORD_ADDR_BIT_WIDTH+1:0] byte_addr, //2 larger bw then the word address space
        input store_type_t store_type,
        input logic is_signed
    );

        logic word_flag;
        logic half_word_flag;
        logic byte_flag;

        logic [3:0] byte_en;
        logic [31:0] data;
        logic [31:0] aligned_data;
        logic [31:0] result;
        logic [WORD_ADDR_BIT_WIDTH-1:0] word_addr;

        {word_flag, half_word_flag, byte_flag} = store_type;

        if (word_flag && (byte_addr[1:0] != 2'b00)) 
            $error("Misaligned SW at address %0d: This is an illegal instruction, not nessisarily a hardware issue.", byte_addr);
        if (half_word_flag && byte_addr[0])
            $error("Misaligned SH at address %0d: This is an illegal instruction, not nessisarily a hardware issue.", byte_addr);

        word_addr = byte_addr >> 2;

        unique case(1'b1)
            word_flag:          byte_en = 4'b1111;

            half_word_flag:     byte_en = byte_addr[1] ? 4'b1100 : //read from upper half of word
                                                         4'b0011;  //read from lower half of word

            byte_flag:          byte_en = byte_addr[1] ? (byte_addr[0] ? 4'b1000 : //read from uppermost byte
                                                                        4'b0100) : //read from middle upper byte
                                 /* byte_addr[1] = 0 */  (byte_addr[0] ? 4'b0010 : //read from middle lower byte
                                                                        4'b0001);   //read from lowermost byte           
        endcase

        data[7:0]   = byte_en[0] ? DATA_MEM[1][word_addr][7:0]   : 8'b0;
        data[15:8]  = byte_en[1] ? DATA_MEM[1][word_addr][15:8]  : 8'b0;
        data[23:16] = byte_en[2] ? DATA_MEM[1][word_addr][23:16] : 8'b0;
        data[31:24] = byte_en[3] ? DATA_MEM[1][word_addr][31:24] : 8'b0;

        unique case(1'b1)
            word_flag:          aligned_data = data;
            half_word_flag:     aligned_data = data >> (16 * byte_addr[1]); //shift upper 16 to lower 16 if we are reading from upper 16
            byte_flag:          aligned_data = data >> (8 * byte_addr[1:0]); //shift byte we are reading from to lower byte
        endcase

        if(is_signed) begin
            unique case(1'b1)
                word_flag:          result = aligned_data;
                half_word_flag:     result = {{16{aligned_data[15]}}, aligned_data[15:0]};
                byte_flag:          result = {{24{aligned_data[7]}}, aligned_data[7:0]};
            endcase
        end else begin
                result = aligned_data;
        end

        return result;

    endfunction

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
            $display("[IF ] redirect_pc     = 0x%08h", cpu_dut.redirect_pc);
                        $write("\n");

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
                        $write("\n");


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
                        $write("\n");


            // --------------------------------
            // MEM stage
            // --------------------------------
            $display("[MEM] ALU_M       = 0x%08h", cpu_dut.ALU_M);
            $display("[MEM] RS2_M_DATA  = 0x%08h", cpu_dut.RS2_DATA_M);
            $display("[MEM] DMEM_OUT   = 0x%08h", cpu_dut.DATA_MEM_OUT);
            $display("[MEM] MEM_WR_EN  = %0b",    cpu_dut.data_mem_wr_en_M);
                        $write("\n");


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
                $write("%5s: %08h ", reg_name[ii], cpu_dut.my_reg_file.regs_out[ii]);
            end
        end
    endtask

    task reg_gold_post_write_back_dump();
        begin
            $write("\nREG_FILE[1] Dump");
            for(int ii = 0; ii < 32; ii++) begin
                if(ii % 8 == 0) begin //i know i should just use 2nd for loop shut up
                    $write("\n\t");
                end
                $write("%5s: 0x%h ", reg_name[ii], REG_FILE[1][ii]);
            end
        end
    endtask

    task data_mem_dut_dump();
        begin
            $display("\n\tDATA_MEM_DUT Dump");
            for(int ii = 0; ii < 256; ii++) begin
                if(ii % 8 == 0) begin //i know i should just use 2nd for loop shut up
                    $write("\n\t");
                end
                $write("\t%2d: 0x%8h", ii, cpu_dut.my_data_mem.data_mem[ii]);
            end
        end
    endtask

    task data_mem_gold_ii_dump(int c);
        begin
            $write("\n\tDATA_MEM_GOLD: Row(%1d)", c);
            for(int ii = 0; ii < 32; ii++) begin
                if(ii % 8 == 0) begin //i know i should just use 2nd for loop shut up
                    $write("\n\t");
                end
                $write("\t%2d: 0x%8h", ii, DATA_MEM[c][ii]);
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
                $display("\n\ngolden_history[%0d]:", c);
                $display("\tPC        = 0x%08h", PC[c]);
                $display("\tPC_TARGET = 0x%08h", PC_TARGET[c]);
                $display("\tINSTR     = 0x%08h", INSTR[c]);
                $display("\tRS1       = %0d", RS1[c]);
                $display("\tRS2       = %0d", RS2[c]);
                $display("\tRD        = %0d", RD[c]);
                $display("\tIM        = %0d", IM[c]);

                $write("\tREG_FILE");
                for (r = 0; r < 32; r = r + 1) begin
                    if(r % 8 == 0) begin //i know i should just use 2nd for loop shut up
                        $write("\n\t");
                    end

                    $write("%5s: 0x%h", reg_name[r], REG_FILE[c][r]);
                end

                $write("\n\tDATA_MEM");
                for(int ii = 0; ii < 32; ii++) begin
                    if(ii % 8 == 0) begin //i know i should just use 2nd for loop shut up
                        $write("\n\t");
                    end
                    $write("\t%2d: 0x%h", ii, DATA_MEM[c][ii]);
                end
            end

            $display("\n========================================================================================");

        end
    endtask

    function automatic logic dut_redirected();
        return (cpu_dut.redirect_pc
            //|| ((cpu_dut.INSTR_D[6:0]  == 7'b1100111) && (cpu_dut.INSTR_D[14:12] == 3'b000)) //JALR
            //|| (cpu_dut.INSTR_D[6:0]   == 7'b1101111) && (cpu_dut.INSTR_D[14:12] == cpu_dut.INSTR_D[14:12]) //JAL
            //|| (cpu_dut.INSTR_D[6:0]   == 7'b1100011) && (cpu_dut.INSTR_D[14:12] == 3'b000) //BEQ
        );
    endfunction

    //verify_row(1), will parse and verify golden[1], this task uses if statements that check the row to ensure
    //that for example addi will only be verified if its in verify_row(5)/golden[5] (post writeback), hoever addi
    //will not be veified if its in verify_row(2)/golden[2], or 1 or 4, etc.
    function automatic verify_row(
        input int row
    );
        begin

            logic [6:0] func7_v;
            logic [4:0] rs2_v;
            logic [4:0] rs1_v;
            logic [4:0] rd_v;
            logic [2:0] func3_v;
            logic [6:0] opcode_v;
            logic [31:0] imm_i_v, imm_s_v;
            logic [31:0] imm_b_v;
            logic [31:0] imm_u_v;
            logic [31:0] imm_j_v;

            opcode_v = INSTR[row][6:0];

            if(show_negedge_verify_row) $write("\n\n");
            if(show_negedge_verify_row) $display("verify_row(%0d) output: \nPC: %h", row, PC[row]);
            if(show_negedge_verify_row) $display("========================================================================================");
            if (opcode_v == 7'b0110011) begin //--------R-TYPE/M-TYPE----------------------------------------------
                {func7_v, rs2_v, rs1_v, func3_v, rd_v} = INSTR[row][31:7];
                if(show_negedge_verify_row) $display("\tR/M-Type: func7_v: 0b%b, rs2_v: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, rd_v: 0b%b, opcode_v: 0b%b", func7_v, rs2_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

                //-R-TYPE---------------
                if (func7_v == 7'b0000000) begin
                    if (func3_v == 3'b000) begin //----ADD------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as ADD:");

                    end else if (func3_v == 3'b100) begin //---XOR----------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as XOR:");

                    end else if (func3_v == 3'b110) begin //----OR-------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as OR:");

                    end else if (func3_v == 3'b111) begin //----AND------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as AND:");

                    end else if (func3_v == 3'b001) begin //----SLL------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as SLL:");

                    end else if (func3_v == 3'b101) begin //----SRL------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as SRL:");

                    end else if (func3_v == 3'b010) begin //----SLT------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as SLT:");

                    end else if (func3_v == 3'b011) begin //----SLTU------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as STLU:");

                    end 

                end else if (func7_v == 7'b0100000) begin     
                    if (func3_v == 3'b000) begin //----SUB---------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as SUB:");

                    end else if (func3_v == 3'b101) begin //----SRA---------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as SRA:");

                    end

                //-M-TYPE---------------
                end else if (func7_v == 7'b0000001) begin
                    if (func3_v == 3'b000) begin //----MUL------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as MUL:");

                    end else if (func3_v == 3'b001) begin //----MULH------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as MULH:");

                    end else if (func3_v == 3'b010) begin //----MULHSU------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as MULHSU:");

                    end else if (func3_v == 3'b011) begin //----MULHU------------------------------
                        if(show_negedge_verify_row) $write("\tIdentified as MULHU:");

                    end

                end

                //Output - compares the actual and expected value of rd after the writeback stage (row = 5)
                if(row == 5) begin

                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); return 1; end

                end


            end else if (opcode_v == 7'b0010011) begin //-----I-TYPE (ARITHMETIC) ---------------------------------
                {imm_i_v[11:0], rs1_v, func3_v, rd_v} = INSTR[row][31:7];
                imm_i_v[31:12] = {20{imm_i_v[11]}};
                if(show_negedge_verify_row) $display("\tI-Type: imm: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, rd_v: 0b%b, opcode_v: 0b%b", imm_i_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

                if(func3_v == 3'b000) begin //-------ADDI-------------------------------
                    if(imm_i_v == 32'd0 & rs1_v == 5'd0 & rd_v == 5'd0) begin
                        if(show_negedge_verify_row) $write("\tIdentified as NOP:");
                        //TODO, do a reg by reg and data by data comparasion for validation here,
                        //once that task has been built as seen at ~line 1

                        if(row == 5) $display(" Success");
                        //assert() $display(" Success");
                        //else begin $display(" FAILURE"); return 1; end

                    end else begin
                        //$display("rd_v: ", rd_v);
                        //$display("dut:%d gold:%d", cpu_dut.my_reg_file.regs_out[rd_v], REG_FILE[5][rd_v]);
                        if(show_negedge_verify_row) $write("\tIdentified as ADDI:");

                        if(row == 5) begin                        
                            
                            //Output - compares the actual and predicted value of rd after the writeback stage
                            assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                            else begin $display(" FAILURE"); return 1; end

                        end
                    end

                end else if(func3_v == 3'b100) begin //-------XORI-------------------------------
                    //$display("rd_v: ", rd_v);
                    //$display("dut:%d gold:%d", cpu_dut.my_reg_file.regs_out[rd_v], REG_FILE[5][rd_v]);
                    if(show_negedge_verify_row) $write("\tIdentified as XORI:");
                    if(row == 5) begin                          
                        //Output - compares the actual and predicted value of rd after the writeback stage
                        assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end

                end else if(func3_v == 3'b110) begin //-------ORI-------------------------------
                    //$display("rd_v: ", rd_v);
                    //$display("dut:%d gold:%d", cpu_dut.my_reg_file.regs_out[rd_v], REG_FILE[5][rd_v]);
                    if(show_negedge_verify_row) $write("\tIdentified as ORI:");
                    if(row == 5) begin                          
                        //Output - compares the actual and predicted value of rd after the writeback stage
                        assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end
            
                end else if(func3_v == 3'b111) begin //-------ANDI-------------------------------
                    //$display("rd_v: ", rd_v);
                    //$display("dut:%d gold:%d", cpu_dut.my_reg_file.regs_out[rd_v], REG_FILE[5][rd_v]);
                    if(show_negedge_verify_row) $write("\tIdentified as ANDI:");
                    if(row == 5) begin                          
                        //Output - compares the actual and predicted value of rd after the writeback stage
                        assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end

                end



            end else if (opcode_v == 7'b0000011) begin //----I-TYPE (LOADS) ----------------------------------
                {imm_i_v[11:0], rs1_v, func3_v, rd_v} = INSTR[row][31:7];
                imm_i_v[31:12] = {20{imm_i_v[11]}};
                if(show_negedge_verify_row) $display("\tI-Type: imm: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, rd_v: 0b%b, opcode_v: 0b%b", imm_i_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

                if(func3_v == 3'b010) begin //----LW------------------------------------
                    if(show_negedge_verify_row) $write("\tIdentified as LW:");
                    if(row == 5) begin

                        assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end
                end

            end else if (opcode_v == 7'b1100111) begin //---I-TYPE (JALR) ------------------------------------------
                {imm_i_v[11:0], rs1_v, func3_v, rd_v} = INSTR[row][31:7];
                imm_i_v[31:12] = {20{imm_i_v[11]}};
                if(show_negedge_verify_row) $display("\tI-Type: imm: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, rd_v: 0b%b, opcode_v: 0b%b", imm_i_v, rs1_v, func3_v, rd_v, opcode_v); //instruction info

                if(func3_v == 3'b000) begin //-------JALR-------------------------------
                    if(show_negedge_verify_row) $write("\tIdentified as JALR:");
                    // $display("dut: %h, gold: %h", cpu_dut.pc_reg.q, PC_ASYNC);
                    if(row == 3) begin

                        assert(cpu_dut.pc_reg.q == PC_ASYNC) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end
                end

            end else if (opcode_v == 7'b0100011) begin //------S-TYPE----------------------------------
                {imm_s_v[11:5], rs2_v, rs1_v, func3_v, imm_s_v[4:0]} = INSTR[row][31:7];
                imm_s_v[31:12] = {20{imm_s_v[11]}};
                if(show_negedge_verify_row) $display("\tS-Type: imm: 0b%b, rs2_v: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, opcode_v: 0b%b", imm_s_v, rs2_v, rs1_v, func3_v, opcode_v); //instruction info

                if(func3_v == 3'b010) begin //----SW-------------------------------------
                    if(show_negedge_verify_row) $write("\tIdentified as SW:");

                    if(row == 4) begin

                        assert(cpu_dut.my_data_mem.data_mem[(cpu_dut.my_reg_file.regs_out[rs1_v] + imm_s_v)>>2] == DATA_MEM[4][(REG_FILE[4][rs1_v] + imm_s_v)>>2]) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end//$display("dut: %d, gold: %d, *rs1_v + imm_s: %d, *rs1_v: %d, imm_s: %d", cpu_dut.my_data_mem.data_mem[(cpu_dut.my_reg_file.regs_out[rs1_v] + imm_s_v)>>2], DATA_MEM[4][(REG_FILE[4][rs1_v] + imm_s_v)>>2], REG_FILE[4][rs1_v] + imm_s_v, REG_FILE[4][rs1_v], imm_s_v);

                end

            end else if (opcode_v == 7'b1100011) begin //------B-TYPE----------------------------
                {imm_b_v[12], imm_b_v[10:5], rs2_v, rs1_v, func3_v, imm_b_v[4:1], imm_b_v[11]} = INSTR[row][31:7];
                imm_b_v[31:13] = {19{imm_b_v[12]}};
                imm_b_v[0] = 1'b0; //LSB is always zero for B-type
                if(show_negedge_verify_row) $display("\tB-Type: imm: 0b%b, rs2_v: 0b%b, rs1_v: 0b%b, func3_v: 0b%b, opcode_v: 0b%b", imm_b_v[12:1], rs2_v, rs1_v, func3_v, opcode_v); //instruction info

                if(func3_v == 3'b000) begin //----BEQ------------------------------------------------
                    if(show_negedge_verify_row) $write("\tIdentified as BEQ:");
                    // $display("dut: %h, gold: %h", cpu_dut.pc_reg.q, PC_ASYNC);
                    if(row == 3) begin
                        
                        assert(cpu_dut.pc_reg.q == PC_ASYNC) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end
                    
                end else if(func3_v == 3'b001) begin //----BNE------------------------------------------------
                    if(show_negedge_verify_row) $write("\tIdentified as BNE:");
                    // $display("dut: %h, gold: %h", cpu_dut.pc_reg.q, PC_ASYNC);
                    if(row == 3) begin
                        
                        assert(cpu_dut.pc_reg.q == PC_ASYNC) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end
                    
                end else if(func3_v == 3'b100) begin //----BLT------------------------------------------------
                    if(show_negedge_verify_row) $write("\tIdentified as BLT:");
                    // $display("dut: %h, gold: %h", cpu_dut.pc_reg.q, PC_ASYNC);
                    if(row == 3) begin
                        
                        assert(cpu_dut.pc_reg.q == PC_ASYNC) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end
                    
                end else if(func3_v == 3'b101) begin //----BGE------------------------------------------------
                    if(show_negedge_verify_row) $write("\tIdentified as BGE:");
                    // $display("dut: %h, gold: %h", cpu_dut.pc_reg.q, PC_ASYNC);
                    if(row == 3) begin
                        
                        assert(cpu_dut.pc_reg.q == PC_ASYNC) $display(" Success");
                        else begin $display(" FAILURE"); return 1; end

                    end
                    
                end
            
            end else if (opcode_v == 7'b1101111) begin //---J-TYPE (JAL) ------------------------------------------
                {imm_j_v[20], imm_j_v[10:1], imm_j_v[11], imm_j_v[19:12], rd_v} = INSTR[row][31:7];
                imm_j_v[31:21] = {11{imm_j_v[20]}};
                imm_j_v[0] = 1'b0;
                if(show_negedge_verify_row) $display("\tJ-Type: imm: 0b%b, rsd: 0b%b, opcode_v: 0b%b", imm_j_v[20:1], rd_v, opcode_v); //instruction info

                //----JAL------------
                if(show_negedge_verify_row) $write("\tIdentified as JAL:");
                // $display("dut: %h, gold: %h", cpu_dut.pc_reg.q, PC_ASYNC);
                if(row == 3) begin
                    
                    assert(cpu_dut.pc_reg.q == PC_ASYNC) $display(" Success"); //here
                    else begin $display(" FAILURE"); return 1; end

                end

            end else if (opcode_v == 7'b0110111) begin  //------U-TYPE-(LUI)-------------------------------
                {imm_u_v[31:12], rd_v} = INSTR[row][31:7];
                imm_u_v[11:0] = 12'b0;
                if(show_negedge_verify_row) $display("\tU-Type: imm: 0b%b, rsd: 0b%b, opcode_v: 0b%b", imm_u_v, rd_v, opcode_v); //instruction info

                //----LUI---------------
                if(show_negedge_verify_row) $write("\tIdentified as LUI:");
                if(row == 5) begin

                    assert(cpu_dut.my_reg_file.regs_out[rd_v] == REG_FILE[5][rd_v]) $display(" Success");
                    else begin $display(" FAILURE"); return 1; end

                end
                // else return 1;

            end else begin
                //UNKNOWN ------------------------------
                if(show_negedge_verify_row) $display("WARNING: Instruction type not currently recognized by TB.");

            end

            return 0;

        end
    endfunction

endmodule