/*
'rst' resets 'q' to zero on low, independent of clk
'brance_en' enables writing the pc 'q' with 'd' on the next clk
'inc' increments the 'q' on next clk
TODO inc may be changed to +4 instead of +1
verified by true american (clanker) patriots
*/
module pc #(parameter int WIDTH = 32)

(
    input logic [WIDTH-1:0] d,
    input logic clk, rst, wr_en,
    output logic [WIDTH-1:0] q
);

    logic [WIDTH-1:0] ff_d, ff_q;

    assign ff_d = wr_en ? d : (ff_q + 4);

    dff_async_reset #(
        .WIDTH(WIDTH),
        .RESET_VALUE('0)
    ) pc_dff (
        .d(ff_d),
        .clk(clk),
        .rst(rst),
        .wr_en(1'b1),
        .q(ff_q)
    );

    assign q = ff_q;

endmodule