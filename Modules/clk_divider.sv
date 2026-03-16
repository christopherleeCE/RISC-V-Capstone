module clk_divider #(
    parameter int DIVIDE = 10     // input clock divided by this value
)(
    input  logic clk_in,
    input  logic rst_n,
    output logic clk_out
);

    // number of input cycles per toggle
    localparam int HALF_DIV = DIVIDE/2;

    logic [$clog2(HALF_DIV)-1:0] cnt;

    always_ff @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            cnt     <= '0;
            clk_out <= 1'b0;
        end
        else begin
            if (cnt == HALF_DIV-1) begin
                cnt     <= '0;
                clk_out <= ~clk_out;
            end
            else begin
                cnt <= cnt + 1;
            end
        end
    end

endmodule