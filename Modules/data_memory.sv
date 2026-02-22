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

   // new word written to memory
   logic [BIT_WIDTH-1:0] writeByte, writeHalf;                       

    // byte read/written from/to memory
   logic [1:0] byte_select_r, byte_select_w;           
   logic [7:0] data_byte_r, data_byte_w;                              

   // half-word read/written from/to memory
   logic [15:0] data_half_r, data_half_w;

   // the data currently in memory at the write address
   logic [BIT_WIDTH-1:0] data_in_mem;                            

   //Need this to initialize the memory
   initial begin
      $readmemh("data_memory.txt", data_mem); //load the memory
   end

   /* < Read from MEM > */ //====================================================================================================   

   // read the word from memory
   assign readWord = data_mem[readAddr[ADDR_WIDTH-1:2]];

   // select the byte from the word based on the byte offset
   assign byte_select_r = readAddr[1:0];

   // select the appropriate byte based on the address
   always_comb begin
      unique case (byte_select_r)
         2'b00	:	data_byte_r = readWord[7:0];
         2'b01	:	data_byte_r = readWord[15:8];
         2'b10	:	data_byte_r = readWord[23:16];
         2'b11	:	data_byte_r = readWord[31:24];
         default	:	data_byte_r = readWord[7:0];
      endcase
   end

   // select the appropriate half-word based on the address
   assign data_half_r = byte_select_r[1] ? readWord[31:16] : readWord[15:0];

   // are we reading a byte, half-word, or word?
   always_comb begin
      unique case ({addr_byte, addr_half})
         2'b10	:	readData = zero_extend ? {24'b0, data_byte_r} : {{24{data_byte_r[7]}}, data_byte_r};
         2'b01	:	readData = zero_extend ? {16'b0, data_half_r} : {{16{data_half_r[15]}}, data_half_r};
         default	:	readData = readWord;
      endcase
   end

   /* < Write to MEM > */ //====================================================================================================

   // select the lower byte and half-word from the data to be written
   assign data_byte_w = writeData[7:0];
   assign data_half_w = writeData[15:0];

   // select the byte offset from the write address
   assign byte_select_w = writeAddr[1:0];

   // read the current word in memory at the write address
   assign data_in_mem = data_mem[writeAddr[ADDR_WIDTH-1:2]];

   // create the new word to be written to memory by replacing the appropriate byte
   always_comb begin
      unique case (byte_select_w)
         2'b00	:	writeByte = {data_in_mem[31:8], data_byte_w};
         2'b01	:	writeByte = {data_in_mem[31:16], data_byte_w, data_in_mem[7:0]};
         2'b10	:	writeByte = {data_in_mem[31:24], data_byte_w, data_in_mem[15:0]};
         2'b11	:	writeByte = {data_byte_w, data_in_mem[23:0]};
         default	:	writeByte = {data_in_mem[31:8], data_byte_w};
      endcase
   end   

   // create the new word to be written to memory by replacing the appropriate half-word
   assign writeHalf = byte_select_w[1] ? {data_half_w, data_in_mem[15:0]} : {data_in_mem[31:16], data_half_w};

   // write the new word to memory on the rising edge of the clock if write enable is high
   always @(posedge clk) begin
      if (writeEn) begin
         if (addr_byte) begin
            data_mem[writeAddr[ADDR_WIDTH-1:2]] <= writeByte;
         end
         else if (addr_half) begin
            data_mem[writeAddr[ADDR_WIDTH-1:2]] <= writeHalf;
         end
         else begin
            data_mem[writeAddr[ADDR_WIDTH-1:2]] <= writeData;
         end
      end
   end

   
endmodule 
    