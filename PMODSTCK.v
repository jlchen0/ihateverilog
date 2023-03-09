module pmod_jstk(
    input wire clk,
    input wire [2:0] JSTK_AXIS, // X-axis=JSTK_AXIS[0], Y-axis=JSTK_AXIS[1], button=JSTK_AXIS[2]
    output reg [7:0] LED,
    output reg [0:0] move
);

//reg [31:0] counter;
//limit = 8'd10000000

always@(posedge clk) begin

//   if (counter == limit) begin // Joystick has been moved X times
//     reset = 1;
//     x = 8'd0;
//     y = 8'd0;
//     counter = 0;
//   end else begin // Joystick has been moved less than X times
//     counter = counter + 1;
//     reset = 0;
//     move = 0;
//   end

  /*
  if (counter == 8'd10000000) begin
    reset = 1;
    x = 8'd0;
  end
  */

  case(JSTK_AXIS)
        3'b001: 
        begin
            LED <= 8'b10000000; // X-axis=1, Y-axis=0, button=0: turn on LED[7]
            move <= 1'b1;
        end
        3'b010: 
        begin 
            LED <= 8'b01000000; // X-axis=0, Y-axis=1, button=0: turn on LED[6]
            move <= 0'b0;
        end
        3'b011: 
        begin
            LED <= 8'b11000000; // X-axis=1, Y-axis=1, button=0: turn on LED[7:6]
            move <= 1'b1;
        end
        3'b100: 
        begin
            LED <= 8'b00100000; // X-axis=0, Y-axis=0, button=1: turn on LED[5]
            move <= 0'b0;
        end
        3'b101: 
        begin
            LED <= 8'b10100000; // X-axis=1, Y-axis=0, button=1: turn on LED[7:5]
            move <= 1'b1;
        end
        3'b110: begin
            LED <= 8'b01100000; // X-axis=0, Y-axis=1, button=1: turn on LED[6:5]
            move <= 0'b0;
        end
        3'b111: begin
            LED <= 8'b11100000; // X-axis=1, Y-axis=1, button=1: turn on all LED
            move <= 1'b1;
        end
        default: LED <= 8'b00000000; // Default case: turn off all LEDs
    endcase

end

endmodule