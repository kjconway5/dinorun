// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module title_tb
    import dinorun_pkg::*;
    ;

import "DPI-C" function chandle gif_open(string filename, int width, int height);
import "DPI-C" function void gif_write_pixel(chandle writer, int x, int y, int r, int g, int b);
import "DPI-C" function void gif_next_frame(chandle writer);
import "DPI-C" function int gif_close(chandle writer);

logic       clk_i;
logic [9:0] pixel_x_i;
logic [9:0] pixel_y_i;

title title (
    .pixel_x_i,
    .pixel_y_i
);

initial begin
    clk_i = 0;
    forever begin
        clk_i = !clk_i;
        #1;
    end
end

chandle title_gif;

initial begin : sim
    $dumpfile( "dump.fst" );
    $dumpvars;
    $display( "Begin simulation." );
    $urandom(100);

    title_gif = gif_open("title.gif", 640, 480);
    gif_next_frame(title_gif);

    for (pixel_x_i = 0; pixel_x_i < ScreenWidth; pixel_x_i++) begin
        for (pixel_y_i = 0; pixel_y_i < ScreenHeight; pixel_y_i++) begin
            @(negedge clk_i);
            if (title.pixel_o)
                gif_write_pixel(title_gif, pixel_x_i, pixel_y_i, 255, 255, 255);
        end
    end

    assert(gif_close(title_gif));

    $display( "End simulation." );
    $finish;
end

endmodule
