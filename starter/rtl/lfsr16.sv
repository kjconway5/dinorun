// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module lfsr16 (
    input  logic       clk_i,
    input  logic       rst_ni,

    input  logic       next_i,
    output logic [15:0] rand_o
);

// TODO
logic [15:0] lfsr_d, lfsr_q;

always_ff@(posedge clk_i) begin
    if(!rst_ni) begin
        lfsr_q <= 16'b0000_0000_0000_0001;
    end
    else if (next_i) begin
        lfsr_q <= lfsr_d;
    end
end

// feedback: x^16 + x^14 + x^13 + x^11 + 1
assign lfsr_d = {lfsr_q[14:0], lfsr_q[15] ^ lfsr_q[13] ^ lfsr_q[12] ^lfsr_q[10]};
assign rand_o = lfsr_q[15:0];

endmodule
