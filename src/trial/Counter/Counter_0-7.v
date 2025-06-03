// requirment Counter 0-7
// use 3 bit
module Counter (
    input wire CLK,
    input wire RESETn,
    output wire [2:0] oCnt
);
  // [2:0] array n = 3 bit (2^n - 1)
  reg [2:0] rCnt;
  assign oCnt = rCnt;

  always @(posedge CLK or negedge RESETn) begin : u_rCnt
    if (RESETn == 1'd0) begin
      rCnt <= 3'd0;
    end else begin
      rCnt <= rCnt + 3'd1;
    end
  end
endmodule
