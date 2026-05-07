module clock_25(
    input logic clk_50,
    input logic rst,
    output logic vga_clk //25mhz clk
);


always_ff @(posedge clk_50) begin
    priority case(1'b1)
        ~rst: vga_clk = 1'b0;
        default: vga_clk = ~vga_clk;
    endcase
end

endmodule
