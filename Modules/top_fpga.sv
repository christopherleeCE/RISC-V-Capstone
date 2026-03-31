
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
    output logic [6:0] hex5,
    output logic [5:0] hex_decimal_point
);

    localparam int BASE_CLK_FREQ = 50000000;
    localparam int OPERATING_CLK_FREQ = 5000000;
    localparam int DEBUG_CLK_FREQ = 10;
    localparam int SLOW_FLASHING_LIGHT_FREQ = 1;
    localparam int FAST_FLASHING_LIGHT_FREQ = 5;

    logic ohalt, ofinish;
    logic local_clk, divided_clk, debug_clk, manual_clk, manual_clk_button;
    logic debug_clk_en, divided_clk_en; 
    logic global_rst, middle_rst, local_rst;
    logic [1:0] dbuttons; //debounced buttons
    logic [1:0] my_buttons; //inverted buttons so press is 1
    logic [9:0] dbswitches; //debounced switches

    logic [31:0] a0, ret_val;
    logic [31:0] curr_pc;
    logic [31:0] instr_f_out;
    logic [31:0] instr_d_out;
    logic [31:0] instr_e_out;
    logic [31:0] instr_m_out;
    logic [31:0] instr_w_out;

    logic [31:0] pc_f_out;
    logic [31:0] pc_d_out;
    logic [31:0] pc_e_out;
    logic [31:0] pc_m_out;
    logic [31:0] pc_w_out;

    logic [4:0] pre_hex0;
    logic [4:0] pre_hex1;
    logic [4:0] pre_hex2;
    logic [4:0] pre_hex3;
    logic [4:0] pre_hex4;
    logic [4:0] pre_hex5;
    logic [4:0] pre_hex6;
    logic [4:0] pre_hex7;
    logic [4:0] pre_hex8;
    logic [4:0] pre_hex9;
    logic [4:0] pre_hex10;
    logic [4:0] pre_hex11;

    logic [3:0] hex_sel;

    logic [4:0] hex_in0;
    logic [4:0] hex_in1;
    logic [4:0] hex_in2;
    logic [4:0] hex_in3;
    logic [4:0] hex_in4;
    logic [4:0] hex_in5;

    logic slow_flash, fast_flash, staggered_fast_flash;
    logic status_light;
    logic [1:0] cnt;

    logic ostart;
    logic oworking;
    logic float_done;
    logic dp_en;
    logic [149:0] bcd;

    logic int_bcd_neg_flag;
    logic [3:0] pre_int_bcd_output [9:0];
    logic [59:0] int_bcd_output;


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

    assign manual_clk_button = dbuttons[1]; //bottom button
    assign manual_clk = manual_clk_button;
    assign debug_clk_en = my_buttons[0]; //top button, intentionally not debounced wont work if it is
    assign divided_clk_en = switches[8]; //sw closest to buttons
    assign global_rst = switches[9]; //sw farthest from buttons

    //makes local_rst allign to posedge divided_clk, may no longer be needed tbh
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
    logic [31:0] portb_q, portb_addr;
    logic b_loading, b_incing;
    always_ff @(posedge manual_clk or posedge debug_clk_en) begin
        if(debug_clk_en) begin //rst
            b_loading <= 1'b1;
            b_incing <= '0;

            portb_addr <= '0;

        end else if(b_loading) begin
            b_loading <= '0;
            b_incing <= 1'b1;

            portb_addr <= a0;

        end else if(b_incing) begin

            portb_addr <= portb_addr + 32'h4;

        end
    end
    riscv_cpu_v2 cpu_dut(
        .clk(local_clk),
        .rst(local_rst),
        .ohalt(ohalt),
        .ofinish(ofinish),
        .a0(a0),
        .instr_f_out(instr_f_out),
        .instr_d_out(instr_d_out),
        .instr_e_out(instr_e_out),
        .instr_m_out(instr_m_out),
        .instr_w_out(instr_w_out),
        .pc_f_out(pc_f_out),
        .pc_d_out(pc_d_out),
        .pc_e_out(pc_e_out),
        .pc_m_out(pc_m_out),
        .pc_w_out(pc_w_out),
        .portb_rst(!debug_clk_en),
        .portb_addr(portb_addr),
        .portb_clk(manual_clk),
        .portb_q(portb_q)
    );

    always_comb begin
        case(switches[6:5])

            2'd0 : ret_val = a0;
            2'd1 : ret_val = a0;
            2'd2 : ret_val = portb_q;
            2'd3 : ret_val = portb_addr;

        endcase
    end

    bin_to_bcd #(
        .bin_width(32),
        .bcd_width(10)
    ) my_bin_to_bcd (
        .bin_input(ret_val),
        .sign_en(switches[3:0] == 4'b0111),
        .bcd_output(pre_int_bcd_output),
        .negative_flag(int_bcd_neg_flag)
    );

    localparam logic [4:0] ALL_OFF = 5'd18;
    localparam logic [4:0] LOWERCASE_F = 5'd15;
    localparam logic [4:0] LOWERCASE_N = 5'd16;
    localparam logic [4:0] LOWERCASE_I = 5'd17;
    localparam logic [4:0] NEGATIVE_SIGN = 5'd19;
    localparam logic [4:0] UPPERCASE_N = 5'd20;
    localparam logic [4:0] UPPERCASE_A = 5'd10;

    assign int_bcd_output = {
        ALL_OFF,
        (int_bcd_neg_flag ? NEGATIVE_SIGN : ALL_OFF),
        1'b0, pre_int_bcd_output[9],
        1'b0, pre_int_bcd_output[8],
        1'b0, pre_int_bcd_output[7],
        1'b0, pre_int_bcd_output[6],
        1'b0, pre_int_bcd_output[5],
        1'b0, pre_int_bcd_output[4],
        1'b0, pre_int_bcd_output[3],
        1'b0, pre_int_bcd_output[2],
        1'b0, pre_int_bcd_output[1],
        1'b0, pre_int_bcd_output[0]
    };

    // logic state_zero;
    // logic state_denorm;
    // logic state_norm;
    // logic state_inf;
    // logic state_nan;

    float2bcd my_float2bcd(
        .fnum(ret_val),
        .clk(local_clk),
        .rst(local_rst),
        .start(ofinish),
        .ostart(ostart),
        .oworking(oworking),
        // .state_zero(state_zero),
        // .state_denorm(state_denorm),
        // .state_norm(state_norm),
        // .state_inf(state_inf),
        // .state_nan(state_nan),
        .odone(float_done),
        .dp_en(dp_en),
        .bcd(bcd)
    );

/*
1 0000 instr
1 0001 instr
1 0010 instr
1 0011 instr
1 0100 instr
1 0101 rethex
1 0110 udec
1 0111 sdec
1 1000 pc
1 1001 pc
1 1010 pc
1 1011 pc
1 1100 pc
1 1101 floatmix
1 1110 floatfac/floatint
1 1111 floatint/floatint(sign)
*/  assign hex_sel = switches[3:0];

    always_comb begin
        case(hex_sel)

            //hell... hexdecoders are 5bits wide, 5'b0XXXX are normal hex values, 5'b1XXXX are special chars, bcd is already encoded correctly in the float2bcd moudle, the rest of the case statement needs to be encoded manually as seen below
            5'h0 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, instr_f_out[31:28], 1'b0, instr_f_out[27:24], 1'b0, instr_f_out[23:20], 1'b0, instr_f_out[19:16], 1'b0, instr_f_out[15:12], 1'b0, instr_f_out[11:8], 1'b0, instr_f_out[7:4], 1'b0, instr_f_out[3:0]};
            5'h1 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, instr_d_out[31:28], 1'b0, instr_d_out[27:24], 1'b0, instr_d_out[23:20], 1'b0, instr_d_out[19:16], 1'b0, instr_d_out[15:12], 1'b0, instr_d_out[11:8], 1'b0, instr_d_out[7:4], 1'b0, instr_d_out[3:0]};
            5'h2 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, instr_e_out[31:28], 1'b0, instr_e_out[27:24], 1'b0, instr_e_out[23:20], 1'b0, instr_e_out[19:16], 1'b0, instr_e_out[15:12], 1'b0, instr_e_out[11:8], 1'b0, instr_e_out[7:4], 1'b0, instr_e_out[3:0]};
            5'h3 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, instr_m_out[31:28], 1'b0, instr_m_out[27:24], 1'b0, instr_m_out[23:20], 1'b0, instr_m_out[19:16], 1'b0, instr_m_out[15:12], 1'b0, instr_m_out[11:8], 1'b0, instr_m_out[7:4], 1'b0, instr_m_out[3:0]};
            5'h4 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, instr_w_out[31:28], 1'b0, instr_w_out[27:24], 1'b0, instr_w_out[23:20], 1'b0, instr_w_out[19:16], 1'b0, instr_w_out[15:12], 1'b0, instr_w_out[11:8], 1'b0, instr_w_out[7:4], 1'b0, instr_w_out[3:0]};
            5'h5 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, ret_val[31:28], 1'b0, ret_val[27:24], 1'b0, ret_val[23:20], 1'b0, ret_val[19:16], 1'b0, ret_val[15:12], 1'b0, ret_val[11:8], 1'b0, ret_val[7:4], 1'b0, ret_val[3:0]};
            5'h6 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = int_bcd_output; //udec
            5'h7 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = int_bcd_output; //sdec
            5'h8 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, pc_f_out[31:28], 1'b0, pc_f_out[27:24], 1'b0, pc_f_out[23:20], 1'b0, pc_f_out[19:16], 1'b0, pc_f_out[15:12], 1'b0, pc_f_out[11:8], 1'b0, pc_f_out[7:4], 1'b0, pc_f_out[3:0]};
            5'h9 : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, pc_d_out[31:28], 1'b0, pc_d_out[27:24], 1'b0, pc_d_out[23:20], 1'b0, pc_d_out[19:16], 1'b0, pc_d_out[15:12], 1'b0, pc_d_out[11:8], 1'b0, pc_d_out[7:4], 1'b0, pc_d_out[3:0]};
            5'hA : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, pc_e_out[31:28], 1'b0, pc_e_out[27:24], 1'b0, pc_e_out[23:20], 1'b0, pc_e_out[19:16], 1'b0, pc_e_out[15:12], 1'b0, pc_e_out[11:8], 1'b0, pc_e_out[7:4], 1'b0, pc_e_out[3:0]};
            5'hB : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, pc_m_out[31:28], 1'b0, pc_m_out[27:24], 1'b0, pc_m_out[23:20], 1'b0, pc_m_out[19:16], 1'b0, pc_m_out[15:12], 1'b0, pc_m_out[11:8], 1'b0, pc_m_out[7:4], 1'b0, pc_m_out[3:0]};
            5'hC : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {20'b0, 1'b0, pc_w_out[31:28], 1'b0, pc_w_out[27:24], 1'b0, pc_w_out[23:20], 1'b0, pc_w_out[19:16], 1'b0, pc_w_out[15:12], 1'b0, pc_w_out[11:8], 1'b0, pc_w_out[7:4], 1'b0, pc_w_out[3:0]};
            5'hD : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {bcd[29:0], bcd[29:0]};      //lower 2 int digits, upper 3 fractional digits, with neg sign as applicable
            5'hE : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {bcd[89:60], bcd[59:30]};    //fractional section of float
            5'hF : {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = {bcd[149:120], bcd[119:90]}; //int section of float
            default: {pre_hex11, pre_hex10, pre_hex9, pre_hex8, pre_hex7, pre_hex6, pre_hex5, pre_hex4, pre_hex3, pre_hex2, pre_hex1, pre_hex0} = 60'hEEFCAFEDEADBEEF;

        endcase
    end

    assign hex_in0 = switches[4] ? pre_hex6 : pre_hex0;
    assign hex_in1 = switches[4] ? pre_hex7 : pre_hex1;
    assign hex_in2 = switches[4] ? pre_hex8 : pre_hex2;
    assign hex_in3 = switches[4] ? pre_hex9 : pre_hex3;
    assign hex_in4 = switches[4] ? pre_hex10 : pre_hex4;
    assign hex_in5 = switches[4] ? pre_hex11 : pre_hex5;

    hex_display my_hex0(.SEL(hex_in0), .ZOUT(hex0));
    hex_display my_hex1(.SEL(hex_in1), .ZOUT(hex1));
    hex_display my_hex2(.SEL(hex_in2), .ZOUT(hex2));
    hex_display my_hex3(.SEL(hex_in3), .ZOUT(hex3));
    hex_display my_hex4(.SEL(hex_in4), .ZOUT(hex4));
    hex_display my_hex5(.SEL(hex_in5), .ZOUT(hex5));

    clk_divider #(
        .DIVIDE(BASE_CLK_FREQ/SLOW_FLASHING_LIGHT_FREQ)
    )slow_flash_generator(
        .clk_in(global_clk),
        .rst_n(1'b1),
        .clk_out(slow_flash)
    );

    clk_divider #(
        .DIVIDE(BASE_CLK_FREQ/FAST_FLASHING_LIGHT_FREQ)
    )fast_flash_generator(
        .clk_in(global_clk),
        .rst_n(1'b1),
        .clk_out(fast_flash)
    );

    //cnt goes 0, 1, 2, 3, 0, 1, etc.
    counter #(
        .m(4),
        .bw(2)
    )my_counter2(
        .inc(1'b1),
        .clk(fast_flash),
        .rst(1'b1),
        .cnt(cnt)
    );

    assign staggered_fast_flash = (cnt != 0) && fast_flash;

    always_comb begin
        priority case(1'b1)

        ohalt   :   status_light = ohalt && staggered_fast_flash;
        ofinish :   status_light = ofinish && slow_flash && (~debug_clk_en);
        default :   status_light = 1'b0;

        endcase
    end

    assign debug_leds[0] = local_rst;
    assign debug_leds[1] = global_rst;
    assign debug_leds[2] = local_clk;
    assign debug_leds[3] = 1'b1;
    assign debug_leds[4] = manual_clk;
    assign debug_leds[5] = debug_clk_en;
    assign debug_leds[6] = 1'b1;
    assign debug_leds[7] = ostart;
    assign debug_leds[8] = oworking;
    assign debug_leds[9] = float_done && slow_flash;

    assign hex_decimal_point[0] = ~(status_light || (switches[4:0] == 5'b01111) && dp_en && ~ohalt);
    assign hex_decimal_point[1] = ~(status_light);
    assign hex_decimal_point[2] = ~(status_light);
    assign hex_decimal_point[3] = ~(status_light || (switches[3:0] == 4'b1101) && dp_en && ~ohalt);
    assign hex_decimal_point[4] = ~(status_light);
    assign hex_decimal_point[5] = ~(status_light);

endmodule