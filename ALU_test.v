`timescale 1ns/1ns
module ALU_test();
reg [31:0]i1;
reg [31:0]i2;
reg [3:0]cntrlALU;
wire [31:0]w;
ALU
    u1(
			i1,
			i2,
			cntrlALU,
			w
			);
initial begin 
 cntrlALU= 4'b1001;
 i1=32'b100000_00000_00001_00000_11000001010;
 i2=32'b000000_00000_00000_00000_00000000011;
 #2000;
 end
 
 endmodule