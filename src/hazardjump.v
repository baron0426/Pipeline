module HazardJumpUnit(PC, stall, Jump, Branch, BranchCond, JumpTarget, branchCmpA, Interrupt, Exception,
IFIDFlush, IDEXFlush, PC_next);
	input [31:0] PC;
	input stall;
	input [1:0] Jump;
	input Branch;
	input BranchCond;
	input [31:0] JumpTarget;
	input [31:0] branchCmpA;
	input Interrupt;
	input Exception;
	wire [31:0] JumpTarget_normal;
	assign JumpTarget_normal = {1'b0, JumpTarget[30:0]};
	wire [31:0] PC_plus_4;
	assign PC_plus_4 = PC + 32'd4;
	output wire [31:0] PC_next;
	output wire IFIDFlush;
	output wire IDEXFlush;
	assign PC_next = 
	   (Interrupt) ? 32'h80000004 : 
	   (Exception) ? 32'h80000008 : 
	   (stall) ? (PC) : ((Jump==2'b10) ? (branchCmpA) : ((Jump== 2'b01) ? (JumpTarget_normal) : ((Branch && BranchCond) ? JumpTarget_normal : {1'b0, PC_plus_4[30:0]} )));
	assign IFIDFlush = (Jump ||(Branch && BranchCond) || Interrupt || Exception) ? 1 : 0;
	assign IDEXFlush = (stall) ? 1 : 0;
endmodule