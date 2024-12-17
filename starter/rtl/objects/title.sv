// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module title import dinorun_pkg::*; (
    input  logic [9:0] pixel_x_i,
    input  logic [9:0] pixel_y_i,
    output logic       pixel_o
);
// TODO

// represents the title.memb array size
localparam int X_WIDTH = 47;
localparam int Y_WIDTH = 7;

localparam int VGA_X = 640;
localparam int VGA_Y = 480;

localparam int SIDE_OFFSET = 10;

// extract title.memb info
logic [X_WIDTH:0] title_mem[Y_WIDTH:0];
initial $readmemb("title.memb", title_mem);

// placeholders for x and y
logic [5:0] x_mem;
logic [5:0] y_mem;

always_comb begin
    // default
    pixel_o = 1'b0;
    // make sure we're within our VGA bounds
    if(pixel_x_i < VGA_X && pixel_y_i < VGA_Y) begin
        // logic to determine what pixels are on/off
        x_mem = ((VGA_X - SIDE_OFFSET) - pixel_x_i)/13;
        y_mem = (pixel_y_i - SIDE_OFFSET)/13;

        // make sure we're within our title.memb file bounds
        if((x_mem >= 0 && x_mem < X_WIDTH) && (y_mem >= 0 && y_mem < Y_WIDTH)) begin
            pixel_o = title_mem[y_mem][x_mem];
        end
    end
end

endmodule
