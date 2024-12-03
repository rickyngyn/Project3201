module stopwatch (
    input clk,             
    input reset,           
    input pause,      
    output reg[3:0] ms1,     
    output reg[3:0] ms2,
	 output reg[3:0] ms3,
    output reg[3:0] s1,     
    output reg[3:0] s2,
	 output reg[3:0] m1
);

    reg [3:0] sec1sw = 0;  
    reg [3:0] sec2sw = 0;  
    reg [3:0] min1sw = 0;   
    reg [3:0] ms1sw = 0;   
    reg [3:0] ms2sw = 0;   
    reg [3:0] ms3sw = 0;   

    wire cout;    
	 reg b = 1;
    
    clockdividersw clk_div (
        .clk(clk),
        .cout(cout)
    );
	 
	 always @(negedge pause) 
	begin
		b = ~b;
	end

    always @(posedge cout & b) begin
			ms1 = ms1sw;
			ms2 = ms2sw;
			ms3 = ms3sw;
			s1 = sec1sw;
			s2 = sec2sw;
			m1 = min1sw;
		  if (reset == 0) begin
            sec1sw <= 0;
            sec2sw <= 0;
            min1sw <= 0;
            ms1sw <= 0;
            ms2sw <= 0;
            ms3sw <= 0;
        end else if (reset != 0) begin  
                if (ms3sw < 9) begin
                    ms3sw <= ms3sw + 1;
                end else begin
                    ms3sw <= 0;
                    if (ms2sw < 9) begin
                        ms2sw <= ms2sw + 1;
                    end else begin
                        ms2sw <= 0;
                        if (ms1sw < 9) begin
                            ms1sw <= ms1sw + 1;
                        end else begin
                            ms1sw <= 0;
                            if (sec2sw < 9) begin
                                sec2sw <= sec2sw + 1;
                            end else begin
                                sec2sw <= 0;
                                if (sec1sw < 5) begin
                                    sec1sw <= sec1sw + 1;
                                end else begin
                                    sec1sw <= 0;
                                    if (min1sw < 9) begin
                                        min1sw <= min1sw + 1;
                                    end else begin
                                        min1sw <= 0;
                                    end
                                end
                            end
                        end
                    end 
            end
        end
    end
endmodule
