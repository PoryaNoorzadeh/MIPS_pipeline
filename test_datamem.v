`timescale 1ns/1ns
module test_datamem();


reg clk=0;
reg rst=0;
reg[31:0]address=0;
reg [31:0] dataIn=0;
reg write_en=0;
reg read_en=0;
wire [31:0]mem_out;

data_memory u1(
  					clk,
					rst,
					address,
					dataIn,
					write_en,
					read_en,
					mem_out
					);
always #50 clk = ~ clk;
initial begin

rst = 1;
#100;
rst=0;
#100;
address = 32'd1124;
dataIn = 32'd100;
write_en=1;
#500;
read_en=1;
#500;
end

endmodule