module memory #(parameter AWIDTH=5, DWIDTH=8)(
    input [AWIDTH-1:0] addr,
    input wr,
    input rd,
    input clk,
    inout [DWIDTH-1:0] data
);
reg [DWIDTH-1:0] mem [0:(1<<AWIDTH)-1];
reg [DWIDTH-1:0] data_out;
always @(posedge clk) begin
    if(wr)
        mem[addr] <= data;
end
always @(*) begin
    if(rd)
        data_out = mem[addr];
    else
        data_out = {DWIDTH{1'b0}};
end
assign data = rd ? data_out : {DWIDTH{1'bz}};
endmodule

 