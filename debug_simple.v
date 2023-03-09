`timescale 1ns / 1ps

module simple (
    input wire clk,  // assume 100mhz 
    input wire rst, 
    input wire pause, 
    input wire sel,
    input wire adj, 
    output reg [6:0] seg, // segments 
    output reg [3:0] an // anodes 
); 
    
    wire [6:0] temp_seg; 
    wire [3:0] temp_an; 
    wire [3:0] clks; 
    
    four_clock c(.clk(clk), .rst(rst), .clks(clks));
    
    
    display d (.clk(clks[2]),  // 
               .spin(clks[1]), 
               .seg(temp_seg),
               .an(temp_an));
          
    always @(posedge clk) begin
        seg <= temp_seg; 
        an <= temp_an;
    end

endmodule
