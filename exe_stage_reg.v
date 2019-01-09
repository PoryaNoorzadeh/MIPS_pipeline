`timescale 1ns/1ns
module exe_stage_reg(
                    input clk,
                    input rst,
                    input [4:0]dest_out_exe,
                    input [31:0]alu_result_in,
                    input [31:0]src2_val,
					input [31:0]pc_in,
                    input mem_r_en_out_exe,
                    input mem_w_en_out_exe,
                    input wb_en_out_exe,
                    
                    output reg [4:0]dest_in_mem,
                    output reg [31:0]alu_result_out,
                    output reg [31:0]st_val,
					output reg [31:0]pc_out,
                    output reg mem_r_en_in_mem,
                    output reg mem_w_en_in_mem,
                    output reg wb_en_in_mem
                    );
always@(posedge clk, posedge rst)begin
	if(rst)begin
        dest_in_mem<=5'b00000;
        alu_result_out<=32'd0;
        st_val<=32'd0;
        mem_r_en_in_mem<=1'b0;
        mem_w_en_in_mem<=1'b0;
        wb_en_in_mem<=1'b0;
		pc_out<=32'd0;
	end
	else begin
		pc_out<=pc_in;
		dest_in_mem<=dest_out_exe;
        alu_result_out<=alu_result_in;
        st_val<=src2_val;
        mem_r_en_in_mem<=mem_r_en_out_exe;
        mem_w_en_in_mem<=mem_w_en_out_exe;
        wb_en_in_mem<=wb_en_out_exe;
	end
end                    
                                        
endmodule                 
