// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

// https://vesa.org/vesa-standards/
// http://tinyvga.com/vga-timing

module vga_timer (
    // TODO
    input logic clk_i,
    input logic rst_ni,
    output logic hsync_o,
    output logic vsync_o,
    output logic visible_o,
    output logic [9:0] position_x_o,
    output logic [9:0] position_y_o
);

// TODO
logic [9:0] hcount_d, hcount_q; // 0-799
logic [9:0] vcount_d, vcount_q; // 0-525

// counter flipflop
always_ff @(posedge clk_i) begin
    if (!rst_ni) begin
        hcount_q <= 0;
        vcount_q <= 0;
    end else begin
        hcount_q <= hcount_d;
        vcount_q <= vcount_d;
    end
end

// combinational logic (count +1 if false)
assign hcount_d = (hcount_q == 799) ? 0:hcount_q+1;

// combinational logic (count +1 if false)
assign vcount_d = (hcount_q == 799 && vcount_q < 524) ? vcount_q+1:
                  (vcount_q == 524 && hcount_q == 799) ? 0:
                   vcount_q;

// low for pixel 656 - 751
assign hsync_o = ~((hcount_q >= 656) && (hcount_q < 752));

// low for pixel 490 - 491
assign vsync_o = ~((vcount_q >= 490) && (vcount_q < 492));

// keeps in bounds of visible area
assign visible_o = (hcount_q < 640) && (vcount_q < 480);

assign position_x_o = hcount_q[9:0]; // x coordinate output (0 - 639)
assign position_y_o = vcount_q[9:0]; // y coordinate output (0 - 479)

endmodule

