
module tb_parity_out;

    parameter w = 8;

    reg clk;
    reg rst;
    reg serialin;

    wire parity_out;

    parity_out #(
        .w(w)
    ) uut (
        .clk(clk),
        .rst(rst),
        .serialin(serialin),
        .parity_out(parity_out)
    );

    always #5 clk = ~clk;

    reg [w-1:0] test_data = 8'b10110010;
    integer i;

    initial begin
        clk = 0;
        rst = 1;
        serialin = 0;

        #20;
        rst = 0;

        for (i = 0; i < w; i = i + 1) begin
            @(negedge clk);
            serialin = test_data[i];
            
            @(posedge clk);
            #1;
            $display("Time = %0t | Shift Reg = %b | Input = %b | Parity Out = %b", 
                     $time, uut.shift_reg, serialin, parity_out);
        end

        #20;
        $finish;
    end

endmodule