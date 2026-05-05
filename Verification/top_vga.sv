`timescale 1ns/1ns

module top_vga();

    logic clk;
    logic rst;
    
    logic [9:0] pix_x, pix_y;
    logic pix_vis;
    logic [5:0] frame_id;
    logic hs, vs;
    vga_ctrl #(10,6) vga_driver( 
        .pix_x(pix_x), 
        .pix_y(pix_y), 
        .pix_vis(pix_vis),
        .frame_id(frame_id),
        .hs(hs), 
        .vs(vs), 
        .clk(clk), 
        .rst(rst) 
    );

    localparam int CLOCK_PERIOD = 20;
    initial begin
        clk = 1'b0;
        forever begin //start the clock
            #CLOCK_PERIOD
            clk = ~clk;
        end
    end

    initial begin
        rst = 1'b0;
        wait(clk == 1'b0); wait(clk == 1'b1);
        wait(clk == 1'b0); wait(clk == 1'b1);
        wait(clk == 1'b0); wait(clk == 1'b1);
        rst = 1'b1;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
        // for(int ii = 0; ii < 5; ii++) begin
        //     wait(clk == 1'b0); wait(clk == 1'b1);
        // end
        // $finish;
    end


endmodule