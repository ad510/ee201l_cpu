// Copyright (c) 2013 Andrew Downing
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Uses the Cpu module to execute a hardcoded program stored in the InstrucMemoryHardcoded module.
module CpuHardcoded
  (clk, reset, start, ack, btn, sw,
   done, ld, ssd0, ssd1, ssd2, ssd3);
  
  localparam INSTRUC_SIZE = 32, ARG_SIZE = 8;
  
  // inputs
  input clk, reset, start, ack;
  input [3:0] btn;
  input [7:0] sw;
  
  // outputs
  output done;
  output [7:0] ld;
  output [3:0] ssd0;
  output [3:0] ssd1;
  output [3:0] ssd2;
  output [3:0] ssd3;
  
  // cpu inputs/outputs
  wire [(INSTRUC_SIZE - 1) : 0] instruc;
  wire [(ARG_SIZE - 1) : 0] pc; // program counter
  
  // instruction memory filler variables
  wire rdEnFiller;
  assign rdEnFiller = 1'b1;
  wire wrEnFiller;
  assign wrEnFiller = 1'b0;
  wire [INSTRUC_SIZE-1:0] wrDataFiller;
  
  Cpu cpu(.clk(clk), .reset(reset), .start(start), .ack(ack), .instruc(instruc), .btn(btn), .sw(sw),
          .pc(pc), .done(done), .ld(ld), .ssd0(ssd0), .ssd1(ssd1), .ssd2(ssd2), .ssd3(ssd3));
  
  defparam instrucMemory.WIDTH = INSTRUC_SIZE;
  InstrucMemoryHardcoded instrucMemory(.Clk(clk), .rdEn(rdEnFiller), .wrEn(wrEnFiller), .addr(pc), .wrData(wrDataFiller),
                                       .Data(instruc));
endmodule
