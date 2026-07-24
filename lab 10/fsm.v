module fsm (
  input wire a,
  input wire b,
  input wire clk,
  input wire reset,
  output reg y0,
  output reg y1
);
localparam [1:0] S0 = 2'b00,
                 S1 = 2'b01,
				         S2 = 2'b10;
reg [1:0] present_state, next_state;
always@(posedge clk, negedge reset) begin 
      case(reset) 
        1'b0 : present_state <= S0;
        1'b1 : present_state <= next_state;
	    endcase
	end
task state (input [1:0] nextstate);
  begin
    next_state = nextstate;
  end
endtask
always @(*) begin
    case(present_state)
        S0: begin
            if(!a)
                state(S0);
            else if(b)
                state(S2);
            else
                state(S1);
        end
        S1: begin
            if(!a)
                state(S1);
            else
                state(S0);
        end
        S2: begin
            state(S0);
        end
        default:
            state(S0);
    endcase
end
always @(*) begin
    case(present_state)
        S0: y1 = 1'b1;
        S1: y1 = 1'b1;
        S2: y1 = 1'b0;

        default: y1 = 1'b0;
    endcase
end
always @(*) begin
    case(present_state)
        S0: begin
            if(b && a)
                y0 = 1'b1;
            else
                y0 = 1'b0;
        end
        S1: y0 = 1'b0;
        S2: y0 = 1'b0;
        default: y0 = 1'b0;

    endcase
end
endmodule