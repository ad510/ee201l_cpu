This is (some of the files from) a project by Gueho Choi and Andrew Downing for the EE 201L course at USC. The project is a Verilog implementation of a simple CPU with a custom instruction set. There are 2 steps to what it does: uploading the program from the computer to the Nexys 3 FPGA, and executing the program on the FPGA.

The top and ucf files are modified from files we were given in class, and I am still arranging releasing them under an open source license. However, I also intend to put these in this repository after that is done. The top file in particular handles uploading the program onto the FPGA.

Without the top file, you can still run our testbenches to run programs stored in a hardcoded instruction memory. OperateTb.v tests solely the combined control unit and arithmetic/logic unit that executes instructions, while the more comprehensive CpuHardcodedTb.v tests instruction execution integrated with the data memory and hardcoded instruction memory. The hardcoded instruction memory is in InstrucMemoryHardcoded.v and includes 3 programs: a divider (using repeated subtraction), an adder, and a program that tests every instruction. You can comment and uncomment the programs to change which one is executed. Originally we planned to use another data memory to store the uploaded program (though we didn't end up doing this), which is why the hardcoded instruction memory has unused inputs and a default width that is shorter than the actual instructions.

Additional resources:

- report: https://docs.google.com/document/d/1rDl6TE-expedje2RqgqnSG9qeeuwKQJCf3Z0rOxhp3Y/edit?usp=sharing
- presentation: https://docs.google.com/presentation/d/116GieqHdPb8hMseBOcMwrmJhGJGsdySCBL26FGL9Kzs/edit?usp=sharing
- CPU state diagram: https://docs.google.com/drawings/d/1v96S4ytBjT4gFATg1ZrOuTrLEdPje1TaeFL2_Q9mjBY/edit?usp=sharing
- uploading program state diagram: https://docs.google.com/drawings/d/1aA-KCpSVyENl9J5f5yNUl7JjhRp0CXWX7f41Lb15Ee4/edit?usp=sharing

This project is licensed under the MIT License, which you can read in copying.txt.