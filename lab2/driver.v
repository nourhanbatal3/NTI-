module driver #(parameter WIDTH=8)(
input [WIDTH-1:0]data_in,
input [1:0]data_en,
output reg [WIDTH-1:0]data_out
);

always @(*)begin 
  if(data_en)begin
   data_out <= data_in;
end
else data_out <= 0;
end
endmodule

