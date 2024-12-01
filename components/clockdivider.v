module Clockdivider(cin, cout);

// Clock divider for milliseconds (1 kHz output)
input cin;
output reg cout;

reg [15:0] count = 16'd0; // 16-bit counter for up to 50,000
always @(posedge cin) begin
    if (count < 50000 - 1) begin // Count up to 49,999 (50,000 cycles)
        count <= count + 16'd1;
    end else begin
        count <= 16'd0; // Reset counter
        cout <= ~cout;  // Toggle output clock
    end
end
endmodule
