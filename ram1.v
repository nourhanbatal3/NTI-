module ram #(parameter w1 = 8, dep = 256, w2 = 20)(
    input wire clk,
    input wire rst,
    input wire en1,
    input wire en2,
    input wire [w2-1:0] din,
    input wire [w1-1:0] addr,
    output reg valid,
    output reg [w2-1:0] dout
);

reg [w2-1:0] mem [0:dep-1];

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        dout <= 0;
        valid <= 0;
    end
    else begin
        valid <= 0;

        if(en1)
            mem[addr] <= din;
        else if(en2) begin
            dout <= mem[addr];
            valid <= 1;
        end
    end
end

endmodule