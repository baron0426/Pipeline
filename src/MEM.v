module MEM(clk, reset, EX_MemRead, EX_MemWrite, EX_ALUOut, EX_WrData, WB_MemReadOut, MEM_ALUOut);
	input clk;
	input reset;
	
	/*From EX_MEM Register*/
	//input EX_RegWrite;
	//input [4:0] EX_RegDest;
	input EX_MemRead;
	input EX_MemWrite;
	//input EX_MemtoReg;
	input [31:0] EX_ALUOut;
	input [31:0] EX_WrData;
	input [31:0] MEM_ALUOut;
	/*To ID, EX Unit*/
	//output [31:0] MEMForwardSrc;
	
	/*To MEM_WB Register*/
	//output wire WB_RegWrite;
	//output wire [4:0] WB_RegDest;
	//output wire [31:0] WB_ALUOut;
	output wire [31:0] WB_MemReadOut;
	wire [31:0] RAMMemReadOut;
	wire [31:0] ROMMemReadOut;
	//output wire WB_MemtoReg;
	assign WB_MemReadOut = 
	   (MEM_ALUOut[31:28] == 4'h3) ? ROMMemReadOut :
	   RAMMemReadOut;
	   
	SortData SortData_inst(.Address(MEM_ALUOut[9:2]),.MemOut(ROMMemReadOut));
	DataMemory data_memory_inst(.reset(reset), .clk(clk), .Address(EX_ALUOut), .Write_data(EX_WrData), .Read_data(RAMMemReadOut), .MemRead(EX_MemRead), .MemWrite(EX_MemWrite));
	//assign WB_RegWrite = EX_RegWrite;
	//assign WB_RegDest = EX_RegDest;
	//assign WB_ALUOut = EX_ALUOut;
	//assign WB_MemtoReg = EX_MemtoReg;
	//assign MEMForwardSrc = EX_ALUOut;

endmodule