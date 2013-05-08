// Copyright (c) 2013 Gueho Choi, Andrew Downing
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/////////////////////////////////////////////////////////////
//	module: instruction memory ( 8 x 256 )
//	inputs: ReadEnable(rdEn), WriteEnable(wrEn), Address(addr), WriteData(wrData)
//	outputs: Data(Data)
//
////////////////////////////////////////////////////////////
module InstrucMemoryHardcoded (Clk, rdEn, wrEn, addr, wrData, Data);
	
	parameter WIDTH = 8;
	parameter DEPTH = 256;
		
	input Clk;
	input rdEn, wrEn;
	input [WIDTH-1:0] wrData;
	input [7:0] addr;
	
	output [WIDTH-1:0] Data;
	
	reg [WIDTH-1:0] data_out;
	
	always @ (posedge Clk)
		begin : INST_MEMORY
			case (addr)
			  
			  // DIVIDER
			  // initialization
				8'h0: data_out <= 32'h0c_00_09_xx; // dividend (addr 0) = 9
				8'h1: data_out <= 32'h0c_01_04_xx; // divisor (addr 1) = 4
				8'h2: data_out <= 32'h0c_02_00_xx; // quotient (addr 2) = 0
				8'h3: data_out <= 32'h0c_c0_00_xx; // constant 0 (addr c0) = 0
				8'h4: data_out <= 32'h0c_c1_01_xx; // constant 1 (addr c1) = 1
				8'h5: data_out <= 32'h0c_c4_04_xx; // constant 4 (addr c4) = 4
				8'h6: data_out <= 32'h08_10_xx_xx; // jump to instruction 10 (hardcoded inputs) or 20 (user input)
				// division by repeated subtraction
				8'h10: data_out <= 32'h01_00_00_01; // dividend = dividend - divisor
				8'h11: data_out <= 32'h0b_14_00_xx; // if dividend < 0 then jump to instruction 14
				8'h12: data_out <= 32'h00_02_02_c1; // quotient = quotient + 1
				8'h13: data_out <= 32'h08_10_xx_xx; // jump to instruction 10
				// calculate remainder, display output, and exit
				8'h14: data_out <= 32'h00_03_00_01; // remainder (addr 3) = dividend + divisor
				8'h15: data_out <= 32'h0d_fa_03_xx; // ssd0 = remainder
				8'h16: data_out <= 32'h02_fb_03_c4; // ssd1 = remainder >> 4
				8'h17: data_out <= 32'h0d_fc_02_xx; // ssd2 = quotient
				8'h18: data_out <= 32'h02_fd_02_c4; // ssd3 = quotient >> 4
				8'h19: data_out <= 32'h0f_xx_xx_xx; // end program
				// get inputs from user
				8'h20: data_out <= 32'h09_22_e4_xx; // if BtnL = 0 then jump to instruction 22
				8'h21: data_out <= 32'h0d_00_e0_xx; // dividend = FPGA switches
				8'h22: data_out <= 32'h09_24_e1_xx; // if BtnR = 0 then jump to instruction 24
				8'h23: data_out <= 32'h0d_01_e0_xx; // divisor = FPGA switches
				8'h24: data_out <= 32'h0d_fa_01_xx; // ssd0 = divisor
				8'h25: data_out <= 32'h02_fb_01_c4; // ssd1 = divisor >> 4
				8'h26: data_out <= 32'h0d_fc_00_xx; // ssd2 = dividend
				8'h27: data_out <= 32'h02_fd_00_c4; // ssd3 = dividend >> 4
				8'h28: data_out <= 32'h0a_10_e3_xx; // if BtnU > 0 then jump to instruction 10
				8'h29: data_out <= 32'h08_20_xx_xx; // jump to instruction 20
				
				/*
				// ADDER
				8'h0: data_out <= 32'h0c_00_01_xx; // addend0 (addr 0) = 1
				8'h1: data_out <= 32'h0c_01_01_xx; // addend1 (addr 1) = 1
				8'h2: data_out <= 32'h0c_c4_04_xx; // constant 4 (addr c4) = 4
				8'h3: data_out <= 32'h09_05_e4_xx; // if BtnL = 0 then jump to instruction 5
				8'h4: data_out <= 32'h0d_00_e0_xx; // addend0 = FPGA switches
				8'h5: data_out <= 32'h09_07_e1_xx; // if BtnR = 0 then jump to instruction 7
				8'h6: data_out <= 32'h0d_01_e0_xx; // addend1 = FPGA switches
				8'h7: data_out <= 32'h00_02_00_01; // sum (addr 2) = addend0 + addend1
				8'h8: data_out <= 32'h0d_fa_02_xx; // ssd0 = sum
				8'h9: data_out <= 32'h02_fb_02_c4; // ssd1 = sum >> 4
				8'ha: data_out <= 32'h0d_fc_01_xx; // ssd2 = addend2
				8'hb: data_out <= 32'h0d_fd_00_xx; // ssd3 = addend1
				8'hc: data_out <= 32'h08_03_xx_xx; // jump to instruction 3
				*/
				/*
				// TEST EVERY INSTRUCTION
				8'h0: data_out <= 32'h0c_a2_05_xx;
				8'h1: data_out <= 32'h0c_a3_03_xx;
				8'h2: data_out <= 32'h00_a1_a2_a3; // add
				8'h3: data_out <= 32'h01_a1_a2_a3; // sub
				8'h4: data_out <= 32'h0c_a2_04_xx;
				8'h5: data_out <= 32'h0c_a3_02_xx;
				8'h6: data_out <= 32'h02_a1_a2_a3; // rshift
				8'h7: data_out <= 32'h03_a1_a2_a3; // lshift
				8'h8: data_out <= 32'h0c_a2_03_xx;
				8'h9: data_out <= 32'h0c_a3_11_xx;
				8'ha: data_out <= 32'h04_a1_a2_a3; // and
				8'hb: data_out <= 32'h05_a1_a2_a3; // or
				8'hc: data_out <= 32'h06_a1_a2_a3; // xor
				8'hd: data_out <= 32'h07_a1_a2_xx; // inv
				8'he: data_out <= 32'h0c_c0_00_xx;
				8'hf: data_out <= 32'h0c_c1_01_xx;
				8'h10: data_out <= 32'h0c_cf_ff_xx;
				8'h11: data_out <= 32'h08_13_xx_xx; // jmp
				8'h13: data_out <= 32'h09_ff_cf_xx; // jeq0 -1
				8'h14: data_out <= 32'h09_ff_c1_xx; // jeq0 1
				8'h15: data_out <= 32'h09_17_c0_xx; // jeq0 0
				8'h17: data_out <= 32'h0a_ff_cf_xx; // jgt0 -1
				8'h18: data_out <= 32'h0a_ff_c0_xx; // jgt0 0
				8'h19: data_out <= 32'h0a_1b_c1_xx; // jgt0 1
				8'h1b: data_out <= 32'h0b_ff_c0_xx; // jlt0 0
				8'h1c: data_out <= 32'h0b_ff_c1_xx; // jlt0 1
				8'h1d: data_out <= 32'h0b_1f_cf_xx; // jlt0 -1
				8'h1f: data_out <= 32'h0c_a1_05_xx;
				8'h20: data_out <= 32'h0d_a2_a1_xx; // copy
				9'h21: data_out <= 32'h0d_a3_a2_xx; // copy
				9'h22: data_out <= 32'h0f_xx_xx_xx; // halt
				*/
				default: data_out <= 32'hxx_xx_xx_xx;
			endcase
		end
		
		assign Data = data_out;
endmodule
	