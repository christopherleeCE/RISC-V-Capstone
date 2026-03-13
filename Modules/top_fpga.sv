
module top_fpga(
    input logic global_clk,
    input logic [9:0] switches,
    input logic [1:0] buttons,
    output logic [9:0] debug_leds,
    output logic [6:0] hex0,
    output logic [6:0] hex1,
    output logic [6:0] hex2,
    output logic [6:0] hex3,
    output logic [6:0] hex4,
    output logic [6:0] hex5
);

logic ohalt, ofinish;
logic local_clk, divided_clk, debug_clk, manual_clk, manual_clk_button;
logic debug_clk_en, divided_clk_en; 
logic global_rst, middle_rst, local_rst;
logic [1:0] dbuttons; //debounced buttons
logic [9:0] dbswitches; //debounced switches

    clk_divider #(
        .DIVIDE(10)
    )my_clock(
        .clk_in(global_clk),
        .rst_n(local_rst),
        .clk_out(divided_clk) //should be 5mhz
    );

    clk_divider #(
        .DIVIDE(5000000)
    )my_clock_debug(
        .clk_in(global_clk),
        .rst_n(local_rst),
        .clk_out(debug_clk) //should be 10hz, should be posedge alligned with 5mhz i think
    );

    //debounces the comically noisy fpga buttons and switches, uses 50mhz clock, not the reduced 5mhz clk
    debounce mydb0(.pb_1(buttons[0]), .clk(global_clk), .pb_out(dbuttons[0]));
    debounce mydb1(.pb_1(buttons[1]), .clk(global_clk), .pb_out(dbuttons[1]));
    debounce mydbs0(.pb_1(switches[0]), .clk(global_clk), .pb_out(dbswitches[0]));
    debounce mydbs1(.pb_1(switches[1]), .clk(global_clk), .pb_out(dbswitches[1]));
    debounce mydbs2(.pb_1(switches[2]), .clk(global_clk), .pb_out(dbswitches[2]));
    debounce mydbs3(.pb_1(switches[3]), .clk(global_clk), .pb_out(dbswitches[3]));
    debounce mydbs4(.pb_1(switches[4]), .clk(global_clk), .pb_out(dbswitches[4]));
    debounce mydbs5(.pb_1(switches[5]), .clk(global_clk), .pb_out(dbswitches[5]));
    debounce mydbs6(.pb_1(switches[6]), .clk(global_clk), .pb_out(dbswitches[6]));
    debounce mydbs7(.pb_1(switches[7]), .clk(global_clk), .pb_out(dbswitches[7]));
    debounce mydbs8(.pb_1(switches[8]), .clk(global_clk), .pb_out(dbswitches[8]));
    debounce mydbs9(.pb_1(switches[9]), .clk(global_clk), .pb_out(dbswitches[9]));

    assign manual_clk_button = dbuttons[0]; //left button
    assign debug_clk_en = dbuttons[1]; //right button
    assign divided_clk_en = dbswitches[0]; //sw closest to buttons
    assign global_rst = dbswitches[9]; //sw farthest from buttons

    //makes local_rst allign to posedge divided_clk
    always_ff @(posedge divided_clk or negedge global_rst) begin
        if (!global_rst) begin
            middle_rst <= 1'b0;
            local_rst <= 1'b0;
        end
        else begin
            middle_rst <= 1'b1;
            local_rst <= middle_rst;
        end
    end

    //switching between these at runtime could introduce mechanical noise into the clk and violate hold and setup times, be just something to note
    always_comb begin
        priority case(1'b1)

        divided_clk_en  : local_clk = divided_clk;
        debug_clk_en    : local_clk = debug_clk;
        default         : local_clk = manual_clk;

        endcase
    end

    riscv_cpu_v2 cpu_dut(
        .clk(local_clk),
        .rst(local_rst),
        .ohalt(ohalt),
        .ofinish(ofinish)
    );

    assign debug_leds[0] = ohalt;
    assign debug_leds[1] = ofinish;

endmodule