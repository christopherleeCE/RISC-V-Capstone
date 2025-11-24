//TODO confirm buses are right,
//TODO better comments for logic declarations

//this makes it so that the compiler will throw an error if we try to use a signal/bus that has not been declared,
//this will help avoid errors where an undeclared bus gets implicitly declared as a wire
// `default_nettype none

//prototype of basic pattern
module riscv_cpu
(
    input logic clk, rst, //This has to be a wire for explicit net type declaration (according to Questa)
    output logic ohalt //when this is asserted, CPU should stop execution. Please implement in testbench
);

    //this assigns the SIG's declarred in microcode to corresponding outputs of the ustore
    `include "sig_declare.inc";

    //TODO some bus declarations may be missing, and those dont show up in questa's console :( but that is a bridge we will burn l8r

    //new terminology:
    // f=fetch, d=decode, e=execute, m=memory, w=writeback
    logic [31:0] PC;
    logic [31:0] PC_D;             //PC after pipeline reg
    logic [31:0] PC_E;              //PC after pipeline reg
    logic [31:0] PC_target;        //target PC for branches (calculated in execute stage)
    logic [31:0] INSTR;
    logic [31:0] INSTR_REAL;      //real instruction after deciding whether to flush or not
    logic [31:0] INSTR_D;           //instruction after pipeline reg
    logic [UIP_WIDTH-1:0] UIP;
    logic [4:0] RS1;               //read addr of regfile 
    logic [31:0] RS1_DATA;          //read1 from regfile
    logic [31:0] RS1_DATA_E;       //read1 from regfile after pipeline reg
    logic [4:0] RS2;               //read addr of regfile
    logic [31:0] RS2_DATA;          //read2 from regfile
    logic [31:0] RS2_DATA_E;       //read2 from regfile after pipeline reg
    logic [31:0] RS2_DATA_M;    //read2 from regfile after 2pipeline reg
    logic [4:0] RD;                //write addr of regfile
    logic [4:0] RD_E;             //write addr of regfile after pipeline reg
    logic [4:0] RD_M;          //write addr of regfile after 2pipeline reg
    logic [4:0] RD_W;       //write addr of regfile after 3pipeline reg
    logic [31:0] RD_DATA;           //input write to regfile
    logic [31:0] IM;
    logic [31:0] IM_E;             //immediate after pipeline reg
    logic [31:0] ALU;               //output of alu
    logic [31:0] ALU_M;   
    logic [31:0] ALU_W;
    logic [31:0] DATA_MEM_OUT;
    logic [31:0] DATA_MEM_OUT_W;

    logic zero_flag;               //from alu, is the result zero?
    logic branch_taken;          //is a branch taken?

    logic [63:0] f2d_data_F;          //fetch to decode data signals
    logic [63:0] f2d_data_D;       //fetch to decode post pipeline    

    logic [132:0] d2e_data_D;          //decode to execute data signals
    logic [15:0] d2e_control_D;       //decode to execute control signals
    logic [132:0] d2e_data_E;       //decode to execute post pipeline
    logic [15:0] d2e_control_E;    //decode to execute control signals post pipeline

    logic [68:0] e2m_data_E;          //execute to memory data signals
    logic [4:0] e2m_control_E;       //execute to memory control signals
    logic [68:0] e2m_data_M;       //execute to memory post pipeline
    logic [4:0] e2m_control_M;    //execute to memory control signals post pipeline  

    logic [68:0] m2w_data_M;          //memory to writeback data signals
    logic [3:0] m2w_control_M;       //memory to writeback control signals
    logic [68:0] m2w_data_W;       //memory to writeback post pipeline
    logic [3:0] m2w_control_W;    //memory to writeback control signals post pipeline    

    //control signals after 1 pipeline reg
    logic reg_file_wr_en_E;
    logic alu_use_im_E;
    logic alu_sel_add_E;
    logic alu_sel_sub_E;
    logic alu_sel_mul_E;
    logic alu_sel_mulh_E;
    logic alu_sel_mulhsu_E;
    logic alu_sel_mulhu_E;
    logic alu_sel_and_E;
    logic alu_sel_or_E;
    logic alu_sel_slt_E;
    logic branch_en_E;
    logic data_mem_wr_en_E;
    logic dbus_sel_alu_E;
    logic dbus_sel_data_mem_E;

    //control signals after 2 pipeline regs
    logic data_mem_wr_en_M;
    logic dbus_sel_alu_M;
    logic dbus_sel_data_mem_M;
    logic reg_file_wr_en_M;

    //control signals after 3 pipeline regs
    logic dbus_sel_alu_W;
    logic dbus_sel_data_mem_W;
    logic reg_file_wr_en_W;

    // halt goes through pipeline
    logic halt_D, halt_E, halt_M, halt_W;

    // flush signals for control hazard handling
    logic flush_FD, flush_DE;  

    // pipeline advance for data signals
    logic pipeline_advance; //when high, pipeline regs advance

    // separate advance signals for control pipeline regs
    logic pipeline_advance_FD;
    logic pipeline_advance_DE; 
    logic pipeline_advance_EM;
    logic pipeline_advance_MW;

    //for rn, data pipeline always advances
    assign pipeline_advance = 1'b1;

    //can change control pipelining depending on if stalling is implemented
    assign pipeline_advance_FD = pipeline_advance;
    assign pipeline_advance_DE = pipeline_advance;
    assign pipeline_advance_EM = pipeline_advance;
    assign pipeline_advance_MW = pipeline_advance;

    // Before the first clock, halt is asserted by default since no valid OPCODE has come from the fetch pipeline yet
    // Thus we have to wait for the first clock
    assign halt_D = (halt && (PC != '0));

    // once halt gets to end of pipeline, can stop CPU
    // (all instructions have fully gone through pipeline)
    assign ohalt = halt_W;

    //branch logic
    assign branch_taken = branch_en_E && zero_flag; //is the branch taken?

    //Control Hazard Handling
    assign flush_FD = branch_taken; //flush IF/ID pipeline reg if branch taken by inserting NOP
    assign flush_DE = branch_taken; //flush ID/EX pipeline reg if branch taken by resetting control signals

    //==================================================================================================================== 
    // < IF STARTS HERE >

    //next pc logic
    pc #(
        .WIDTH(32)
    ) pc_reg (
        .d(PC_target),
        .clk(clk),
        .rst(rst),
        .wr_en(branch_taken), //normally, PC increments by 4 each cycle, but if branch taken, load PC_target
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

    //deciding whether to flush instruction or not
    assign INSTR_REAL = flush_FD ? 32'h00000013 : INSTR; //if flushing, replace instruction with NOP (ADDI x0, x0, 0)

    //preparing data for pipeline reg
    assign f2d_data_F = {INSTR_REAL, PC};

//pipeline register
/* < IF/ID > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(64)
    ) instruction_reg (
        .d(f2d_data_F),
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_FD),
        .q(f2d_data_D)
    );

//====================================================================================================================    

    //unpacking IF/ID pipeline reg
    assign {INSTR_D, PC_D} = f2d_data_D;

    //given no seq engine, ID goes str8 into ustore
    UID__ my_uid ( .instr (INSTR_D), .uip(UIP) );
    US__ my_ustore ( .uip(UIP), .sig(sig) );
    //sig is all the control signals, see sig_declar.inc or "SIG" section in microcode for list

    //muxing of reg addrs, and imediates
    id_t my_id_t (
            .instr(INSTR_D),
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
        .rd_wr_en(reg_file_wr_en_W),
        .rd_addr(RD_W),
        .rd_data(RD_DATA), 
        .clk(clk),
        .rst(rst)
    );

    //preparing data and control signals for pipeline reg
    assign d2e_data_D = {RS1_DATA, RS2_DATA, IM, RD, PC_D};
    assign d2e_control_D = {
        alu_use_im,
        alu_sel_add,
        alu_sel_sub,
        alu_sel_mul,
        alu_sel_mulh,
        alu_sel_mulhsu,
        alu_sel_mulhu,
        alu_sel_and,
        alu_sel_or,
        alu_sel_slt,
        branch_en,
        data_mem_wr_en,
        dbus_sel_alu,
        dbus_sel_data_mem,
        reg_file_wr_en,
        halt_D
    };

/* < ID/EX > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(133)
    ) id_ex_reg (
        .d(d2e_data_D),      // Include IM in pipeline
        .clk(clk),
        .rst(rst && !flush_DE), //flush on branch taken (DeMorgan's law for active low reset)
        .wr_en(pipeline_advance_DE),
        .q(d2e_data_E)
    );

    dff_async_reset #(
        .WIDTH(16)
    ) id_ex_control_reg (
        .d(d2e_control_D),      // Include control signals in pipeline
        .clk(clk),
        .rst(rst && !flush_DE), //flush on branch taken (DeMorgan's law for active low reset)
        .wr_en(pipeline_advance_DE),
        .q(d2e_control_E)
    );

//==================================================================================================================== 

    //unpacking data and control signals from pipeline reg
    assign {RS1_DATA_E, RS2_DATA_E, IM_E, RD_E, PC_E} = d2e_data_E;
    assign {
        alu_use_im_E,
        alu_sel_add_E,
        alu_sel_sub_E,
        alu_sel_mul_E,
        alu_sel_mulh_E,
        alu_sel_mulhsu_E,
        alu_sel_mulhu_E,
        alu_sel_and_E,
        alu_sel_or_E,
        alu_sel_slt_E,
        branch_en_E,
        data_mem_wr_en_E,
        dbus_sel_alu_E,
        dbus_sel_data_mem_E,
        reg_file_wr_en_E,
        halt_E
    } = d2e_control_E;

    /* < ALU STARTS HERE > */

    /* Please note NOP's are a pseudoinstruction in RISC-V handled by the assembler as an ADDI of 0 with the zero register
    back into the zero register, and it likely doesn't need its own signal. Also it may be worth considering using func3 
    and func7 instead of individual signals to reduce the number of signals being passed into the module. */

    alu #(
        .WIDTH(32)
    ) alu_again_colon_closing_parenthesis (
        .operand_a(RS1_DATA_E),
        .operand_b(
            alu_use_im_E ? IM_E : RS2_DATA_E   // IM changed to IM_E
            ),
        .alu_sel_add(alu_sel_add_E),
        .alu_sel_sub(alu_sel_sub_E),
        .alu_sel_mul(alu_sel_mul_E),
        .alu_sel_mulh(alu_sel_mulh_E),
        .alu_sel_mulhsu(alu_sel_mulhsu_E),
        .alu_sel_mulhu(alu_sel_mulh_E),
        .alu_sel_and(alu_sel_and_E),
        .alu_sel_or(alu_sel_or_E),
        .alu_sel_slt(alu_sel_slt_E),
        .zero_flag(zero_flag),
        .result(ALU)
    );

    //calculating target PC for branches
    assign PC_target = PC_E + IM_E; //

    //preparing data and control signals for pipeline reg
    assign e2m_data_E = {ALU, RS2_DATA_E, RD_E};
    assign e2m_control_E = {
        data_mem_wr_en_E,
        dbus_sel_alu_E,
        dbus_sel_data_mem_E,
        reg_file_wr_en_E,
        halt_E
    };    

/* < EX/MEM > */ //====================================================================================================

    //not sure but i think we may not need a pipeline reg here because of the nature of the data_mem
    dff_async_reset #(
        .WIDTH(69)
    ) ex_mem_reg (
        .d(e2m_data_E),       
        .clk(clk),                   
        .rst(rst),
        .wr_en(pipeline_advance_EM),
        .q(e2m_data_M)
    );

    dff_async_reset #(
        .WIDTH(5)
    ) ex_mem_control_reg (
        .d(e2m_control_E),      // Include control signals in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_EM),
        .q(e2m_control_M)
    );

//==================================================================================================================== 

    //unpacking data and control signals from pipeline reg
    assign {ALU_M, RS2_DATA_M, RD_M} = e2m_data_M;
    assign {
        data_mem_wr_en_M,
        dbus_sel_alu_M,
        dbus_sel_data_mem_M,
        reg_file_wr_en_M,
        halt_M
    } = e2m_control_M;     

    //should be converted to proper RAM at some point
    data_memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(32)
    ) data_mem (
        .readAddr(ALU_M),
        .writeAddr(ALU_M),
        .writeData(RS2_DATA_M),
        .writeEn(data_mem_wr_en_M),
        .readData(DATA_MEM_OUT),
        .clk(clk)
    );

    //preparing data and control signals for pipeline reg
    assign m2w_data_M = {ALU_M, DATA_MEM_OUT, RD_M};
    assign m2w_control_M = {
        dbus_sel_alu_M,
        dbus_sel_data_mem_M,
        reg_file_wr_en_M,
        halt_M
    };        

/* < MEM/WB > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(69)
    ) mem_wb_reg (
        .d(m2w_data_M),
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_MW),
        .q(m2w_data_W)
    );

    dff_async_reset #(
        .WIDTH(4)
    ) mem_wb_control_reg (
        .d(m2w_control_M),      // Include control signals in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_MW),
        .q(m2w_control_W)
    );

//====================================================================================================================     

    //unpacking data and control signals from pipeline reg
    assign {ALU_W, DATA_MEM_OUT_W, RD_W} = m2w_data_W;
    assign {
        dbus_sel_alu_W,
        dbus_sel_data_mem_W,
        reg_file_wr_en_W,
        halt_W
    } = m2w_control_W;         

    //dbus mux
    always_comb begin
        unique case (1'b1)

        dbus_sel_alu_W        : RD_DATA = ALU_W;
        dbus_sel_data_mem_W   : RD_DATA = DATA_MEM_OUT_W;

        default : RD_DATA = '0;
        endcase
    end


endmodule
