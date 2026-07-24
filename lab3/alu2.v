module alu #(parameter WIDTH = 8, v=3) (  input [w-1:0] in_a ,
                  input [w-1:0] in_b ,
                  input [v:0] opcode,
                  input en,
                  output reg [w-1:0] alu_out,
                  output reg a_is_zero);

   always @ (*) begin
     case(in_a ==0)
       1'b1 : a_is_zero=1;
      endcase
       if (en==1) begin
          case(opcode)
            3'b000: alu_out= in_a ; 
            3'b001: alu_out= in_a ; 
            3'b010: alu_out= in_a +in_b ;
            3'b011: alu_out= in_a &in_b ;
            3'b100: alu_out= in_a  ^ in_b ;
            3'b101: alu_out= in_b ;
            3'b110: alu_out= in_a ; 
            3'b111: alu_out= in_a ; 
            default: 
            alu_out = 0;
            endcase
        end 
              else alu_out=0;

    end
      
     
     
endmodule
