module BinaryLED (
    input CLK,
    input RESETn,
    output wire [5:0] oled
);
  localparam Timedelay = 25'd26_999_999;
  reg [24:0] rCnt;
  reg [ 5:0] rled;

  always @(posedge CLK or negedge RESETn) begin : u_rCnt
    if (RESETn == 1'd0) begin
      rCnt <= 25'd0;
    end else begin
      if (rCnt < Timedelay) begin
        rCnt <= rCnt + 1;
      end else begin
        rCnt <= 25'd0;
      end
    end
  end

  always @(posedge CLK or negedge RESETn) begin : u_rled
    if (RESETn == 1'd0) begin
      rled <= 6'd0;
    end else begin
      if (rCnt == Timedelay) begin
        if (rled == 6'd63) rled <= 6'd0;
        else rled <= rled + 1;
      end
    end
  end

  assign oled = ~rled;

endmodule
