module top_riscv_cpu ();

  logic clk;
  logic rst;
  logic                 halt;

  riscv_cpu CPU
        ( .clk(clk), .rst(rst),
          .ohalt(halt)
        );

  // initialize clk
  initial clk = 1'b0;

  // clocking in one line - take that Prof Abraham
  always #500 clk <= !clk;

   // How long should our test run 
   // this is our failsafe end to catch runaway programs
   initial begin
      repeat(10000) @(posedge clk) ; // lots of positive edges
     assert( halt ) 
       else $error("Running away code");
      $stop ;
   end

    //Debug
    always @(posedge clk) begin
     #1 
      //every clock or stage show these things (can be changed)
      $write("%d STAGE     pc:%h IR:%h IR_D:%h ", $time, CPU.PC,     CPU.INSTR, CPU.INSTR_D );

      //I used to see if pipelining was working, can't really tell anything else from these:
      
      //$write( " F %h", CPU.f2d_data_F );
      //$write( " D %h", CPU.d2e_data_D );
      //$write( " E %h", CPU.e2m_data_E );
      //$write( " M %h", CPU.m2w_data_M );
      //$write( " W %h", CPU.m2w_data_W );
      
      //$write( " D %h", CPU.d2e_control_D );
      //$write( " E %h", CPU.e2m_control_E );
      //$write( " M %h", CPU.m2w_control_M );
      //$write( " W %h", CPU.m2w_control_W );
      
      $display(""); //this on its own is just a "/n"

      //Most signals in the Decode stage dont have '_D' since thats where they originate from
      //but signals that propagate through the other stages will take on the letters of the stage like
      //CPU.RS2_DATA_E or CPU.ALU_M
      //CPU design shows it a little better
      
      //To check what's happening with specific signals that pass through different stages:
      
      //$display("Reg A address in Decode stage", CPU.RS1);
      //$display("Reg B address in Decode stage", CPU.RS2);
      //$display("Immediate out", CPU.IM);
      //$display("Reg A Out in Decode %h and Execute %h stages", CPU.RS1_DATA, CPU.RS1_DATA_E);
      //$display("Reg B Out in Decode %h and Execute %h stages", CPU.RS2_DATA, CPU.RS2_DATA_E);
      //$display("mem x4 %h mem x8 %h", CPU.data_mem.mem[4], CPU.data_mem.mem[8]);
      
      $display("");
    end

    //If instructions are finished...
    always @(negedge clk) begin    
      if (halt)
      begin
       #100 
       $stop;    
      end
    end
  
  
    // at the end, dump non-zero memory...
    int i;

    final begin
      // Look at the dump output and look for what you expect
      
      $display("Core dump at%8d \n ", $time );
      // skip unused memory
      
      $display(" Instruction Memory " );
      for (i=0; i < 2048; i++ ) begin
        if ( CPU.instr_mem.instr_mem[ i ] >= 0 )
        begin
          $display(" addr:%3h val:%h ",   i,CPU.instr_mem.instr_mem[i] );
        end
      end
      $display("\n");
      
      $display(" Data Memory " );
      for (i=0; i < 2048; i++ ) begin
        if ( CPU.data_mem.mem[ i ] >= 0 )
        begin
          $display(" addr:%h val:%h ",   i,CPU.data_mem.mem[i] );
        end
      end      
      
      $display("\n");
      
      $display(" Register File " );
      for (i=0; i < 2048; i++ ) begin
        if ( CPU.my_reg_file.regs_out[ i ] >= 0 )
        begin
          $display(" addr:%h val:%h ",   i,CPU.my_reg_file.regs_out[i] );
        end
      end          
    end
  
  //initial reset of CPU
  initial begin

    rst = 1'b0;
    // resets about 4-5 times before run of CPU program. Please keep in mind
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    #5
    rst = 1'b1;

   end


endmodule // top_cpu2v1
