module dff
#(parameter int size = 1) // adjust flip-flop size
(
    input logic [size-1:0] d,
    input logic clk,
    input logic rst,
    input logic en,
    output logic [size-1:0] q
);

// Creating the flip-flop
always_ff @ (posedge clk) begin // check conditions on rising clock edge
    priority case (1'b1)
        ~rst: q[size-1:0] <= '0; // active low reset
        en: q[size-1:0] <= d[size-1:0]; // ff enabled
        default: q[size-1:0] <= q[size-1:0]; // ff not enabled
    endcase
end

endmodule

