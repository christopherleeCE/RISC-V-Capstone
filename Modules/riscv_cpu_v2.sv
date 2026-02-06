//TODO confirm buses are right,
//TODO better comments for logic declarations

//this makes it so that the compiler will throw an error if we try to use a signal/bus that has not been declared,
//this will help avoid errors where an undeclared bus gets implicitly declared as a wire
// `default_nettype none

//prototype of basic pattern
module riscv_cpu_v2
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
    logic [31:0] PC_plus_4_E;      //PC + 4 (needed for JAL)
    logic [31:0] PC_plus_4_M;
    logic [31:0] PC_plus_4_W;
    logic [31:0] INSTR_F;           //IF instruction from instruction memory, before flush
    logic [31:0] INSTR_F_FLUSH;    //IF instruction after deciding whether to flush or not
    logic [31:0] INSTR_D;           //ID instruction after pipeline reg, before flush
    logic [31:0] INSTR_D_FLUSH;     //ID instruction after pipeline reg, after flush
    logic [UIP_WIDTH-1:0] UIP;
    logic [4:0] RS1;               //read addr of regfile 
    logic [4:0] RS1_E;            //read addr of regfile after pipeline reg
    logic [31:0] RS1_DATA;          //read1 from regfile
    logic [31:0] RS1_DATA_FWD;      //read1 from regfile after data hazard forwarding
    logic [31:0] RS1_DATA_E;       //read1 from regfile after pipeline reg
    logic [31:0] RS1_DATA_E_FWD;   //read1 from regfile after data hazard forwarding]
    logic [4:0] RS2;               //read addr of regfile
    logic [4:0] RS2_E;            //read addr of regfile after pipeline reg
    logic [31:0] RS2_DATA;          //read2 from regfile
    logic [31:0] RS2_DATA_FWD;      //read2 from regfile after data hazard forwarding
    logic [31:0] RS2_DATA_E;       //read2 from regfile after pipeline reg
    logic [31:0] RS2_DATA_E_FWD;   //read2 from regfile after data hazard forwarding
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
    logic less_than;              //from alu, is op1 < op2? (for signed comparisons)

    logic branch_taken;          //is a branch taken?
    logic redirect_pc;           //should the PC be redirected?

    logic [63:0] f2d_data_F;          //fetch to decode data signals
    logic [63:0] f2d_data_D;       //fetch to decode post pipeline    

    logic [142:0] d2e_data_D;          //decode to execute data signals
    logic [21:0] d2e_control_D;       //decode to execute control signals
    logic [142:0] d2e_data_E;       //decode to execute post pipeline
    logic [21:0] d2e_control_E;    //decode to execute control signals post pipeline

    logic [100:0] e2m_data_E;          //execute to memory data signals
    logic [5:0] e2m_control_E;       //execute to memory control signals
    logic [100:0] e2m_data_M;       //execute to memory post pipeline
    logic [5:0] e2m_control_M;    //execute to memory control signals post pipeline  

    logic [100:0] m2w_data_M;          //memory to writeback data signals
    logic [4:0] m2w_control_M;       //memory to writeback control signals
    logic [100:0] m2w_data_W;       //memory to writeback post pipeline
    logic [4:0] m2w_control_W;    //memory to writeback control signals post pipeline    

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
    logic alu_sel_xor_E;
    logic alu_sel_slt_E;
    logic alu_sel_sltu_E;
    logic branch_eq_E;
    logic branch_neq_E;
    logic branch_lt_E;
    logic branch_gte_E;
    logic data_mem_wr_en_E;
    logic dbus_sel_alu_E;
    logic dbus_sel_data_mem_E;
    logic dbus_sel_pc_plus_4_E;

    //control signals after 2 pipeline regs
    logic data_mem_wr_en_M;
    logic dbus_sel_alu_M;
    logic dbus_sel_data_mem_M;
    logic dbus_sel_pc_plus_4_M;
    logic reg_file_wr_en_M;

    //control signals after 3 pipeline regs
    logic dbus_sel_alu_W;
    logic dbus_sel_data_mem_W;
    logic dbus_sel_pc_plus_4_W;
    logic reg_file_wr_en_W;

    // halt goes through pipeline
    logic halt_D, halt_E, halt_M, halt_W;

    // flush signals for control hazard handling
    logic flush_FD, flush_DE;  

    // data hazard case signals
    logic R1_case_dm2alu;
    logic R1_case_rf2alu;
    logic R1_case_rf2rf;
    logic R2_case_dm2alu;
    logic R2_case_rf2alu;
    logic R2_case_rf2rf;

    // pipeline advance for data signals
    logic pipeline_advance; //when high, pipeline regs advance

    // separate advance signals for control pipeline regs
    logic pipeline_advance_FD;
    logic pipeline_advance_DE; 
    logic pipeline_advance_EM;
    logic pipeline_advance_MW;

    //for rn, pipeline always advances
    assign pipeline_advance = 1'b1;

    //can change specific stage register depending on if stalling is implemented
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

    //conditional and unconditional branch logic
    assign branch_taken = ( ( branch_eq_E && zero_flag ) ||
                             ( branch_neq_E && !zero_flag ) ||
                             ( branch_lt_E && less_than ) ||
                             ( branch_gte_E && !less_than )    ); //is the branch taken?
    assign redirect_pc = branch_taken || jump_en; //should the PC be redirected?

    //Control Hazard Handling
    assign flush_FD = redirect_pc; //flush IF/ID pipeline reg if branch or jump taken by inserting NOP
    assign flush_DE = branch_taken; //flush ID/EX pipeline reg if branch taken by inserting NOP

    //Data Hazard Handling (might put in another module)
    //detecting data hazards for RS1
    assign R1_case_dm2alu = (reg_file_wr_en_M && 
                            (RD_M != 5'd0) && 
                            (RD_M == RS1_E)    );    //Hazard Description: Correct data still in MEM, needed in EX
    assign R1_case_rf2alu = (reg_file_wr_en_W && 
                            (RD_W != 5'd0) && 
                            (RD_W == RS1_E)    );    //Hazard Description: Correct data still in WB, needed in EX
    assign R1_case_rf2rf = (reg_file_wr_en_W && 
                            (RD_W != 5'd0) && 
                            (RD_W == RS1)    );      //Hazard Description: Correct data still in WB, needed in ID

    //detecting data hazards for RS2
    assign R2_case_dm2alu = (reg_file_wr_en_M && 
                            (RD_M != 5'd0) && 
                            (RD_M == RS2_E)    );
    assign R2_case_rf2alu = (reg_file_wr_en_W && 
                            (RD_W != 5'd0) && 
                            (RD_W == RS2_E)    );
    assign R2_case_rf2rf = (reg_file_wr_en_W && 
                            (RD_W != 5'd0) && 
                            (RD_W == RS2)    );

    //==================================================================================================================== 
    // < IF STARTS HERE >

    //next pc logic
    pc #(
        .WIDTH(32)
    ) pc_reg (
        .d(PC_target),
        .clk(clk),
        .rst(rst),
        .wr_en(redirect_pc), //normally, PC increments by 4 each cycle, but if branch/jump taken, load PC_target
        .q(PC)
    );

    //should be converted to proper ROM at some point
    //as of rn idk if its async or not
    // response - This should now function as a ROM, and I believe it's async (no clk needed)
    instruction_memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(512)
    ) instr_mem (
        .read_address(PC),
        .read_data(INSTR_F)
    );

    //deciding whether to flush instruction or not
    assign INSTR_F_FLUSH = flush_FD ? 32'h00000013 : INSTR_F; //if flushing, replace instruction with NOP (ADDI x0, x0, 0)

    //preparing data for pipeline reg
    assign f2d_data_F = {INSTR_F_FLUSH, PC};

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

    //deciding whether to flush instruction or not
    assign INSTR_D_FLUSH = flush_DE ? 32'h00000013 : INSTR_D; //if flushing, replace instruction with NOP 

    //given no seq engine, ID goes str8 into ustore
    UID__ my_uid ( .instr (INSTR_D_FLUSH), .uip(UIP) );
    US__ my_ustore ( .uip(UIP), .sig(sig) );
    //sig is all the control signals, see sig_declar.inc or "SIG" section in microcode for list

    //muxing of reg addrs, and imediates
    id_t my_id_t (
            .instr(INSTR_D_FLUSH),
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

    //Data Hazard Forwarding for Register File Read
    assign RS1_DATA_FWD = (R1_case_rf2rf) ? RD_DATA : RS1_DATA;     //Before WB clock, take from RD_DATA if data about to be written is needed immediately
    assign RS2_DATA_FWD = (R2_case_rf2rf) ? RD_DATA : RS2_DATA;     //Before WB clock, take from RD_DATA if data about to be written is needed immediately

    //preparing data and control signals for pipeline reg
    assign d2e_data_D = {RS1_DATA_FWD, RS2_DATA_FWD, IM, RD, PC_D, RS1, RS2};
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
        alu_sel_xor,
        alu_sel_slt,
        alu_sel_sltu,
        branch_eq,
        branch_neq,
        branch_lt,
        branch_gte,
        data_mem_wr_en,
        dbus_sel_alu,
        dbus_sel_data_mem,
        dbus_sel_pc_plus_4,
        reg_file_wr_en,
        halt_D
    };

/* < ID/EX > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(143)
    ) id_ex_reg (
        .d(d2e_data_D),      // Include IM in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_DE),
        .q(d2e_data_E)
    );

    dff_async_reset #(
        .WIDTH(22)
    ) id_ex_control_reg (
        .d(d2e_control_D),      // Include control signals in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_DE),
        .q(d2e_control_E)
    );

//==================================================================================================================== 

    //unpacking data and control signals from pipeline reg
    assign {RS1_DATA_E, RS2_DATA_E, IM_E, RD_E, PC_E, RS1_E, RS2_E} = d2e_data_E;
    assign PC_plus_4_E = PC_E + 32'd4;
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
        alu_sel_xor_E,
        alu_sel_slt_E,
        alu_sel_sltu_E,
        branch_eq_E,
        branch_neq_E,
        branch_lt_E,
        branch_gte_E,
        data_mem_wr_en_E,
        dbus_sel_alu_E,
        dbus_sel_data_mem_E,
        dbus_sel_pc_plus_4_E,
        reg_file_wr_en_E,
        halt_E
    } = d2e_control_E;

    //Data Hazard Forwarding MUXes for RS1
    always_comb begin
        priority case (1'b1)

        (R1_case_dm2alu && dbus_sel_alu_M) : RS1_DATA_E_FWD = ALU_M;         //Take from ALU_M if needed in EX stage and was gotten from ALU
        (R1_case_dm2alu && dbus_sel_data_mem_M)  : RS1_DATA_E_FWD = DATA_MEM_OUT;  //Take from DATA_MEM_OUT if needed in EX stage and was gotten from Data Memory
        (R1_case_dm2alu && dbus_sel_pc_plus_4_M)  : RS1_DATA_E_FWD = PC_plus_4_M;  //Take from PC_plus_4_M if needed in EX stage and was gotten from PC+4
        R1_case_rf2alu : RS1_DATA_E_FWD = RD_DATA;                                //Take from RD_DATA if needed in EX stage and was about to be written in WB stage

        default : RS1_DATA_E_FWD = RS1_DATA_E;
        endcase
    end

    //Data Hazard Forwarding MUXes for RS2
    always_comb begin
        priority case (1'b1)

        (R2_case_dm2alu && dbus_sel_alu_M) : RS2_DATA_E_FWD = ALU_M;
        (R2_case_dm2alu && dbus_sel_data_mem_M)  : RS2_DATA_E_FWD = DATA_MEM_OUT; 
        (R2_case_dm2alu && dbus_sel_pc_plus_4_M)  : RS2_DATA_E_FWD = PC_plus_4_M;       
        R2_case_rf2alu : RS2_DATA_E_FWD = RD_DATA;

        default : RS2_DATA_E_FWD = RS2_DATA_E;
        endcase
    end

    /* < ALU STARTS HERE > */
    alu #(
        .WIDTH(32)
    ) my_alu (
        .operand_a(RS1_DATA_E_FWD),
        .operand_b(
            alu_use_im_E ? IM_E : RS2_DATA_E_FWD   // IM changed to IM_E
            ),
        .alu_sel_add(alu_sel_add_E),
        .alu_sel_sub(alu_sel_sub_E),
        .alu_sel_mul(alu_sel_mul_E),
        .alu_sel_mulh(alu_sel_mulh_E),
        .alu_sel_mulhsu(alu_sel_mulhsu_E),
        .alu_sel_mulhu(alu_sel_mulhu_E),
        .alu_sel_and(alu_sel_and_E),
        .alu_sel_or(alu_sel_or_E),
        .alu_sel_xor(alu_sel_xor_E),
        .alu_sel_slt(alu_sel_slt_E),
        .alu_sel_sltu(alu_sel_sltu_E),
        .zero_flag(zero_flag),
        .less_than(less_than),
        .result(ALU)
    );

    //calculating target PC for branches and jumps
    assign PC_target = (alu_sel_add_E) ? ALU : PC_E + IM_E; //left is for JALR, right for branches and JAL

    //preparing data and control signals for pipeline reg
    assign e2m_data_E = {ALU, RS2_DATA_E_FWD, RD_E, PC_plus_4_E};
    assign e2m_control_E = {
        data_mem_wr_en_E,
        dbus_sel_alu_E,
        dbus_sel_data_mem_E,
        dbus_sel_pc_plus_4_E,
        reg_file_wr_en_E,
        halt_E
    };    

/* < EX/MEM > */ //====================================================================================================

    //not sure but i think we may not need a pipeline reg here because of the nature of the data_mem
    dff_async_reset #(
        .WIDTH(101)
    ) ex_mem_reg (
        .d(e2m_data_E),       
        .clk(clk),                   
        .rst(rst),
        .wr_en(pipeline_advance_EM),
        .q(e2m_data_M)
    );

    dff_async_reset #(
        .WIDTH(6)
    ) ex_mem_control_reg (
        .d(e2m_control_E),      // Include control signals in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_EM),
        .q(e2m_control_M)
    );

//==================================================================================================================== 

    //unpacking data and control signals from pipeline reg
    assign {ALU_M, RS2_DATA_M, RD_M, PC_plus_4_M} = e2m_data_M;
    assign {
        data_mem_wr_en_M,
        dbus_sel_alu_M,
        dbus_sel_data_mem_M,
        dbus_sel_pc_plus_4_M,
        reg_file_wr_en_M,
        halt_M
    } = e2m_control_M;     

    //TODO i think EC = 32 might mean we only have words 32 of datamem, mabye increase at some point
    //TODO implement rst, in current state data mem entries are initialized to 0xXXXXXXXX
    //-chris
    data_memory #(
        .BIT_WIDTH(32),
        .ENTRY_COUNT(255)
    ) my_data_mem (
        .readAddr(ALU_M),
        .writeAddr(ALU_M),
        .writeData(RS2_DATA_M),
        .writeEn(data_mem_wr_en_M),
        .readData(DATA_MEM_OUT),
        .clk(clk)
    );

    //preparing data and control signals for pipeline reg
    assign m2w_data_M = {ALU_M, DATA_MEM_OUT, RD_M, PC_plus_4_M};
    assign m2w_control_M = {
        dbus_sel_alu_M,
        dbus_sel_data_mem_M,
        dbus_sel_pc_plus_4_M,
        reg_file_wr_en_M,
        halt_M
    };        

/* < MEM/WB > */ //====================================================================================================

    dff_async_reset #(
        .WIDTH(101)
    ) mem_wb_reg (
        .d(m2w_data_M),
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_MW),
        .q(m2w_data_W)
    );

    dff_async_reset #(
        .WIDTH(5)
    ) mem_wb_control_reg (
        .d(m2w_control_M),      // Include control signals in pipeline
        .clk(clk),
        .rst(rst),
        .wr_en(pipeline_advance_MW),
        .q(m2w_control_W)
    );

//====================================================================================================================     

    //unpacking data and control signals from pipeline reg
    assign {ALU_W, DATA_MEM_OUT_W, RD_W, PC_plus_4_W} = m2w_data_W;
    assign {
        dbus_sel_alu_W,
        dbus_sel_data_mem_W,
        dbus_sel_pc_plus_4_W,
        reg_file_wr_en_W,
        halt_W
    } = m2w_control_W;         

    //dbus mux
    always_comb begin
        unique case (1'b1)

        dbus_sel_alu_W        : RD_DATA = ALU_W;
        dbus_sel_data_mem_W   : RD_DATA = DATA_MEM_OUT_W;
        dbus_sel_pc_plus_4_W  : RD_DATA = PC_plus_4_W;

        default : RD_DATA = '0;
        endcase
    end


endmodule
