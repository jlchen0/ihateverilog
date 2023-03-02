module stateMachine(
    input clk,
    input reset,
    input lever, // whether its pulled or not to indicate the state of the machine
    output reg [2:0] display
);

    // IDLE --> SPIN --> WIN --> RESET --> IDLE ...

    // State machine states
    parameter IDLE = 2'b00; // The slot machine is not spinning and the display is blank, it stays in this state until the lever is pulled.
    parameter SPIN = 2'b01; // The slot machine is spinning and the display shows a random number, stop when it's released or it's winning number 
    parameter WIN = 2'b10; // The slot machine is winning
    parameter RESET = 2'b11; // The slot machine is reset, display blank
    
    // State machine signals
    reg [1:0] state;
    reg [1:0] next_state;
    reg [2:0] random_num;
    
    // State machine outputs
    assign display = (state == IDLE) ? 3'b000 : (state == SPIN) ? random_num : (state == WIN) ? 3'b111 : 3'b000;
    // assign display = (state == IDLE) ? 3'b000 : (state == SPIN) ? random_num : (state == WIN) ? 3'b111 : 3'b000;

    // State machine transition logic
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            state <= RESET;
        end
        else begin
            state <= next_state;
        end
    end

    // State machine next state logic
    always @ (*) begin
        case (state)
            IDLE: begin
                if (lever) begin
                    next_state = SPIN;
                    random_num = $random;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SPIN: begin
                next_state = (random_num == 3'b111) ? WIN : IDLE;
                // next_state = (randome_num == 3'b101) ? WIN : IDLE;
            end
            WIN: begin
                next_state = IDLE;
            end
            RESET: begin
                next_state = IDLE;
            end
        endcase
    end
    
endmodule

