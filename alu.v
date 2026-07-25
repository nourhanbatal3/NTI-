module alu #(parameter w = 8, v = 3) (
    input [w-1:0] in_a,
    input [w-1:0] in_b,
    input [v-1:0] opcode,
    input en,
    output reg [w-1:0] alu_out,
    output reg a_is_zero
);

   always @(*) begin
       a_is_zero = (in_a == {w{1'b0}});
       
       if (en) begin
          case(opcode)
            3'b000: alu_out = in_a + in_b; 
            3'b001: alu_out = in_a - in_b; 
            3'b010: alu_out = in_a & in_b;
            3'b011: alu_out = in_a ^ in_b;
            3'b100: alu_out = in_a | in_b;
            3'b101: alu_out = in_a;
            3'b110: alu_out = {w{1'b0}}; 
            default: alu_out = {w{1'b0}};
          endcase
       end 
       else begin
          alu_out = {w{1'b0}};
       end
    end

endmodule