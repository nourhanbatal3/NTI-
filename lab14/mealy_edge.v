module edge_mealy (
    input  wire clk,
    input  wire reset,
    input  wire level,
    output reg tick
);

    parameter ZERO = 1'b0;
    parameter ONE  = 1'b1;

    reg current_state;
    reg next_state;

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
                    next_state = ONE;

                else
                    next_state = ZERO;

            end

            ONE: begin

                if (level)
                    next_state = ONE;

                else
                    next_state = ZERO;

            end


            default:
                next_state = ZERO;

        endcase

    end
    always @(*) begin

        if ((current_state == ZERO && level == 1'b1) ||
            (current_state == ONE  && level == 1'b0))

            tick = 1'b1;

        else
            tick = 1'b0;

    end

endmodule
