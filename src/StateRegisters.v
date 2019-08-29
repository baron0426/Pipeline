module IFIDR (reset, clk, Instruction, PC, Instruction_next, PC_next);
	input reset; 
	input clk;
	input [31:0] Instruction_next; 
	input [31:0] PC_next;
	output reg [31:0] Instruction; 
	output reg [31:0] PC;
	always @(posedge clk)
	begin
	if (reset)
		begin
		Instruction <= 32'h00000000;
		//PC <= 32'h00000000;
		end
	else
		begin
		Instruction <= Instruction_next;
		PC <= PC_next;
		end
	end
endmodule

module IDEXR (reset, clk, RegWrite_next, RegDest_next, MemRead_next, MemWrite_next, 
MemtoReg_next, ALUSrc1_next, ALUSrc2_next, ALUCtl_next, ALU_sign_next, shamt_next, DataBusA_next, DataBusB_next, Imm_next, 
rs_next, rt_next, PC_next,
RegWrite, RegDest, MemRead, MemWrite, MemtoReg, ALUSrc1, ALUSrc2, ALUCtl, ALU_sign, shamt, DataBusA, DataBusB, Imm, rs, rt, PC_EX);
	input reset; 
	input clk;
	input RegWrite_next;
	input [4:0] RegDest_next;
	input MemRead_next;
	input MemWrite_next;
	input [1:0] MemtoReg_next;
	input ALUSrc1_next;
	input ALUSrc2_next;
	input [4:0] ALUCtl_next;
	input ALU_sign_next;
	input [4:0] shamt_next;
	input [31:0] DataBusA_next;
	input [31:0] DataBusB_next;
	input [31:0] Imm_next;
	input [4:0] rs_next;
	input [4:0] rt_next;
	input [31:0] PC_next;
	output reg RegWrite;
	output reg [4:0] RegDest;
	output reg MemRead;
	output reg MemWrite;
	output reg [1:0] MemtoReg;
	output reg ALUSrc1;
	output reg ALUSrc2;
	output reg [4:0] ALUCtl;
	output reg ALU_sign;
	output reg [4:0] shamt;
	output reg [31:0] DataBusA;
	output reg [31:0] DataBusB;
	output reg [31:0] Imm;	
	output reg [4:0] rs;
	output reg [4:0] rt;
	output reg [31:0] PC_EX;
	always @(posedge reset or posedge clk)
	begin
	if (reset)
		begin
		RegWrite <= 1'b0;
		RegDest <= 5'b0;
		MemWrite <= 1'b0;
		MemRead <= 1'b0;
		MemtoReg <= 2'b0;
		ALUSrc1 <= 1'b0;
		ALUSrc2 <= 1'b0;
		ALUCtl <= 5'b0;
		ALU_sign <= 1'b0;
		shamt <= 5'b0;
		DataBusA <= 32'b0;
		DataBusB <= 32'b0;
		Imm <= 32'b0;
		rs <= 5'b0;
		rt <= 5'b0;
		PC_EX <= 32'b0;
		end
	else
		begin
		RegWrite <= RegWrite_next;
		RegDest <= RegDest_next;
		MemRead <= MemRead_next;
		MemWrite <= MemWrite_next;
		MemtoReg <= MemtoReg_next;
		ALUSrc1 <= ALUSrc1_next;
		ALUSrc2 <= ALUSrc2_next;
		ALUCtl <= ALUCtl_next;
		ALU_sign <= ALU_sign_next;
		shamt <= shamt_next;
		DataBusA <= DataBusA_next;
		DataBusB <= DataBusB_next;
		Imm <= Imm_next;
		rs <= rs_next;
		rt <= rt_next;
		PC_EX <= PC_next; 
		end
	end
endmodule


module EXMEMR(clk, EX_RegWrite, EX_RegDest, EX_MemRead, EX_MemWrite, EX_MemtoReg, EX_ALUOut, EX_WrData,
MEM_RegWrite, MEM_RegDest, MEM_MemRead, MEM_MemWrite, MEM_MemtoReg, MEM_ALUOut, MEM_WrData);
	input clk;
	input EX_RegWrite;
	input [4:0] EX_RegDest;
	input EX_MemRead;
	input EX_MemWrite;
	input [1:0] EX_MemtoReg;
	input [31:0] EX_ALUOut;
	input [31:0] EX_WrData;
	output reg MEM_RegWrite;
	output reg [4:0] MEM_RegDest;
	output reg MEM_MemRead;
	output reg MEM_MemWrite;
	output reg MEM_MemtoReg;
	output reg [31:0] MEM_ALUOut;
	output reg [31:0] MEM_WrData;
	always @(posedge clk)
	begin
		MEM_RegWrite <= EX_RegWrite;
		MEM_RegDest <= EX_RegDest;
		MEM_MemRead <= EX_MemRead;
		MEM_MemWrite <= EX_MemWrite;
		MEM_MemtoReg <= EX_MemtoReg[0];
		MEM_ALUOut <= EX_ALUOut;
		MEM_WrData <= EX_WrData;
	end
endmodule

module MEMWBR(clk, MEM_RegWrite, MEM_RegDest, MEM_ALUOut, MEM_MemReadOut, MEM_MemtoReg,
WB_RegWrite, WB_RegDest, WB_ALUOut, WB_MemReadOut, WB_MemtoReg);
	input clk;
	input MEM_RegWrite;
	input [4:0] MEM_RegDest;
	input [31:0] MEM_ALUOut;
	input [31:0] MEM_MemReadOut;
	input MEM_MemtoReg;
	output reg WB_RegWrite;
	output reg [4:0] WB_RegDest;
	output reg [31:0] WB_ALUOut;
	output reg [31:0] WB_MemReadOut;
	output reg WB_MemtoReg;
	always @(posedge clk)
	begin
		WB_RegWrite <= MEM_RegWrite;
		WB_RegDest <= MEM_RegDest;
		WB_ALUOut <= MEM_ALUOut;
		WB_MemReadOut <= MEM_MemReadOut;
		WB_MemtoReg <= MEM_MemtoReg;
	end
endmodule