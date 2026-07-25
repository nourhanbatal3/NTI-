// USE add wave -r /top_tb/*; run -all as command ???? ??? ?? ???????? ???? ?? ??? ???? 

module top #(
    parameter w1 = 8,
    parameter w2 = 20,
    parameter dep = 256
)(
    input wire clk,
    input wire rst,
    input wire en1,
    input wire en2,
    input wire [w1-1:0] addr,
    input wire [w2-1:0] din,
    output wire [7:0] alu_out,
    output wire azero
);

wire [w2-1:0] ram_dout;
wire ram_valid;
wire piso_en;
wire piso_valid;
wire serial_data;
wire [w2-1:0] parallel_data;

ram #(
    .w1(w1),
    .dep(dep),
    .w2(w2)
) RAM1 (
    .clk(clk),
    .rst(rst),
    .en1(en1),
    .en2(en2),
    .din(din),
    .addr(addr),
    .valid(ram_valid),
    .dout(ram_dout)
);

piso #(
    .w2(w2)
) PISO1 (
    .clk(clk),
    .rst(rst),
    .pin(ram_dout),
    .ram_valid(ram_valid),
    .en(piso_en),
    .sout(serial_data),
    .valid(piso_valid)
);

pout #(
    .w(w2)
) SIPO1 (
    .clk(clk),
    .rst(rst),
    .en(piso_valid),
    .serialin(serial_data),
    .pout(parallel_data)
);

alu #(
    .w(8),
    .v(3)
) ALU1 (
    .in_a(parallel_data[15:8]),
    .in_b(parallel_data[7:0]),
    .opcode(parallel_data[18:16]),
    .en(parallel_data[19]),
    .alu_out(alu_out),
    .a_is_zero(azero)
);

endmodule