module Rotary_LED (
    input  wire       Fg_Clk,    // 27 MHz clock
    input  wire       RESETn,
    input  wire       Rot_A,     // 29
    input  wire       Rot_B,     // 30 
    output wire [5:0] oLED,
    output wire       A_Fall,    // 54
    output wire       B_Fall     // 55
);

  // FSM states
  localparam State_idle = 3'd0;
  localparam State_CW   = 3'd1;
  localparam State_CCW  = 3'd2;

  // Debounce threshold for 1s at 27 MHz
  localparam integer DEBOUNCE_MAX = 25'd135000;

  // Registers
  reg [2:0] rFlop_Rot_A;
  reg [2:0] rFlop_Rot_B;
  reg [5:0] rLED;
  reg [5:0] Count;
  reg [1:0] State;
  reg       CW, CCW;

  // Debounce variables
  reg [24:0] debounce_cnt_A, debounce_cnt_B;
  reg        Rot_A_sync, Rot_B_sync;
  reg        debounced_Rot_A, debounced_Rot_B;

  // Debounce for Rot_A
  always @(posedge Fg_Clk or negedge RESETn) begin
    if (!RESETn) begin
      debounce_cnt_A   <= 0;
      Rot_A_sync       <= 1'b1;
      debounced_Rot_A  <= 1'b1;
    end else begin
      if (Rot_A != Rot_A_sync) begin
        debounce_cnt_A <= 0;
        Rot_A_sync     <= Rot_A;
      end else if (debounce_cnt_A < DEBOUNCE_MAX) begin
        debounce_cnt_A <= debounce_cnt_A + 1;
      end else begin
        debounced_Rot_A <= Rot_A_sync;
      end
    end
  end

  // Debounce for Rot_B
  always @(posedge Fg_Clk or negedge RESETn) begin
    if (!RESETn) begin
      debounce_cnt_B   <= 0;
      Rot_B_sync       <= 1'b1;
      debounced_Rot_B  <= 1'b1;
    end else begin
      if (Rot_B != Rot_B_sync) begin
        debounce_cnt_B <= 0;
        Rot_B_sync     <= Rot_B;
      end else if (debounce_cnt_B < DEBOUNCE_MAX) begin
        debounce_cnt_B <= debounce_cnt_B + 1;
      end else begin
        debounced_Rot_B <= Rot_B_sync;
      end
    end
  end

  // Synchronize debounced Rot_A
  always @(posedge Fg_Clk or negedge RESETn) begin
    if (!RESETn)
      rFlop_Rot_A <= 3'b111;
    else
      rFlop_Rot_A <= {rFlop_Rot_A[1], rFlop_Rot_A[0], debounced_Rot_A};
  end

  // Synchronize debounced Rot_B
  always @(posedge Fg_Clk or negedge RESETn) begin
    if (!RESETn)
      rFlop_Rot_B <= 3'b111;
    else
      rFlop_Rot_B <= {rFlop_Rot_B[1], rFlop_Rot_B[0], debounced_Rot_B};
  end

  // Detect falling edge
  assign A_Fall = (rFlop_Rot_A[2] == 1'b1 && rFlop_Rot_A[1] == 1'b0) ? 1'b1 : 1'b0;
  assign B_Fall = (rFlop_Rot_B[2] == 1'b1 && rFlop_Rot_B[1] == 1'b0) ? 1'b1 : 1'b0;

  assign oLED   = ~rLED;

  // FSM for direction detection and count
  always @(posedge Fg_Clk or negedge RESETn) begin
    if (!RESETn) begin
      State <= State_idle;
      Count <= 6'd0;
      CW    <= 1'b0;
      CCW   <= 1'b0;
    end else begin
      case (State)
        State_idle: begin
          State <= (A_Fall) ? State_CCW : (B_Fall) ? State_CW : State_idle;
          CW    <= 1'b0;
          CCW   <= 1'b0;
        end
        State_CW: begin
          CW    <= 1'b1;
          State <= (A_Fall) ? State_idle : State_CW;
        end
        State_CCW: begin
          CCW   <= 1'b1;
          State <= (B_Fall) ? State_idle : State_CCW;
        end
      endcase

      if (CW) begin
        Count <= Count + 6'd1;
        CW    <= 1'b0;
      end else if (CCW) begin
        Count <= Count - 6'd1;
        CCW   <= 1'b0;
      end
    end
  end

  // Output update
  always @(posedge Fg_Clk or negedge RESETn) begin
    if (!RESETn)
      rLED <= 6'd0;
    else
      rLED <= Count;
  end

endmodule
