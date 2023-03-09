`timescale 1ns / 1ps


module clk_delay(
    input clk,
    output reg delay
);
    
    integer counter = 0; 
    always @(posedge clk) begin
       counter <= counter + 1; 
       if (counter == 1) begin
            delay <= 1;
       end else if (counter == 2) begin
            counter <= 0;
            delay <= 0;
       end
    end
endmodule
