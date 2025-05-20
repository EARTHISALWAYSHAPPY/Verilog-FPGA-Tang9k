module HalfAdder(
    input wire iAugend, iAddend,
    output wire oSum, oCarry
);
    assign oSum = iAugend ^ iAddend;  // XOR
    assign oCarry = iAugend & iAddend; // AND
endmodule
