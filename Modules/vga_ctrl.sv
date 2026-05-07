//i stole this from eee333's lab 5, take clk should be 50mhz, even tho spec calls for 25mhz
//params modified as the defaults from the lab cut off the rightmost pixel
//spec says 640 and 48,  but if those values are used then then a pixel gets cut off, so 641 and 47 are used instead

module vga_ctrl #(
    parameter int PIX_AW = 10,
    parameter int FRM_AW = 6 
)(
    output logic [PIX_AW-1:0] pix_x,    //x_cord
    output logic [PIX_AW-1:0] pix_y,    //y_cord
    output logic              pix_vis,  //visible
    output logic [FRM_AW-1:0] frame_id, //frame num/60
    output logic hs,       //horz sync sig
    output logic vs,       //vert sync sig
    input  logic clk,      //50mhz clk
    input  logic rst       //active low
);

    //TAKEN FROM BASYS 3 DEMO
    localparam int FRAME_WIDTH  = 640+1;
    localparam int FRAME_HEIGHT = 480;
    localparam int FRAMES = 60;

    localparam int HPW = 96;    //hsync pulse length
    localparam int VPW = 2;     //vsync pulse length
    localparam int HBP = 48-1;  //end of horizontal back porch
    localparam int HFP = 16;    //beginning of horizontal front porch
    localparam int VBP = 33;    //end of vertical back porch
    localparam int VFP = 10;    //beginning of vertical front porch

    localparam int H_PIXELS = FRAME_WIDTH  + HPW + HFP + HBP; //horizontal pixels per line
    localparam int V_LINES  = FRAME_HEIGHT + VPW + VFP + VBP; //vertical lines per frame	
	
    logic [PIX_AW-1:0] count_x, count_y;
    logic row_return, img_return;

    //Generate the increments for the outer loop counters
    assign row_return = count_x == (H_PIXELS-1);
    assign img_return = (count_y == (V_LINES-1)) && row_return;

    //Yay for counters 
    counter #(PIX_AW, H_PIXELS) ctrX(.inc(1'b1),       .clk, .rst, .cnt(count_x) );
    counter #(PIX_AW, V_LINES)  ctrY(.inc(row_return), .clk, .rst, .cnt(count_y) );
    counter #(FRM_AW, FRAMES)   ctrF(.inc(img_return), .clk, .rst, .cnt(frame_id));

    //Generate the sync pulses
    assign hs = !(count_x >= (HFP+HBP+FRAME_WIDTH) );
    assign vs = !(count_y >= (VFP+VBP+FRAME_HEIGHT));

    //Translate the counts into useful numbers
    assign pix_x = count_x - HBP;
    assign pix_y = count_y - VBP;
    assign pix_vis = (count_x >= HBP) 
                && (count_x < (HBP+FRAME_WIDTH-1))
                && (count_y >= VBP)
                && (count_y < (VBP+FRAME_HEIGHT-0));

endmodule