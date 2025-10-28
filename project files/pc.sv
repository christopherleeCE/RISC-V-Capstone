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
    input logic clk, rst, inc, wr_en, 
    output logic [WIDTH-1:0] q
);

    logic [WIDTH-1:0] ff_d, ff_q;

    always_comb begin
        unique case(1'b1)

        inc:        ff_d = ff_q + 1;
        wr_en:  ff_d = d;
        default:    ff_d = ff_q;

        endcase
    end

    dff_async_reset #(
        .WIDTH(WIDTH),
        .RESET_VALUE('0)
    ) pc_dff (
        .d(ff_d),
        .clk(clk),
        .rst(rst),
        .wr_en(inc || wr_en),
        .q(ff_q)
    );

    assign q = ff_q;

endmodule