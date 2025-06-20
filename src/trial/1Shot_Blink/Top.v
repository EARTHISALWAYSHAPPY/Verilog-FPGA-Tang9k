module TopModule(
    input  wire CLK,
    input  wire RESETn,
    input  wire iExtBtn,
    output wire oLED
);
  wire wIntBtn;

  Btn_Interface m_btn_if (
      .CLK(CLK),
      .RESETn(RESETn),
      .iExtBtn(iExtBtn),
      .oIntBtn(wIntBtn)
  );

  LED_Driver m_led_driver (
      .CLK(CLK),
      .RESETn(RESETn),
      .iIntBtn(wIntBtn),
      .oLED(oLED)
  );
endmodule
