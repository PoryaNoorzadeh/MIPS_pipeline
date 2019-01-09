module control_unit
					(
					input [5 : 0] opcode,
					output reg [3:0]exe_cmd,
					output reg mem_read,
					output reg mem_write,
					output reg wb_en,
					output reg is_immediate,
					output reg [1:0] branch_type
					);

					
always@(*)begin
		exe_cmd=4'b0000;mem_read=1'b0;mem_write=1'b0;wb_en=1'b0;is_immediate=1'b0;branch_type=2'b00;
	case (opcode)
	//6'd0: // do nothing
	6'd1: begin exe_cmd = 4'b0000; wb_en = 1'b1; end // ADD
	6'd3: begin exe_cmd = 4'b0010; wb_en = 1'b1; end // SUB
	6'd5: begin exe_cmd = 4'b0100; wb_en = 1'b1; end // AND
	6'd6: begin exe_cmd = 4'b0101; wb_en = 1'b1; end // OR
	6'd7: begin exe_cmd = 4'b0110; wb_en = 1'b1; end // NOR
	6'd8: begin exe_cmd = 4'b0111; wb_en = 1'b1; end // XOR
	6'd9: begin exe_cmd = 4'b1000; wb_en = 1'b1; end // SLA
	6'd10: begin exe_cmd = 4'b1000; wb_en = 1'b1; end // SLL
	6'd11: begin exe_cmd = 4'b1001; wb_en = 1'b1; end // SRA
	6'd12: begin exe_cmd = 4'b1010; wb_en = 1'b1; end // SRL
	6'd32: begin exe_cmd = 4'b0000; is_immediate = 1; wb_en = 1'b1; end // ADDI
	6'd33: begin exe_cmd = 4'b0010; is_immediate = 1; wb_en = 1'b1; end // SUBI
	6'd36: begin exe_cmd = 4'b0000; mem_read = 1'b1; is_immediate = 1; wb_en = 1'b1; end// LD
	6'd37: begin exe_cmd = 4'b0000; mem_write = 1'b1; is_immediate = 1; wb_en = 1'b1; end// ST
	6'd40: begin branch_type = 2'b01; is_immediate = 1; end // BEZ
	6'd41: begin branch_type = 2'b10; is_immediate = 1; end // BNE
	6'd42: begin branch_type = 2'b11; is_immediate = 1; end // JMP
		default: begin 	exe_cmd=4'b0000;mem_read=1'b0;mem_write=1'b0;wb_en=1'b0;is_immediate=1'b0;branch_type=2'b00;end
	endcase
end

endmodule