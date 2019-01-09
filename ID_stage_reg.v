`timescale 1ns/1ns
module ID_stage_reg(
                    input clk,
                    input rst,
                    input [4:0]dest_in,
                    input [31:0]imm_in,
                    input [31:0]reg2_in,
                    input [31:0]reg1_in,
                    input [31:0]PC_in,
                    input [1:0]branch_type_in,
                    input [3:0]exe_cmd_in,
                    input mem_r_en_in,
                    input mem_w_en_in,
                    input wb_en_in,
                    
                    output reg [4:0]dest_out,
                    output reg [31:0]imm_out,
                    output reg [31:0]reg2_out,
                    output reg [31:0]reg1_out,
                    output reg [31:0]PC_out,
                    output reg [1:0]branch_type_out,
                    output reg [3:0]exe_cmd_out,
                    output reg mem_r_en_out,
                    output reg mem_w_en_out,
                    output reg wb_en_out
                    );
always@(posedge clk, posedge rst)begin
	if(rst)begin
        dest_out<=5'b00000;
        imm_out<=32'd0;
        reg2_out<=32'd0;
        reg1_out<=32'd0;
        PC_out<=32'd0;
        branch_type_out<=2'b00;
        exe_cmd_out<=4'b0000;
        mem_r_en_out<=1'b0;
        mem_w_en_out<=1'b0;
        wb_en_out<=1'b0;
	end
	else begin
		    dest_out<=dest_in;
        imm_out<=imm_in;
        reg2_out<=reg2_in;
        reg1_out<=reg1_in;
        PC_out<=PC_in;
        branch_type_out<=branch_type_in;
        exe_cmd_out<=exe_cmd_in;
        mem_r_en_out<=mem_r_en_in;
        mem_w_en_out<=mem_w_en_in;
        wb_en_out<=wb_en_in;
	end
end                    
                                        
endmodule                 