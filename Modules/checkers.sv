module checkers
  #(
    parameter int pA = 10 ,
    parameter int fA = 32 ,
    parameter int cA = 4 
    )
    (
     input  logic [pA-1:0] pix_x ,
     input  logic [pA-1:0] pix_y ,
     input  logic          pix_v ,
     input  logic [fA-1:0] frame_id,
     output logic [cA-1:0] color[2:0],
     input  logic clk,
     input  logic rst
     );

   //assign color = ( pix_x[0] ^ pix_y[0] ^ frame_id[7] ) && pix_v ? '{4'hf,4'hf,4'hf} : '{4'h0,4'h0,4'h0} ;
	
	//4:1 mux, color = 0 if pix_v (valid) is low
	assign color[2] = pix_v ? ((pix_x[5] ^ pix_y[5] ^ 1'b1) ? 4'hf: 4'h0):4'h0;   
   assign color[1] = pix_v ? ((pix_x[5] ^ pix_y[5] ^ 1'b1) ? 4'hf: 4'h0):4'h0; 
   assign color[0] = pix_v ? ((pix_x[5] ^ pix_y[5] ^ 1'b1) ? 4'hf: 4'h0):4'h0;
   
endmodule //checkers