//tb file from GPT

`timescale 1ns / 1ps
`include "HalfAdder.v"  


module HalfAdder_tb;

  // Inputs

  reg iAugend, iAddend;

  // Outputs

  wire oSum, oCarry;

  // Instantiate the HalfAdder module

  HalfAdder dut (
      .iAugend(iAugend),
      .iAddend(iAddend),
      .oSum(oSum),
      .oCarry(oCarry)
  );

  // Stimulus

  initial begin

    $dumpfile("HalfAdder_tb.vcd");
    $dumpvars(0, HalfAdder_tb);  

    // Test case 1: iAugend = 1, iAddend = 0

    iAugend = 1;
    iAddend = 0;
    #10;
    $display("Test Case 1: iAugend = %b, iAddend = %b, oSum = %b, oCarry = %b", iAugend, iAddend,
             oSum, oCarry);

    // Test case 2: iAugend = 1, iAddend = 1

    iAugend = 1;
    iAddend = 1;
    #10;
    $display("Test Case 2: iAugend = %b, iAddend = %b, oSum = %b, oCarry = %b", iAugend, iAddend,
             oSum, oCarry);

    // Test case 3: iAugend = 0, iAddend = 1

    iAugend = 0; 
    iAddend = 1;
    #10;
    $display("Test Case 3: iAugend = %b, iAddend = %b, oSum = %b, oCarry = %b", iAugend, iAddend,
             oSum, oCarry);

    // Test case 4: iAugend = 0, iAddend = 0

    iAugend = 0;
    iAddend = 0;
    #10;
    $display("Test Case 4: iAugend = %b, iAddend = %b, oSum = %b, oCarry = %b", iAugend, iAddend,
             oSum, oCarry);

    $finish;
  end

endmodule
