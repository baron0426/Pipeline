module ForwardingUnit(stall, BranchSrcA, BranchSrcB, Forward1, Forward2, 
MEM_RegWrite, WB_RegWrite, MEM_RegDest, WB_RegDest, MEM_MemRead, IDF_rs, IDF_rt, EXF_rs, EXF_rt, 
ID_Jump, EX_MemRead, EX_RegDest, EX_RegWrite, stall1, stall2);
	input MEM_RegWrite;
	input WB_RegWrite;
	input MEM_MemRead;
	input [4:0] MEM_RegDest;
	input [4:0] WB_RegDest;
	input [4:0] IDF_rs;
	input [4:0] IDF_rt;
	input [4:0] EXF_rs;
	input [4:0] EXF_rt;
	
	//in the case of "load-jr,jalr" we need two stalls.
	//therefore, we need to check the EX stage parameters.
	input [1:0] ID_Jump; //to check if the current instruction in ID stage is a jr or jalr instruction.
	input EX_MemRead;
	input [4:0] EX_RegDest;
	input EX_RegWrite;
	
	output wire stall; //to hazard and jump unit.
	output wire stall1;
    output wire stall2;
	output wire [1:0] BranchSrcA; //to ID unit - forwards of branch addresses from registers
	output wire [1:0] BranchSrcB; //to ID unit
	output wire [1:0] Forward1; //to EX unit - forwards of operand from registers
	output wire [1:0] Forward2; //to EX unit
	assign BranchSrcA = (EX_RegWrite) ? (((EX_RegDest != 0) && (EX_RegDest == IDF_rs)) ? 2'b01 : ((MEM_RegWrite) ? (( (MEM_RegDest != 0) && (MEM_RegDest == IDF_rs)) ? 2'b10 : ((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == IDF_rs)) ? 2'b11 : 2'b00) : 2'b00) ) :((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == IDF_rs)) ? 2'b11 : 2'b00) : 2'b00)) ) : ((MEM_RegWrite) ? (( (MEM_RegDest != 0) && (MEM_RegDest == IDF_rs)) ? 2'b10 : ((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == IDF_rs)) ? 2'b11 : 2'b00) : 2'b00) ) :((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == IDF_rs)) ? 2'b11 : 2'b00) : 2'b00));
	assign BranchSrcB = (EX_RegWrite) ? (((EX_RegDest != 0) && (EX_RegDest == IDF_rt)) ? 2'b01 : ((MEM_RegWrite) ? (( (MEM_RegDest != 0) && (MEM_RegDest == IDF_rt)) ? 2'b10 : ((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == IDF_rt)) ? 2'b11 : 2'b00) : 2'b00) ) :((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == IDF_rt)) ? 2'b11 : 2'b00) : 2'b00)) ) : ((MEM_RegWrite) ? (( (MEM_RegDest != 0) && (MEM_RegDest == IDF_rt)) ? 2'b10 : ((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == IDF_rt)) ? 2'b11 : 2'b00) : 2'b00) ) :((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == IDF_rt)) ? 2'b11 : 2'b00) : 2'b00));
	assign Forward1   = (MEM_RegWrite) ? (( (MEM_RegDest != 0) && (MEM_RegDest == EXF_rs)) ? 2'b01 : ((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == EXF_rs)) ? 2'b10 : 2'b00) : 2'b00) ) :((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == EXF_rs)) ? 2'b10 : 2'b00) : 2'b00);
	assign Forward2   = (MEM_RegWrite) ? (( (MEM_RegDest != 0) && (MEM_RegDest == EXF_rt)) ? 2'b01 : ((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == EXF_rt)) ? 2'b10 : 2'b00) : 2'b00) ) :((WB_RegWrite) ? (( (WB_RegDest != 0) && (WB_RegDest == EXF_rt)) ? 2'b10 : 2'b00) : 2'b00);
	
	assign stall1     = (EX_MemRead)  ? ( (((EX_RegDest == IDF_rs) && (EX_RegDest != 0)) || ( (EX_RegDest == IDF_rt) && (EX_RegDest != 0) )) ? 1  : 0) : 0;
	assign stall2     = (ID_Jump == 2'b10) ? ((EX_MemRead) ? (((EX_RegDest != 0) && (EX_RegDest == IDF_rs)) ? 1 : ((MEM_MemRead) ? (((MEM_RegDest != 0) && (MEM_RegDest == IDF_rs)) ? 1 : 0 ) : 0 ) ) : ((MEM_MemRead) ? (((MEM_RegDest != 0) && (MEM_RegDest == IDF_rs)) ? 1 : 0 ) : 0 ) ) : 0;
	assign stall      = (stall1 | stall2);
endmodule