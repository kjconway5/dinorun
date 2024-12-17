// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module obstacle_tb
    import dinorun_pkg::*;
    ;

localparam int NUM_FRAMES = 150;

import "DPI-C" function chandle gif_open(string filename, int width, int height);
import "DPI-C" function void gif_write_pixel(chandle writer, int x, int y, int r, int g, int b);
import "DPI-C" function void gif_next_frame(chandle writer);
import "DPI-C" function int gif_close(chandle writer);

logic       clk_i;
logic       rst_ni;
logic       next_frame_i;

logic [7:0] rand_i;
logic       spawn_i;

logic [9:0] pixel_x_i;
logic [9:0] pixel_y_i;

cactus cactus (
    .clk_i,
    .rst_ni,
    .next_frame_i,

    .spawn_i,
    .rand_i,

    .pixel_x_i,
    .pixel_y_i
);

bird bird (
    .clk_i,
    .rst_ni,
    .next_frame_i,

    .spawn_i,
    .rand_i,

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

chandle cactus_gif;
chandle bird_gif;

initial begin : sim
    $dumpfile( "dump.fst" );
    $dumpvars;
    $display( "Begin simulation." );
    $urandom(100);

    cactus_gif = gif_open("cactus.gif", 640, 480);
    bird_gif = gif_open("bird.gif", 640, 480);

    rst_ni = 0;
    @(negedge clk_i);
    @(negedge clk_i);
    rst_ni = 1;

    repeat(NUM_FRAMES) begin
        spawn_i = 1;
        rand_i = $urandom;

        for (pixel_x_i = 0; pixel_x_i < ScreenWidth; pixel_x_i++) begin
            for (pixel_y_i = 0; pixel_y_i < ScreenHeight; pixel_y_i++) begin
                @(negedge clk_i);
                if (cactus.pixel_o)
                    gif_write_pixel(cactus_gif, pixel_x_i, pixel_y_i, 255, 255, 255);
                if (bird.pixel_o)
                    gif_write_pixel(bird_gif, pixel_x_i, pixel_y_i, 255, 255, 255);
            end
        end
        next_frame_i = 1;
        @(negedge clk_i);
        next_frame_i = 0;
        gif_next_frame(cactus_gif);
        gif_next_frame(bird_gif);
    end

    assert(gif_close(cactus_gif));
    assert(gif_close(bird_gif));

    $display( "End simulation." );
    $finish;
end

endmodule
