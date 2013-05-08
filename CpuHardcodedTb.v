// Copyright (c) 2013 Andrew Downing
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

`timescale 1ns / 1ps

module CpuHardcodedTb();
  // constants
  localparam INSTRUC_SIZE = 32, ARG_SIZE = 8, DATA_SIZE = 8;
  
  // inputs
  reg clk, reset, start, ack;
  reg [3:0] btn;
  reg [7:0] sw;
  
  // outputs
  wire done;
  wire [7:0] ld;
  wire [3:0] ssd0;
  wire [3:0] ssd1;
  wire [3:0] ssd2;
  wire [3:0] ssd3;
  
  CpuHardcoded uut(.clk(clk), .reset(reset), .start(start), .ack(ack), .btn(btn), .sw(sw),
                   .done(done), .ld(ld), .ssd0(ssd0), .ssd1(ssd1), .ssd2(ssd2), .ssd3(ssd3));
  
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
    btn = 4'b0;
    sw = 8'b0;
    #15;
    // start program
    reset = 0;
    start = 1;
    ack = 0;
    #10;
    // let program run
    start = 0;
    wait (done);
    #5;
    // ack
    ack = 1;
    wait (!done);
    #5;
    ack = 0;
  end
endmodule

