`timescale 1ns/1ns
module top_mips(
				clk,
				rst,
				Instruction,
				PC_plus4,
				PC_plus4_ifstage_out,
				PC_plus4_idstage_out,
				PC_plus4_exestage_out,
				PC_plus4_memstage_out
				);
input clk;
input rst;

//IF_stage_wires
output wire [31:0] PC_plus4;
output wire [31:0] PC_plus4_ifstage_out;
output wire [31:0] Instruction;
wire [31:0] Instruction_ifstage_out;
//EOF_IF_stage_wires

//ID_stage_wires
wire [3:0]exe_cmd;
wire mem_read;
wire mem_write;
wire wb_en;
wire is_immediate;
wire [1:0] branch_type;
wire [31:0]output_reg1;
wire [31:0]output_reg2;
wire [31:0]sign_extended;
wire [31:0]immediate_out;
wire [31:0]immediate_out_ex_stage;
wire [31:0]output_reg1_ex_stage;
wire [31:0]output_reg2_ex_stage;
output wire [31:0]PC_plus4_idstage_out;
wire [1:0]branch_type_out;
wire [3:0]exe_cmd_out;
wire mem_read_out;
wire mem_write_out;
wire wb_en_out_id_stage;
wire [4:0]dest_in_id;
//EOF_ID_stage_wires

//Ex_stage_wires
wire branch_tacken;
wire [31:0]alu_result;
wire [31:0]alu_result_out;
wire [31:0]st_val;
wire mem_r_en_in_mem;
wire mem_w_en_in_mem;
wire wb_en_in_mem;
wire [4:0]dest_in_ex;
output wire [31:0]PC_plus4_exestage_out;
//EOF_Ex_stage_wires

//Mem_stage_wires
wire [31:0]data_memory_out;
wire [31:0]alu_result_in_wb;
wire [31:0]data_memory_in_wb;
wire mem_r_en_in_wb;
wire wb_en_in_wb;
wire [4:0]dest_in_mem;
output wire [31:0]PC_plus4_memstage_out;
//EOF_Mem_stage_wires

//WB_stage_wires
wire [31:0]wb_stage_out_data;
wire [4:0]dest_in_wb;
//EOF_WB_stage_wires

//Instruction_Fetch_Stage
IFstage
	ifstage(
		  .clk(clk),
		  .rst(rst),
		  .br_taken(branch_tacken),
		  .br_addr(PC_plus4_idstage_out+(immediate_out_ex_stage<<2)),
		  .PC_out(PC_plus4),
		  .Instruction(Instruction)
	);
	reg32bit
	ifstage_reg(
		  .clk(clk),
		  .rst(rst),
		  .in1(PC_plus4),
		  .in2(Instruction),
		  .out1(PC_plus4_ifstage_out),
		  .out2(Instruction_ifstage_out)
	);
//EOF_Instruction_Fetch_Stage

//Instruction_Decode_Stage
control_unit
	ControlUnit(
			.opcode(Instruction_ifstage_out[31:26]),
			.exe_cmd(exe_cmd),
			.mem_read(mem_read),
			.mem_write(mem_write),
			.wb_en(wb_en),
			.is_immediate(is_immediate),
			.branch_type(branch_type)
			);
RegisterFile
    registerfileU(
					.clk(clk),
					.rst(rst),
					.src1(Instruction_ifstage_out[25:21]),
					.src2(Instruction_ifstage_out[20:16]),
					.dest(dest_in_wb),
					.write_value(wb_stage_out_data),
					.write_enable(wb_en_in_wb),
					.output_reg1(output_reg1),
					.output_reg2(output_reg2)
					);
sign_extend
    SignExtend(
					.input_data(Instruction_ifstage_out[15:0]),
					.output_data(sign_extended)
					);
mux2to1_5bit 
      mux5bit(
        .input_data1(Instruction_ifstage_out[20:16]),
				.input_data2(Instruction_ifstage_out[15:11]),
				.sel(is_immediate),
				.output_data(dest_in_id)
				);
mux2to1
      selImOrReg2(
				.input_data1(sign_extended),
				.input_data2(output_reg2),
				.sel(is_immediate),
				.output_data(immediate_out)
				);
ID_stage_reg
  IdStageReg(
            .clk(clk),
            .rst(rst),
            .dest_in(dest_in_id),
            .imm_in(immediate_out),
            .reg2_in(output_reg2),
            .reg1_in(output_reg1),
            .PC_in(PC_plus4_ifstage_out),
            .branch_type_in(branch_type),
            .exe_cmd_in(exe_cmd),
            .mem_r_en_in(mem_read),
            .mem_w_en_in(mem_write),
            .wb_en_in(wb_en),
                    
            .dest_out(dest_in_ex),
            .imm_out(immediate_out_ex_stage),
            .reg2_out(output_reg2_ex_stage),
            .reg1_out(output_reg1_ex_stage),
            .PC_out(PC_plus4_idstage_out),
            .branch_type_out(branch_type_out),
            .exe_cmd_out(exe_cmd_out),
            .mem_r_en_out(mem_read_out),
            .mem_w_en_out(mem_write_out),
            .wb_en_out(wb_en_out_id_stage)
          );
//EOF_Instruction_Decode_Stage

//Execution_Stage
cond_check
      CondCheck(
				.branch_type(branch_type_out),
				.i1(output_reg1_ex_stage),
				.i2(output_reg2_ex_stage),
				.branch_check_result(branch_tacken)
			);
ALU	
	aluU(
		.i1(output_reg1_ex_stage),
		.i2(immediate_out_ex_stage),
		.cntrlALU(exe_cmd_out),
		.w(alu_result)
		);
exe_stage_reg
    ExeStageReg(
                .clk(clk),
                .rst(rst),
                .dest_out_exe(dest_in_ex),
                .alu_result_in(alu_result),
				.pc_in(PC_plus4_idstage_out),
                .src2_val(output_reg2_ex_stage),
                .mem_r_en_out_exe(mem_read_out),
                .mem_w_en_out_exe(mem_write_out),
                .wb_en_out_exe(wb_en_out_id_stage),
                    
                .dest_in_mem(dest_in_mem),
                .alu_result_out(alu_result_out),
				.pc_out(PC_plus4_exestage_out),
				.st_val(st_val),
                .mem_r_en_in_mem(mem_r_en_in_mem),
                .mem_w_en_in_mem(mem_w_en_in_mem),
                .wb_en_in_mem(wb_en_in_mem)
                    );
//EOF_Execution_Stage

//Mem_stage
data_memory
      DataMem(
  			.clk(clk),
		    .rst(rst),
			.address(alu_result_out),
			.dataIn(st_val),
			.write_en(mem_w_en_in_mem),
			.read_en(mem_r_en_in_mem),
			.mem_out(data_memory_out)
			);
mem_stage_reg
			MemStageReg(
                    .clk(clk),
                    .rst(rst),
                    .dest_out_mem(dest_in_mem),
                    .alu_result_out_mem(alu_result_out),
                    .data_memory_out(data_memory_out),
					.pc_in(PC_plus4_exestage_out),
                    .mem_r_en_out_mem(mem_r_en_in_mem),
                    .wb_en_out_mem(wb_en_in_mem),
                    
                    .dest_in_wb(dest_in_wb),
                    .alu_result_in_wb(alu_result_in_wb),
                    .data_memory_in_wb(data_memory_in_wb),
					.pc_out(PC_plus4_memstage_out),
                    .mem_r_en_in_wb(mem_r_en_in_wb),
                    .wb_en_in_wb(wb_en_in_wb)
                    );			
//EOF_Mem_stage

//WB_stage
mux2to1
		WbStageMux(
				.input_data2(alu_result_in_wb),
				.input_data1(data_memory_in_wb),
				.sel(mem_r_en_in_wb),
				.output_data(wb_stage_out_data)
				);
//EOF_WB_stage

endmodule		