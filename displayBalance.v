module displayBalance(
    input clk,
    input reset,
    // 2'b00 -> no win
    // 2'b01 -> two number same
    // 2'b10 -> three number same
    // 2'b11 -> four number same
    input [1:0] state,  
    output [8:0] reg current_balance
);

initial begin
    balance = 0;
end

always@(posedge clk) begin

    if (reset) begin

        balance = 0
        current_balance = 0;

    end else begin

        case(state)

            2'b00: 

                current_balance = balance; 

            2'b01:

                current_balance = balance + 2;

            2'b10:

                current_balance = balance + 3;

            2'b11:

                current_balance = balance + 4;

        endcase
            
        balance = current_balance;

    end

end

endmodule