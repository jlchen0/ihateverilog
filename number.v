// Outputs the correct number... 

module iter (
    input wire clk, 
    output reg [3:0] val
); 
    initial begin
        val = 9; 
    end

    always @(posedge clk) begin
        if (val == 0)
            val = 9; 
        else
            val = val - 1; 
    end
endmodule

module rolling_clk(
    input wire clk,
    output reg output_clk
);
    integer mod = 35 - 1; // (700 Hz / 10 hz) / 2 - 1
    integer counter = 0; 

    initial begin
        output_clk = 0;
    end
    always @(posedge clk) begin
        if (counter == mod) begin
            counter <= 0;
            output_clk <= ~output_clk;
        end else begin
            counter <= counter + 1; 
        end
    end
endmodule

module clk_2s (
    input wire clk, 
    input wire active,
    output reg output_clk
); 

    initial begin
        output_clk = 0;
    end
    integer mod = 700 - 1; // (700 Hz / 0.5 hz) / 2 - 1
    integer counter = 0; 

    always @(posedge clk) begin
        if (~active) 
            output_clk <= 0; 
        else begin
            if (counter == mod) begin
                counter <= 0;
                output_clk <= ~output_clk;
            end else begin
                counter <= counter + 1; 
            end
        end
    end
endmodule


module clk_5s (
    input wire clk, 
    input wire active,
    output reg output_clk
); 
    initial begin
        output_clk = 0;
    end
    integer mod = 1750 - 1; // (700 Hz / 0.5 hz) / 2 - 1
    integer counter = 0; 

    always @(posedge clk) begin
        if (~active) 
            output_clk <= 0; 
        else begin
            if (counter == mod) begin
                counter <= 0;
                output_clk <= ~output_clk;
            end else begin
                counter <= counter + 1; 
            end
        end
    end
endmodule


module number (
    input wire clk, 
    input wire spin,
    output reg [6:0] o1, 
    output reg [6:0] o2, 
    output reg [6:0] o3, 
    output reg [6:0] o4
); 
    
    reg show_final; 
    reg fixed1; 
    reg fixed2; 
    reg fixed3;
    reg fixed4; 
    reg spin_active; 
    reg stop_active; 
    wire spin_clk; 
    wire stop_clk; 

    initial begin 
        o1 = 7'b0000000; 
        o2 = 7'b0000000; 
        o3 = 7'b0000000; 
        o4 = 7'b0000000; 
        show_final = 0; 
        fixed1 = 0;
        fixed2 = 0; 
        fixed3 = 0;
        fixed4 = 0; 
        spin_active = 0; 
    end

    wire [3:0] d1;// = 4'b0001; 
    wire [3:0] d2;// = 4'b0101; 
    wire [3:0] d3;// = 4'b0111; 
    wire [3:0] d4;// = 4'b0000; 

    // These vars hold the real spin output segments 
    wire [6:0] seg1; 
    wire [6:0] seg2; 
    wire [6:0] seg3; 
    wire [6:0] seg4; 

    wire clk2; 
    wire clk3; 
    wire clk4; 
    
    wire r_clk1; 
    wire r_clk2; 
    wire r_clk3; 
    wire r_clk4; 
    
    // Counter stuff 
    wire [3:0] i1;// = 4'b0001; 
    wire [3:0] i2;// = 4'b0101; 
    wire [3:0] i3;// = 4'b0111; 
    wire [3:0] i4;// = 4'b0000; 


    // These vars hold the real spin output segments 
    wire [6:0] i_seg1; 
    wire [6:0] i_seg2; 
    wire [6:0] i_seg3; 
    wire [6:0] i_seg4;
 
    clk_delay cd (.clk(clk), .delay(clk2));
    clk_delay cd2 (.clk(clk2), .delay(clk3));
    clk_delay cd3 (.clk(clk3), .delay(clk4));

    rng r1 (.clk(clk),
            .spin(spin),
            .digit(d1)); 
    rng r2 ( .clk(clk2),
            .spin(spin),
            .digit(d2)); 
    rng r3 (.clk(clk3),
            .spin(spin),
            .digit(d3));
    rng r4 (.clk(clk4),
            .spin(spin),
            .digit(d4));   

    digit_to_seg digit1 (
        .digit(d1),
        .display_binary(seg1)
    ); 

    digit_to_seg digit2 (
        .digit(d2),
        .display_binary(seg2)
    ); 

    digit_to_seg digit3 (
        .digit(d3),
        .display_binary(seg3)
    ); 

    digit_to_seg digit4 (
        .digit(d4),
        .display_binary(seg4)
    );

    rolling_clk roll1 (.clk(clk), .output_clk(r_clk1)); 
    
    rolling_clk roll2 (.clk(clk), .output_clk(r_clk2)); 
    rolling_clk roll3 (.clk(clk), .output_clk(r_clk3)); 
    rolling_clk roll4 (.clk(clk), .output_clk(r_clk4));  

    // clk_delay delay1 (.clk(r_clk1), .delay(r_clk2)); 
    // clk_delay delay2 (.clk(r_clk2), .delay(r_clk3)); 
    // clk_delay delay3 (.clk(r_clk3), .delay(r_clk4)); 


    iter c1 (.clk(r_clk1), .val(i1)); 
    iter c2 (.clk(r_clk2), .val(i2)); 
    iter c3 (.clk(r_clk3), .val(i3)); 
    iter c4 (.clk(r_clk4), .val(i4)); 

    digit_to_seg iseg1 (.digit(i1), .display_binary(i_seg1));
    digit_to_seg iseg2 (.digit(i2), .display_binary(i_seg2));
    digit_to_seg iseg3 (.digit(i3), .display_binary(i_seg3));
    digit_to_seg iseg4 (.digit(i4), .display_binary(i_seg4));

    // on spinning: continue to iterate for 2 seconds
    // then show final for 2 seconds 
    // and then reset 

    clk_2s show_final_clk (.clk(clk), .active(spin_active), .output_clk(spin_clk));
    clk_5s run_stop_clk (.clk(clk), .active(stop_active), .output_clk(stop_clk));

    // Pick the correct one to output 
    always @(posedge clk) begin
        if (show_final) begin
            if (fixed1) begin
                o1 <= seg1; 
            end else begin
                o1 <= i_seg1; 
                if (i_seg1 == seg1)
                    fixed1 <= 1; 
                else 
                    fixed1 <= 0; 
            end

            if (fixed2) begin
                o2 <= seg2; 
            end else begin
                o2 <= i_seg2; 
                if (i_seg2 == seg2)
                    fixed2 <= 1; 
                else 
                    fixed2 <= 0;                 
            end

            if (fixed3) begin
                o3 <= seg3; 
            end else begin
                o3 <= i_seg3; 
                if (i_seg3 == seg3)
                    fixed3 <= 1; 
                else 
                    fixed3 <= 0;                    
            end

            if (fixed4) begin
                o4 <= seg4; 
            end else begin
                o4 <= i_seg4; 
                if (i_seg4 == seg4)
                    fixed4 <= 1; 
                else 
                    fixed4 <= 0;
            end
        end else begin
            o1 <= i_seg1; 
            o2 <= i_seg2; 
            o3 <= i_seg3; 
            o4 <= i_seg4;
        end
    end
    // Requirements: MUST HOLD SPIN FOR AT LEAST 7 SECONDS
    always @(posedge spin) begin
        spin_active <= 1; 
        // also reset all the fixed vars
    end

    always @(posedge spin_clk) begin
        // after 2 seconds, set show_final = 1 and spin_active = 0 
        show_final <= 1;
        spin_active <= 0; 
        stop_active <= 1; 
    end

    always @(posedge stop_clk) begin
        // 5 seconds after that, set show_final = false
        show_final <= 0; 
        stop_active <= 0; 
        fixed1 <= 0;
        fixed2 <= 0;
        fixed3 <= 0; 
        fixed4 <= 0; 
    end
endmodule

