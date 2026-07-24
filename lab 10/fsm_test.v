module fsm_test;
  reg a;
  reg b;
  reg clk;
  reg reset;
  wire y0;
  wire y1;
  fsm dut(
  .a(a),
  .b(b),
  .clk(clk),
  .reset(reset),
  .y0(y0), 
  .y1(y1)
);
//clk gen
initial begin 
  clk=0;
  forever #5 clk =~ clk;
end
initial begin
  a = 0;
  b = 0;
  reset = 0;

  #10;

  reset = 1;
#20
 a = 0;
  b = 0;
  #20;
  a = 1;
  b = 0;

  #20;
  a = 0;
  b = 1;

  #20;
  a = 1;
  b = 1;

  #20;
  a = 0;
  b = 0;

  #20;
  $stop;

end
initial begin
    $monitor("Time=%0t | reset=%b | a=%b b=%b | present=%b next=%b | y0=%b y1=%b",
              $time, reset, a, b, dut.present_state,
    dut.next_state, y0, y1);
end
endmodule
    
