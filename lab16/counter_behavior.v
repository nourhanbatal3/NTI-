module counter_behavioral (
    input  wire       clk,
    input  wire       reset_n,
    output reg  [2:0] count
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            count <= 3'b000;
        else
            count <= count + 1'b1;
    end

endmodule
