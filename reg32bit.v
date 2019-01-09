`timescale 1ns/1ns
module reg32bit(
		input clk,
		input rst,
		input [31:0]in1,
		input [31:0]in2,
		output reg [31:0]out1,
		output reg [31:0]out2
	);
always@(posedge clk, posedge rst)begin
	if(rst)begin
		out1<=32'd0;
		out2<=32'd0;
	end
	else begin
		out1<=in1;
		out2<=in2;
	end
end
endmodule