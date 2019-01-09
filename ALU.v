`timescale 1ns/1ns
module ALU(
			input[31:0]i1,
			input[31:0]i2,
			input[3:0]cntrlALU,
			output reg[31:0]w
			);
always@(*)begin
	case(cntrlALU)
	4'b0000 : begin w = i1 + i2;  end
	4'b0010 : begin w = i1 - i2; end
	4'b0100 : begin w = i1 & i2; end
	4'b0101 : begin w = i1 | i2; end
	4'b0111 : begin w = i1 ^ i2; end // xor
	4'b0110 : begin w = ~(i1 | i2); end // nor
	4'b1000 : begin w = i1 << i2; end //sla
	4'b1001 : begin w = $signed(i1)>>>i2; end // sra
	4'b1010 : begin w = i1 >> i2; end // srl
	default : begin w=32'd0; end
	endcase		 
end

endmodule