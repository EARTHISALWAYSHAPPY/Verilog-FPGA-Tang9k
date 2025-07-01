module blink (
    input  wire CLK,
    input  wire RESETn,
    output wire oLED
);
  localparam delay = 25'd27000000 - 1;
  ////

  reg [24:0] rCnt;
  reg rled;

  ////

  always @(posedge CLK or negedge RESETn) begin : u_rCnt
    if (!RESETn) begin
      rCnt <= 25'd0;
    end else begin
      rCnt <= (rCnt < delay) ? rCnt + 25'd1 : 25'd0;
    end
  end

  always @(posedge CLK or negedge RESETn) begin : u_rled
    if (!RESETn) begin
      rled <= 1'd0;
    end else begin
      if (rCnt == delay) begin
        rled <= (rled == 1'd0) ? 1'd1 : 1'd0;
      end

    end
  end

  ////

  assign oLED = rled;

endmodule
