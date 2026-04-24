module uart_packing #(
    parameter SIGNAL_WIDTH = 368,               //default is 368
    parameter BUFFER_SIZE = SIGNAL_WIDTH + 32   // Total size of the data buffer, including the debug signals and the end bytes
)(
    input logic clk,
    input logic reset,
    input logic busy,
    input logic divided_clk_en,
    input logic local_clk, 
    input logic debug_clk,
    input logic cpu_finish,
    input logic cpu_halt,
    input logic [SIGNAL_WIDTH-1:0] dbg_signals,

    output logic send,
    output logic [7:0] out_byte
); 

    logic [BUFFER_SIZE-1:0] data_buffer; // Buffer to hold the data to be sent
    logic [31:0] end_bytes; // Register to hold the last bytes sent

    logic old_local_clk; // Register to hold the previous state of the CPU clock
    logic cpu_tick; // Signal to indicate a change in the CPU clock

    logic old_debug_clk; // Register to hold the previous state of the debug clock
    logic fast_tick; // Signal to indicate a CPU finish or halt event, which triggers data packing

    logic condition; // Combined condition to trigger data packing based on the clock division and CPU events

    assign end_bytes = 32'hBEEF0A0D; // Initialize end_bytes with the newline and carriage return characters to signify the end of a data packet

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    always_ff @(posedge clk) begin
        old_local_clk <= local_clk; // Capture the (10Hz or manual) CPU clock to synchronize data packing
        cpu_tick <= (local_clk && !old_local_clk); // Detect a positive edge in the CPU clock to trigger data packing

        old_debug_clk <= debug_clk; // Capture the debug clock (only 10Hz) to synchronize data packing
        fast_tick <= (debug_clk && !old_debug_clk); // Detect a positive edge in the debug clock to trigger data packing on CPU finish/halt events
    end

    assign condition = (divided_clk_en) ? (fast_tick && ( cpu_finish || cpu_halt )) : cpu_tick; // Use the appropriate signal to trigger data packing based on the clock division

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START,
        CAPTURE,
        SHIFT,
        LOADING
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_comb begin
        unique case (state)
            IDLE: next_state = (!busy && condition) ? START : IDLE; // Wait until not busy and the appropriate cpu clocking condition is met to start sending data
            START: next_state = CAPTURE; // Move to CAPTURE state after initiating send
            CAPTURE: next_state = SHIFT; // Move to SHIFT state after tx has captured the data
            SHIFT: next_state = LOADING; // Move to LOADING state after shifting the data buffer to prepare the next byte for sending
            LOADING: next_state = (data_buffer == '0) ? IDLE : ((!busy) ? START : LOADING); // Return to START state to send the next byte if not busy, otherwise stay in LOADING
            default: next_state = IDLE;
        endcase
    end

    // Sequential logic to update state and manage shift register
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin

            state <= IDLE;
            data_buffer <= {end_bytes, dbg_signals}; // Load the data buffer with the data to be sent

        end else begin

            state <= next_state;

            if (state == IDLE) begin
                data_buffer <= {end_bytes, dbg_signals}; // Load the data buffer with the data to be sent
            end else if (state == SHIFT) begin
                data_buffer <= {8'b0, data_buffer[BUFFER_SIZE-1:8]}; // Shift the data buffer to prepare the next byte for sending
            end
        end
    end

    // output logic
    assign out_byte = data_buffer[7:0]; // Output the least significant byte of the data buffer
    assign send = (state == START); // Trigger send when in the START state

endmodule