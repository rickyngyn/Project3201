module ClockCounter(cin, cout);
input cin;
output reg cout;
   
reg [31:0] count = 32'd0;
parameter D = 25000000;
always @(posedge cin) begin
    if (count >= D - 1) begin
        count <= 32'd0;
        cout <= ~cout;
    end else begin
        count <= count + 32'd1;
    end
end
endmodule
module Decoder(hex, index);
input [3:0] hex;
output reg [6:0] index;
always @(*) begin
    case (hex)
        0: index = 7'b0000001;
        1: index = 7'b1001111;
        2: index = 7'b0010010;
        3: index = 7'b0000110;
        4: index = 7'b1001100;
        5: index = 7'b0100100;
        6: index = 7'b0100000;
        7: index = 7'b0001101;
        8: index = 7'b0000000;
        9: index = 7'b0000100;
        default: index = 7'b1111111;
    endcase
end
endmodule
// SIMILIAR TO LAB 4 MODULE
module finalProj(clock, reset, pause, switch, set1, l1, l2, tens);
input clock;
input reset;
input pause;
input tens;
input switch;       
input [3:0] set1;      
output [6:0] l1;
output [6:0] l2;
wire cout;
reg enable;       
reg [3:0] digit1 = 4'd0;
reg [3:0] digit2 = 4'd0;
ClockCounter clk_divider(clock, cout);
always @(negedge pause) begin
    enable <= ~enable;
end

always @(posedge cout) begin
    if (reset == 0) begin
        digit1 <= 4'd0;
        digit2 <= 4'd0;
    end else if (switch == 0) begin
        digit1 <= 4'd10;
        digit2 <= 4'd10;
    end else if (switch == 1 && enable == 0) begin
        digit1 <= set1;
		  if (tens == 1) begin
				digit2 <= set1;
		  end
    end else if (enable) begin
        if (digit1 == 4'd0 && digit2 == 4'd0) begin
            digit1 <= 4'd0;
            digit2 <= 4'd0;
        end else if (digit1 == 4'd0) begin
            digit1 <= 4'd9;
            digit2 <= digit2 - 1;
        end else begin
            digit1 <= digit1 - 1;
        end
    end
end
Decoder d1((digit1 < 10) ? digit1 : 4'd10, l1);
Decoder d2((digit2 < 10) ? digit2 : 4'd10, l2);
endmodule
