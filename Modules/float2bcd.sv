

module float2bcd(
    input logic [31:0] fnum,
    input logic clk,
    input logic rst,
    input logic start,
    output logic ostart,
    output logic oshifting,
    output logic odone,
    output logic [47:0]bcd
);

localparam int FF_TRAIN_EC = 11;

logic sign;
logic [7:0] exp;
logic [23:0] mantisa;
logic [276:0] pre_norm, norm;
logic [127:0] int_sec;
logic [148:0] frac_sec_async;
logic [152:0] frac_sec; //4 bits larger, enuf to accomidate nibble of int portion after mul10
//128 (1 from 1.f + 127 from 2^127) bits for int poriton, implicit binary point, 149 (23 + 126 from f in 1.f)

logic start_q, shifting, done;
logic [4:0] ff_train [FF_TRAIN_EC-1:0];

assign {
    sign,
    exp,
    mantisa
} = {
    fnum[31],
    //if at or above the bias, regular application, if bellow we need to do the subratction,
    //then get the abs value, remove the 2s complement of the neg number
    (fnum[30:23] >= 8'd127) ? (fnum[30:23] - 8'd127) : ~(fnum[30:23] - 8'd128),
    {1'b1, fnum[22:0]}
};

assign pre_norm = {127'b0, mantisa, 126'b0};

assign norm = (fnum[30:23] >= 8'd127) ? pre_norm << exp : pre_norm >> exp;
assign int_sec = norm[276:149];
assign frac_sec_async = norm[148:0];

//int_sec gets passed into a bcd when edgar finishes that

//frac_sec goes through mul10 algorithm fsm
always_ff @(posedge clk or negedge rst) begin
    if(!rst) begin
        start_q <= '0;
        shifting <= '0;
        done <= '0;

        frac_sec <= '0;

        //rst ff train
        for(int ii = 0; ii < FF_TRAIN_EC; ii++) begin
            ff_train[ii] <= '0;
        end

    end else if(start_q) begin
        start_q <= '0;
        shifting <= 1'b1;
        done <= '0;

        frac_sec <= {4'b0, frac_sec_async};

    end else if(shifting) begin
        start_q <= '0;
        shifting <= ~(ff_train[FF_TRAIN_EC-1][4] == 1'b1);
        done <= (ff_train[FF_TRAIN_EC-1][4] == 1'b1);

        frac_sec <= (frac_sec[148:0] << 2'd3) + (frac_sec[148:0] << 1'd1);

        ff_train[0] <= {1'b1, frac_sec[152:149]};  //set occupied bit to high, lower 4 bits bcd
        for(int ii = 1; ii < FF_TRAIN_EC; ii++) begin
            ff_train[ii] <= ff_train[ii-1];
        end
        
    end else if(done) begin
        //do nothing

    end else begin
        start_q <= start;
    end
end

assign bcd = {
    int_sec[3:0],
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

assign ostart = start_q;
assign oshifting = shifting;
assign odone = done;

endmodule