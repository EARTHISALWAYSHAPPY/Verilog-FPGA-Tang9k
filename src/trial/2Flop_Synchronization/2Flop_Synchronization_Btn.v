// apply 2Flop_sync. with Buttom 
// reduce metastable phase.
module Btn_Interface (
    input  wire CLk,
    input  wire RESETn,
    input  wire iExtBtn,
    output wire oIntBtn
);
  reg [1:0] rIntBtn;
  assign oIntBtn = rIntBtn[1];

  always @(posedge CLk or negedge RESETn) begin : u_rIntBtn
    if (RESETn == 1'd0) begin
      rIntBtn <= 2'd3;  // 2b'11 (default high signal)
    end else begin
      rIntBtn <= {rIntBtn[0], iExtBtn};
    end
  end
endmodule
