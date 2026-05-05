
module counter #(
    parameter int BW=4, //bitwidth for count
    parameter int OVERFLOW_VAL=10  //overflow value, OVERFLOW_VAL=10 will go 7, 8, 9, 0, 1, etc
)(
    input  logic         inc,
    input  logic         clk,
    input  logic         rst,
    output logic [BW-1:0] cnt 
);
    logic [BW-1:0] next_cnt;

    always_comb begin
        case(1'b1)

        (inc && (cnt != OVERFLOW_VAL-1))   :   next_cnt = cnt + 1'b1;
        (inc && (cnt == OVERFLOW_VAL-1))   :   next_cnt = '0;
        default                 :   next_cnt = cnt;

        endcase
    end

    always_ff @(posedge clk or negedge rst) begin
        if(!rst) begin
            cnt <= '0;
        end else begin
            cnt <= next_cnt;
        end
    end
   
endmodule 