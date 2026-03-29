

module float2bcd(
    input logic [31:0] fnum,
    input logic clk,
    input logic rst,
    input logic start,
    output logic ostart,
    output logic oworking,
    // output logic state_zero,
    // output logic state_denorm,
    // output logic state_norm,
    // output logic state_denorm_int,
    // output logic state_norm_int,
    // output logic state_inf,
    // output logic state_nan,
    output logic odone,
    output logic dp_en,
    output logic [149:0]bcd
);

localparam int FF_TRAIN_EC = 12;
localparam int BCD_INT_SEC_BW = 284;
localparam int BCD_INT_SEC_NW = 71;

logic sign;
logic [7:0] exp, unbiased_exp;
logic [23:0] mantisa;

logic [276:0] pre_norm, norm;
logic [127:0] int_sec_async;
logic [148:0] frac_sec_async;

                        //4 bits larger, enuf to accomidate nibble of int portion after mul10
logic [152:0] frac_sec; //128 (1 from 1.f + 127 from 2^127) bits for int poriton, implicit binary point, 149 (23 + 126 from f in 1.f)
logic [283:0] int_sec, next_int_sec;

logic [149:0] pre_bcd;
logic [4:0] auto_sign;

//state regs, the norm state and denorm state are ubiquidouse with each other, leaving in both for debuging
logic start_q, state_zero, state_denorm, state_norm, state_denorm_int, state_norm_int, state_inf, state_nan, state_done;
logic disp_zero, disp_denorm_norm, disp_inf, disp_nan;

logic [4:0] ff_train [FF_TRAIN_EC-1:0];
logic [7:0] cnt;

assign unbiased_exp = fnum[30:23];

assign {
    sign,
    exp,
    mantisa
} = {
    //sign bit
    fnum[31], 

    /*ugly looking pri case
    if (at or above bias): 
        unbiased_exp - 127

    else if (below bias & unbiased_exp == 0): #this is a denormal 
        126 #prevents exp from becoming 127, ieee states it should be 126 instead

    else if (below bias & unbiased_exp == 0): #this is NOT denormal
        abs(unbiansed_exp - 127) #we are just doing -127, then -1 and invert to undo 2's comp 
    */
    (unbiased_exp >= 8'd127) ? (unbiased_exp - 8'd127) : ((unbiased_exp == 0) ? 8'd126 :
                                                                            ~(unbiased_exp - 8'd128)),

    //only include implicate 1 in mantisa if not a denorm
    {(unbiased_exp != 8'b0) , fnum[22:0]}
};

assign pre_norm = {127'b0, mantisa, 126'b0};
assign norm = (unbiased_exp >= 8'd127) ? pre_norm << exp : pre_norm >> exp;

assign int_sec_async = norm[276:149];
assign frac_sec_async = norm[148:0];

genvar ii;
assign next_int_sec[127:0] = int_sec[127:0];
generate for(ii = 32; ii < (BCD_INT_SEC_NW); ii++) begin : add_3_block
    //if bcd nibble is >= 5, add three to that nibble, then all nibbles are bitshifted in ff block
    assign next_int_sec[(3+(4*ii)):(0+(4*ii))] = (int_sec[(3+(4*ii)):(0+(4*ii))] >= 4'd5) ?
                                                int_sec[(3+(4*ii)):(0+(4*ii))] + 4'd3     :
                                                int_sec[(3+(4*ii)):(0+(4*ii))]            ;
end endgenerate 

logic [127:0] lower;
logic [155:0] upper;
assign lower = int_sec[127:0];
assign upper = int_sec[283:128];

//frac_sec goes through mul10 algorithm fsm
always_ff @(posedge clk or negedge rst) begin
    if(!rst) begin
        start_q <= '0;
        state_zero <= '0;
        state_denorm <= '0;
        state_norm <= '0;
        state_denorm_int <= '0;
        state_norm_int <= '0;
        state_inf <= '0;
        state_nan <= '0;
        disp_zero <= '0;
        disp_denorm_norm <= '0;
        disp_inf <= '0;
        disp_nan <= '0;
        state_done <= '0;

        frac_sec <= '0;
        int_sec <= '0;

        cnt <= '0;

        //rst ff train
        for(int ii = 0; ii < FF_TRAIN_EC; ii++) begin
            ff_train[ii] <= '0;
        end

    end else if(start_q) begin
        start_q <= '0;
        state_zero <= (unbiased_exp == 8'b0) && (mantisa[22:0] == 22'b0);
        state_denorm <= (unbiased_exp == 8'b0) && (mantisa[22:0] != 22'b0);
        state_norm <= (unbiased_exp > 8'b0 ) && (unbiased_exp < 8'hFF);
        state_denorm_int <= (unbiased_exp == 8'b0) && (mantisa[22:0] != 22'b0);
        state_norm_int <= (unbiased_exp > 8'b0 ) && (unbiased_exp < 8'hFF);
        state_inf <= (unbiased_exp == 8'hFF) && (mantisa[22:0] == 22'b0);
        state_nan <= (unbiased_exp == 8'hFF) && (mantisa[22:0] != 22'b0);

        frac_sec <= {4'b0, frac_sec_async};
        int_sec <= {156'b0, int_sec_async};

    end else if(state_zero) begin
        state_zero <= '0;
        state_done <= 1'b1;
        disp_zero <= 1'b1;

    end else if(state_denorm || state_norm || state_denorm_int || state_norm_int) begin
        state_denorm    <= ~(ff_train[FF_TRAIN_EC-1][4] == 1'b1);
        state_norm      <= ~(ff_train[FF_TRAIN_EC-1][4] == 1'b1);
        state_done      <=  (ff_train[FF_TRAIN_EC-1][4] == 1'b1) && (cnt == 8'h7F); //int_sec[127:0] == 128'b0
        state_denorm_int<= ~(cnt == 8'h7F);
        state_norm_int  <= ~(cnt == 8'h7F);
        disp_denorm_norm <= 1'b1;

        //stop double dabble after all 128 bit of int section of float are shifted
        if(state_denorm_int || state_norm_int) begin
            int_sec[0] <= '0;
            int_sec[283:1] <= next_int_sec[282:0];
        end

        //disable write_en on fftrain once end has been reached
        if(state_denorm || state_norm) begin
            frac_sec <= (frac_sec[148:0] << 2'd3) + (frac_sec[148:0] << 1'd1);
            ff_train[0] <= {1'b1, frac_sec[152:149]};  //set occupied bit to high, lower 4 bits are the bcd
            for(int ii = 1; ii < FF_TRAIN_EC; ii++) begin
                ff_train[ii] <= ff_train[ii-1];
            end
        end

        //keep track of how many shifts in the double dable
        cnt <= cnt + 1'b1;
        
    end else if(state_inf) begin
        state_inf <= '0;
        state_done <= 1'b1;
        disp_inf <= 1'b1;

    end else if(state_nan) begin
        state_nan <= '0;
        state_done <= 1'b1;
        disp_nan <= 1'b1;

    end else if(state_done) begin
        //do nothing, only way out is ~rst

    end else begin
        start_q <= start;
    end
end

localparam logic [4:0] ALL_OFF = 5'd18;
localparam logic [4:0] LOWERCASE_F = 5'd15;
localparam logic [4:0] LOWERCASE_N = 5'd16;
localparam logic [4:0] LOWERCASE_I = 5'd17;
localparam logic [4:0] NEGATIVE_SIGN = 5'd19;
localparam logic [4:0] UPPERCASE_N = 5'd20;
localparam logic [4:0] UPPERCASE_A = 5'd10;

assign auto_sign = (sign ? NEGATIVE_SIGN : ALL_OFF); //either negsign of all of hex encode value

assign pre_bcd = {
        auto_sign,
    1'b0, upper[43:40],
    1'b0, upper[39:36],
    1'b0, upper[35:32],
    1'b0, upper[31:28],
    1'b0, upper[27:24],
    //////////////////////
    1'b0, upper[23:20],
    1'b0, upper[19:16],
    1'b0, upper[15:12],
    1'b0, upper[11:8],
    1'b0, upper[7:4],
    1'b0, upper[3:0],
    //////////////////////
    1'b0, ff_train[11][3:0], 
    1'b0, ff_train[10][3:0], 
    1'b0, ff_train[9][3:0], 
    1'b0, ff_train[8][3:0], 
    1'b0, ff_train[7][3:0], 
    1'b0, ff_train[6][3:0],
    //////////////////////
    1'b0, ff_train[5][3:0], 
    1'b0, ff_train[4][3:0], 
    1'b0, ff_train[3][3:0], 
    1'b0, ff_train[2][3:0], 
    1'b0, ff_train[1][3:0], 
    1'b0, ff_train[0][3:0],
    //////////////////////
        auto_sign,
    1'b0, upper[7:4],
    1'b0, upper[3:0],
    1'b0, ff_train[11][3:0], 
    1'b0, ff_train[10][3:0], 
    1'b0, ff_train[9][3:0]
};

logic [95:0] debug_bcd;
assign debug_bcd ={
    upper[47:44],
    upper[43:40],
    upper[39:36],
    upper[35:32],
    upper[31:28],
    upper[27:24],
    upper[23:20],
    upper[19:16],
    upper[15:12],
    upper[11:8],
    upper[7:4],
    upper[3:0],
    ff_train[11][3:0], 
    ff_train[10][3:0], 
    ff_train[9][3:0], 
    ff_train[8][3:0], 
    ff_train[7][3:0], 
    ff_train[6][3:0], 
    ff_train[5][3:0], 
    ff_train[4][3:0], 
    ff_train[3][3:0], 
    ff_train[2][3:0], 
    ff_train[1][3:0], 
    ff_train[0][3:0]
};

always_comb begin
    unique case(1'b1)

    disp_denorm_norm    : bcd = pre_bcd;

    disp_zero           : bcd = {ALL_OFF, ALL_OFF, ALL_OFF, ALL_OFF, auto_sign, 5'h0,
                                ALL_OFF, ALL_OFF, ALL_OFF, ALL_OFF, auto_sign, 5'h0,
                                ALL_OFF, ALL_OFF, ALL_OFF, ALL_OFF, auto_sign, 5'h0,
                                ALL_OFF, ALL_OFF, ALL_OFF, ALL_OFF, auto_sign, 5'h0};

    disp_inf            : bcd = {ALL_OFF, ALL_OFF, auto_sign, LOWERCASE_I, LOWERCASE_N, LOWERCASE_F,
                                ALL_OFF, ALL_OFF, auto_sign, LOWERCASE_I, LOWERCASE_N, LOWERCASE_F,
                                ALL_OFF, ALL_OFF, auto_sign, LOWERCASE_I, LOWERCASE_N, LOWERCASE_F,
                                ALL_OFF, ALL_OFF, auto_sign, LOWERCASE_I, LOWERCASE_N, LOWERCASE_F};

    disp_nan            : bcd = {ALL_OFF, ALL_OFF, ALL_OFF, UPPERCASE_N, UPPERCASE_A, UPPERCASE_N,
                                ALL_OFF, ALL_OFF, ALL_OFF, UPPERCASE_N, UPPERCASE_A, UPPERCASE_N,
                                ALL_OFF, ALL_OFF, ALL_OFF, UPPERCASE_N, UPPERCASE_A, UPPERCASE_N,
                                ALL_OFF, ALL_OFF, ALL_OFF, UPPERCASE_N, UPPERCASE_A, UPPERCASE_N};
                                
    default             : bcd = {5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19,
                                5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19,
                                5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19,
                                5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19, 5'd19};

    endcase
end

assign ostart = start_q;
assign oworking = (state_zero || state_denorm || state_norm || state_denorm_int || state_norm_int || state_inf || state_nan);
assign odone = state_done;
assign dp_en = disp_denorm_norm;

endmodule