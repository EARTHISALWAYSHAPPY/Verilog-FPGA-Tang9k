module ClkDivider (
    input  wire CLK,
    input  wire RESETn,
    output wire oCLK_DIV
);
  reg rCLk_DIV;

  assign oCLK_DIV = rCLk_DIV;
  // assign for net type link variable type.

  always @(posedge CLK or negedge RESETn) begin : u_rCLk_DIV
    if (RESETn == 1'b0) begin
      rCLk_DIV <= 1'b0;
    end else begin
      rCLk_DIV <= ~rCLk_DIV;
    end
  end
endmodule
