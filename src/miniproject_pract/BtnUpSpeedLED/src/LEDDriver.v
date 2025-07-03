module LEDDriver (
    input wire CLK,
    input wire RESETn,
    input wire iIntBtn,
    output wire [5:0] oLED
);

  localparam OneSecond = 26'd27000000 - 1;
  localparam DotFiveSecond = 26'd13500000 - 1;
  localparam DotOneSecond = 26'd2700000 - 1;

  reg [25:0] rTimedelay;
  reg [25:0] rCnt;
  reg [ 5:0] rLED;

  always @(posedge CLK or negedge RESETn) begin : u_Timdelay
    if (RESETn == 1'd0) begin
      rTimedelay <= OneSecond;
    end else begin
      if (iIntBtn == 1'd1) begin
        if (rTimedelay == OneSecond) begin  // 1 -> 0.5
          rTimedelay <= DotFiveSecond;
        end else if (rTimedelay == DotFiveSecond) begin  // 0.5 -> 0.1
          rTimedelay <= DotOneSecond;
        end else if (rTimedelay == DotOneSecond) begin  // 0.1 -> 1
          rTimedelay <= DotFiveSecond;
        end
      end
    end
  end


  always @(posedge CLK or negedge RESETn) begin : u_rCnt_rLED
    if (RESETn == 1'd0) begin
      rCnt <= 26'd0;
      rLED <= 6'd0;
    end else begin
      if (rCnt < rTimedelay) begin
        rCnt <= rCnt + 1;
      end else begin
        rCnt <= 26'd0;

        if (rLED == 6'd60) begin
          rLED <= 6'd0;
        end else begin
          rLED <= rLED + 6'd1;
        end
      end
    end
  end

  assign oLED = ~rLED;

endmodule
