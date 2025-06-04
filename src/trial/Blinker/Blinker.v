module Blinker (
    input wire CLK,
    input wire RESETn,
    output wire oLED
);
    reg rLED;
    reg [2:0] rCnt;

    assign oLED = rLED;

    always @(posedge CLK or negedge RESETn) begin : u_rCnt
    if (RESETn == 1'd0) begin
        rCnt <= 3'd0;
    end
    else begin
        rCnt <= rCnt 3'd1;
    end
    end

    always @(posedge CLK or negedge RESETn) begin : u_rLED
    if (RESETn == 1'd0) begin
        rLED <= 1'd0;
    end
    else begin
        rLED <= (rCnt == 3'd7) ? ~rLED : rLED;
    end
    end

endmodule
