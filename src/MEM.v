module MEM(clk, reset, EX_MemRead, EX_MemWrite, EX_ALUOut, EX_WrData, WB_MemReadOut);
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
	
	/*To ID, EX Unit*/
	//output [31:0] MEMForwardSrc;
	
	/*To MEM_WB Register*/
	//output wire WB_RegWrite;
	//output wire [4:0] WB_RegDest;
	//output wire [31:0] WB_ALUOut;
	output wire [31:0] WB_MemReadOut;
	//output wire WB_MemtoReg;
	
	DataMemory data_memory_inst(.reset(reset), .clk(clk), .Address(EX_ALUOut), .Write_data(EX_WrData), .Read_data(WB_MemReadOut), .MemRead(EX_MemRead), .MemWrite(EX_MemWrite));
	//assign WB_RegWrite = EX_RegWrite;
	//assign WB_RegDest = EX_RegDest;
	//assign WB_ALUOut = EX_ALUOut;
	//assign WB_MemtoReg = EX_MemtoReg;
	//assign MEMForwardSrc = EX_ALUOut;

endmodule