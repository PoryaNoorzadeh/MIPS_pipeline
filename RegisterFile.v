`timescale 1ns/1ns
module RegisterFile(
					input clk,
					input rst,
					input [4:0]src1,
					input [4:0]src2,
					input [4:0]dest,
					input [31:0]write_value,
					input write_enable,
					output [31:0]output_reg1,
					output [31:0]output_reg2
					);
reg [31:0]data[31:0];
always@(posedge rst, negedge clk)begin
	if(rst==1'b1) begin
		data[0]<=32'd0;data[1]<=32'd0;data[2]<=32'b0;data[3]<=32'b0;data[4]<=32'b0;data[5]<=32'b0;data[6]<=32'b0;data[7]<=32'b0;
		data[8]<=32'b0;data[9]<=32'b0;data[10]<=32'b0;data[11]<=32'b0;data[12]<=32'b0;data[13]<=32'b0;data[14]<=32'b0;
		data[15]<=32'b0;data[16]<=32'b0;data[17]<=32'b0;data[18]<=32'b0;data[19]<=32'b0;data[20]<=32'b0;data[21]<=32'b0;
		data[22]<=32'b0;data[23]<=32'b0;data[24]<=32'b0;data[25]<=32'b0;data[26]<=32'b0;data[27]<=32'b0;data[28]<=32'b0;
		data[29]<=32'b0;data[30]<=32'b0;data[31]<=32'b0;
	end
	else if (write_enable == 1'b1 && dest!=5'b00000) begin
		data[dest]<=write_value;
	end
end

assign	output_reg1=data[src1];
assign	output_reg2=data[src2];

endmodule