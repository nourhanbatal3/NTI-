// nesset hena initial el clk  initial clk = 0;
module memory_test;

  localparam integer AWIDTH=5;
  localparam integer DWIDTH=8;

  reg               clk   ;
  reg               wr    ;
  reg               rd    ;
  reg  [AWIDTH-1:0] addr  ;
  wire [DWIDTH-1:0] data  ;
  reg  [DWIDTH-1:0] rdata ;

 assign data = wr ? rdata : {DWIDTH{1'bz}};

  memory
  #(
    .AWIDTH ( AWIDTH ),
    .DWIDTH ( DWIDTH ) 
   )
  memory_inst
   (
    .clk  ( clk  ),
    .wr   ( wr   ),
    .rd   ( rd   ),
    .addr ( addr ),
    .data ( data ) 
   );
initial clk = 0;
  always #5 clk = ~clk;
task checck;
input [DWIDTH-1:0] expected;
begin
    if (data !== expected) begin
        $display("TEST FAILED");
        $display("At time %0d addr=%b data=%b", $time, addr, data);
        $display("data should be %b", expected);
    end
    else begin
        $display("At time %0d addr=%b data=%b", $time, addr, data);
    end
end
endtask
  // 1 hena task for el writing
  
  
  
task write;
    input [AWIDTH-1:0] waddr;
    input [DWIDTH-1:0] wdata;
    begin
      @(negedge clk);
      addr= waddr;
      rdata = wdata;
      wr=1;
      rd=0;
      @(negedge clk);
      wr=0;
    
    end
endtask
    task read;
    input [AWIDTH-1:0] raddr;
    input [DWIDTH-1:0] expected;
    begin
      @(negedge clk);
      addr= raddr;
      wr=0;
      rd=1;
      @(negedge clk);
      rd=0;
      checck(expected);
    end
  endtask
initial begin

    write(5'b00001, 8'b00000111);
    read (5'b00001, 8'b00000111);
    write(5'b00010, 8'b11100111);
    read (5'b00010, 8'b11100111);
    write(5'b00011, 8'b00011000);
    read (5'b00011, 8'b00011000);
end
endmodule 
/*  initial repeat (67) begin #5 clk=1; #5 clk=0; end

  initial @(negedge clk) begin : TEST
    reg [AWIDTH-1:0] addr;
    reg [DWIDTH-1:0] data;
    addr=0; data=-1;
    $display("Writing addr=%b data=%b",addr,data);
    wr=1; rd=0; memory_test.addr=addr; rdata=data; @(negedge clk);
    addr=-1; data=0;
    $display("Writing addr=%b data=%b",addr,data);
    wr=1; rd=0; memory_test.addr=addr; rdata=data; @(negedge clk);
    addr=0; data=-1;
    $display("Reading addr=%b data=%b",addr,data);
    wr=0; rd=1; memory_test.addr=addr; rdata='bz; @(negedge clk) expect(data);
    addr=-1; data=0;
    $display("Reading addr=%b data=%b",addr,data);
    wr=0; rd=1; memory_test.addr=addr; rdata='bz; @(negedge clk) expect(data);
    $display("Writing ascending data to   descending addresses");
    addr=-1; data=0;
    while ( addr ) begin
      wr=1; rd=0; memory_test.addr=addr; rdata=data; @(negedge clk);
      addr=addr-1;
      data=data+1;
    end
    $display("Reading ascending data from descending addresses");
    addr=-1; data=0;
    while ( addr ) begin
      wr=0; rd=1; memory_test.addr=addr; rdata='bz; @(negedge clk) expect(data);
      addr=addr-1;
      data=data+1;
    end
    $display("TEST PASSED");
    
  end
*/
