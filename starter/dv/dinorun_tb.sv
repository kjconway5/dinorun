// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module dinorun_tb
    import dinorun_pkg::*;
    ;

localparam int NUM_FRAMES = 120;

import "DPI-C" function chandle gif_open(string filename, int width, int height);
import "DPI-C" function void gif_write_pixel(chandle writer, int x, int y, int r, int g, int b);
import "DPI-C" function void gif_next_frame(chandle writer);
import "DPI-C" function int gif_close(chandle writer);

logic clk_i;
logic rst_ni;

logic start_i = 0;
logic up_i = 0;
logic down_i = 0;

dinorun dinorun (
    .clk_25_175_i(clk_i),
    .rst_ni,

    .start_i,
    .up_i,
    .down_i
);

initial begin
    clk_i = 0;
    forever begin
        clk_i = !clk_i;
        #19.8609731877ps; // 25.175 MHz
    end
end

chandle dinorun_gif;

initial begin : buttons
    start_i = 1;
    repeat(15) @(posedge dinorun.vga_vsync_o);
    start_i = 0;
    up_i = 1;
    repeat(15) @(posedge dinorun.vga_vsync_o);
    up_i = 0;
    down_i = 1;
    repeat(80) @(posedge dinorun.vga_vsync_o);
    start_i = 1;
    down_i = 0;
end

initial begin : sim
    $dumpfile( "dump.fst" );
    $dumpvars;
    $display( "Begin simulation." );
    $urandom(100);

    dinorun_gif = gif_open("dinorun.gif", 640, 480);

    rst_ni = 0;
    @(negedge clk_i);
    @(negedge clk_i);
    rst_ni = 1;

    for (int frame = 0; frame < NUM_FRAMES; frame++) begin
        @(negedge dinorun.vga_vsync_o);
        @(posedge dinorun.vga_vsync_o);
        repeat(26400) @(posedge clk_i);
        @(negedge clk_i);

        for (int pixel_y = 0; pixel_y < ScreenHeight; pixel_y++) begin
            for (int pixel_x = 0; pixel_x < ScreenWidth; pixel_x++) begin
                gif_write_pixel(dinorun_gif, pixel_x, pixel_y, {dinorun.vga_red_o,4'b0}, {dinorun.vga_green_o,4'b0}, {dinorun.vga_blue_o,4'b0});
                @(negedge clk_i);
            end
            repeat(160) @(negedge clk_i);
        end

        if (frame != NUM_FRAMES-1) gif_next_frame(dinorun_gif);
        $display("Frame %0d drawn", frame);
    end

    assert(gif_close(dinorun_gif));

    $display( "End simulation." );
    $finish;
end

endmodule
