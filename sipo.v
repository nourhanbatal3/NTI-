module pout #(parameter w = 20)(
  input clk,
  input rst,
  input en,
  input serialin,
  output reg [w-1:0] pout
);

always @(posedge clk or negedge rst) begin 
  if(rst == 0) begin 
    pout <= 0;
  end
  else if(en == 1) begin
    pout <= {serialin, pout[w-1:1]};
  end 
end 

endmodule