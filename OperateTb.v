// Copyright (c) 2013 Andrew Downing
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

`timescale 1ns / 1ps

module OperateTb();
  // constants
  localparam INSTRUC_SIZE = 32, ARG_SIZE = 8, DATA_SIZE = 8;
  
  // inputs
  reg clk, reset, start, ack;
  reg [(INSTRUC_SIZE - 1) : 0] instruc;
  reg [(DATA_SIZE - 1) : 0] rdData;
  
  // outputs
  wire rdEn; // data read enable
  wire wrEn; // data write enable
  wire [(ARG_SIZE - 1) : 0] addr; // data read/write address
  wire [(DATA_SIZE - 1) : 0] wrData; // data write value
  wire [(ARG_SIZE - 1) : 0] pc; // program counter
  wire done;
  
  Operate uut(.clk(clk), .reset(reset), .start(start), .ack(ack), .instruc(instruc), .rdData(rdData),
              .rdEn(rdEn), .wrEn(wrEn), .addr(addr), .wrData(wrData), .pc(pc), .done(done));
  
  initial begin : CLOCK_GEN
    clk = 1;
    forever begin
      #5;
      clk = ~clk;
    end
  end
  
  initial begin
    // do reset
    reset = 1;
    #15;
    // start program
    reset = 0;
    start = 1;
    ack = 0;
    #10;
    start = 0;
    #10;
    // add
    instruc = 32'h00_01_02_03;
    #20;
    rdData = 4;
    #10;
    rdData = 5;
    #10;
    rdData = 8'bx;
    #10;
    // halt
    instruc = 32'h0f_xx_xx_xx;
    wait (done);
    #5;
    // ack
    ack = 1;
    wait (!done);
    #5;
    ack = 0;
  end
endmodule