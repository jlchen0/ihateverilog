
module display (
    input wire clk, 
    input wire spin, 
    output reg [6:0] seg, // segments 
    output reg [3:0] an // anodes 
);
    reg [1:0] anode_counter;  
    
    wire [6:0] seg1; 
    wire [6:0] seg2; 
    wire [6:0] seg3; 
    wire [6:0] seg4; 

    initial begin
        anode_counter = 2'b00; 
    end
    
    // For iterating through anodes, every clk cycle += 1 
    always @(posedge clk) begin
        anode_counter <= anode_counter + 1; 
    end

    number n (.clk(clk), 
              .spin(spin), 
              .o1(seg1), 
              .o2(seg2),
              .o3(seg3),
              .o4(seg4)
    );

    always @(posedge clk) begin
        if (anode_counter == 2'b00) begin 
            // Display m1 
            seg <= seg1; 
            an <= 4'b0111; 
        end else if (anode_counter == 2'b01) begin
            // Display m2 
            seg <= seg2; 
            an <= 4'b1011;
        end else if (anode_counter == 2'b10) begin
            // Display m1 
            seg <= seg3; 
            an <= 4'b1101;
        end else begin
            // Display s2
            seg <= seg4; 
            an <= 4'b1110;
        end
    end    
endmodule    
