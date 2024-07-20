module clock_divider (
    input wire clk_in,      // Input clock (e.g., 100 MHz)
    input wire reset,       // Reset signal
    output reg clk_out      // Divided clock output
);
    parameter DIVISOR = 500; // Adjust this value to get the desired output frequency

    reg [31:0] counter;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == (DIVISOR - 1)) begin
                counter <= 0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule