module main(

	input clk,
	input pause,
	input switch,
	input tens,
	input reset,
	input clock,
	input stopwatch,
	input countdown,
	input [3:0] set,
	output [6:0] sec1,
   output [6:0] sec2,
	output [6:0] min1,
   output [6:0] min2,
	output [6:0] hour1,
   output [6:0] hour2
); 
	
	reg[6:0] sec1final;
   reg[6:0] sec2final;
	reg[6:0] min1final;
   reg[6:0] min2final;
	reg[6:0] hour1final;
   reg[6:0] hour2final;

	wire [6:0] sec1clock, sec2clock, min1clock, min2clock, hour1clock, hour2clock;

    clock clk_inst (
        .clk(clk),
        .pause(pause),
        .reset(reset),
        .sec1(sec1clock),
        .sec2(sec2clock),
        .min1(min1clock),
        .min2(min2clock),
        .hour1(hour1clock),
        .hour2(hour2clock)
    );
	 
	 wire[3:0] m1, s2, s1, ms3, ms2, ms1;
		
	 stopwatch sw_inst (
        .clk(clk),
        .reset(reset),
        .pause(pause),
        .ms1(ms1),
        .ms2(ms2),
        .ms3(ms3),
        .s1(s1),
        .s2(s2),
        .m1(m1)
    );
	 
	 wire[3:0] sc2, sc1;
	 countdown cd_inst (
        .clock(clk),
        .reset(reset),
        .pause(pause),
        .tens(tens),
        .switch(switch),
        .set1(set),
        .digit1(sc1),
        .digit2(sc2)
    );
	 
	 
	 always @(*) begin
		if (clock) begin
			sec1final = sec1clock;
			sec2final = sec2clock;
			min1final = min1clock;
			min2final = min2clock;
			hour1final = hour1clock;
			hour2final = hour2clock;
		end else if (stopwatch) begin
			sec1final <= ms2;
			sec2final <= ms3;
			min1final <= s2;
			min2final <= ms1;
			hour1final <= m1;
			hour2final <= s1;
		end else if (countdown) begin
			sec1final <= (sc2 < 10) ? sc2 : 4'd10;
			sec2final <= (sc1 < 10) ? sc1 : 4'd10;
			min1final <= 0;
			min2final <= 0;
			hour1final <= 0;
			hour2final <= 0;
		end
	 end
    // Assign final outputs to 7-segment displays
    Decoder sec1_decoder(sec1final, sec1);
    Decoder sec2_decoder(sec2final, sec2);
    Decoder min1_decoder(min1final, min1);
    Decoder min2_decoder(min2final, min2);
    Decoder hour1_decoder(hour1final, hour1);
    Decoder hour2_decoder(hour2final, hour2);

endmodule

	

