module LED_Driver (
    input  wire CLK,
    input  wire RESETn,
    input  wire iIntBtn,
    output wire oLED
);
  localparam cOnPeriod = 4;

  reg [2:0] rCnt;
  assign oLED = (rCnt != 0) ? 1'd1 : 1'd0;

  always @(posedge CLK or negedge RESETn) begin : u_rCnt
    if (RESETn == 1'd0) begin
      rCnt <= 3'd0;
    end else begin
      if (rCnt == 3'd0) begin
        rCnt <= (iIntBtn == 1'd1) ? 3'd1 : 3'd0;
      end else begin
        rCnt <= (rCnt == cOnPeriod) ? 3'd0 : rCnt + 3'd1;
      end
    end
  end
endmodule
