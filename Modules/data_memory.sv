
module data_memory
  #( 
      parameter int BIT_WIDTH,
      parameter int ADDR_WIDTH=32 
   )(
      input  logic [ADDR_WIDTH-1:0] addr,
      input  logic [BIT_WIDTH-1:0] writeData,
      input  logic          writeEn,
      output logic [BIT_WIDTH-1:0] readData,
      input  logic          clk,
      input  logic          rst,
      input  logic          addr_byte,          //are we reading/writing a byte, half-word, or word?
      input  logic          addr_half,
      input  logic          zero_extend,           //should we zero-extend the data read from memory

      input logic portb_rst,
      input logic [ADDR_WIDTH-1:0] portb_addr,
      input logic portb_clk,
      output logic [BIT_WIDTH-1:0] portb_q,
      input logic portb_addr_byte,
      input logic portb_addr_half,
      input logic portb_zero_extend
   );

   // byteena and halfena signals for data memory
   logic [3:0] byteena_temp, halfena_temp, byteena_sig;

   // the word read from memory
   logic [BIT_WIDTH-1:0] readWord, data_out_mem, readDataPreMask;          

   // byte read from memory         
   logic [7:0] data_byte_r;                              

   // half-word read from memory
   logic [15:0] data_half_r;             

   // new word written to memory
   logic [BIT_WIDTH-1:0] writeByte, writeHalf;   

   // the word written to memory
   logic [BIT_WIDTH-1:0] writeWord;  

   logic [ADDR_WIDTH-1:0] addr_internal_mirror;
   logic [BIT_WIDTH-1:0] write_data_internal_mirror, write_word_internal_mirror;
   // logic [3:0] byteena_sig_internal_mirror;
   logic addr_byte_internal_mirror;
   logic addr_half_internal_mirror;
   logic zero_extend_internal_mirror;

   logic [31:0] addr_internal_mirrorb;
   logic [31:0] data_out_memb;
   logic [31:0] readWordb;
   logic [7:0] data_byte_rb;
   logic [15:0] data_half_rb;
   logic [31:0] readDataPreMaskb;
   logic addr_byte_internal_mirrorb, addr_half_internal_mirrorb, zero_extend_internal_mirrorb;

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

   // create the new word to be written to memory by replacing the appropriate byte
   always_comb begin
      unique case (addr[1:0])
         2'b00	:	writeByte = writeData;
         2'b01	:	writeByte = writeData << 8;
         2'b10	:	writeByte = writeData << 16;
         2'b11	:	writeByte = writeData << 24;
         default	:	writeByte = writeData;
      endcase
   end   

   // create the new word to be written to memory by replacing the appropriate half-word
   assign writeHalf = addr[1] ? ( writeData << 16 ) : writeData;

   always_comb begin
      unique case ({addr_byte, addr_half})
            2'b10	:	writeWord = writeByte;
            2'b01	:	writeWord = writeHalf;
            default	:	writeWord = writeData;
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

   dff_async_reset #(
      .WIDTH(32)
   )addr_mirror(
      .d(addr),
      .clk(clk),
      .rst(rst),
      .wr_en(1'b1),
      .q(addr_internal_mirror)
   );

   dff_async_reset #(
      .WIDTH(32)
   )write_data_mirror(
      .d(writeData),
      .clk(clk),
      .rst(rst),
      .wr_en(1'b1),
      .q(write_data_internal_mirror)
   );

   dff_async_reset #(
      .WIDTH(32)
   )write_word_mirror(
      .d(writeData),
      .clk(clk),
      .rst(rst),
      .wr_en(1'b1),
      .q(write_word_internal_mirror)
   );

   dff_async_reset #(
      .WIDTH(1)
   )writeEn_mirror(
      .d(writeEn),
      .clk(clk),
      .rst(rst),
      .wr_en(1'b1),
      .q(writeEn_internal_mirror)
   );

   // dff_async_reset #(
   //    .WIDTH(4)
   // )byte_en_mirror(
   //    .d(byteena_sig),
   //    .clk(clk),
   //    .rst(rst),
   //    .wr_en(1'b1),
   //    .q(byteena_sig_internal_mirror)
   // );

   dff_async_reset #(
      .WIDTH(3)
   )addr_bye_half_mirror(
      .d({{addr_byte, addr_half, zero_extend}}),
      .clk(clk),
      .rst(rst),
      .wr_en(1'b1),
      .q({addr_byte_internal_mirror, addr_half_internal_mirror, zero_extend_internal_mirror})
   );

   // mk9_ram_mif	mk9_ram_mif_inst (
   //    .aclr ( !rst ),
   //    .address ( addr[11:2] ),
   //    .byteena ( byteena_sig ),
   //    .clock ( clk ),
   //    .data ( writeWord ),
   //    .wren ( writeEn ),
   //    .q ( data_out_mem )
   // );

   dff_async_reset #(
      .WIDTH(32)
   )addr_mirrorb(
      .d(portb_addr),
      .clk(portb_clk),
      .rst(portb_rst),
      .wr_en(1'b1),
      .q(addr_internal_mirrorb)
   );

   dff_async_reset #(
      .WIDTH(3)
   )addr_byte_half_mirrorb(
      .d({portb_addr_byte, portb_addr_half, portb_zero_extend}),
      .clk(portb_clk),
      .rst(portb_rst),
      .wr_en(1'b1),
      .q({addr_byte_internal_mirrorb, addr_half_internal_mirrorb, zero_extend_internal_mirrorb})
   );


   dual_mk9_ram_mif_aclr_80k my_dual_mk9_ram_mif(
      .aclr_a(!rst),
      .address_a(addr[16:2]),
      .byteena_a(byteena_sig),
      .clock_a(clk),
      .data_a(writeWord),
      .wren_a(writeEn),
      .q_a(data_out_mem),
      .aclr_b(!portb_rst),
      .address_b(portb_addr[16:2]),
      .clock_b(portb_clk),
      .data_b(32'b0),
      .wren_b(1'b0),
      .q_b(data_out_memb)
	);

   /* < Read from MEM > */ //==================================================================================================== 

   assign readWord = data_out_mem;
   assign readWordb = data_out_memb;    

   // select the appropriate byte based on the address
   always_comb begin
      unique case (addr_internal_mirror[1:0])
            2'b00	:	data_byte_r = readWord[7:0];
            2'b01	:	data_byte_r = readWord[15:8];
            2'b10	:	data_byte_r = readWord[23:16];
            2'b11	:	data_byte_r = readWord[31:24];
            default	:	data_byte_r = readWord[7:0];
      endcase
   end

   always_comb begin
      unique case (addr_internal_mirrorb[1:0])
            2'b00	:	data_byte_rb = readWordb[7:0];
            2'b01	:	data_byte_rb = readWordb[15:8];
            2'b10	:	data_byte_rb = readWordb[23:16];
            2'b11	:	data_byte_rb = readWordb[31:24];
            default	:	data_byte_rb = readWordb[7:0];
      endcase
   end

   // select the appropriate half-word based on the address
   assign data_half_r = addr_internal_mirror[1] ? readWord[31:16] : readWord[15:0];
   assign data_half_rb = addr_internal_mirrorb[1] ? readWordb[31:16] : readWordb[15:0];

   // are we reading a byte, half-word, or word?
   // always_comb begin
   //    unique case ({addr_byte_internal_mirror, addr_half_internal_mirror})
   //          2'b10	:	readData = zero_extend_internal_mirror ? {24'b0, data_byte_r} : {{24{data_byte_r[7]}}, data_byte_r};
   //          2'b01	:	readData = zero_extend_internal_mirror ? {16'b0, data_half_r} : {{16{data_half_r[15]}}, data_half_r};
   //          default	:	readData = readWord;
   //    endcase
   // end

   always_comb begin
      unique case ({addr_byte_internal_mirror, addr_half_internal_mirror})
            2'b10	:	readDataPreMask = zero_extend_internal_mirror ? {24'b0, data_byte_r} : {{24{data_byte_r[7]}}, data_byte_r};
            2'b01	:	readDataPreMask = zero_extend_internal_mirror ? {16'b0, data_half_r} : {{16{data_half_r[15]}}, data_half_r};
            default	:	readDataPreMask = readWord;
      endcase
   end

   always_comb begin
      unique case ({addr_byte_internal_mirrorb, addr_half_internal_mirrorb})
            2'b10	:	readDataPreMaskb = zero_extend_internal_mirrorb ? {24'b0, data_byte_rb} : {{24{data_byte_rb[7]}}, data_byte_rb};
            2'b01	:	readDataPreMaskb = zero_extend_internal_mirrorb ? {16'b0, data_half_rb} : {{16{data_half_rb[15]}}, data_half_rb};
            default	:	readDataPreMaskb = readWordb;
      endcase
   end

   // always_comb begin
   //    unique case ({addr_byte_internal_mirrorb})
   //          2'b1	:	readDataPreMaskb = {24'b0, data_byte_rb};
   //          default	:	readDataPreMaskb = readWordb;
   //    endcase
   // end

   //aliasing mask, less addr < exclusive top of 80kb (this intern_addr is normalized to virtual addr space of dmem blk)
   assign readData = (addr_internal_mirror < 32'h14000) ? readDataPreMask : 32'h0;
   assign portb_q = (addr_internal_mirrorb < 32'h14000) ? readDataPreMaskb : 32'h0;

   
endmodule 
    