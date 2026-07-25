module piso #(parameter w2 = 20)(
  input wire clk, rst,
  input wire [w2-1:0] pin,
  input wire ram_valid, 
  output reg en,        
  output reg sout,
  output reg valid
);

reg [w2-1:0] shreg;
reg [4:0] counter;

always @(posedge clk or negedge rst) begin
  if(!rst) begin  
    shreg   <= 0;
    sout    <= 0;
    valid   <= 0;
    en      <= 1; 
    counter <= 0; 
  end
  else begin
    if(ram_valid && en) begin 
      shreg   <= pin >> 1;
      sout    <= pin[0];
      counter <= w2 - 1;
      valid   <= 1;
      en      <= 0; 
    end
    else if(valid) begin
      sout    <= shreg[0];
      shreg   <= shreg >> 1;
      counter <= counter - 1;
      
      if(counter == 1) begin 
        valid <= 0;
        en    <= 1; 
      end 
    end
    else begin
      en <= 1; 
    end
  end
end

endmodule