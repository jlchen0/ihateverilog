module rng(
    input clk,
    input spin,
    output reg [3:0] digit
);
    reg [4:0] d;
    
    initial begin
        d = 5'b01010;
        digit = 4'b0000;
    end

    always @(posedge clk) begin
        d = { d[3:0], d[4] ^ d[2] };
        d = d + 1;
    end
    
    always @(posedge spin) begin
        digit <= d[3:0];
        $display("RNG picked: ", d[3:0]); 
    end
endmodule
