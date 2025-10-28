//active low asyncronous reset dff, stolen :)

module dff_async_reset  #(parameter int WIDTH = 1,
                        parameter logic [WIDTH-1:0] RESET_VALUE = '0) 

(
    input  logic [WIDTH-1:0]     d,
    input  logic                 clk,
    input  logic                 rst, // async reset, active low
    input  logic                 wr_en,
    output logic [WIDTH-1:0]     q
);

    always_ff @(posedge clk or negedge rst) begin
        if(!rst)
            q <= RESET_VALUE;
        else if(wr_en)
            q <= d;
    end
endmodule