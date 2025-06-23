module Top (
    input wire CLK,
    input wire RESETn,
    output wire [7:0] Row_LED,
    output wire [7:0] Col_LED
);

  localparam Timedelay = 25'd27000;
  reg [24:0] rCnt;
  reg [7:0] rRow_LED;
  reg [7:0] rCol_LED;
  reg [2:0] Cnt_row;

  reg [7:0] char_a[0:7];
  initial begin
    char_a[0] = 8'b11101100;
    char_a[1] = 8'b10010100;
    char_a[2] = 8'b10000110;
    char_a[3] = 8'b01000001;
    char_a[4] = 8'b01000001;
    char_a[5] = 8'b10000110;
    char_a[6] = 8'b10010100;
    char_a[7] = 8'b11101100;
  end

  always @(posedge CLK or negedge RESETn) begin
    if (!RESETn) begin
      rCnt <= 25'd0;
    end else if (rCnt == Timedelay) begin
      rCnt <= 25'd0;
    end else begin
      rCnt <= rCnt + 25'd1;
    end
  end

  always @(posedge CLK or negedge RESETn) begin
    if (!RESETn) begin
      Cnt_row <= 3'd0;
    end else if (rCnt == Timedelay) begin
      Cnt_row <= (Cnt_row == 3'd7) ? 3'd0 : Cnt_row + 3'd1;
    end
  end

  always @(*) begin
    rCol_LED = (8'b00000001 << Cnt_row);
    rRow_LED = ~char_a[Cnt_row];
  end

  assign Row_LED = rRow_LED;
  assign Col_LED = rCol_LED;
endmodule

