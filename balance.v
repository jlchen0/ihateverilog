module balance (
    input wire clk,
    input wire [3:0] score, 
    output reg [3:0] output1, 
    output reg [3:0] output2
); 
    reg [3:0] digit1; 
    reg [3:0] digit2; 

    initial begin
        output1 = 0; 
        output2 = 0; 
        digit1 = 0;
        digit2 = 0; 
    end

    always @(posedge clk) begin
        if (score == 10) begin
            if (digit1 != 9) begin
                digit1 <= digit1 + 1; 
                digit2 <= digit2; 
            end else begin
                // Overflow, max 
                digit1 <= 9;
                digit2 <= 9; 
            end
        end else if (score == 5) begin
            if (digit1 == 9 && digit2 >= 5) begin
                digit1 <= 9;
                digit2 <= 9; 
            end else if (digit2 >= 5) begin
                digit1 = digit1 + 1; 
                digit2 = digit2 - 5; 
            end else begin
                digit1 <= digit1;
                digit2 = digit2 + 5; 
            end
        end else if (score == 1) begin
            if (digit1 == 9 && digit2 == 9) begin
                digit1 <= 9;
                digit2 <= 9; 
            end else if (digit2 == 9) begin
                digit2 <= 0; 
                digit1 <= digit1 + 1; 
            end else begin
                digit1 <= digit1;
                digit2 <= digit2 + 1;  
            end
        end else begin
            digit1 <= digit1; 
            digit2 <= digit2; 
        end
    end

    always @(digit1) begin
        output1 = digit1; 
    end

    always @(digit2) begin
        output2 = digit2; 
    end
    
endmodule