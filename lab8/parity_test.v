module parity_test;
  localparam w=8;
  reg clk;
  reg rst;
  reg serialin;
  wire parity_out;

parity_out dut(
.clk(clk),
.rst(rst),
.serialin(serialin),
.parity_out(parity_out)

);
initial clk=0;
always #5 clk = ~clk;

task serialinn (
input [7:0] enter,
input expected
);
integer i;
begin
  for(i=7; i>=0; i=i-1)
  begin
    @(negedge clk);
    serialin = enter[i];
end

@(posedge clk)
#1
if(parity_out == expected)
  $display("Test passsed with frame = %b, output parit is %b" , enter, expected);
else 
$display("Test failed= %b output parit is not as expected", enter);
end
endtask

initial begin
    rst = 1;
    serialin = 0;

    #20;
    rst = 0;
    serialinn(8'b00000111,1'b1);
    serialinn(8'b11100111,1'b0);
    serialinn(8'b01110111,1'b0);
    #20;
    $stop;
    
end
endmodule 
 