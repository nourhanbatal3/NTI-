
module tb_rising_edge_mealy;

    // Testbench signals
    reg clk;
    reg reset;
    reg level;

    wire tick;


    // Instantiate the DUT
    rising_edge_mealy DUT (
        .clk   (clk),
        .reset (reset),
        .level (level),
        .tick  (tick)
    );


    // Clock generation
    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    // Test stimulus
    initial begin

        // Initial values
        reset = 1'b1;
        level = 1'b0;
        #10;

        reset = 1'b0;

        #10;

        level = 1'b1;

        #20;
        level = 1'b1;

        #20;

        level = 1'b0;

        #20;

        level = 1'b1;

        #20;

        level = 1'b0;

        #20;

        $finish;

    end
    initial begin

        $monitor(
            "Time = %0t | clk = %b | reset = %b | level = %b | tick = %b",
            $time,
            clk,
            reset,
            level,
            tick
        );

    end

endmodule
