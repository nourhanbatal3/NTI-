
module tb_seq_detector;

    reg clk;
    reg reset_n;
    reg din;

    wire detected_overlapping;
    wire detected_non_overlapping;

    seq_detector_110101 #(.OVERLAPPING(1)) uut_overlapping (
        .clk(clk),
        .reset_n(reset_n),
        .din(din),
        .detected(detected_overlapping)
    );

    seq_detector_110101 #(.OVERLAPPING(0)) uut_non_overlapping (
        .clk(clk),
        .reset_n(reset_n),
        .din(din),
        .detected(detected_non_overlapping)
    );

    always #5 clk = ~clk;

    reg [0:10] test_stream = 11'b11010110101;
    integer i;

    initial begin
        clk     = 0;
        reset_n = 0;
        din     = 0;

        #12;
        reset_n = 1;

        for (i = 0; i < 11; i = i + 1) begin
            @(negedge clk);
            din = test_stream[i];
            
            @(posedge clk);
            #1;
            $display("Time = %0t | Input = %b | Overlapping Out = %b | Non-Overlapping Out = %b", 
                     $time, din, detected_overlapping, detected_non_overlapping);
        end

        #20;
        $finish;
    end

endmodule