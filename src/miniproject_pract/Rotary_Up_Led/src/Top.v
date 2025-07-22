module Rotary_LED (
    input  wire       Fg_Clk,
    input  wire       RESETn,
    input  wire       Rot_A,   // 29
    input  wire       Rot_B,   // 30 
    output wire [5:0] oLED,
    output wire       A_Fall,  // 54
    output wire       B_Fall   //55
);

  localparam State_idle = 3'd0;
  localparam State_CW = 3'd1;
  localparam State_CCW = 3'd2;

  //wire       A_Fall;
  // wire       B_Fall;
  reg [2:0] rFlop_Rot_A;
  reg [2:0] rFlop_Rot_B;
  reg       CW;
  reg       CCW;
  reg [1:0] State;
  reg [5:0] Count;
  reg [5:0] rLED;

  assign A_Fall = (rFlop_Rot_A[2] == 1'b1 && rFlop_Rot_A[1] == 1'b0) ? 1'b1 : 1'b0;
  assign B_Fall = (rFlop_Rot_B[2] == 1'b1 && rFlop_Rot_B[1] == 1'b0) ? 1'b1 : 1'b0;
  assign oLED   = rLED;

  // Sync Rot_A with 2-flop
  always @(posedge Fg_Clk or negedge RESETn) begin : u_rFlop_Rot_A
    if (!RESETn) begin
      rFlop_Rot_A <= 3'b111;
    end else begin
      rFlop_Rot_A <= {rFlop_Rot_A[1], rFlop_Rot_A[0], Rot_A};
    end
  end

  // Sync Rot_B with 2-flop
  always @(posedge Fg_Clk or negedge RESETn) begin : u_rFlop_Rot_B
    if (!RESETn) begin
      rFlop_Rot_B <= 3'b111;
    end else begin
      rFlop_Rot_B <= {rFlop_Rot_B[1], rFlop_Rot_B[0], Rot_B};
    end
  end

  //State machine for up/down
  always @(posedge Fg_Clk or negedge RESETn) begin : u_State_and_rCnt_Rot
    if (!RESETn) begin
      State <= State_idle;  // <-- begin start idle state
      Count <= 11'd0;
      CW <= 1'b0;
      CCW <= 1'b0;
    end else begin
      case (State)
        State_idle: begin
          State <= (A_Fall) ? State_CCW : (B_Fall) ? State_CW : State_idle;
          CW <= 1'b0;
          CCW <= 1'b0;
        end
        State_CW: begin
          CW <= 1'b1;
          State <= (A_Fall) ? State_idle : State;
        end
        State_CCW: begin
          CCW   <= 1'b1;
          State <= (B_Fall) ? State_idle : State;
        end
      endcase
      if (CW) begin
        Count <= Count + 6'd1;
        CW <= 1'b0;
      end else if (CCW) begin
        Count <= Count - 6'd1;
        CCW   <= 1'b0;
      end
    end
  end

  always @(posedge Fg_Clk or negedge RESETn) begin : u_rLED
    if (!RESETn) begin
      rLED <= 1'd0;
    end else begin
      rLED <= Count;
    end
  end
endmodule
