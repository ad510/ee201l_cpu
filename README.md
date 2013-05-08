This is (some of the files from) a project by Gueho Choi and Andrew Downing for the EE 201L course at USC. The project is a Verilog implementation of a simple CPU with a custom instruction set. There are 2 steps to what it does: downloading the program from the computer to the Nexys 3 FPGA, and executing the program on the FPGA.

The top and ucf files are modified from files we were given in class, and I am still arranging releasing them under an open source license. However, I also intend to put these in this repository after that is done. The top file in particular handles downloading the program onto the FPGA.

Without the top file, you can still run our testbenches to run programs stored in a hardcoded instruction memory. OperateTb.v tests solely the combined control unit and arithmetic/logic unit that executes instructions, while the more comprehensive CpuHardcodedTb.v tests instruction execution integrated with the data memory and hardcoded instruction memory. The hardcoded instruction memory is in InstrucMemoryHardcoded.v and includes 3 programs: a divider (using repeated subtraction), an adder, and a program that tests every instruction. You can comment and uncomment the programs to change which one is executed.

We made a presentation about our project which you can view at https://docs.google.com/presentation/d/116GieqHdPb8hMseBOcMwrmJhGJGsdySCBL26FGL9Kzs/edit?usp=sharing

This project is licensed under the MIT License, which you can read in copying.txt.