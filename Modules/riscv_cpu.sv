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
    logic [6:0] OP;
    logic [31:0] UID;
    logic [31:0] RS1;               //read addr of regfile 
    logic [31:0] RS1_DATA;          //read1 from regfile
    logic [31:0] RS1_DATA_PP;       //read1 from regfile after pipeline reg
    logic [31:0] RS2;               //read addr of regfile
    logic [31:0] RS2_DATA;          //read2 from regfile
    logic [31:0] RS2_DATA_PP;       //read2 from regfile after pipeline reg
    logic [31:0] RS2_DATA_PP_PP;    //read2 from regfile after 2pipeline reg
    logic [31:0] RD;                //write addr of regfile
    logic [31:0] RD_DATA;           //input write to regfile
    logic [31:0] IM;
    logic [31:0] IM_PP;             //immediate after pipeline reg
    logic [31:0] ALU;               //output of alu
    logic [31:0] ALU_PP;   
    logic [31:0] ALU_PP_PP;
    logic [31:0] DATA_MEM_OUT;
    logic [31:0] DATA_MEM_OUT_PP;

    logic [95:0] d2e_data;          //decode to execute data signals
    logic [10:0] d2e_control;       //decode to execute control signals
    logic [95:0] d2e_data_PP;       //decode to execute post pipeline
    logic [10:0] d2e_control_PP;    //decode to execute control signals post pipeline

    logic [63:0] e2m_data;          //execute to memory data signals
    logic [3:0] e2m_control;       //execute to memory control signals
    logic [63:0] e2m_data_PP;       //execute to memory post pipeline
    logic [3:0] e2m_control_PP;    //execute to memory control signals post pipeline    

    //control signals after 1 pipeline reg
    logic reg_file_wr_en_PP;
    logic alu_use_im_PP,
    logic alu_sel_add_PP,
    logic alu_sel_sub_PP,
    logic alu_sel_and_PP,
    logic alu_sel_or_PP,
    logic alu_sel_slt_PP,
    logic branch_en_PP,
    logic data_mem_wr_en_PP,
    logic dbus_sel_alu_PP,
    logic dbus_sel_data_mem_PP;

    //control signals after 2 pipeline regs
    logic data_mem_wr_en_PP_PP;
    logic dbus_sel_alu_PP_PP;
    logic dbus_sel_data_mem_PP_PP;
    logic reg_file_wr_en_PP_PP;

    logic clk, rst;

    // TODO will place these control signals in microcode to be transferred to sig file later
    logic zero_flag;

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
    // response - This should now function as a ROM, and I believe it's async (no clk needed)
    instruction_memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(32)
    ) instr_mem (
        .read_address(PC),
        .read_data(INSTR)
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

    //TODO grouping together the ustore output signals to prepare them for the cnrt_sig pipeline
    //-chris

    assign OP = INSTR_PP[6:0]; //OPCODE is last 7 bits of instr
    //TODO when we start to test R-TYPE inst, UID will also take in func3 and func7
    //For now, this will work for LW, SW, and BEQ since they don't need the func fields to specify ALU operation

    //given no seq engine, ID goes str8 into ustore
    UID__ my_uid ( .ir (OP), .uip(UID) );
    US__ my_ustore ( .uip(UID), .sig(sig) );
    //sig is all the control signals, see sig_declar.inc or "SIG" section in microcode for list

    //muxing of reg addrs, and imediates
    id_t my_id_t (
            .instr(INSTR_PP),
            .r_type,
            .i_type,
            .s_type,
            .b_type,
            .u_type,
            .j_type,
            .rs1(RS1),
            .rs2(RS2),
            .rd(RD),
            .im(IM)
        );
        
    //for rn hardcoded to R type instr
    reg_file #(
        .REG_BIT_WIDTH(32),
        .NUM_OF_REGS(32)
    ) my_reg_file (
        .rs1_addr(RS1),
        .rs2_addr(RS2),
        .rs1_data(RS1_DATA),
        .rs2_data(RS2_DATA),
        .rd_wr_en(reg_file_wr_en),
        .rd_addr(RD), //TODO, THIS SHOULD NOT BE RD, BUT SOME POST PIPELINE REGISTER RD, AS PER "PPwithControl.png" IN GOOGLE DOC
        .rd_data(RD_DATA), 
        .clk(clk),
        .rst(rst)
    );

    //preparing data and control signals for pipeline reg
    assign d2e_data = {RS1_DATA, RS2_DATA, IM};
    assign d2e_control = {
        alu_use_im,
        alu_sel_add,
        alu_sel_sub,
        alu_sel_and,
        alu_sel_or,
        alu_sel_slt,
        branch_en,
        data_mem_wr_en,
        dbus_sel_alu,
        dbus_sel_data_mem,
        reg_file_wr_en
    };

/* < ID/EX > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(96)
    ) id_ex_reg (
        .d(d2e_data),      // Include IM in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance),
        .q(d2e_data_PP)
    );

    dff_async_reset #(
        .WIDTH(11)
    ) id_ex_control_reg (
        .d(d2e_control),      // Include control signals in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance),
        .q(d2e_control_PP)
    );

    //unpacking data and control signals from pipeline reg
    assign {RS1_DATA_PP, RS2_DATA_PP, IM_PP} = d2e_data_PP;
    assign {
        alu_use_im_PP,
        alu_sel_add_PP,
        alu_sel_sub_PP,
        alu_sel_and_PP,
        alu_sel_or_PP,
        alu_sel_slt_PP,
        branch_en_PP,
        data_mem_wr_en_PP,
        dbus_sel_alu_PP,
        dbus_sel_data_mem_P,
        reg_file_wr_en_PP
    } = d2e_control_PP;

    /* < ALU STARTS HERE > */

    /* Please note NOP's are a pseudoinstruction in RISC-V handled by the assembler as an ADDI of 0 with the zero register
    back into the zero register, and it likely doesn't need its own signal. Also it may be worth considering using func3 
    and func7 instead of individual signals to reduce the number of signals being passed into the module. */

    alu #(
        .WIDTH(32),
    ) alu_again_colon_closing_parenthesis (
        .operand_a(RS1_DATA_PP),
        .operand_b(
            alu_use_im_PP ? IM_PP : RS2_DATA_PP   // IM changed to IM_PP
            ),
        .alu_sel_add(alu_sel_add_PP),
        .alu_sel_sub(alu_sel_sub_PP),
        .alu_sel_and(alu_sel_and_PP),
        .alu_sel_or(alu_sel_or_PP),
        .alu_sel_slt(alu_sel_slt_PP),
        .zero_flag(zero_flag),
        .result(ALU)
    );

    //preparing data and control signals for pipeline reg
    assign e2m_data = {ALU, RS2_DATA_PP};
    assign e2m_control = {
        data_mem_wr_en_PP,
        dbus_sel_alu_PP,
        dbus_sel_data_mem_PP,
        reg_file_wr_en_PP
    };    

/* < EX/MEM > */ //====================================================================================================

    //not sure but i think we may not need a pipeline reg here because of the nature of the data_mem
    dff_async_reset #(
        .WIDTH(64)
    ) ex_mem_reg (
        .d(e2m_data),       
        .clk(clk),                   
        .rst(rst),
        .wr_en(pipeline_advance),
        .q(e2m_data_PP)
    );

    dff_async_reset #(
        .WIDTH(4)
    ) ex_mem_control_reg (
        .d(e2m_control),      // Include control signals in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance),
        .q(e2m_control_PP)
    );

    //unpacking data and control signals from pipeline reg
    assign {ALU_PP, RS2_DATA_PP_PP} = e2m_data_PP;
    assign {
        data_mem_wr_en_PP_PP,
        dbus_sel_alu_PP_PP,
        dbus_sel_data_mem_PP_PP,
        reg_file_wr_en_PP_PP
    } = e2m_control_PP;     

    //should be converted to proper RAM at some point
    data_memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(32)
    ) data_mem (
        .readAddr(ALU_PP),
        .writeAddr(ALU_PP),
        .writeData(RS2_DATA_PP_PP),
        .writeEn(data_mem_wr_en_PP_PP),
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
