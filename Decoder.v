module Decoder(hex, index);


//Decoder taken from labs
input [3:0] hex;
output reg[6:0] index;


always @ (*)
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
      
   endcase	

    
endmodule