module EX(ID_ALUSrc1, ID_ALUSrc2, ID_ALUCtl, ID_ALU_Sign, ID_shamt, ID_DataBusA, ID_DataBusB, ID_Imm, ID_MemtoReg,
MEMForwardSrc, WBForwardSrc, Forward1, Forward2, MEM_ALUOut, MEM_WrData, PC_EX, Interrupt);
	/*From ID_EX register*/
	/*input ID_RegWrite;
	input [4:0] ID_RegDest;
	input ID_MemRead;
	input ID_MemWrite;
	;*/
	input [1:0] ID_MemtoReg;
	input ID_ALUSrc1;
	input ID_ALUSrc2;
	input [4:0] ID_ALUCtl;
	input ID_ALU_Sign;
	input [4:0] ID_shamt;
	input [31:0] ID_DataBusA;
	input [31:0] ID_DataBusB;
	input [31:0] ID_Imm;
	input [31:0] PC_EX;
	/*From Forwarding Unit*/
	input [31:0] MEMForwardSrc;
	input [31:0] WBForwardSrc;
	input [1:0] Forward1;
	input [1:0] Forward2;
	input Interrupt;
	
	/*To EX_MEM Register*/
	/*output wire MEM_RegWrite;
	output wire [4:0] MEM_RegDest;
	output wire MEM_MemRead;
	output wire MEM_MemWrite;
	output wire MEM_MemtoReg;
	
	output wire MEM_ALU_Zero;*/
	output wire [31:0] MEM_WrData;
	output wire [31:0] MEM_ALUOut;
	wire [31:0] ALUOut;
	wire [31:0] ALU_in1;
	wire [31:0] ALU_in2;
	wire MEM_ALU_Zero;
	assign ALU_in1 = ID_ALUSrc1 ? {17'h00000, ID_shamt}: ((Forward1==2'b00) ? ID_DataBusA : ((Forward1 == 2'b10) ? WBForwardSrc : MEMForwardSrc));
	assign ALU_in2 = ID_ALUSrc2 ? ID_Imm               : ((Forward2==2'b00) ? ID_DataBusB : ((Forward2 == 2'b10) ? WBForwardSrc : MEMForwardSrc));
	ALU alu1(.in1(ALU_in1), .in2(ALU_in2), .ALUCtl(ID_ALUCtl), .Sign(ID_ALU_Sign), .out(ALUOut), .zero(MEM_ALU_Zero));
	assign MEM_ALUOut = (Interrupt)? (PC_EX) :((ID_MemtoReg == 2'b10) ? (PC_EX + 32'd4) : ALUOut);
	assign MEM_WrData = ((Forward2==2'b00) ? ID_DataBusB : ((Forward2 == 2'b10) ? WBForwardSrc : MEMForwardSrc));
	/*
	assign MEM_RegWrite = ID_RegWrite;
	assign MEM_RegDest = ID_RegDest;
	assign MEM_MemRead = ID_MemRead;
	assign MEM_MemWrite = ID_MemWrite;*/
	
endmodule