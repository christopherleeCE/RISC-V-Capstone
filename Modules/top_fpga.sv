
//alt pll in ip catalogcheckch

/*
topbutton enable 10hz clk, if full clk is disabled
bottombutton manual clk button, active if full clk is disabled
topbutton rst the pointer seq engine
bottombutton increment the pointer seq engine

sw[9] rst to cpu active low
sw[8] enable full clk (5mhz)
sw[7] decimal point status light en, (when high decimal points in hex disp will slow flash on completion of prog), extern_portb_en
sw[6:5] select the source [11 10 01 00] = [pointer in seq engine, contents of pointer loc, ascii mode (overites sw[4:0]), raw retvalue]
sw[4] select if we display the upper 6 digits or lower 6 digits
sw[3:0]...
0000 instr_f
0001 instr_d
0010 instr_e
0011 instr_m
0100 instr_w
0101 rethex
0110 udec
0111 sdec
1000 pc_f
1001 pc_d
1010 pc_e
1011 pc_m
1100 pc_w
1101 floatmix (1 sign, 2 ints, 3 fractions), mirrored on disp low and high
1110 6'floatfrac / 6'floatfrac
1111 sign, 5'floatint / 6'floatint
*/

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
    output logic [5:0] hex_decimal_point,
    output logic FPGA_UART_TX,
    output logic [3:0] VGA_RED,
    output logic [3:0] VGA_BLUE,
    output logic [3:0] VGA_GREEN,
    output logic       VGA_HS,
    output logic       VGA_VS
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

    logic control_hazard;

    logic [4:0] r1_data_hazard_1;
    logic [4:0] r1_data_hazard_2;
    logic [4:0] r1_data_hazard_3;
    logic [4:0] r2_data_hazard_1;
    logic [4:0] r2_data_hazard_2;
    logic [4:0] r2_data_hazard_3;

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

    logic [6:0] ascii_hex_decoded0;
    logic [6:0] ascii_hex_decoded1;
    logic [6:0] ascii_hex_decoded2;
    logic [6:0] ascii_hex_decoded3;
    logic [6:0] ascii_hex_decoded4;
    logic [6:0] ascii_hex_decoded5;
    logic [7:0] ascii_val_ff_train [5:0];
    logic [6:0] pre_hex_disp0;
    logic [6:0] pre_hex_disp1;
    logic [6:0] pre_hex_disp2;
    logic [6:0] pre_hex_disp3;
    logic [6:0] pre_hex_disp4;
    logic [6:0] pre_hex_disp5;

    logic [31:0] portb_q, portb_addr;
    logic b_loading, b_incing, b_done;
    logic [15:0] seq_eng_cnt, max_arr_index;

    logic ascii_mode;
    assign ascii_mode = switches[6:5] == 2'b01;

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

    always_ff @(posedge manual_clk or posedge debug_clk_en) begin
        if(debug_clk_en) begin //rst
            b_loading <= 1'b1;
            b_incing <= '0;
            b_done <= '0;

            seq_eng_cnt <= '0;
            max_arr_index <= '0;

            portb_addr <= '0;

            for(int ii = 0; ii < 6; ii++) begin
                ascii_val_ff_train[ii] <= '0;
            end

        end else if(b_loading) begin
            b_loading <= '0;
            b_incing <= 1'b1;

            max_arr_index <= a0[31:16];
            portb_addr <= {16'b0, a0[15:0]};

        end else if(b_incing) begin
            b_incing <= ~(seq_eng_cnt == max_arr_index);
            b_done <= (seq_eng_cnt == max_arr_index);

            seq_eng_cnt <= seq_eng_cnt + 1'b1;
            portb_addr <= portb_addr + ((ascii_mode) ? 32'h1 : 32'h4);

            ascii_val_ff_train[0] <= portb_q[7:0];
            for(int ii = 1; ii < 6; ii++) begin
                ascii_val_ff_train[ii] <= ascii_val_ff_train[ii-1];
            end

        end else if(b_done) begin
            //do nothing, only way out is rst

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
        .control_hazard(control_hazard),
        .r1_data_hazard_1(r1_data_hazard_1),
        .r1_data_hazard_2(r1_data_hazard_2),
        .r1_data_hazard_3(r1_data_hazard_3),
        .r2_data_hazard_1(r2_data_hazard_1),
        .r2_data_hazard_2(r2_data_hazard_2),
        .r2_data_hazard_3(r2_data_hazard_3),
        .portb_extern_en(switches[7]),
        .portb_rst(!debug_clk_en),
        .portb_addr(portb_addr),
        .portb_clk(manual_clk),
        .portb_q(portb_q),
        .portb_addr_byte(ascii_mode),
        .portb_addr_half('0),
        .portb_zero_extend('0),
        .clk_50(global_clk),
        .VGA_RED(VGA_RED),
        .VGA_BLUE(VGA_BLUE),
        .VGA_GREEN(VGA_GREEN),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS)
    );

    //assign ret_val = portb_q;
    always_comb begin
        case(switches[6:5])

            2'd0 : ret_val = a0;
            2'd1 : ret_val = a0; //gets overwritten down the line, outputs ascii instead
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
        .rst(!manual_clk),
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

    // the uart packing module is designed to capture the relevant signals from the CPU at the right time 
    // (either on every CPU clock tick or only on CPU finish/halt events based on the divided_clk_en signal), 
    // pack them into a data buffer, and then shift out one byte at a time to the uart_tx module for transmission. 
    // The state machine ensures that the data is captured and sent in an orderly fashion, 
    // and the use of local_clk allows for synchronization with the CPU's operation.
    
    logic [7:0] uart_data;
    logic uart_send;
    logic uart_busy;
    logic [423:0] signals, dbg_signals, dbg_signals_capture;
    logic dbg_finish_capture, dbg_halt_capture;    
    logic dbg_finish, dbg_halt;

    assign signals = {
        instr_f_out, instr_d_out, instr_e_out, instr_m_out, instr_w_out,
        pc_f_out, pc_d_out, pc_e_out, pc_m_out, pc_w_out,
        a0, {7'b0, ofinish}, {7'b0, ohalt}, {7'b0, control_hazard},
        {3'b0, r1_data_hazard_1}, {3'b0, r1_data_hazard_2}, {3'b0, r1_data_hazard_3},
        {3'b0, r2_data_hazard_1}, {3'b0, r2_data_hazard_2}, {3'b0, r2_data_hazard_3}
    };

    // Clock domain crossing
    always_ff @(posedge global_clk or negedge global_rst) begin
        if (!global_rst) begin
            dbg_signals <= signals;
            dbg_signals_capture <= signals;

            dbg_finish <= ofinish;
            dbg_finish_capture <= ofinish;

            dbg_halt <= ohalt;
            dbg_halt_capture <= ohalt;
        end else begin
            dbg_signals_capture <= signals; // Capture the signals in the local clock domain
            dbg_signals <= dbg_signals_capture; // Transfer the captured signals to the global clock domain

            dbg_finish_capture <= ofinish; // Capture the finish signal in the local clock domain
            dbg_finish <= dbg_finish_capture; // Transfer the captured finish signal to the global clock domain

            dbg_halt_capture <= ohalt; // Capture the halt signal in the local clock domain
            dbg_halt <= dbg_halt_capture; // Transfer the captured halt signal to the global clock domain
        end
    end

    // State machine for data packing and UART transmission control
    uart_packing #(
        .SIGNAL_WIDTH(424)
    ) my_uart_packing(
        .clk(global_clk),
        .reset(global_rst),
        .busy(uart_busy), // Receive the busy signal from the uart_tx module to know when it's ready for the next byte
        .divided_clk_en(divided_clk_en), // Send data on every CPU clock tick or only on CPU finish/halt events based on this signal
        .local_clk(local_clk), // Send data when the local clock ticks, which is synchronized with the CPU
        .debug_clk(debug_clk), // Send data on debug clock ticks to capture signals on CPU finish/halt events
        .cpu_finish(dbg_finish),
        .cpu_halt(dbg_halt),
        .dbg_signals(dbg_signals), // Send the captured signals to the UART packing module
        .send(uart_send), // Output signal to trigger sending data when the uart_tx module is ready
        .out_byte(uart_data)
    );

    // Takes the packed data from the uart_packing module and sends it serially over the FPGA_UART_TX line.
    uart_tx #(
        .BAUD_RATE(115200),
        .GLOBAL_CLK_FREQ(50000000)
    ) my_uart_tx (
        .clk(global_clk),
        .reset(global_rst),
        .in_byte(uart_data),
        .send(uart_send), // Triggered by the uart_packing module when data is ready to be sent
        .busy(uart_busy), // Output signal to indicate when the uart_tx module is busy transmitting data
        .tx(FPGA_UART_TX)
    );

    assign hex_sel = switches[3:0];

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

    hex_display my_hex0(.SEL(hex_in0), .ZOUT(pre_hex_disp0));
    hex_display my_hex1(.SEL(hex_in1), .ZOUT(pre_hex_disp1));
    hex_display my_hex2(.SEL(hex_in2), .ZOUT(pre_hex_disp2));
    hex_display my_hex3(.SEL(hex_in3), .ZOUT(pre_hex_disp3));
    hex_display my_hex4(.SEL(hex_in4), .ZOUT(pre_hex_disp4));
    hex_display my_hex5(.SEL(hex_in5), .ZOUT(pre_hex_disp5));

    ascii_decoder my_ascii_decoder0(.SEL(ascii_val_ff_train[0]), .ZOUT(ascii_hex_decoded0));
    ascii_decoder my_ascii_decoder1(.SEL(ascii_val_ff_train[1]), .ZOUT(ascii_hex_decoded1));
    ascii_decoder my_ascii_decoder2(.SEL(ascii_val_ff_train[2]), .ZOUT(ascii_hex_decoded2));
    ascii_decoder my_ascii_decoder3(.SEL(ascii_val_ff_train[3]), .ZOUT(ascii_hex_decoded3));
    ascii_decoder my_ascii_decoder4(.SEL(ascii_val_ff_train[4]), .ZOUT(ascii_hex_decoded4));
    ascii_decoder my_ascii_decoder5(.SEL(ascii_val_ff_train[5]), .ZOUT(ascii_hex_decoded5));

    assign hex0 = (ascii_mode) ? ascii_hex_decoded0 : pre_hex_disp0;
    assign hex1 = (ascii_mode) ? ascii_hex_decoded1 : pre_hex_disp1;
    assign hex2 = (ascii_mode) ? ascii_hex_decoded2 : pre_hex_disp2;
    assign hex3 = (ascii_mode) ? ascii_hex_decoded3 : pre_hex_disp3;
    assign hex4 = (ascii_mode) ? ascii_hex_decoded4 : pre_hex_disp4;
    assign hex5 = (ascii_mode) ? ascii_hex_decoded5 : pre_hex_disp5;

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
        .OVERFLOW_VAL(4),
        .BW(2)
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
        ofinish :   status_light = ofinish && slow_flash && (switches[7]);
        default :   status_light = 1'b0;

        endcase
    end

    assign debug_leds[0] = local_rst;
    assign debug_leds[1] = global_rst;
    assign debug_leds[2] = local_clk;
    assign debug_leds[3] = 1'b1;
    assign debug_leds[4] = manual_clk;
    assign debug_leds[5] = debug_clk_en;
    assign debug_leds[6] = b_loading;
    assign debug_leds[7] = b_incing;
    assign debug_leds[8] = b_done;
    assign debug_leds[9] = float_done && slow_flash;

    assign hex_decimal_point[0] = ~(status_light || (switches[4:0] == 5'b01111) && dp_en && ~ohalt);
    assign hex_decimal_point[1] = ~(status_light);
    assign hex_decimal_point[2] = ~(status_light);
    assign hex_decimal_point[3] = ~(status_light || (switches[3:0] == 4'b1101) && dp_en && ~ohalt);
    assign hex_decimal_point[4] = ~(status_light);
    assign hex_decimal_point[5] = ~(status_light);

endmodule