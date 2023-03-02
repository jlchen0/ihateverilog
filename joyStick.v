module joyStick(
    input clk,
    input [1:0] positions, 
    output [7:0] reg w,
    output [7:0] reg x,
    output [0:0] reg move,
    output [0:0] reg reset
    // up --> 1, down --> 0
);

reg [31:0] counter;
limit = 8'd10000000

always@(posedge clk) begin

  if (counter == limit) begin // Joystick has been moved X times
    reset = 1;
    x = 8'd0;
    y = 8'd0;
    counter = 0;
  end else begin // Joystick has been moved less than X times
    counter = counter + 1;
    reset = 0;
    move = 0;
  end

  /*
  if (counter == 8'd10000000) begin
    reset = 1;
    x = 8'd0;
  end
  */

  case(positions):
    
    // up
    2'b00: begin
        y = y + 1;
        move  = 1'b1;
    end

    // down
    2'b01: begin
        y = y - 1;
        move = 1'b1;
    end

    // left 
    2'b10: begin
        x = x - 1;
        move = 1'b0;
    end

    // right
    2'b11: begin
        x = x + 1;
        move = 1'b0;
    end

  endcase

end

endmodule
