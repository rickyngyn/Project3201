module clockdividersw(
    input clk,   
    output reg cout 
);
//This clock divider was taken from lab 4 altered for ms count
    
    reg [15:0] count; 
    
    always @(posedge clk) begin
        if (count == 16'd49999) begin  
            cout <= ~cout;  
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end
endmodule
