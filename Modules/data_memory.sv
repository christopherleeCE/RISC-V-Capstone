// This is the former memory module but renamed as the data memory
// This should function as a RAM due to its option to write to it
// A similar, read-only module has been created as the instruction memory

module data_memory
  #( 
     parameter int BIT_WIDTH,
     parameter int ENTRY_COUNT,
     parameter int ADDR_WIDTH=32 
     )
   (
    input  logic [ADDR_WIDTH-1:0] readAddr,
    input  logic [ADDR_WIDTH-1:0] writeAddr,
    input  logic [BIT_WIDTH-1:0] writeData,
    input  logic          writeEn,
    output logic [BIT_WIDTH-1:0] readData,
    input  logic          clk,
    input  logic          addr_byte,          //are we reading/writing a byte, half-word, or word?
    input  logic          addr_half,
    input  logic          zero_extend           //should we zero-extend the data read from memory
    );

   logic [BIT_WIDTH-1:0] data_mem [ENTRY_COUNT-1:0];

   // the word read from memory
   logic [BIT_WIDTH-1:0] readWord;                       

    // the byte read from memory
   logic [1:0] byte_select;                              
   logic [7:0] data_byte_r;                              

   // the half-word read from memory
   logic [15:0] data_half_r;                            

   //Need this to initialize the memory
   initial begin
      $readmemh("data_memory.txt", data_mem); //load the memory
   end

   // read the word from memory
   assign readWord = data_mem[readAddr[ADDR_WIDTH-1:2]];

   // select the byte from the word based on the byte offset
   assign byte_select = readAddr[1:0];

   // select the appropriate byte based on the address
   always_comb begin
      unique case (byte_select)
         2'b00	:	data_byte_r = readWord[7:0];
         2'b01	:	data_byte_r = readWord[15:8];
         2'b10	:	data_byte_r = readWord[23:16];
         2'b11	:	data_byte_r = readWord[31:24];
         default	:	data_byte_r = readWord[7:0];
      endcase
   end

   // select the appropriate half-word based on the address
   assign data_half_r = byte_select[1] ? readWord[31:16] : readWord[15:0];

   // are we reading a byte, half-word, or word?
   always_comb begin
      unique case ({addr_byte, addr_half})
         2'b10	:	readData = zero_extend ? {24'b0, data_byte_r} : {{24{data_byte_r[7]}}, data_byte_r};
         2'b01	:	readData = zero_extend ? {16'b0, data_half_r} : {{16{data_half_r[15]}}, data_half_r};
         default	:	readData = readWord;
      endcase
   end

   always @(posedge clk) begin
      if( writeEn == 1'b1) begin
          data_mem[writeAddr[ADDR_WIDTH-1:2]] <= writeData ; // probably should be non-blocking
      end
   end

   
endmodule 
    