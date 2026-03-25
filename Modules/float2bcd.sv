

module float2bcd(
    input logic [31:0] fnum,
    input logic clk,
    input logic rst,
    output logic bcd
);

logic sign;
logic signed [7:0] exp;
logic signed [7:0] exp_ff;
logic [23:0] mantisa;
logic [23:0] mantisa_ff;
logic [276:0] norm; 
//128 (1 from 1.f + 127 from 2^127) bits for int poriton, implicit binary point, 149 (23 + 126 from f in 1.f)

assign {
    sign,
    exp,
    mantisa
} = {
    fnum[31],
    fnum[30:23] - 8'b127,
    {1'b1, fnum[22:0]}
};

assign norm = (exp >= 0) mantisa << exp : mantisa >> exp;

always_ff @(posedge clk or negedge rst) begin
    if(!rst) begin
        exp_ff <= '0;
        mantisa_ff <= '0;

    end else begin

    end
end





endmodule