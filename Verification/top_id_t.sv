
`timescale 1ns/1ps

module id_t_tb;

    // DUT inputs
    logic [31:0] instr;
    logic        r_type, i_type, s_type, b_type, u_type, j_type;

    // DUT outputs
    logic [4:0]  rs1, rs2, rd;
    logic [31:0] im;

    // Instantiate DUT
    id_t dut (
        .instr (instr),
        .rs1   (rs1),
        .rs2   (rs2),
        .rd    (rd),
        .im    (im),
        .r_type(r_type),
        .i_type(i_type),
        .s_type(s_type),
        .b_type(b_type),
        .u_type(u_type),
        .j_type(j_type)
    );

    // Convenience task: clear all type bits
    task automatic clear_types();
        {r_type, i_type, s_type, b_type, u_type, j_type} = '0;
    endtask

    initial begin
        $display("Starting id_t testbench...");

        // Default reset values
        instr = '0;
        clear_types();
        #1;

        // ----------------------------
        // R-type test
        // ----------------------------
        // Fields:
        //   rs2 = 5'b00010 = 2
        //   rs1 = 5'b00100 = 4
        //   rd  = 5'b01000 = 8
        //   imm should be 0
        instr = 32'h0022_0433;   // 0000000_00010_00100_000_01000_0110011
        clear_types();
        r_type = 1'b1;
        #1; // allow combinational logic to settle

        assert (rs1 == 5'd4 && rs2 == 5'd2 && rd == 5'd8 && im == 32'h0000_0000)
            else $error("R-type decode failed: rs1=%0d rs2=%0d rd=%0d im=%h",
                         rs1, rs2, rd, im);

        // ----------------------------
        // I-type test
        // ----------------------------
        // Immediate = instr[31:20] = 0xFFF -> sign-extended = 0xFFFF_FFFF (-1)
        // rs1 = 5'b00101 = 5
        // rd  = 5'b01010 = 10
        // rs2 should be 0 for I-type
        instr = 32'hFFF2_8513;   // 111111111111_00101_000_01010_0010011
        clear_types();
        i_type = 1'b1;
        #1;

        assert (rs1 == 5'd5 && rs2 == 5'd0 && rd == 5'd10 && im == 32'hFFFF_FFFF)
            else $error("I-type decode failed: rs1=%0d rs2=%0d rd=%0d im=%h",
                         rs1, rs2, rd, im);

        // ----------------------------
        // S-type test
        // ----------------------------
        // rs2 = 3, rs1 = 6, rd must be 0
        // immediate (12-bit) encoded across [31:25] and [11:7] = -4
        // so im = 0xFFFF_FFFC
        instr = 32'hFE33_0E23;   // 1111111_00011_00110_000_11100_0100011
        clear_types();
        s_type = 1'b1;
        #1;

        assert (rs1 == 5'd6 && rs2 == 5'd3 && rd == 5'd0 && im == 32'hFFFF_FFFC)
            else $error("S-type decode failed: rs1=%0d rs2=%0d rd=%0d im=%h",
                         rs1, rs2, rd, im);

        // ----------------------------
        // B-type test
        // ----------------------------
        // rs2 = 3, rs1 = 6, rd must be 0
        // immediate decodes (with sign extension) to +4
        instr = 32'h0033_0263;   // 0_000000_00011_00110_000_0010_0_1100011
        clear_types();
        b_type = 1'b1;
        #1;

        assert (rs1 == 5'd6 && rs2 == 5'd3 && rd == 5'd0 && im == 32'h0000_0004)
            else $error("B-type decode failed: rs1=%0d rs2=%0d rd=%0d im=%h",
                         rs1, rs2, rd, im);

        // ----------------------------
        // U-type test
        // ----------------------------
        // imm[31:12] = 0x00001, rd = 10
        // im output = {instr[31:12], 12'h0} = 0x0000_1000
        instr = 32'h0000_1537;   // 00000000000000000001_01010_0110111
        clear_types();
        u_type = 1'b1;
        #1;

        assert (rs1 == 5'd0 && rs2 == 5'd0 && rd == 5'd10 && im == 32'h0000_1000)
            else $error("U-type decode failed: rs1=%0d rs2=%0d rd=%0d im=%h",
                         rs1, rs2, rd, im);

        // ----------------------------
        // J-type test
        // ----------------------------
        // rd = 10, small positive offset ? im = 0x0000_1000
        instr = 32'h0000_156F;   // 0_00000000_0_0000000001_01010_1101111
        clear_types();
        j_type = 1'b1;
        #1;

        assert (rs1 == 5'd0 && rs2 == 5'd0 && rd == 5'd10 && im == 32'h0000_1000)
            else $error("J-type decode failed: rs1=%0d rs2=%0d rd=%0d im=%h",
                         rs1, rs2, rd, im);

        $display("All id_t tests completed.");
        $finish;
    end

endmodule