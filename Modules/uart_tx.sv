// UART Transmitter module | Baud rate: 115200 | Data bits: 8 | Parity: None | Stop bits: 1

// This module is designed to transmit data over a UART interface. 
// It takes an 8-bit input byte and sends it serially on the 'tx' line. 

module uart_tx #(
    parameter BAUD_RATE = 115200,
    parameter GLOBAL_CLK_FREQ = 50000000
)(
    input logic clk,
    input logic reset,
    input logic [7:0] in_byte,
    input logic send,
    output logic busy,
    output logic tx
); 

    // Calculate the number of clock cycles needed for one bit period based on the baud rate and global clock frequency
    localparam integer BAUD_DIV = GLOBAL_CLK_FREQ / BAUD_RATE;

    logic [$clog2(BAUD_DIV)-1:0] baud_cnt; // Counter to keep track of the clock cycles for timing the bits
    logic [3:0] bit_cnt; // To count the bits being transmitted (start, data bits, stop)
    logic [9:0] shift_reg; // Shift register to hold the byte being transmitted, and the start and stop bits
    logic [7:0] my_byte; // Register to hold the input byte for transmission

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        START,
        BAUD_CNT,
        BIT_SHIFT
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_comb begin
        unique case (state)
            IDLE: next_state = send ? START : IDLE; // Wait for the send signal to start transmission
            START: next_state = BAUD_CNT; // Move to BAUD_CNT state to start timing the bits
            BAUD_CNT: next_state = (baud_cnt == BAUD_DIV - 1) ? BIT_SHIFT : BAUD_CNT; // Wait until the baud counter reaches the required count for one bit period before shifting bits
            BIT_SHIFT: next_state = (bit_cnt == 9) ? IDLE : BAUD_CNT; // After shifting all bits (start + 8 data bits + stop), return to IDLE, otherwise go back to BAUD_CNT to time the next bit
            default: next_state = IDLE;
        endcase
    end

    // Sequential logic to update state and manage counters and shift register
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin

            state <= IDLE;
            baud_cnt <= 0;
            bit_cnt <= 0;
            my_byte <= 8'hFF; // Default value for my_byte
            shift_reg <= 10'b1111111111; // Idle state of shift register (all bits high)
            tx <= 1; // Idle state of tx line is high

        end else begin

            state <= next_state;

            if (state == IDLE) begin

                baud_cnt <= 0;
                bit_cnt <= 0;
                my_byte <= 8'hFF; 
                shift_reg <= 10'b1111111111; 
                tx <= 1; 

            end else if (state == START) begin

                baud_cnt <= 0;
                bit_cnt <= 0;
                my_byte <= in_byte; // Capture the input byte to be transmitted
                shift_reg <= {1'b1, in_byte, 1'b0}; // Load shift register with start bit, data bits, and stop bit (LSB first)
                tx <= 1;

            end else if (state == BAUD_CNT) begin

                baud_cnt <= baud_cnt + 1; // Increment baud counter to time the bits
                bit_cnt <= bit_cnt;
                my_byte <= my_byte;
                shift_reg <= shift_reg;
                tx <= tx;

            end else if (state == BIT_SHIFT) begin

                baud_cnt <= 0;
                bit_cnt <= bit_cnt + 1; // Increment bit counter to keep track of how many bits have been sent
                my_byte <= my_byte;
                shift_reg <= {1'b1, shift_reg[9:1]}; // Shift right, filling with 1s for stop bits
                tx <= shift_reg[0]; // Output the least significant bit on tx line

            end
        end
    end

    // output logic
    assign busy = (state != IDLE); // Busy when not in IDLE state

endmodule