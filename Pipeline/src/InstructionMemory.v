module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
	begin
        //for exception test
		/*case (Address[9:2])
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
		endcase*/
		//for fluidity test
		
		case (Address[9:2])
			8'd0:    Instruction <= 32'h08000003;
			8'd1:    Instruction <= 32'h08000015;
			8'd2:    Instruction <= 32'h08000016;
			8'd3:    Instruction <= 32'h20040003;
			8'd4:    Instruction <= 32'h0c000006;
			8'd5:    Instruction <= 32'h1000ffff;
			8'd6:    Instruction <= 32'h23bdfff8;
			8'd7:    Instruction <= 32'hafbf0004;
			8'd8:    Instruction <= 32'hafa40000;
			8'd9:    Instruction <= 32'h28880001;
			8'd10:    Instruction <= 32'h11000003;
			8'd11:    Instruction <= 32'h00001026;
			8'd12:    Instruction <= 32'h23bd0008;
			8'd13:    Instruction <= 32'h03e00008;
			8'd14:    Instruction <= 32'h2084ffff;
			8'd15:    Instruction <= 32'h0c000006;
			8'd16:    Instruction <= 32'h8fa40000;
			8'd17:    Instruction <= 32'h8fbf0004;
			8'd18:   Instruction <= 32'h23bd0008;
			8'd19:   Instruction <= 32'h00821020;
			8'd20:   Instruction <= 32'h03e00008;
			8'd21:   Instruction <= 32'h1000ffff;
			8'd22:   Instruction <= 32'h1000ffff;
			default: Instruction <= 32'h0;
		endcase
		
		// for save-load test
		/*case (Address[9:2])
			8'd0:    Instruction <= 32'h08000003;
			8'd1:    Instruction <= 32'h0800000a;
			8'd2:    Instruction <= 32'h0800000b;
			8'd3:    Instruction <= 32'h3c083000;
			8'd4:    Instruction <= 32'h00002020;
			8'd5:    Instruction <= 32'h8d090000;
			8'd6:    Instruction <= 32'h8d0a0004;
			8'd7:    Instruction <= 32'hac890000;
			8'd8:    Instruction <= 32'hac8a0004;
			8'd9:    Instruction <= 32'h1000ffff;
			8'd10:    Instruction <= 32'h1000ffff;
			8'd11:    Instruction <= 32'h1000ffff;
			default: Instruction <= 32'h0;
		endcase*/
		/*case (Address[9:2])
            8'd0:Instruction <= 32'h08000003;
            8'd1:Instruction <= 32'h08000071;
            8'd2:Instruction <= 32'h08000072;
            8'd3:Instruction <= 32'h0000d820;
            8'd4:Instruction <= 32'h3c103000;
            8'd5:Instruction <= 32'h8e110000;
            8'd6:Instruction <= 32'haf600004;
            8'd7:Instruction <= 32'h001b9021;
            8'd8:Instruction <= 32'h00124821;
            8'd9:Instruction <= 32'h24080001;
            8'd10:Instruction <= 32'h237b0008;
            8'd11:Instruction <= 32'haf600004;
            8'd12:Instruction <= 32'had3b0004;
            8'd13:Instruction <= 32'h001b4821;
            8'd14:Instruction <= 32'h00085880;
            8'd15:Instruction <= 32'h01705820;
            8'd16:Instruction <= 32'h8d6a0000;
            8'd17:Instruction <= 32'had2a0000;
            8'd18:Instruction <= 32'h25080001;
            8'd19:Instruction <= 32'h0228082a;
            8'd20:Instruction <= 32'h1020fff5;
            8'd21:Instruction <= 32'h8e440004;
            8'd22:Instruction <= 32'h10800055;
            8'd23:Instruction <= 32'h0c00003e;
            8'd24:Instruction <= 32'hae420004;
            8'd25:Instruction <= 32'h0800006c;
            8'd26:Instruction <= 32'h00044821;
            8'd27:Instruction <= 32'h00055021;
            8'd28:Instruction <= 32'h237b0008;
            8'd29:Instruction <= 32'haf690004;
            8'd30:Instruction <= 32'h00024021;
            8'd31:Instruction <= 32'h00024821;
            8'd32:Instruction <= 32'h8d2b0000;
            8'd33:Instruction <= 32'h8d2b0004;
            8'd34:Instruction <= 32'h11600006;
            8'd35:Instruction <= 32'h8d6b0000;
            8'd36:Instruction <= 32'h8d4c0000;
            8'd37:Instruction <= 32'h018b082a;
            8'd38:Instruction <= 32'h14200005;
            8'd39:Instruction <= 32'h8d290004;
            8'd40:Instruction <= 32'h08000021;
            8'd41:Instruction <= 32'had2a0004;
            8'd42:Instruction <= 32'h8d020004;
            8'd43:Instruction <= 32'h03e00008;
            8'd44:Instruction <= 32'h000a6021;
            8'd45:Instruction <= 32'h8d8d0004;
            8'd46:Instruction <= 32'h11a00005;
            8'd47:Instruction <= 32'h8dad0000;
            8'd48:Instruction <= 32'h016d082a;
            8'd49:Instruction <= 32'h14200002;
            8'd50:Instruction <= 32'h8d8c0004;
            8'd51:Instruction <= 32'h0800002d;
            8'd52:Instruction <= 32'h8d2b0004;
            8'd53:Instruction <= 32'h8d8d0004;
            8'd54:Instruction <= 32'had8b0004;
            8'd55:Instruction <= 32'had2a0004;
            8'd56:Instruction <= 32'h000d5021;
            8'd57:Instruction <= 32'h11400002;
            8'd58:Instruction <= 32'h000b4821;
            8'd59:Instruction <= 32'h08000021;
            8'd60:Instruction <= 32'h8d020004;
            8'd61:Instruction <= 32'h03e00008;
            8'd62:Instruction <= 32'h00044021;
            8'd63:Instruction <= 32'h8d090004;
            8'd64:Instruction <= 32'h15200002;
            8'd65:Instruction <= 32'h00041021;
            8'd66:Instruction <= 32'h03e00008;
            8'd67:Instruction <= 32'h00044821;
            8'd68:Instruction <= 32'h00045021;
            8'd69:Instruction <= 32'h8d4a0004;
            8'd70:Instruction <= 32'h11400006;
            8'd71:Instruction <= 32'h8d4a0004;
            8'd72:Instruction <= 32'h11400004;
            8'd73:Instruction <= 32'h8d290004;
            8'd74:Instruction <= 32'h8d4a0004;
            8'd75:Instruction <= 32'h11400001;
            8'd76:Instruction <= 32'h08000047;
            8'd77:Instruction <= 32'h8d2a0004;
            8'd78:Instruction <= 32'had200004;
            8'd79:Instruction <= 32'h00082021;
            8'd80:Instruction <= 32'h20010008;
            8'd81:Instruction <= 32'h03a1e822;
            8'd82:Instruction <= 32'hafbf0000;
            8'd83:Instruction <= 32'hafaa0004;
            8'd84:Instruction <= 32'h0c00003e;
            8'd85:Instruction <= 32'h00025821;
            8'd86:Instruction <= 32'h8fbf0000;
            8'd87:Instruction <= 32'h8faa0004;
            8'd88:Instruction <= 32'h23bd0008;
            8'd89:Instruction <= 32'h000a2021;
            8'd90:Instruction <= 32'h20010008;
            8'd91:Instruction <= 32'h03a1e822;
            8'd92:Instruction <= 32'hafbf0000;
            8'd93:Instruction <= 32'hafab0004;
            8'd94:Instruction <= 32'h0c00003e;
            8'd95:Instruction <= 32'h00026021;
            8'd96:Instruction <= 32'h8fbf0000;
            8'd97:Instruction <= 32'h8fab0004;
            8'd98:Instruction <= 32'h23bd0008;
            8'd99:Instruction <= 32'h000b2021;
            8'd100:Instruction <= 32'h000c2821;
            8'd101:Instruction <= 32'h20010004;
            8'd102:Instruction <= 32'h03a1e822;
            8'd103:Instruction <= 32'hafbf0000;
            8'd104:Instruction <= 32'h0c00001a;
            8'd105:Instruction <= 32'h8fbf0000;
            8'd106:Instruction <= 32'h23bd0004;
            8'd107:Instruction <= 32'h03e00008;
            8'd108:Instruction <= 32'h8e480004;
            8'd109:Instruction <= 32'h8d090000;
            8'd110:Instruction <= 32'h8d080004;
            8'd111:Instruction <= 32'h1500fffd;
            8'd112:Instruction <= 32'h1000ffff;
            8'd113:Instruction <= 32'h1000ffff;
            8'd114:Instruction <= 32'h1000ffff;
		endcase*/
	end	
endmodule
