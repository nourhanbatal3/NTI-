module t_ff (
    input  wire clk,
    input  wire reset_n,
    input  wire t,
    output reg  q
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            q <= 1'b0;
        else if (t)
            q <= ~q;
    end

endmodule