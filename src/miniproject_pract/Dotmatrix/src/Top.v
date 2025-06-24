module Top (
    input wire CLK,
    input wire RESETn,
    output wire [7:0] Row_LED,
    output wire [7:0] Col_LED
);

  //wanna be 120 Hz
  localparam Scanrate = 25'd22500;
  reg [18:0] rCnt;

  reg [7:0] rRow_LED;
  reg [7:0] rCol_LED;

  reg [2:0] Cnt_row;

  reg [7:0] char_a[0:7];
  initial begin
    char_a[0] = 8'b00000000;
    char_a[1] = 8'b01100110;
    char_a[2] = 8'b11111111;
    char_a[3] = 8'b11111111;
    char_a[4] = 8'b11111111;
    char_a[5] = 8'b01111110;
    char_a[6] = 8'b00111100;
    char_a[7] = 8'b00011000;
  end

  always @(posedge CLK or negedge RESETn) begin : u_rCnt
    if (!RESETn) begin
      rCnt <= 18'd0;
    end else if (rCnt == Scanrate) begin
      rCnt <= 18'd0;
    end else begin
      rCnt <= rCnt + 18'd1;
    end
  end

  always @(posedge CLK or negedge RESETn) begin : u_rDotmatrix
    if (!RESETn) begin
      Cnt_row <= 3'd0;
    end else if (rCnt == Scanrate) begin
      Cnt_row  <= (Cnt_row == 3'd7) ? 3'd0 : Cnt_row + 3'd1;
      //rCol_LED = 8'b11111111;
      rCol_LED <= (8'b00000001 << Cnt_row);
      rRow_LED <= ~char_a[Cnt_row];
    end
  end

  assign Row_LED = rRow_LED;
  assign Col_LED = rCol_LED;

endmodule
