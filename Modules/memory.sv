module memory
  #( 
     parameter int BIT_WIDTH,
     parameter int ENTRY_COUNT,
     parameter int ADDR_WIDTH=$clog2(ENTRY_COUNT) 
     )
   (
    input  logic [ADDR_WIDTH-1:0] readAddr,
    input  logic [ADDR_WIDTH-1:0] writeAddr,
    input  logic [BIT_WIDTH-1:0] writeData,
    input  logic          writeEn,
    output logic [BIT_WIDTH-1:0] readData,
    input  logic          clk
    );

   logic [BIT_WIDTH-1:0] 	  mem[ENTRY_COUNT-1:0];

   assign readData = mem[readAddr];

   always @(posedge clk)
     if( writeEn )
       mem[writeAddr] <= writeData ; // probably should be non-blocking
   
endmodule 
    