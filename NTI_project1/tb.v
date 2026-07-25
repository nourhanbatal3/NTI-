`timescale 1ns/1ps

module top_tb;

    parameter w1  = 8;
    parameter w2  = 20;
    parameter dep = 256;

    reg clk;
    reg rst;
    reg en1;
    reg en2;
    reg [w1-1:0] addr;
    reg [w2-1:0] din;

    wire [7:0] alu_out;
    wire azero;

    top #(
        .w1(w1),
        .w2(w2),
        .dep(dep)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .en1(en1),
        .en2(en2),
        .addr(addr),
        .din(din),
        .alu_out(alu_out),
        .azero(azero)
    );

    always #5 clk = ~clk;

    initial begin
        $addwave("-group Top_Ports", "/top_tb/*");
        $addwave("-group RAM_Internal", "/top_tb/DUT/RAM1/*");
        $addwave("-group PISO_Internal", "/top_tb/DUT/PISO1/*");
        $addwave("-group SIPO_Internal", "/top_tb/DUT/SIPO1/*");
        $addwave("-group ALU_Internal", "/top_tb/DUT/ALU1/*");

        clk  = 0;
        rst  = 0;
        en1  = 0;
        en2  = 0;
        addr = 0;
        din  = 0;

        #20;
        rst = 1;
        #10;

        addr = 8'h02;
        din  = {1'b1, 3'b000, 8'd15, 8'd10};
        en1  = 1;
        #10;
        en1  = 0;
        #20;

        en2  = 1;
        #10;
        en2  = 0;

        #260;

        addr = 8'h05;
        din  = {1'b1, 3'b001, 8'd25, 8'd5};
        en1  = 1;
        #10;
        en1  = 0;
        #20;

        en2  = 1;
        #10;
        en2  = 0;

        #260;

        $stop;
    end

endmodule