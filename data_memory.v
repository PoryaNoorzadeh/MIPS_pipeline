`timescale 1ns/1ns
module data_memory(
  					input clk,
					input rst,
					input[31:0]address,
					input [31:0] dataIn,
					input write_en,
					input read_en,
					output [31:0]mem_out
					);
					
reg[31 : 0] data [0 : 255]; // memory az address 1024 shuru mishe
integer i;
wire [31:0]b_address;
	
assign b_address = ( address & 32'b11111111111111111000001111111111 )>>2;
                                  
always@(posedge clk)begin
	if(rst)begin
		for(i=0 ; i < 256 ; i = i + 1)begin
			data[i]<= 32'd0;
		end
	end
	else if(write_en) begin data[b_address] = dataIn; end
end


assign mem_out=(read_en)?data[b_address]:mem_out;
endmodule