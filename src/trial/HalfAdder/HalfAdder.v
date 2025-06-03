module HalfAdder (
    input  wire iAugend,
    input  wire iAddend,
    output wire oSum,
    output wire oCarry
);
  assign oSum   = iAugend ^ iAddend;  // XOR
  assign oCarry = iAugend & iAddend;  // AND
endmodule
