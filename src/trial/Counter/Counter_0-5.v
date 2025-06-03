// requirment Counter 0-5 modified
// use 3 bit
module Counter (
    input wire CLK,
    input wire RESETn,
    output wire [2:0] oCnt
);
  reg [2:0] rCnt;
  assign oCnt = rCnt;

  always @(posedge CLK or negedge RESETn) begin : u_rCnt
    if (RESETn == 1'd0) begin
      rCnt <= 3'd0;
    end else begin
      if (rCnt == 3'd5) begin
        rCnt <= 3'd0;
      end else begin
        rCnt <= rCnt + 3'd1;
      end
    end
    // use ternary if 
    // else begin
    //     rCnt <= (rCnt == 3'd5) ? 3'd0 : rCnt + 3'd1;
    // end
  end
endmodule
