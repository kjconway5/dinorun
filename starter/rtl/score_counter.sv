// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module score_counter (
    input  logic       clk_i,
    input  logic       rst_ni,
    input  logic       en_i,

    output logic [3:0] digit0_o,
    output logic [3:0] digit1_o,
    output logic [3:0] digit2_o,
    output logic [3:0] digit3_o
);

logic [3:0] digit0_d, digit0_q;
logic [3:0] digit1_d, digit1_q;
logic [3:0] digit2_d, digit2_q;
logic [3:0] digit3_d, digit3_q;

assign digit0_o = digit0_q;
assign digit1_o = digit1_q;
assign digit2_o = digit2_q;
assign digit3_o = digit3_q;

always_comb begin
    digit0_d = digit0_q + 1;
    digit1_d = digit1_q;
    digit2_d = digit2_q;
    digit3_d = digit3_q;

    if (digit0_d == 10) begin
        digit0_d = 0;
        digit1_d = digit1_q + 1;
    end
    if (digit1_d == 10) begin
        digit1_d = 0;
        digit2_d = digit2_q + 1;
    end
    if (digit2_d == 10) begin
        digit2_d = 0;
        digit3_d = digit3_q + 1;
    end
end

always_ff @(posedge clk_i) begin
    if (!rst_ni) begin
        digit0_q <= 0;
        digit1_q <= 0;
        digit2_q <= 0;
        digit3_q <= 0;
    end else if (en_i) begin
        digit0_q <= digit0_d;
        digit1_q <= digit1_d;
        digit2_q <= digit2_d;
        digit3_q <= digit3_d;
    end
end

endmodule
