 `timescale 1ns/1ns
module segment(
		input [31:0]seg_in_pc,
		input [31:0]seg_in_instruction,
		output [6:0]seg_out_pc,
		output [6:0]seg_out_instruction
	);
wire[6 : 0]segment_display[15 : 0];
								  //gfedcba
assign segment_display[0] = 7'b1000000; // 0
assign segment_display[1] = 7'b1001111; // 1
assign segment_display[2] = 7'b0100100; // 2
assign segment_display[3] = 7'b0110000; // 3
assign segment_display[4] = 7'b0011001; // 4
assign segment_display[5] = 7'b0010010;
assign segment_display[6] = 7'b0000010;
assign segment_display[7] = 7'b1111000; // 7
assign segment_display[8] = 7'b0000000; // 8
assign segment_display[9] = 7'b0110000; // 9

assign segment_display[10] = 7'b0001000; // A
assign segment_display[11] = 7'b0000011;
assign segment_display[12] = 7'b1000110;
assign segment_display[13] = 7'b0000001; // D
assign segment_display[14] = 7'b0000110;
assign segment_display[15] = 7'b0001110; // F

assign seg_out_pc = segment_display[seg_in_pc[5:2]];
assign seg_out_instruction = segment_display[seg_in_instruction[24:21]];

endmodule
