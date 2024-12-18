module clock(

	input clk,
	input pause,
	input reset,
	output reg[3:0] sec1,
   output reg[3:0] sec2,
	output reg[3:0] min1,
   output reg[3:0] min2,
	output reg[3:0] hour1,
   output reg[3:0] hour2
); 

	reg [3:0] sec_reg1 = 4'd0;
	reg [3:0] sec_reg2 = 4'd1;
	reg [3:0] min_reg1 = 4'd0;
	reg [3:0] min_reg2 = 4'd1;
	reg [3:0] hour_reg1 = 4'd0;
	reg [3:0] hour_reg2 = 4'd1;
	
	reg b = 1;
	
	wire cout;
	
	Clockdivider clk_div(clk, cout);
	
	always @(negedge pause) 
	begin
		b = ~b;
	end
		always @(posedge cout & b) begin
			sec1 <= sec_reg1;
			sec2 <= sec_reg2;
			min1 <= min_reg1;
			min2 <= min_reg2;
			hour1 <= hour_reg1;
			hour2 <= hour_reg2;
			if (reset == 0) begin
				sec_reg1 <= 0;
				sec_reg2 <= 0;
				min_reg1 <= 0;
				min_reg2 <= 0;
				hour_reg1 <= 0;
				hour_reg2 <= 0;
			end else if (b == 0) begin
				sec_reg1 <= sec_reg1;
				sec_reg2 <= sec_reg2;
				min_reg1 <= min_reg1;
				min_reg2 <= min_reg2;
				hour_reg1 <= hour_reg1;
				hour_reg2 <= hour_reg2;
			end else if (reset != 0) begin
				if (sec_reg2 < 4'd9) begin
					sec_reg2 <= sec_reg2 + 1;
				end else begin
					sec_reg2 <= 4'd0;
					if (sec_reg1 < 4'd5) begin
						sec_reg1 <= sec_reg1 + 1;
					end else begin
						sec_reg1 <= 4'd0;
						if (min_reg2 < 4'd9) begin
							min_reg2 <= min_reg2 + 1;
						end else begin
							min_reg2 <= 4'd0;
							if (min_reg1 < 4'd5) begin
								min_reg1 <= min_reg1 + 1;
							end else begin
								min_reg1 <= 4'd0;
								if (hour_reg2 == 4'd3 && hour_reg1 == 4'd2) begin
									hour_reg2 <= 4'd0;
									hour_reg1 <= 4'd0;
								end else begin
									if (hour_reg2 < 4'd9) begin
										hour_reg2 <= hour_reg2 + 1;
									end else begin
										hour_reg2 <= 4'd0;
										if (hour_reg1 < 4'd2) begin
											hour_reg1 <= hour_reg1 + 1;
										end else begin
											hour_reg1 <= 4'd0;
											hour_reg2 <= 4'd0;
											min_reg1 <= 4'd0;
											min_reg2 <= 4'd0;
											sec_reg1 <= 4'd0;
											sec_reg2 <= 4'd0;
										end
									end
								end
							end
						end
					end
				end
			end
	end
	
		

endmodule
	

