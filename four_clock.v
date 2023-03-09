
module clock_state (
    input wire [2:0] state, 
    input wire [3:0] clks,
    output reg output_clk
); 
    always @(*) begin
        // if select states, use 2hz clock 
        if (state == 3'b010 || state == 3'b011 || state == 3'b111 || state == 3'b110) 
            output_clk <= clks[0];
        else 
            output_clk <= clks[1];
    end
endmodule 

module four_clock (
    input wire clk, 
    input wire rst, 
    output reg [3:0] clks // 2hz, 1hz, display, blink from 0 -> 3 idxs
);
    integer counter2hz;
    integer counter1hz; 
    integer counter_display;
    integer counter_blink;  

    // Constants
    integer freq2hz = 25E6 - 1; // (100e6 hz/ 2 hz) / 2 - 1 
    integer freq1hz = 500E6 - 1; // (100e6 hz/ 0.1 hz) / 2 - 1 
    integer freq_display = 1E5 - 1; // (100e6 hz / 500 hz) / 2 - 1 
    integer freq_blink = 125E5 - 1; // (100e6 hz / 4 hz) / 2 - 1

    initial begin
        counter2hz = 0; 
        counter1hz = 0;
        counter_display = 0;
        counter_blink = 0; 
    end

    always @(posedge clk) begin
        if (rst == 1) begin 
            // reset all 
            clks <= 4'b0000;
            counter2hz <= 0; 
            counter1hz <= 0;
            counter_display <= 0;
            counter_blink <= 0;
            
        end else begin 
            if (counter2hz == freq2hz) begin
                clks[0] <= ~clks[0];
                counter2hz <= 0;
            end else begin
                counter2hz <= counter2hz + 1;
            end

            if (counter1hz == freq1hz) begin
                clks[1] <= ~clks[1];
                counter1hz <= 0;
            end else begin
                counter1hz <= counter1hz + 1;
            end 

            if (counter_display == freq_display) begin
                clks[2] <= ~clks[2];
                counter_display <= 0;
            end else begin
                counter_display <= counter_display + 1;
            end 

            if (counter_blink == freq_blink) begin
                clks[3] <= ~clks[3];
                counter_blink <= 0;
            end else begin
                counter_blink <= counter_blink + 1;
            end
        end
    end
endmodule
