module seq_detector_110101 #(
    parameter OVERLAPPING = 1
)(
    input  wire clk,
    input  wire reset_n,
    input  wire din,
    output reg  detected
);

    localparam S0 = 3'b000,
               S1 = 3'b001,
               S2 = 3'b010,
               S3 = 3'b011,
               S4 = 3'b100,
               S5 = 3'b101;

    reg [2:0] current_state, next_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = S0;
        detected   = 1'b0;

        case (current_state)
            S0: begin
                if (din) next_state = S1;
                else     next_state = S0;
            end

            S1: begin
                if (din) next_state = S2;
                else     next_state = S0;
            end

            S2: begin
                if (!din) next_state = S3;
                else      next_state = S2;
            end

            S3: begin
                if (din) next_state = S4;
                else     next_state = S0;
            end

            S4: begin
                if (!din) next_state = S5;
                else      next_state = S2;
            end

            S5: begin
                if (din) begin
                    detected = 1'b1;
                    if (OVERLAPPING)
                        next_state = S1;
                    else
                        next_state = S0;
                end else begin
                    next_state = S0;
                end
            end

            default: next_state = S0;
        endcase
    end

endmodule