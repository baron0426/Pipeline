module ID(reset, clk, RegWrEn, RegWBDst, DataBusC, 
Instruction, MEMForwardSrc, WBForwardSrc, BranchSrcA, BranchSrcB, BranchCond, 
RegWrite, RegDest, MemRead, MemWrite, MemtoReg, ALUSrc1, ALUSrc2, ALUCtl, ALU_Sign, 
shamt, Imm, rs, rt, branchCmpA, branchCmpB, JumpTarget, Jump, EXForwardSrc, PC, Branch, Exception, Interrupt);
	input Interrupt;
	/*From WriteBack Stage: For numbers to write back to register file*/
	input reset;
	input clk;
	input RegWrEn;
	input [4:0] RegWBDst;
	input [31:0] DataBusC;
	/*From IFID register*/
	input [31:0]Instruction;
	input [31:0]PC;
	
	/*From Forwarding Unit*/
	input [31:0]MEMForwardSrc;
	input [31:0]WBForwardSrc;
	input [31:0]EXForwardSrc;
	input [1:0]BranchSrcA;
	input [1:0]BranchSrcB;

	/*To Hazard and Jump Unit*/
	output wire [1:0]Jump;
	output wire Branch;
	output reg BranchCond;
	output wire [31:0] JumpTarget;
	wire [31:0] JumpTarget_temp;
	assign JumpTarget_temp = (Jump != 2'b00) ? {PC[31:28], Instruction[25:0], 2'b00} : (PC + 32'd4 + ({{14{Instruction[15]}},Instruction[15:0],2'b00}));
	assign JumpTarget = {PC[31], JumpTarget_temp[30:0]};
	output Exception;
	wire Exception_temp;
	assign Exception = Exception_temp && (PC[31] == 1'b0);
	
	/*To IDEX register*/
	output wire RegWrite;
	output wire [4:0] RegDest;
	output wire MemRead;
	output wire MemWrite;
	output wire [1:0] MemtoReg;
	output wire ALUSrc1;
	output wire ALUSrc2;
	output wire [4:0] ALUCtl;
	output wire ALU_Sign;
	output wire [4:0] shamt;
	wire [31:0] DataBusA;
	wire [31:0] DataBusB;
	output wire [31:0] Imm;
	output wire [4:0] rs;
	output wire [4:0] rt;
	assign rs = Instruction[25:21];
	assign rt = Instruction[20:16];
	wire [1:0] RegDst;
	wire [3:0] ALUOp;
    wire ExtOp;
    wire LuOp;
	wire [2:0] BranchType; //Dealing with all sorts of branch
	wire [1:0] RegimmFunct; //Dealing with all sorts of branch
	assign Branch =  (BranchType == 3'b000) ? 1'b0 : 1'b1;
	assign RegimmFunct = {Instruction[20], Instruction[16]};
	Control control_inst(
	.OpCode(Instruction[31:26]), .Funct(Instruction[5:0]), .RegimmFunct(RegimmFunct),
	.PCSrc(Jump), .Branch(BranchType), .RegWrite(RegWrite), .RegDst(RegDst), 
	.MemRead(MemRead),	.MemWrite(MemWrite), .MemtoReg(MemtoReg),
	.ALUSrc1(ALUSrc1), .ALUSrc2(ALUSrc2), .ExtOp(ExtOp), .LuOp(LuOp),.ALUOp(ALUOp),
	.Exception(Exception_temp) ,.Interrupt(Interrupt));
	
	ALUControl alu_control_inst(.ALUOp(ALUOp), .Funct(Instruction[5:0]), .ALUCtl(ALUCtl), .Sign(ALU_Sign));
	assign RegDest = 
	   (Exception_temp || Interrupt) ? 5'd26 :
	   (RegDst == 2'b00)? Instruction[20:16]: (RegDst == 2'b01)? Instruction[15:11]: 5'b11111;
	
	wire [31:0] Ext_out;
	assign Ext_out = {ExtOp? {16{Instruction[15]}}: 16'h0000, Instruction[15:0]};
	assign Imm = LuOp? {Instruction[15:0], 16'h0000}: Ext_out;
	assign shamt = Instruction[10:6];
	
	RegisterFile register_file1(.reset(reset), .clk(clk), .RegWrite(RegWrEn), 
		.Read_register1(Instruction[25:21]), .Read_register2(Instruction[20:16]), .Write_register(RegWBDst),
		.Write_data(DataBusC), .Read_data1(DataBusA), .Read_data2(DataBusB));
	
	output wire [31:0] branchCmpA; //To hazard and jump unit and EX unit
	output wire [31:0] branchCmpB; // To EX unit
	assign branchCmpA = (BranchSrcA == 2'b11) ? WBForwardSrc : ( (BranchSrcA == 2'b10) ? MEMForwardSrc : ((BranchSrcA == 2'b01) ? EXForwardSrc : DataBusA));
	assign branchCmpB = (BranchSrcB == 2'b11) ? WBForwardSrc : ( (BranchSrcB == 2'b10) ? MEMForwardSrc : ((BranchSrcB == 2'b01) ? EXForwardSrc : DataBusB));
	//Conditioning on all sorts of Branch
	wire BranchCond_beq;
	wire BranchCond_bne;
	wire BranchCond_bgtz;
	wire BranchCond_blez;
	wire BranchCond_bgez;
	wire BranchCond_bltz;

	assign BranchCond_beq = (branchCmpA == branchCmpB) ? 1'b1 : 1'b0;
	assign BranchCond_bgez = (branchCmpA[31] == 0) ? 1'b1 : 1'b0;
	assign BranchCond_bltz = ~BranchCond_bgez;
	assign BranchCond_bgtz = BranchCond_bgez && (branchCmpA != 32'h0);
	assign BranchCond_blez = ~BranchCond_bgtz;
	assign BranchCond_bne = ~BranchCond_beq;
	
	always@(*)
	begin
	   case(BranchType)
	   3'b001:BranchCond<=BranchCond_beq;
	   3'b010:BranchCond<=BranchCond_bne;
	   3'b011:BranchCond<=BranchCond_blez;
	   3'b100:BranchCond<=BranchCond_bgtz;
	   3'b101:BranchCond<=BranchCond_bltz;
	   3'b110:BranchCond<=BranchCond_bgez;
	   default:BranchCond<=0;
	   endcase
	end
		
endmodule