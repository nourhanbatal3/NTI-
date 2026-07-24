module edge_moore (
    input  wire clk,
    input  wire reset,
    input  wire level,
    output reg tick
);

    parameter ZERO = 2'b00;
    parameter EDGE = 2'b01;
    parameter ONE  = 2'b10;

    reg [1:0] current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= ZERO;
        else
            current_state <= next_state;
    end

    always @(*) begin

        case (current_state)

            ZERO: begin
                if (level)
                    next_state = EDGE;   // 0 -> 1
                else
                    next_state = ZERO;
            end


            EDGE: begin
                if (level)
                    next_state = ONE;
                else
                    next_state = ZERO;
            end


            ONE: begin
                if (!level)
                    next_state = EDGE;   // 1 -> 0
                else
                    next_state = ONE;
            end


            default:
                next_state = ZERO;

        endcase

    end
    always @(*) begin

        if (current_state == EDGE)
            tick = 1'b1;
        else
            tick = 1'b0;

    end

endmodule
