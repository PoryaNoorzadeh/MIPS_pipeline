`timescale 1ns/1ns
module cond_check(
					input [1:0] branch_type,
					input [31:0]i1,
					input [31:0]i2,
					output reg branch_check_result
					);
reg [31:0]w=32'd1;
always@(*)begin
	branch_check_result = 1'b0;
	case(branch_type)
	2'b01 : begin w = i1 - i2; branch_check_result = (w == 32'b0) ? 1'b1 : 1'b0; end
	2'b10: begin w = i1 - i2; branch_check_result = (w == 32'b0) ? 1'b0 : 1'b1; end
	2'b11 : begin branch_check_result =1'b1; end
	default : branch_check_result =1'b0;
	endcase
end
					
endmodule