// Copyright (c) 2013 Andrew Downing
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Executes a series of instructions and stores the associated data memory.
// The instruction corresponding to the program counter must still be passed in.
module Cpu
  (clk, reset, start, ack, instruc, btn, sw,
   pc, done, ld, ssd0, ssd1, ssd2, ssd3);
  
  localparam INSTRUC_SIZE = 32, ARG_SIZE = 8, DATA_SIZE = 8;
  
  // inputs
  input clk, reset, start, ack;
  input [(INSTRUC_SIZE - 1) : 0] instruc;
  input [3:0] btn;
  input [7:0] sw;
  
  // outputs
  output [(ARG_SIZE - 1) : 0] pc; // program counter
  output done;
  output reg [7:0] ld;
  output reg [3:0] ssd0;
  output reg [3:0] ssd1;
  output reg [3:0] ssd2;
  output reg [3:0] ssd3;
  
  // operate inputs/outputs
  wire [(DATA_SIZE - 1) : 0] rdData;
  wire rdEn; // data read enable
  wire wrEn; // data write enable
  wire [(ARG_SIZE - 1) : 0] addr; // data read/write address
  wire [(DATA_SIZE - 1) : 0] wrData; // data write value
  
  // data memory output (overriden for FPGA inputs)
  wire [(DATA_SIZE - 1) : 0] rdDataMem;
  
  reg [(ARG_SIZE - 1) : 0] addrPrev; // addr on previous clock
  // hardcode certain data locations to FPGA inputs
  assign rdData = ((addrPrev == 8'he0) ? sw[7:0] :
                   (addrPrev == 8'he1) ? btn[0] :
                   (addrPrev == 8'he2) ? btn[1] :
                   (addrPrev == 8'he3) ? btn[2] :
                   (addrPrev == 8'he4) ? btn[3] :
                   rdDataMem);
  
  Operate operate(.clk(clk), .reset(reset), .start(start), .ack(ack), .instruc(instruc), .rdData(rdData),
                  .rdEn(rdEn), .wrEn(wrEn), .addr(addr), .wrData(wrData), .pc(pc), .done(done));
  
  DataMemory dataMemory(.Clk(clk), .rdEn(rdEn), .wrEn(wrEn), .addr(addr), .wrData(wrData),
                        .Data(rdDataMem));
  
  always @(posedge clk, posedge reset)
  begin
    if (reset)
    begin
      // reset FPGA outputs
      ld <= 8'b0;
      ssd0 <= 4'h0;
      ssd1 <= 4'h0;
      ssd2 <= 4'h0;
      ssd3 <= 4'h0;
    end
    else
    begin
      // remember addr on previous clock for assigning rdData
      addrPrev <= addr;
      // set FPGA outputs to corresponding data memory locations
      if (wrEn)
      begin
        case (addr)
          8'hf0: ld[0] <= wrData[0];
          8'hf1: ld[1] <= wrData[0];
          8'hf2: ld[2] <= wrData[0];
          8'hf3: ld[3] <= wrData[0];
          8'hf4: ld[4] <= wrData[0];
          8'hf5: ld[5] <= wrData[0];
          8'hf6: ld[6] <= wrData[0];
          8'hf7: ld[7] <= wrData[0];
          8'hfa: ssd0 <= wrData[3:0];
          8'hfb: ssd1 <= wrData[3:0];
          8'hfc: ssd2 <= wrData[3:0];
          8'hfd: ssd3 <= wrData[3:0];
        endcase
      end
    end
  end
endmodule
