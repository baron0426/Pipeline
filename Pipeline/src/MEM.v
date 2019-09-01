module MEM(clk, reset, EX_MemRead, EX_MemWrite, EX_ALUOut, EX_WrData, WB_MemReadOut, RAMMemReadOut,
leds, digit, digit_en, Systick, Interrupt);
	input clk;
	input reset;
	input [31:0] Systick;
	input [31:0] RAMMemReadOut;
	output reg [7:0] leds;
	output reg [7:0] digit;
	output reg [3:0] digit_en;
	output Interrupt;
	reg [31:0] TH;
	reg [31:0] TL;
	reg [2:0] TCON;
	assign Interrupt = TCON[2];
	/*From EX_MEM Register*/
	//input EX_RegWrite;
	//input [4:0] EX_RegDest;
	input EX_MemRead;
	input EX_MemWrite;
	//input EX_MemtoReg;
	input [31:0] EX_ALUOut;
	input [31:0] EX_WrData;
	/*To ID, EX Unit*/
	//output [31:0] MEMForwardSrc;
	
	/*To MEM_WB Register*/
	//output wire WB_RegWrite;
	//output wire [4:0] WB_RegDest;
	//output wire [31:0] WB_ALUOut;
	output wire [31:0] WB_MemReadOut;
	wire [31:0] RAMMemReadOut;
	wire [31:0] ROMMemReadOut;
	//output wire WB_MemtoReg;
	assign WB_MemReadOut = 
	   (EX_ALUOut[31:28] == 4'h3) ? ROMMemReadOut :
	   (EX_ALUOut == 32'h40000000) ? TH :
	   (EX_ALUOut == 32'h40000004) ? TL :
	   (EX_ALUOut == 32'h40000008) ? {29'b0, TCON} :
	   (EX_ALUOut == 32'h4000000C) ? {24'b0, leds} :
	   (EX_ALUOut == 32'h40000010) ? {20'b0, digit_en, digit} :
	   (EX_ALUOut == 32'h40000014) ? Systick :
	   RAMMemReadOut;
	   
	SortData SortData_inst(.Address(EX_ALUOut[9:2]),.MemOut(ROMMemReadOut));
	
	always @(posedge clk)
	begin
	  if(reset)
	  begin
	     TH <= 32'h0;
	     TL <= 32'hffffffff;
	     TCON <= 3'b000;
	     leds <= 8'b00000000;
	     digit <= 8'b11111111;
	     digit_en <= 4'b0000;
	  end
	  else if(EX_MemWrite)
	  begin
	       case (EX_ALUOut)
	       32'h40000000: TH <= EX_WrData;
	       32'h40000008: TCON <= EX_WrData[2:0];
	       32'h4000000C: leds <= EX_WrData[7:0];
	       32'h40000010: begin
	       digit <= EX_WrData[7:0];
	       digit_en <= EX_WrData[11:8];
	       end    
	       endcase
	  end
	  else if(TCON[0] && TCON[1] && TL==32'hffffffff)
	  begin
	       TCON[2] <= 1'b1;
	  end
	  
	  if(TCON[0])
	  begin
	      if(TL == 32'hffffffff) TL <= TH;
	      else TL <= TL + 1;
	  end
	  else if (TCON == 3'b000)
	  begin
	      TL <= TH;
	  end
	end
	//DataMemory data_memory_inst(.reset(reset), .clk(clk), .Address(EX_ALUOut), .Write_data(EX_WrData), .Read_data(RAMMemReadOut), .MemRead(EX_MemRead), .MemWrite(EX_MemWrite));
	//assign WB_RegWrite = EX_RegWrite;
	//assign WB_RegDest = EX_RegDest;
	//assign WB_ALUOut = EX_ALUOut;
	//assign WB_MemtoReg = EX_MemtoReg;
	//assign MEMForwardSrc = EX_ALUOut;

endmodule