// This is the former memory module but renamed as the data memory
// This should function as a RAM due to its option to write to it
// A similar, read-only module has been created as the instruction memory

module data_memory
  #( 
     parameter int BIT_WIDTH,
     parameter int ENTRY_COUNT,
     parameter int ADDR_WIDTH=$clog2((BIT_WIDTH/8)*ENTRY_COUNT) //I think this is correct for byte-addressable mem. 
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
    