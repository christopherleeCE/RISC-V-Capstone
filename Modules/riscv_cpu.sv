//TODO pipelining regs for data & cntr_sigs
//TODO confirm buses are right,
//TODO better comments for logic declarations

//this makes it so that the compiler will throw an error if we try to use a signal/bus that has not been declared,
//this will help avoid errors where an undeclared bus gets implicitly declared as a wire
`default_nettype none

//prototype of basic pattern
module riscv_cpu;

    //this assigns the SIG's declarred in microcode to corresponding outputs of the ustore
    `include "sig_declare.inc";

    //TODO some bus declarations may be missing, and those dont show up in questa's console :( but that is a bridge we will burn l8r
    //a 'PP' mean post pipline (reg), so RS1_DATA goes into a pipeline reg, then on the out is 'RS1_DATA_PP'
    //is the output of that reg and if 'RS1_DATA_PP' goes into a pipeline reg then the output is 'RS1_DATA_PP_PP'
    logic [31:0] PC;
    logic [31:0] INSTR;
    logic [31:0] INSTR_PP;
    logic [31:0] IR, ID;
    logic [31:0] RS1_DATA;  //read1 from regfile
    logic [31:0] RS1_DATA_PP;  //read1 from regfile after pipeline reg
    logic [31:0] RS2_DATA;  //read2 from regfile
    logic [31:0] RS2_DATA_PP;  //read2 from regfile after pipeline reg
    logic [31:0] RS2_DATA_PP_PP;
    logic [31:0] RD_DATA;   //input write to regfile
    logic [31:0] ALU;   //output of alu
    logic [31:0] ALU_PP;
    logic [31:0] ALU_PP_PP;
    logic [31:0] DATA_MEM_OUT;
    logic [31:0] DATA_MEM_OUT_PP;
    logic clk, rst;

    pc #(
        .WIDTH(32)
    ) pc_reg (
        .d(ALU_PP), //TODO i put ALU_PP here as a placeholder, THIS CAN CHANGE!!! -chris
        .clk(clk),
        .rst(rst),
        .inc(inc_pc),
        .wr_en(branch_en),
        .q(PC)
    );

    //should be converted to proper ROM at some point
    //as of rn idk if its async or not
    memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(32)
    ) instr_mem (
        .readAddr(PC),
        .writeAddr(32'h0),
        .writeData(32'h0),
        .writeEn(0),
        .readData(INSTR),
        .clk(clk)
    );

/* < IF/ID > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(32)
    ) instruction_reg (
        .d(INSTR),
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance),
        .q(INSTR_PP)
    );

    //TODO either the ID or the (ustore -> more hardware) needs to control datapath for instruciton types (R type, I type, etc), (i reccomend ustore -> more hardware) 
    //TODO grouping together the ustore output signals to prepare them for the cnrt_sig pipeline
    //-chris

    //given no seq engine, ID goes str8 into ustore
    ID__ my_id ( .ir (IR), .uip(ID) );
    US__ my_ustore ( .uip(ID), .sig(sig) );    
    //sig is all the control signals, see sig_declar.inc or "SIG" section in microcode for list

    //reg address & instr type needs to be interpreted here

    //for rn hardcoded to R type instr
    reg_file #(
        .REG_BIT_WIDTH(32),
        .NUM_OF_REGS(32)
    ) my_reg_file (
        .rs1_addr(IR[19:15]),
        .rs2_addr(IR[24:20]),
        .rs1_data(RS1_DATA),
        .rs2_data(RS2_DATA),
        .rd_wr_en(reg_file_wr_en),
        .rd_addr(IR[11:7]),
        .rd_data(RD_DATA),
        .clk(clk),
        .rst(rst)
    );

/* < ID/EX > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(64)
    ) id_ex_reg (
        .d('{RS1_DATA, RS2_DATA}),
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance),
        .q('{RS1_DATA_PP, RS2_DATA_PP})
    );

    /* < ALU STARTS HERE > */

    /* Please note NOP's are a pseudoinstruction in RISC-V handled by the assembler as an ADDI of 0 with the zero register
    back into the zero register, and it likely doesn't need its own signal. Also it may be worth considering using func3 
    and func7 instead of individual signals to reduce the number of signals being passed into the module. - Edgar */

    alu #(
        .WIDTH(32)
    ) alu_again_colon_closing_parenthesis (
        .operand_a(RS1_DATA_PP),
        .operand_b(RS2_DATA_PP),
        .alu_sel_add,
        .alu_sel_sub,
        .alu_sel_nop,
        .alu_sel_pass1,
        .alu_sel_pass2,
        .result(ALU)
    );

/* < EX/MEM > */ //====================================================================================================

    //not sure but i think we may not need a pipeline reg here because of the nature of the data_mem
    dff_async_reset #(
        .WIDTH(32)
    ) ex_mem_reg (
        .d('{ALU, RS2_DATA_PP}),
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance),
        .q('{ALU_PP, RS2_DATA_PP_PP})
    );

    //should be converted to proper ROM at some point
    memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(32)
    ) data_mem (
        .readAddr(ALU_PP),
        .writeAddr(ALU_PP),
        .writeData(RS2_DATA_PP_PP),
        .writeEn(data_mem_wr_en),
        .readData(DATA_MEM_OUT),
        .clk(clk)
    );

/* < MEM/WB > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(64)
    ) mem_we_reg (
        .d('{ALU_PP, DATA_MEM_OUT}),
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance),
        .q('{ALU_PP_PP, DATA_MEM_OUT_PP})
    );

    //dbus mux
    always_comb begin
        unique case (1'b1)

        dbus_sel_alu        : RD_DATA = ALU_PP_PP;
        dbus_sel_data_mem   : RD_DATA = DATA_MEM_OUT_PP;

        endcase
    end


endmodule
