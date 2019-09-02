module WB(MEM_ALUOut, MEM_MemReadOut, MEM_MemtoReg, ID_DataBusC);
	/*From MEM_WB register*/
	//input MEM_RegWrite;
	//input [4:0] MEM_RegDest;
	input [31:0] MEM_ALUOut;
	input [31:0] MEM_MemReadOut;
	input MEM_MemtoReg;
	/*To ID Register Files*/
	//output wire [31:0] WBForwardSrc;
	//output wire ID_RegWrEn;
	//output wire [4:0] ID_RegWBDst;
	output wire [31:0] ID_DataBusC;
	assign ID_DataBusC = ( (MEM_MemtoReg)? MEM_MemReadOut : MEM_ALUOut);
	//assign WBForwardSrc = ID_DataBusC;
	//assign ID_RegWBDst = MEM_RegDest;
	//assign ID_RegWrEn = MEM_RegWrite;
endmodule