module Top (
    input wire CLK,
    input wire RESETn,
    output wire [7:0] Row_LED,
    output wire [7:0] Col_LED
);

  localparam Timedelay = 25'd26999999;  // 1 second
  reg [24:0] rCnt;
  reg [ 7:0] rRow_LED;
  reg [ 7:0] rCol_LED;


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

  always @(posedge CLK or negedge RESETn) begin : u_rDotmatix
    if (RESETn == 1'd0) begin
      rCol_LED <= 8'b00000000;
      rRow_LED <= 8'b00000000;
    end else begin
      rCol_LED <= 8'b11111111;
      rRow_LED <= 8'b00000000;
    end
  end


  assign Row_LED = rRow_LED;
  assign Col_LED = rCol_LED;
endmodule
