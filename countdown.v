
// SIMILIAR TO LAB 4 MODULE
module countdown(
	input clock,
	input reset,
	input pause,
	input tens,
	input switch,    
	input [3:0] set1,            
	output reg [3:0] digit1,
	output reg [3:0] digit2
	);
	
	wire cout;
	reg enable;
	Clockdivider clk_divider(clock, cout);
	
	
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
	
	endmodule 