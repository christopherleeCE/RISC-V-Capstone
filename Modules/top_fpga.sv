
//alt pll in ip catalogcheckch

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

localparam int BASE_CLK_FREQ = 50000000;
localparam int OPERATING_CLK_FREQ = 5000000;
localparam int DEBUG_CLK_FREQ = 10;
localparam int FLASHING_LIGHT_FREQ = 1;

logic ohalt, ofinish;
logic local_clk, divided_clk, debug_clk, manual_clk, manual_clk_button;
logic debug_clk_en, divided_clk_en; 
logic global_rst, middle_rst, local_rst;
logic [1:0] dbuttons; //debounced buttons
logic [1:0] my_buttons; //inverted buttons so press is 1
logic [9:0] dbswitches; //debounced switches

assign my_buttons = ~buttons;

    clk_divider #(
        .DIVIDE(BASE_CLK_FREQ/OPERATING_CLK_FREQ)
    )my_clock(
        .clk_in(global_clk),
        .rst_n(1'b1),
        .clk_out(divided_clk) //should be 5mhz
    );

    clk_divider #(
        .DIVIDE(BASE_CLK_FREQ/DEBUG_CLK_FREQ)
    )my_clock_debug(
        .clk_in(global_clk),
        .rst_n(1'b1),
        .clk_out(debug_clk) //should be 10hz, should be posedge alligned with 5mhz i think
    );

    //debounces the comically noisy fpga buttons and switches, uses 50mhz clock, not the reduced 5mhz clk
    debounce mydb0(.pb_1(my_buttons[0]), .clk(global_clk), .pb_out(dbuttons[0]));
    debounce mydb1(.pb_1(my_buttons[1]), .clk(global_clk), .pb_out(dbuttons[1]));

    assign manual_clk_button = dbuttons[1]; //left button
    assign manual_clk = manual_clk_button;
    assign debug_clk_en = my_buttons[0]; //right button
    assign divided_clk_en = switches[8]; //sw closest to buttons
    assign global_rst = switches[9]; //sw farthest from buttons

    //makes local_rst allign to posedge divided_clk
    always_ff @(posedge local_clk or negedge global_rst) begin
        if (!global_rst) begin
            middle_rst <= 1'b0;
            local_rst <= 1'b0;
        end
        else begin
            middle_rst <= 1'b1;
            local_rst <= middle_rst;
        end
    end

    //passing the clk to combinational logic is a big nono, and can cause major issues, especially
    //if we are switching the mux at run time
    always_comb begin
        priority case(1'b1)

        divided_clk_en  : local_clk = divided_clk;
        debug_clk_en    : local_clk = debug_clk;
        default         : local_clk = manual_clk;

        endcase
    end

    // //this is the "correct" way we should be assigning the clk
    // assign local_clk = debug_clk;


    logic [31:0] ret_val;
    logic [31:0] curr_pc;
    logic [31:0] instr_f_out;
    logic [31:0] instr_d_out;
    logic [31:0] instr_e_out;
    logic [31:0] instr_m_out;
    logic [31:0] instr_w_out;

    riscv_cpu_v2 cpu_dut(
        .clk(local_clk),
        .rst(local_rst),
        .ohalt(ohalt),
        .ofinish(ofinish),
        .a0(ret_val),
        .pc_out(curr_pc),
        .instr_f_out(instr_f_out),
        .instr_d_out(instr_d_out),
        .instr_e_out(instr_e_out),
        .instr_m_out(instr_m_out),
        .instr_w_out(instr_w_out)
    );

    logic [3:0] pre_hex0;
    logic [3:0] pre_hex1;
    logic [3:0] pre_hex2;
    logic [3:0] pre_hex3;
    logic [3:0] pre_hex4;
    logic [3:0] pre_hex5;
    logic [3:0] pre_hex6;
    logic [3:0] pre_hex7;

    logic [2:0] hex_sel;
    assign hex_sel = switches[2:0];

    always_comb begin
        case(hex_sel)

            3'd0 : {pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = instr_f_out;
            3'd1 : {pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = instr_d_out;
            3'd2 : {pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = instr_e_out;
            3'd3 : {pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = instr_m_out;
            3'd4 : {pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = instr_w_out;
            3'd6 : {pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = curr_pc;
            3'd7 : {pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = ret_val;
            default: {pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = 32'hDEADBEEF;

        endcase
    end

    logic [3:0] hex_in0;
    logic [3:0] hex_in1;
    logic [3:0] hex_in2;
    logic [3:0] hex_in3;
    logic [3:0] hex_in4;
    logic [3:0] hex_in5;

    assign hex_in0 = switches[7] ? pre_hex2 : pre_hex0;
    assign hex_in1 = switches[7] ? pre_hex3 : pre_hex1;
    assign hex_in2 = switches[7] ? pre_hex4 : pre_hex2;
    assign hex_in3 = switches[7] ? pre_hex5 : pre_hex3;
    assign hex_in4 = switches[7] ? pre_hex6 : pre_hex4;
    assign hex_in5 = switches[7] ? pre_hex7 : pre_hex5;

    hex_display my_hex0(.SEL(hex_in0), .ZOUT(hex0));
    hex_display my_hex1(.SEL(hex_in1), .ZOUT(hex1));
    hex_display my_hex2(.SEL(hex_in2), .ZOUT(hex2));
    hex_display my_hex3(.SEL(hex_in3), .ZOUT(hex3));
    hex_display my_hex4(.SEL(hex_in4), .ZOUT(hex4));
    hex_display my_hex5(.SEL(hex_in5), .ZOUT(hex5));


    logic flashing;
    clk_divider #(
        .DIVIDE(BASE_CLK_FREQ/FLASHING_LIGHT_FREQ)
    )slow_flash_generator(
        .clk_in(global_clk),
        .rst_n(1'b1),
        .clk_out(flashing) //should be 5mhz
    );

    assign debug_leds[0] = local_rst;
    assign debug_leds[1] = global_rst;
    assign debug_leds[2] = local_clk;
    assign debug_leds[3] = debug_clk;
    assign debug_leds[4] = global_clk;
    assign debug_leds[5] = 1'b1;
    assign debug_leds[6] = dbuttons[1];
    assign debug_leds[7] = dbuttons[0];
    assign debug_leds[8] = ofinish;
    assign debug_leds[9] = (ohalt && flashing);

endmodule