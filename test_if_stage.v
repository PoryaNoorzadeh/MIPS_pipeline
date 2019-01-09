`timescale 1ns/1ns
module test_if_stage();
reg clk =0;
reg rst =0;
reg br_taken=0;
reg [31:0]br_addr=0;
wire [31:0] PC_out;
wire [31:0] Instruction;
IFstage
	if_stage(
		clk,
		rst,
		br_taken,
		br_addr,
		PC_out,
		Instruction
	);
	always #50 clk = ~ clk;
	
initial begin 
  rst =0;
  #100;
  rst= 1;
  #200;
  rst=0;
  
end
endmodule
