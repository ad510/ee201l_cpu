// Copyright (c) 2013 Gueho Choi
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/////////////////////////////////////////////////////////////
//	module: data memory ( 8 x 256 )
//	inputs: ReadEnable(rdEn), WriteEnable(wrEn), Address(addr), WriteData(wrData)
//	outputs: Data(Data)
//
////////////////////////////////////////////////////////////
module DataMemory (Clk, rdEn, wrEn, addr, wrData, Data);
	
	parameter WIDTH = 8;
	parameter DEPTH = 256;
		
	input Clk;
	input rdEn, wrEn;
	input [WIDTH-1:0] wrData;
	input [7:0] addr;
	
	output [WIDTH-1:0] Data;
	
	reg [WIDTH-1:0] data_out;

	reg [WIDTH-1 : 0] memory[DEPTH-1 : 0];
	
	always @ (posedge Clk)
		begin : DATA_MEM
		  data_out <= 100'bx;
			if (wrEn)
				begin
					memory[addr] <= wrData;
				end
			if (rdEn) 
				begin
					data_out <= memory[addr]; 
				end
		end
		
		assign Data = data_out;
endmodule
	