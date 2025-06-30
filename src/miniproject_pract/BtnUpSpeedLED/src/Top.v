module Top (
    input wire CLK,
    input wire RESETn,
    input wire iExtBtn,
    output wire [5:0] oLED
);

  wire wIntBtn;

  Btn m_btn (
      .CLK(CLK),
      .RESETn(RESETn),
      .iExtBtn(iExtBtn),
      .oIntBtn(wIntBtn)
  );

  LEDDriver m_timerled (
      .CLK(CLK),
      .RESETn(RESETn),
      .iIntBtn(wIntBtn),
      .oLED(oLED)
  );

endmodule
