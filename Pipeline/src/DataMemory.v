
module DataMemory( clk, Address, Write_data, Read_data, MemRead, MemWrite);
	input clk;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output reg [31:0] Read_data;
	
	parameter RAM_SIZE = 512;
	parameter RAM_SIZE_BIT = 9;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	
	integer i;
	
	/*always @(posedge clk)
		if (reset)
		begin
			for (i = 0; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;
		end
		else if (MemWrite)
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
	    else
	        Read_data <=  MemRead ? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;*/
	always @(posedge clk)
	begin
	   if (MemWrite)
		  RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
	   if(MemRead)
	       Read_data <= RAM_data[Address[RAM_SIZE_BIT + 1:2]];
	   else
	       Read_data <= 32'h0;
    end      
			
endmodule
