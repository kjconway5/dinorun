// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module dino_tb
    import dinorun_pkg::*;
    ;

localparam int NUM_FRAMES = 250;

import "DPI-C" function chandle gif_open(string filename, int width, int height);
import "DPI-C" function void gif_write_pixel(chandle writer, int x, int y, int r, int g, int b);
import "DPI-C" function void gif_next_frame(chandle writer);
import "DPI-C" function int gif_close(chandle writer);

logic       clk_i;
logic       rst_ni;
logic       next_frame_i;

logic       up_i;
logic       down_i;
logic       hit_i;

logic [9:0] pixel_x_i;
logic [9:0] pixel_y_i;

dino dino (
    .clk_i,
    .rst_ni,
    .next_frame_i,

    .up_i,
    .down_i,
    .hit_i,

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

chandle dino_gif;

initial begin : sim
    $dumpfile( "dump.fst" );
    $dumpvars;
    $display( "Begin simulation." );
    $urandom(100);

    dino_gif = gif_open("dino.gif", 640, 480);

    rst_ni = 0;
    @(negedge clk_i);
    @(negedge clk_i);
    rst_ni = 1;

    up_i = 0;
    down_i = 0;
    hit_i = 0;
    repeat(NUM_FRAMES/6) begin
        for (pixel_x_i = 0; pixel_x_i < ScreenWidth; pixel_x_i++) begin
            for (pixel_y_i = 0; pixel_y_i < ScreenHeight; pixel_y_i++) begin
                @(negedge clk_i);
                if (dino.pixel_o)
                    gif_write_pixel(dino_gif, pixel_x_i, pixel_y_i, 255, 255, 255);
            end
        end
        next_frame_i = 1;
        @(negedge clk_i);
        next_frame_i = 0;
        gif_next_frame(dino_gif);
    end

    up_i = 1;
    down_i = 0;
    hit_i = 0;
    repeat(NUM_FRAMES/6) begin
        for (pixel_x_i = 0; pixel_x_i < ScreenWidth; pixel_x_i++) begin
            for (pixel_y_i = 0; pixel_y_i < ScreenHeight; pixel_y_i++) begin
                @(negedge clk_i);
                if (dino.pixel_o)
                    gif_write_pixel(dino_gif, pixel_x_i, pixel_y_i, 255, 255, 255);
            end
        end
        next_frame_i = 1;
        @(negedge clk_i);
        next_frame_i = 0;
        gif_next_frame(dino_gif);
    end

    up_i = 1;
    down_i = 1;
    hit_i = 0;
    repeat(NUM_FRAMES/6) begin
        for (pixel_x_i = 0; pixel_x_i < ScreenWidth; pixel_x_i++) begin
            for (pixel_y_i = 0; pixel_y_i < ScreenHeight; pixel_y_i++) begin
                @(negedge clk_i);
                if (dino.pixel_o)
                    gif_write_pixel(dino_gif, pixel_x_i, pixel_y_i, 255, 255, 255);
            end
        end
        next_frame_i = 1;
        @(negedge clk_i);
        next_frame_i = 0;
        gif_next_frame(dino_gif);
    end

    up_i = 1;
    down_i = 0;
    hit_i = 1;
    repeat(NUM_FRAMES/6) begin
        for (pixel_x_i = 0; pixel_x_i < ScreenWidth; pixel_x_i++) begin
            for (pixel_y_i = 0; pixel_y_i < ScreenHeight; pixel_y_i++) begin
                @(negedge clk_i);
                if (dino.pixel_o)
                    gif_write_pixel(dino_gif, pixel_x_i, pixel_y_i, 255, 255, 255);
            end
        end
        next_frame_i = 1;
        @(negedge clk_i);
        next_frame_i = 0;
        gif_next_frame(dino_gif);
    end

    up_i = 0;
    down_i = 1;
    hit_i = 0;
    repeat(NUM_FRAMES/6) begin
        for (pixel_x_i = 0; pixel_x_i < ScreenWidth; pixel_x_i++) begin
            for (pixel_y_i = 0; pixel_y_i < ScreenHeight; pixel_y_i++) begin
                @(negedge clk_i);
                if (dino.pixel_o)
                    gif_write_pixel(dino_gif, pixel_x_i, pixel_y_i, 255, 255, 255);
            end
        end
        next_frame_i = 1;
        @(negedge clk_i);
        next_frame_i = 0;
        gif_next_frame(dino_gif);
    end

    assert(gif_close(dino_gif));

    $display( "End simulation." );
    $finish;
end

endmodule
