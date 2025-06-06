module Btn_Interface (
    input  wire CLK,
    input  wire RESETn,
    input  wire iExtBtn,
    output wire oIntBtn
);
  reg [2:0] rIntBtn;

  assign oIntBtn = (rIntBtn[2] == 1'd1 && rIntBtn[1] == 1'd0) ? 1'd1 : 1'd0;

  always @(posedge CLK or posedge RESETn) begin : u_rIntBtn
    if (RESETn == 1'd0) begin
      rIntBtn <= 3'b111;
    end else begin
      rIntBtn <= {rIntBtn[1], rIntBtn[0], iExtBtn};
    end
  end

endmodule
