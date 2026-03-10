//TODO when bram gets implemented make sure that aliasing is not an issue

module data_memory
  #( 
     parameter int BIT_WIDTH,
     parameter int ADDR_WIDTH=32 
     )
   (
    input  logic [ADDR_WIDTH-1:0] addr,
    input  logic [BIT_WIDTH-1:0] writeData,
    input  logic          writeEn,
    output logic [BIT_WIDTH-1:0] readData,
    input  logic          clk,
    input  logic          rst,
    input  logic          addr_byte,          //are we reading/writing a byte, half-word, or word?
    input  logic          addr_half,
    input  logic          zero_extend           //should we zero-extend the data read from memory
    );

   // byteena and halfena signals for data memory
   logic [3:0] byteena_temp, halfena_temp, byteena_sig;

   // the word read from memory
   logic [BIT_WIDTH-1:0] readWord, data_out_mem;          

   // byte read from memory         
   logic [7:0] data_byte_r;                              

   // half-word read from memory
   logic [15:0] data_half_r;                         

   /* < Writing to MEM > */ //====================================================================================================

   // select the appropriate byte based on the address
   always_comb begin
      unique case (addr[1:0])
            2'b00	:	byteena_temp = 4'b0001;
            2'b01	:	byteena_temp = 4'b0010;
            2'b10	:	byteena_temp = 4'b0100;
            2'b11	:	byteena_temp = 4'b1000;
            default	:	byteena_temp = 4'b0001;
      endcase
   end

   // select the appropriate half-word based on the address
   assign halfena_temp = addr[1] ? 4'b1100 : 4'b0011;

   // are we writing a byte, half-word, or word?
   always_comb begin
      unique case ({addr_byte, addr_half})
            2'b10	:	byteena_sig = byteena_temp;
            2'b01	:	byteena_sig = halfena_temp;
            default	:	byteena_sig = 4'b1111;
      endcase
   end   

   /* < BRAM MEM > */ //====================================================================================================
   
   // mk9_ram_mif_aclr	mk9_ram_mif_aclr_inst (
   //    .aclr ( !rst ),
   //    .address ( addr[11:2] ),
   //    .byteena ( byteena_sig ),
   //    .clock ( clk ),
   //    .data ( writeData ),
   //    .wren ( writeEn ),
   //    .q ( data_out_mem )
   // );

   mk9_ram_mif	mk9_ram_mif_inst (
      .aclr ( !rst ),
      .address ( addr[11:2] ),
      .byteena ( byteena_sig ),
      .clock ( clk ),
      .data ( writeData ),
      .wren ( writeEn ),
      .q ( data_out_mem )
   );

   /* < Read from MEM > */ //==================================================================================================== 

   //preventing aliasing
   assign readWord = (addr[31:12] == '0) ? data_out_mem : '0;     

   // select the appropriate byte based on the address
   always_comb begin
      unique case (addr[1:0])
            2'b00	:	data_byte_r = readWord[7:0];
            2'b01	:	data_byte_r = readWord[15:8];
            2'b10	:	data_byte_r = readWord[23:16];
            2'b11	:	data_byte_r = readWord[31:24];
            default	:	data_byte_r = readWord[7:0];
      endcase
   end

   // select the appropriate half-word based on the address
   assign data_half_r = addr[1] ? readWord[31:16] : readWord[15:0];

   // are we reading a byte, half-word, or word?
   always_comb begin
      unique case ({addr_byte, addr_half})
            2'b10	:	readData = zero_extend ? {24'b0, data_byte_r} : {{24{data_byte_r[7]}}, data_byte_r};
            2'b01	:	readData = zero_extend ? {16'b0, data_half_r} : {{16{data_half_r[15]}}, data_half_r};
            default	:	readData = readWord;
      endcase
   end      

   
endmodule 
    