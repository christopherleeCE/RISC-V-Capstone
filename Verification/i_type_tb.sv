/*
TESTING: ADDI, LW

We can have a main TB for the CPU if we really need to, but I like the idea of smaller, seperate TBs for each instruction 
type. In theory, each type will have a similar datapath, so in theory, each type could use a similar verification process,
I'll have to see for sure though.

I have a couple ideas for a TB but I have to figure out the implementation and see if it works. I'll be focused on these 
instructions for now; to others doing verification, please feel free to test the other instructions, thank you!

*/

`timescale 1ns/1ns

module i_type_tb ();
//constants
parameter int CLOCK_PERIOD = 20;
parameter int NUM_INSTRUCTIONS = 2; //Will go up to 14 for all I-type
parameter int NUM_DATA_WORDS = 3;

//declare the buses and signals
logic clk, rst;
reg [31:0] instruction_memory [NUM_INSTRUCTIONS-1:0];
reg [31:0] data_memory [NUM_DATA_WORDS-1:0];

//golden model
int instruction_track; //NOT the program counter, only for verification
logic [31:0] inst_fetch; //instruction being fetched
logic [31:0] if_id, id_ex, ex_mem, mem_wb, post_wb; //transferring instructions

//I-type
logic [11:0] imm;
logic [4:0] rs1, rd;
logic [2:0] func3;
logic [6:0] opcode;


//instantiate the CPU
riscv_cpu cpu_dut(.clk(clk), .rst(rst));


//booting the memory and starting
initial begin
    //WARNING - reset could potentially mask bugs, so I will leave it off for now
    // rst = 1'b0; //reset the CPU and golden model during startup
    instruction_track = 0;
    clk = 1'b0;

    // list the instructions here:
    instruction_memory[NUM_INSTRUCTIONS-1:0] = 
    '{
        32'h0000a103, //lw x2, 0(x1),
        32'h00300093 //addi x1, x0, 3
    };

    //list the data memory here:
    data_memory[NUM_DATA_WORDS-1:0] =
    '{
        32'hdeadbeef,
        32'h000000ff,
        32'hdeadbeef
    };
    
    $writememh("instruction_memory.txt", instruction_memory); //transfer to instruction memory of CPU
    $writememh("data_memory.txt", data_memory); //transfer to data memory of CPU

    #1 //brief delay for setup
    rst = 1'b1; //disable the reset
    forever begin //start the clock
        #CLOCK_PERIOD
        clk = ~clk;
    end
end


//transfering instructions - asynchronous to match CPU registers
//helps verification follow the CPU's pipeline
always@(posedge clk or negedge rst) begin
    if(!rst) begin //resets the pipeline and tracker
        {if_id, id_ex, ex_mem, mem_wb, post_wb} <= '0;
        instruction_track = 0;
    end else begin
        if (instruction_track <= NUM_INSTRUCTIONS-1) begin
            inst_fetch <= instruction_memory[instruction_track]; //advances instruction
        end else begin
            inst_fetch <= 32'hdeadbeef; //no more instructions
        end
        //continues advancing instructions
        if_id <= inst_fetch;
        id_ex <= if_id;
        ex_mem <= id_ex;
        mem_wb <= ex_mem;
        post_wb <= mem_wb;
        instruction_track += 1;
    end
end


//start simulation of the CPU
always @(negedge clk) begin
    $display("\nInstructions in pipeline:"); //seeing where the instructions are located
    $display("IF: %h, ID: %h, EX: %h, MEM: %h, WB: %h", inst_fetch, if_id, id_ex, ex_mem, mem_wb);

    if(post_wb == 32'hdeadbeef) begin
        $display("Verification complete.");
        $stop(); //program ends after all instructions are completed
    end else if (instruction_track > 5) begin
        //verification begins once first instruction has fully executed
        $display("Currently verifying: %h", post_wb);

        //break the instruction into components
        {imm, rs1, func3, rd, opcode} = post_wb;
        $display("imm: %b, rs1: %b, func3: %b, rd: %b, opcode: %b", imm, rs1, func3, rd, opcode);
        
        //identify the instruction and begin verification
        if (opcode == 7'b0010011) begin
            if(func3 == 3'b000) begin

                //ADDI
                $display("Identified as ADDI");
                assert(
                    cpu_dut.reg_file.regs_out(rd) == ({{20{imm[11]}},imm[11:0] } + cpu_dut.reg_file.regs_out(rs1))
                ) else $error("ADDI failed");

            end
        end else if (opcode == 7'b0000011) begin
           if(func3 == 3'b010) begin

                //LW 
                $display("Identified as LW");
           end
        end else begin
            $display("Not an I-type instruction");
        end
    end

end


endmodule