module clockdivider(cin, cout);

//This clock divider was taken from lab 4

input cin;
output reg cout; 

reg[31:0] count = 32'd0;
always @(posedge cin) begin
	if (count < 25000000) begin
		count <= count + 32'd1;
	end else begin
		count <= 32'd0;
		cout <= ~cout;
	end
end
endmodule 