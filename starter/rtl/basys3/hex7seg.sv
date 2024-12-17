// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module hex7seg(
    input  logic d3,d2,d1,d0,
    output logic A,B,C,D,E,F,G
);

// TODO
/*logic [3:0] hex_i;
assign hex_i = {d3, d2, d1, d0};

always_comb begin
    case(hex_i)
        4'h0: {A, B, C, D, E, F, G} = 7'b011_1111;
        4'h1: {A, B, C, D, E, F, G} = 7'b000_0110;
        4'h2: {A, B, C, D, E, F, G} = 7'b101_1011;
        4'h3: {A, B, C, D, E, F, G} = 7'b100_1111;
        4'h4: {A, B, C, D, E, F, G} = 7'b110_1111;
        4'h5: {A, B, C, D, E, F, G} = 7'b110_1101;
        4'h6: {A, B, C, D, E, F, G} = 7'b111_1101;
        4'h7: {A, B, C, D, E, F, G} = 7'b000_0111;
        4'h8: {A, B, C, D, E, F, G} = 7'b111_1111;
        4'h9: {A, B, C, D, E, F, G} = 7'b110_1111;
        4'hA: {A, B, C, D, E, F, G} = 7'b111_0111;
        4'hB: {A, B, C, D, E, F, G} = 7'b111_1100;
        4'hC: {A, B, C, D, E, F, G} = 7'b011_1001;
        4'hD: {A, B, C, D, E, F, G} = 7'b101_1110;
        4'hE: {A, B, C, D, E, F, G} = 7'b111_1001;
        4'hF: {A, B, C, D, E, F, G} = 7'b111_0001;
        default: {A, B, C, D, E, F, G} = 7'b000_0000;
    endcase
end*/

assign A = ((~d3&~d2&~d1&~d0)|(~d3&~d2&d1&~d0)|(~d3&~d2&d1&d0)|(~d3&d2&~d1&d0)|(~d3&d2&d1&~d0)|
(~d3&d2&d1&d0)|(d3&~d2&~d1&~d0)|(d3&~d2&~d1&d0)|(d3&~d2&d1&~d0)|(d3&d2&~d1&~d0)|(d3&d2&d1&~d0)|
(d3&d2&d1&d0));

assign B = ((~d3&~d2&~d1&~d0)|(~d3&~d2&~d1&d0)|(~d3&~d2&d1&~d0)|(~d3&~d2&d1&d0)|(~d3&d2&~d1&~d0)|
(~d3&d2&d1&d0)|(d3&~d2&~d1&~d0)|(d3&~d2&~d1&d0)|(d3&~d2&d1&~d0)|(d3&d2&~d1&d0));

assign C = ((~d3&~d2&~d1&~d0)|(~d3&~d2&~d1&d0)|(~d3&~d2&d1&d0)|(~d3&d2&~d1&~d0)|(~d3&d2&~d1&d0)|
(~d3&d2&d1&~d0)|(~d3&d2&d1&d0)|(d3&~d2&~d1&~d0)|(d3&~d2&~d1&d0)|(d3&~d2&d1&~d0)|(d3&~d2&d1&d0)|
(d3&d2&~d1&d0));

assign D = ((~d3&~d2&~d1&~d0)|(~d3&~d2&d1&~d0)|(~d3&~d2&d1&d0)|(~d3&d2&~d1&d0)|(~d3&d2&d1&~d0)|
(d3&~d2&~d1&~d0)|(d3&~d2&~d1&d0)|(d3&~d2&d1&d0)|(d3&d2&~d1&~d0)|(d3&d2&~d1&d0)|(d3&d2&d1&~d0));

assign E = ((~d3&~d2&~d1&~d0)|(~d3&~d2&d1&~d0)|(~d3&d2&d1&~d0)|(d3&~d2&~d1&~d0)|(d3&~d2&d1&~d0)|
(d3&~d2&d1&d0)|(d3&d2&~d1&~d0)|(d3&d2&~d1&d0)|(d3&d2&d1&~d0)|(d3&d2&d1&d0));

assign F = ((~d3&~d2&~d1&~d0)|(~d3&d2&~d1&~d0)|(~d3&d2&~d1&d0)|(~d3&d2&d1&~d0)|(d3&~d2&~d1&~d0)|
(d3&~d2&~d1&d0)|(d3&~d2&d1&~d0)|(d3&~d2&d1&d0)|(d3&d2&~d1&~d0)|(d3&d2&d1&~d0)|(d3&d2&d1&d0));

assign G = ((~d3&~d2&d1&~d0)|(~d3&~d2&d1&d0)|(~d3&d2&~d1&~d0)|(~d3&d2&~d1&d0)|(~d3&d2&d1&~d0)|
(d3&~d2&~d1&~d0)|(d3&~d2&~d1&d0)|(d3&~d2&d1&~d0)|(d3&~d2&d1&d0)|(d3&d2&~d1&d0)|(d3&d2&d1&~d0)|
(d3&d2&d1&d0));

endmodule
