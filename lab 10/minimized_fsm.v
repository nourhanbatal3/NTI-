module fsm_2 (
    input  wire in_a,
    input  wire in_b,
    input  wire clock,
    input  wire rst_n,
    output reg  out_y0,
    output reg  out_y1
);

localparam STATE_0 = 2'b00,
           STATE_1 = 2'b01,
           STATE_2 = 2'b10;

reg [1:0] current_state, future_state;

// State Register
always @(posedge clock or negedge rst_n)
    if (!rst_n)
        current_state <= STATE_0;
    else
        current_state <= future_state;

// Next State & Output Logic
always @(*) begin
    future_state = STATE_0;
    out_y0 = 0;
    out_y1 = 0;
    
    case (current_state)
        STATE_0: begin
            out_y1 = 1;
            future_state = (!in_a) ? STATE_0 : (in_b ? STATE_2 : STATE_1);
            out_y0 = (in_a && in_b);
        end
        
        STATE_1: begin
            out_y1 = 1;
            future_state = (!in_a) ? STATE_1 : STATE_0;
        end

        STATE_2: begin
            future_state = STATE_0;
        end
    endcase
end

endmodule