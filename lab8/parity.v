module parity_out #(parameter w=8)(
input clk, rst, serialin,
output wire parity_out
);
 reg [w-1:0] shift_reg;
 function calcparity;
 input [w-1:0] datain;
 begin
    calcparity= ^datain;
end
endfunction

always @(posedge clk) begin
  if(rst) shift_reg <= {w{1'b0}};
  else    shift_reg <= {shift_reg[w-2:0], serialin};
end
assign parity_out = calcparity(shift_reg);
endmodule
 
