`timescale 1ns/1ns
module test_top_mips();
  
reg clk=0;
reg rst=0;

top_mips u(clk, rst);

always #50 clk = ~ clk;

initial begin 
  rst =0;
  #100;
  rst= 1;
  #200;
  rst=0;
  
end
endmodule