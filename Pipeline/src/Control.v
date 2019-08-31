
module Control(OpCode, Funct, RegimmFunct,
	PCSrc, Branch, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp, ALUOp, Exception, Interrupt);
	input [5:0] OpCode;
	input [5:0] Funct;
	input [2:0] RegimmFunct;
	input Interrupt;
	output [1:0] PCSrc;
	output [2:0] Branch;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output LuOp;
	output [3:0] ALUOp;
	output Exception;
	
	// Your code below
	
	assign PCSrc[1:0] = 
		(OpCode == 6'h02 || OpCode == 6'h03)? 2'b01 :
		(OpCode == 6'h00 && (Funct ==6'h08 || Funct == 6'h09)) ? 2'b10 :
		2'b00;
	assign Branch =
		(OpCode == 6'h04) ? 3'b001:
		(OpCode == 6'h05) ? 3'b010:
		(OpCode == 6'h06) ? 3'b011:
		(OpCode == 6'h07) ? 3'b100:
		(OpCode == 6'h01 && RegimmFunct[0] == 0) ? 3'b101:
		(OpCode == 6'h01 && RegimmFunct[0] == 1) ? 3'b110:
		(OpCode == 6'h02 || OpCode == 6'h03)? 3'bXXX :
		(OpCode == 6'h00 && (Funct ==6'h08 || Funct == 6'h09)) ? 3'bXXX :
		3'b000;
	assign RegWrite = 
		(OpCode == 6'h2b || OpCode == 6'h04 || OpCode == 6'h02) ? 1'b0 :
		(OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07) ? 1'b0 :
		(OpCode == 6'h00 && Funct == 6'h08) ? 1'b0 :
		(OpCode == 6'h01 && RegimmFunct[1] == 0) ? 1'b0 :
		1'b1;
	assign RegDst[1:0] = 
		(OpCode == 6'h00 && (Funct == 6'h08)) ? 2'bX :
		(OpCode == 6'h02 || OpCode == 6'h04 || OpCode == 6'h2b) ? 2'bX :
		(OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07) ? 2'bX :
		(OpCode == 6'h03 || OpCode == 6'h01) ? 2'b10 :
		(OpCode == 6'h0a || OpCode == 6'h0b || OpCode == 6'h0c || OpCode == 6'h08 || OpCode == 6'h09 || OpCode == 6'h23 || OpCode == 6'h0f) ? 2'b00 :
		2'b01;
	assign MemRead =
		(OpCode == 6'h23) ? 1 : 0;
	assign MemWrite = 
		(OpCode == 6'h2b) ? 1 : 0;
	assign MemtoReg[1:0] = 
	    (Exception || Interrupt) ? 2'b10 :
		(OpCode == 6'h23) ? 2'b01 :
		(OpCode == 6'h03) ? 2'b10 :
		(OpCode == 6'h01) ? 2'b10 :
		(OpCode == 6'h00 && Funct == 6'h09) ? 2'b10 :
		(OpCode == 6'h02 || OpCode == 6'h04) ? 2'bXX : // || OpCode == 6'h2b
		(OpCode == 6'h00 && Funct == 6'h08) ? 2'bXX :
		(OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07) ? 2'bXX :
		2'b00;
	assign ALUSrc1 = 
		(OpCode == 6'h00 && (Funct == 6'h00 || Funct==6'h02 || Funct == 6'h03)) ? 1'b1 :
		(OpCode == 6'h00 && (Funct == 6'h08 || Funct==6'h09)) ? 1'bX :
		(OpCode == 6'h02 || OpCode == 6'h03) ? 1'bX :
		1'b0;
	assign ALUSrc2 = 
		(OpCode == 6'h23 || OpCode == 6'h2b || OpCode == 6'h0f || OpCode == 6'h08 || OpCode == 6'h09 || OpCode == 6'h0c || OpCode == 6'h0a || OpCode == 6'h0b) ? 1'b1 :
		(OpCode == 6'h00 && (Funct == 6'h08 || Funct==6'h09)) ? 1'bX :
		(OpCode == 6'h02 || OpCode == 6'h03) ? 1'bX :
		1'b0;
	assign ExtOp = 
		(OpCode == 6'h0c) ? 1'b0 :
		(OpCode == 6'h00) ? 1'bX :
		(OpCode == 6'h02 || OpCode == 6'h03) ? 1'bx :
		(OpCode == 6'h0f) ? 1'bX :
		1'b1;
	assign LuOp = 
		(OpCode == 6'h0f) ? 1'b1 :
		(OpCode == 6'h00) ? 1'bX :
		(OpCode == 6'h02 || OpCode == 6'h03) ? 1'bx :
		1'b0;
		
	assign Exception = 
	     (OpCode == 6'h23 || OpCode == 6'h2b || OpCode == 6'h0f) ? 1'b0 : 
	     (OpCode >= 6'h00 && OpCode <= 6'h0c) ? 1'b0 :
	     1'b1;
	
	// Your code above
	
	assign ALUOp[2:0] = 
		(OpCode == 6'h00)? 3'b010: 
		(OpCode == 6'h04)? 3'b001: 
		(OpCode == 6'h0c)? 3'b100: 
		(OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: 
		3'b000;
		
	assign ALUOp[3] = OpCode[0];
	
endmodule