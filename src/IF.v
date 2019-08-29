module IF(PC_in, IFIDFlush, Instruction);
	input [31:0]PC_in;
	input IFIDFlush;
	output [31:0] Instruction;
	wire [31:0]Inst_read;
	InstructionMemory instruction_memory1(.Address(PC_in), .Instruction(Inst_read));
	assign Instruction = (IFIDFlush) ? 32'd0 : Inst_read;
endmodule