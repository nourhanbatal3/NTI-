module controller #(
    parameter HLT = 3'b000,
              SKZ = 3'b001,
              ADD = 3'b010,
              AND = 3'b011,
              XOR = 3'b100,
              LDA = 3'b101,
              STO = 3'b110,
              JMP = 3'b111
)(
    input wire clk,
    input wire rst,
    input wire zero,
    input wire [2:0] phase,
    input wire [2:0] opcode,
    output reg sel,
    output reg rd,
    output reg ld_ir,
    output reg halt,
    output reg inc_pc,
    output reg wr,
    output reg ld_pc,
    output reg data_e,
    output reg ld_ac
);

reg alu_op;

always @(*) begin 
    alu_op = (opcode == ADD) || (opcode == AND) || (opcode == XOR) || (opcode == LDA);

    sel    = 0; 
    rd     = 0; 
    ld_ir  = 0; 
    halt   = 0; 
    inc_pc = 0; 
    ld_ac  = 0; 
    wr     = 0; 
    ld_pc  = 0; 
    data_e = 0;

    case(phase)
        3'b000: begin
            sel = 1;
        end    
        
        3'b001: begin
            sel = 1;
            rd  = 1;
        end
        
        3'b010: begin
            sel   = 1;
            rd    = 1;
            ld_ir = 1;
        end
                    
        3'b011: begin
            sel   = 1;
            rd    = 1;
            ld_ir = 1;
        end
                    
        3'b100: begin
            halt   = (opcode == HLT);
            inc_pc = 1;
        end
                    
        3'b101: begin
            rd = alu_op;
        end
                    
        3'b110: begin
            rd     = alu_op;
            inc_pc = (opcode == SKZ && zero == 1);
            ld_pc  = (opcode == JMP);
            data_e = (opcode == STO);
        end
                    
        3'b111: begin
            rd     = alu_op;
            ld_ac  = alu_op;
            ld_pc  = (opcode == JMP);
            wr     = (opcode == STO);
            data_e = (opcode == STO);
        end
                    
        default: begin
            sel    = 0; 
            rd     = 0; 
            ld_ir  = 0; 
            halt   = 0; 
            inc_pc = 0; 
            ld_ac  = 0; 
            wr     = 0; 
            ld_pc  = 0; 
            data_e = 0;
        end
    endcase
end

endmodule

