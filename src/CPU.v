module CPU(reset, clk);
	input reset, clk;
	wire [31:0] PC;
	wire [31:0] PC_next;
	
	wire stall;
	wire stall1;
	wire stall2;
	wire IFIDFlush;
	wire IFIDFlush_in;
	assign IFIDFlush_in = IFIDFlush | reset;
	wire IDEXFlush;
	wire [1:0] BranchSrcA;
	wire [1:0] BranchSrcB;
	wire Branch;
	wire BranchCond;
	wire [31:0] branchCmpA;
	wire [31:0] JumpTarget;
	wire [1:0] IDs_Jump;
	wire [1:0] Forward1;
	wire [1:0] Forward2;
	
	wire [31:0] IDs_PC;
	wire [31:0] IFs_Instruction;
	wire [31:0] IDs_Instruction;
	wire IDs_RegWrite;
	wire [4:0] IDs_RegDest;
	wire IDs_MemRead;
	wire IDs_MemWrite;
	wire [1:0] IDs_MemtoReg;
	wire IDs_ALUSrc1;
	wire IDs_ALUSrc2;
	wire [4:0] IDs_ALUCtl;
	wire IDs_ALU_sign;
	wire [4:0] IDs_shamt;
	//wire [31:0] IDs_DataBusA;
	wire [31:0] IDs_DataBusB;
	wire [31:0] IDs_Imm;
	wire [4:0] IDs_rs;
	wire [4:0] IDs_rt;
	
	wire EXs_RegWrite;
	wire [4:0] EXs_RegDest;
	wire EXs_MemRead;
	wire EXs_MemWrite;
	wire [1:0] EXs_MemtoReg;
	wire EXs_ALUSrc1;
	wire EXs_ALUSrc2;
	wire [4:0] EXs_ALUCtl;
	wire EXs_ALU_sign;
	wire [4:0] EXs_shamt;
	wire [31:0] EXs_DataBusA;
	wire [31:0] EXs_DataBusB;
	wire [31:0] EXs_Imm;
	wire [4:0] EXs_rs;
	wire [4:0] EXs_rt;
	wire [31:0] EXs_PC;
	
	wire [31:0] MEMR_ALUOut;
	wire [31:0] MEMR_WrData;
	
	wire MEMs_RegWrite;
	wire [4:0] MEMs_RegDest;
	wire MEMs_MemRead;
	wire MEMs_MemWrite;
	wire MEMs_MemtoReg;
	wire [31:0] MEMs_ALUOut;
	wire [31:0] MEMs_WrData;
	//wire [31:0] MEMs_PC;
	
	wire [31:0] WBR_MemReadOut;
	
	wire WBs_RegWrite;
	wire [4:0] WBs_RegDest;
	wire [31:0] WBs_ALUOut;
	wire [31:0] WBs_MemReadOut;
	wire WBs_MemtoReg;
	wire [31:0] WB_ID_WriteBackData;
	//wire [31:0] WBs_PC;
	
	PC pc(.reset(reset), .clk(clk), .PC_next(PC_next), .PC(PC));
	HazardJumpUnit hazard_jump(.PC(PC), .stall(stall), .Jump(IDs_Jump), .Branch(Branch), .BranchCond(BranchCond), 
	.JumpTarget(JumpTarget), .branchCmpA(branchCmpA), .IFIDFlush(IFIDFlush), .IDEXFlush(IDEXFlush), .PC_next(PC_next));
	ForwardingUnit forward(.stall(stall), .BranchSrcA(BranchSrcA), .BranchSrcB(BranchSrcB),
	.Forward1(Forward1), .Forward2(Forward2), .MEM_RegWrite(MEMs_RegWrite), .WB_RegWrite(WBs_RegWrite), 
	.MEM_RegDest(MEMs_RegDest), .WB_RegDest(WBs_RegDest), .MEM_MemRead(MEMs_MemRead), 
	.IDF_rs(IDs_rs), .IDF_rt(IDs_rt), .EXF_rs(EXs_rs), .EXF_rt(EXs_rt), .ID_Jump(IDs_Jump), 
	.EX_MemRead(EXs_MemRead), .EX_RegDest(EXs_RegDest), .EX_RegWrite(EXs_RegWrite), .stall1(stall1), .stall2(stall2));


	IF IFs(.PC_in(PC), .IFIDFlush(IFIDFlush), .Instruction(IFs_Instruction));
	
	IFIDR IF_ID(.reset(IFIDFlush_in), .clk(clk), .Instruction(IDs_Instruction), .Instruction_next(IFs_Instruction), .PC(IDs_PC), .PC_next(PC));
	
	ID IDs(.reset(reset), .clk(clk), .RegWrEn(WBs_RegWrite), .RegWBDst(WBs_RegDest), .DataBusC(WB_ID_WriteBackData), 
	.Instruction(IDs_Instruction), .MEMForwardSrc(MEMs_ALUOut), .WBForwardSrc(WB_ID_WriteBackData), .BranchSrcA(BranchSrcA), .BranchSrcB(BranchSrcB), .BranchCond(BranchCond), 
	.RegWrite(IDs_RegWrite), .RegDest(IDs_RegDest), .MemRead(IDs_MemRead), .MemWrite(IDs_MemWrite), .MemtoReg(IDs_MemtoReg), 
	.ALUSrc1(IDs_ALUSrc1), .ALUSrc2(IDs_ALUSrc2), .ALUCtl(IDs_ALUCtl), .ALU_Sign(IDs_ALU_sign), 
	.shamt(IDs_shamt), .Imm(IDs_Imm), .rs(IDs_rs), .rt(IDs_rt), .branchCmpA(branchCmpA),.branchCmpB(IDs_DataBusB), .JumpTarget(JumpTarget),
	.Jump(IDs_Jump), .EXForwardSrc(MEMR_ALUOut), .PC(IDs_PC), .Branch(Branch));
    
	IDEXR ID_EX(.reset(IDEXFlush), .clk(clk), .RegWrite_next(IDs_RegWrite), .RegDest_next(IDs_RegDest), .MemRead_next(IDs_MemRead), .MemWrite_next(IDs_MemWrite), 
	.MemtoReg_next(IDs_MemtoReg), .ALUSrc1_next(IDs_ALUSrc1), .ALUSrc2_next(IDs_ALUSrc2), .ALUCtl_next(IDs_ALUCtl), .ALU_sign_next(IDs_ALU_sign), .shamt_next(IDs_shamt), .DataBusA_next(branchCmpA), .DataBusB_next(IDs_DataBusB), .Imm_next(IDs_Imm), 
	.rs_next(IDs_rs), .rt_next(IDs_rt), .PC_next(IDs_PC),
	.RegWrite(EXs_RegWrite), .RegDest(EXs_RegDest), .MemRead(EXs_MemRead), .MemWrite(EXs_MemWrite), 
	.MemtoReg(EXs_MemtoReg), .ALUSrc1(EXs_ALUSrc1), .ALUSrc2(EXs_ALUSrc2), .ALUCtl(EXs_ALUCtl), .ALU_sign(EXs_ALU_sign), 
	.shamt(EXs_shamt), .DataBusA(EXs_DataBusA), .DataBusB(EXs_DataBusB), .Imm(EXs_Imm), .rs(EXs_rs), .rt(EXs_rt), .PC_EX(EXs_PC));
	
	EX EXs(.ID_ALUSrc1(EXs_ALUSrc1), .ID_ALUSrc2(EXs_ALUSrc2), .ID_ALUCtl(EXs_ALUCtl), .ID_MemtoReg(EXs_MemtoReg),
	.ID_ALU_Sign(EXs_ALU_sign), .ID_shamt(EXs_shamt), .ID_DataBusA(EXs_DataBusA), .ID_DataBusB(EXs_DataBusB), 
	.ID_Imm(EXs_Imm), .MEMForwardSrc(MEMs_ALUOut), .WBForwardSrc(WB_ID_WriteBackData), 
	.Forward1(Forward1), .Forward2(Forward2), .MEM_ALUOut(MEMR_ALUOut), .MEM_WrData(MEMR_WrData),
	.PC_EX(EXs_PC));
	
	EXMEMR EX_MEM(.clk(clk), .EX_RegWrite(EXs_RegWrite), .EX_RegDest(EXs_RegDest), .EX_MemRead(EXs_MemRead), 
	.EX_MemWrite(EXs_MemWrite), .EX_MemtoReg(EXs_MemtoReg), .EX_ALUOut(MEMR_ALUOut), .EX_WrData(MEMR_WrData), 
	.MEM_RegWrite(MEMs_RegWrite), .MEM_RegDest(MEMs_RegDest), .MEM_MemRead(MEMs_MemRead), .MEM_MemWrite(MEMs_MemWrite), 
	.MEM_MemtoReg(MEMs_MemtoReg), .MEM_ALUOut(MEMs_ALUOut), .MEM_WrData(MEMs_WrData));
	
	MEM MEMs(.clk(clk), .reset(reset), .EX_MemRead(EXs_MemRead), .EX_MemWrite(EXs_MemWrite), .EX_ALUOut(MEMR_ALUOut),
	.EX_WrData(MEMR_WrData), .WB_MemReadOut(WBR_MemReadOut));
	
	MEMWBR MEM_WB(.clk(clk), .MEM_RegWrite(MEMs_RegWrite), .MEM_RegDest(MEMs_RegDest), .MEM_ALUOut(MEMs_ALUOut), 
	.MEM_MemReadOut(WBR_MemReadOut), .MEM_MemtoReg(MEMs_MemtoReg), 
	.WB_RegWrite(WBs_RegWrite), .WB_RegDest(WBs_RegDest), .WB_ALUOut(WBs_ALUOut), .WB_MemReadOut(WBs_MemReadOut), .WB_MemtoReg(WBs_MemtoReg));
	
	WB WBs(.MEM_ALUOut(WBs_ALUOut), .MEM_MemReadOut(WBs_MemReadOut), .MEM_MemtoReg(WBs_MemtoReg), .ID_DataBusC(WB_ID_WriteBackData));
	
endmodule
	