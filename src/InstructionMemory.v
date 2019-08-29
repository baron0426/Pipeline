module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			8'd0:    Instruction <= 32'h20020010;
			8'd1:    Instruction <= 32'h00002020;
			8'd2:    Instruction <= 32'h10800002;
			8'd3:    Instruction <= 32'h2084fffb;
			8'd4:    Instruction <= 32'h04900005;
			8'd5:    Instruction <= 32'h20840003;
			8'd6:    Instruction <= 32'h1400fffe;
			8'd7:    Instruction <= 32'h2084fffb;
			8'd8:    Instruction <= 32'h1880fffa;
			8'd9:    Instruction <= 32'h04910006;
			8'd10:   Instruction <= 32'h2084000a;
			8'd11:   Instruction <= 32'h00041020;
			8'd12:   Instruction <= 32'h20030010;
			8'd13:   Instruction <= 32'h0043082a;
			8'd14:   Instruction <= 32'h10200003;
			8'd15:   Instruction <= 32'h03e00008;
			8'd16:   Instruction <= 32'h20840005;
			8'd17:   Instruction <= 32'h03e00008;
			8'd18:   Instruction <= 32'h1000ffff;
			default: Instruction <= 32'h0;
		endcase
		
endmodule
