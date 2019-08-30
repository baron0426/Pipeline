module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			8'd0:    Instruction <= 32'h08000003;
			8'd1:    Instruction <= 32'h08000008;
			8'd2:    Instruction <= 32'h08000009;
			8'd3:    Instruction <= 32'h20040003;
			8'd4:    Instruction <= 32'h20010002;
			8'd5:    Instruction <= 32'h70812002;
			8'd6:    Instruction <= 32'h20840002;
			8'd7:    Instruction <= 32'h1000ffff;
			8'd8:    Instruction <= 32'h00000000;
			8'd9:    Instruction <= 32'h20840001;
			8'd10:    Instruction <= 32'h03400008;
			default: Instruction <= 32'h0;
		endcase
		
endmodule
