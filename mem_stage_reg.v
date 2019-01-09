`timescale 1ns/1ns
module mem_stage_reg(
                    input clk,
                    input rst,
                    input [4:0]dest_out_mem,
                    input [31:0]alu_result_out_mem,
                    input [31:0]data_memory_out,
					input [31:0]pc_in,
                    input mem_r_en_out_mem,
                    input wb_en_out_mem,
                    
                    output reg [4:0]dest_in_wb,
                    output reg [31:0]alu_result_in_wb,
                    output reg [31:0]data_memory_in_wb,
					output reg [31:0]pc_out,
                    output reg mem_r_en_in_wb,
                    output reg wb_en_in_wb
                    );
always@(posedge clk, posedge rst)begin
	if(rst)begin
        dest_in_wb<=5'b00000;
        alu_result_in_wb<=32'd0;
        data_memory_in_wb=32'd0;
        mem_r_en_in_wb<=1'b0;
        wb_en_in_wb<=1'b0;
		pc_out<=32'd0;
	end
	else begin
		pc_out<=pc_in;
		dest_in_wb<=dest_out_mem;
        alu_result_in_wb<=alu_result_out_mem;
        data_memory_in_wb<=data_memory_out;
        mem_r_en_in_wb<=mem_r_en_out_mem;
        wb_en_in_wb<=wb_en_out_mem;
	end
end                    
                                        
endmodule                 

