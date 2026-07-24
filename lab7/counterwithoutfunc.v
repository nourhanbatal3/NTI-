module counter #(parameter WIDTH =5)(
input clk, rst, load, enab,
input [WIDTH-1:0] cnt_in,
output reg [WIDTH-1:0] cnt_out
);

always @ (posedge clk or posedge rst) begin 
if(rst) cnt_out <= {WIDTH{1'b0}};
else if(load)
  cnt_out <= cnt_in;
else if(enab) begin
  cnt_out <= cnt_out +1'b1; 

end
end
endmodule
