// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module basys3_7seg_driver (
    input              clk_1k_i,
    input              rst_ni,

    input  logic       digit0_en_i,
    input  logic [3:0] digit0_i,
    input  logic       digit1_en_i,
    input  logic [3:0] digit1_i,
    input  logic       digit2_en_i,
    input  logic [3:0] digit2_i,
    input  logic       digit3_en_i,
    input  logic [3:0] digit3_i,

    output logic [3:0] anode_o,
    output logic [6:0] segments_o
);

// TODO
logic [6:0] seg_n;
logic [1:0] digsel_d, digsel_q;
logic [3:0] current_dig;

always_ff @(posedge clk_1k_i) begin
    if(!rst_ni) begin
        digsel_q <= 0;
    end
    else begin
        digsel_q <= digsel_d;
    end
end

assign digsel_d = digsel_q + 1;

always_comb begin

    anode_o = 4'b1111;
    current_dig = 4'b0000;

    unique case (digsel_q)
        2'b00: begin
            anode_o[0] = ~digit0_en_i;
            current_dig =  digit0_i;
            //anode_o[3:1] = 3'b111;

        end
        2'b01: begin
            anode_o[1] = ~digit1_en_i;
            current_dig = digit1_i;
            //anode_o[3:2] = 2'b11;
            //anode_o[0] = 1'b1;
        end
        2'b10: begin
            anode_o[2] = ~digit2_en_i;
            current_dig = digit2_i;
            //anode_o[3] = 1'b1;
            //anode_o[1:0] = 2'b11;
        end
        2'b11: begin
            anode_o[3] = ~digit3_en_i;
            current_dig = digit3_i;
            //anode_current_digo[2:0] = 3'b111;
        end
    endcase
end


hex7seg hex_decode (
    .d3(current_dig[3]),
    .d2(current_dig[2]),
    .d1(current_dig[1]),
    .d0(current_dig[0]),
    .A(seg_n[0]),
    .B(seg_n[1]),
    .C(seg_n[2]),
    .D(seg_n[3]),
    .E(seg_n[4]),
    .F(seg_n[5]),
    .G(seg_n[6])
);

assign segments_o = ~seg_n;

endmodule
