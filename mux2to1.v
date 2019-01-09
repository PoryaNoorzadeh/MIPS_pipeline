`timescale 1ns/1ns
module mux2to1(
				input [31:0]input_data1,
				input [31:0]input_data2,
				input sel,
				output [31:0]output_data
				);
assign output_data=(sel)?input_data1:input_data2;
endmodule