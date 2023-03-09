module digit_to_seg(
    input [3:0] digit, 
    output reg [6:0] display_binary
);
    always @(*) begin
        if (digit == 0) begin
            display_binary = 7'b1000000;
        end else if (digit == 1) begin
            display_binary = 7'b1111001;
        end else if (digit == 2) begin
            display_binary = 7'b0100100;
        end else if (digit == 3) begin
            display_binary = 7'b0110000;
        end else if (digit == 4) begin
            display_binary = 7'b0011001;
        end else if (digit == 5) begin
            display_binary = 7'b0010010;
        end else if (digit == 6) begin
            display_binary = 7'b0000010;
        end else if (digit == 7) begin
            display_binary = 7'b1111000;
        end else if (digit == 8) begin
            display_binary = 7'b0000000;
        end else if (digit == 9) begin
            display_binary = 7'b0011000;
        end else begin
            display_binary = 7'b0000000; // <- default, errors at 8 
        end
    end

endmodule