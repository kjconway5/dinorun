// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module edge_detector (
    input  logic clk_i,

    input  logic data_i,
    output logic edge_o
);

logic data_d, data_q1, data_q2;
assign data_d = data_i;
assign edge_o = data_q1 && !data_q2;

always_ff @(posedge clk_i) begin
    data_q1 <= data_d;
    data_q2 <= data_q1;
end

endmodule
