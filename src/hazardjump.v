module HazardJumpUnit(PC, stall, Jump, Branch, BranchCond, JumpTarget, branchCmpA,
IFIDFlush, IDEXFlush, PC_next);
	input [31:0] PC;
	input stall;
	input [1:0] Jump;
	input Branch;
	input BranchCond;
	input [31:0] JumpTarget;
	
	
	input [31:0] branchCmpA;
	output wire [31:0] PC_next;
	output wire IFIDFlush;
	output wire IDEXFlush;
	assign PC_next = (stall) ? (PC) : ((Jump==2'b10) ? (branchCmpA) : ((Jump== 2'b01) ? (JumpTarget) : ((Branch && BranchCond) ? JumpTarget : (PC + 32'd4) )));
	assign IFIDFlush = (Jump ||(Branch && BranchCond)) ? 1 : 0;
	assign IDEXFlush = (stall) ? 1 : 0;
endmodule