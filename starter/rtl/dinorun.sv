// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module dinorun import dinorun_pkg::*; (
    input  logic       clk_25_175_i,
    input  logic       rst_ni,

    input  logic       start_i,
    input  logic       up_i,
    input  logic       down_i,

    output logic       digit0_en_o,
    output logic [3:0] digit0_o,
    output logic       digit1_en_o,
    output logic [3:0] digit1_o,
    output logic       digit2_en_o,
    output logic [3:0] digit2_o,
    output logic       digit3_en_o,
    output logic [3:0] digit3_o,

    output logic [3:0] vga_red_o,
    output logic [3:0] vga_green_o,
    output logic [3:0] vga_blue_o,
    output logic       vga_hsync_o,
    output logic       vga_vsync_o
);

// TODO

// Fix/finish flash

/*---------------------------------------------------*/
// holder variables
state_t state_d, state_q;
logic edge_det;
logic [15:0] lfsr_rand;
logic visible;
logic score_en, score_rst_ni;
logic [9:0] vga_x, vga_y;
logic [3:0] vga_r_d, vga_r_q;
logic [3:0] vga_b_d, vga_b_q;
logic [3:0] vga_g_d, vga_g_q;
logic dino_pixel;
logic cactus_pixel, cactus_pixel2;
logic bird_pixel;
logic title_pixel;
logic dino_hit;
logic obs_rst_ni;
logic next_frame;

assign next_frame = edge_det && !(state_q == HIT || state_q == GAMEOVER);

lfsr16 lfsr_init(
    .clk_i(clk_25_175_i),
    .rst_ni(rst_ni),
    .next_i(next_frame),
    .rand_o(lfsr_rand)
);
score_counter score_init(
    .clk_i(clk_25_175_i),
    .rst_ni(rst_ni && score_rst_ni),
    .en_i((state_q == PLAYING) && next_frame),
    .digit0_o(digit0_o),
    .digit1_o(digit1_o),
    .digit2_o(digit2_o),
    .digit3_o(digit3_o)
);
vga_timer vga_init(
    .clk_i(clk_25_175_i),
    .rst_ni(rst_ni),
    .hsync_o(vga_hsync_o),
    .vsync_o(vga_vsync_o),
    .visible_o(visible),
    .position_x_o(vga_x),
    .position_y_o(vga_y)
);
edge_detector edge_init(
    .clk_i(clk_25_175_i),
    .data_i(vga_vsync_o),
    .edge_o(edge_det)
);
/*---------------------------------------------------*/
dino dino_init(
    .clk_i(clk_25_175_i),
    .rst_ni(rst_ni),
    .next_frame_i(next_frame),
    .up_i(up_i),
    .down_i(down_i),
    .hit_i(state_q == HIT),
    .pixel_x_i(vga_x),
    .pixel_y_i(vga_y),
    .pixel_o(dino_pixel)
);
bird bird_init(
    .clk_i(clk_25_175_i),
    .rst_ni(rst_ni && obs_rst_ni),
    .next_frame_i(next_frame),
    .spawn_i((state_q == PLAYING) && (lfsr_rand[11:7] == 5'b11100 || lfsr_rand[11:7] == 5'b10101)),
    .rand_i(lfsr_rand),
    .pixel_x_i(vga_x),
    .pixel_y_i(vga_y),
    .pixel_o(bird_pixel)
);
cactus cactus_init (
    .clk_i(clk_25_175_i),
    .rst_ni(rst_ni && obs_rst_ni),
    .next_frame_i(next_frame),
    .spawn_i((state_q == PLAYING) && (lfsr_rand[12:8] == 5'b00100 || lfsr_rand[11:7] == 5'b01010)),
    .rand_i(lfsr_rand),
    .pixel_x_i(vga_x),
    .pixel_y_i(vga_y),
    .pixel_o(cactus_pixel)
);
cactus cactus_init2 (
    .clk_i(clk_25_175_i),
    .rst_ni(rst_ni && obs_rst_ni),
    .next_frame_i(next_frame),
    .spawn_i((state_q == PLAYING) && (lfsr_rand[12:8] == 5'b01111 || lfsr_rand[12:8] == 5'b11011)),
    .rand_i(lfsr_rand),
    .pixel_x_i(vga_x),
    .pixel_y_i(vga_y),
    .pixel_o(cactus_pixel2)
);
title title_init (
    .pixel_x_i(vga_x),
    .pixel_y_i(vga_y),
    .pixel_o(title_pixel)
);
/*---------------------------------------------------*/

// anodes always on
assign digit0_en_o = 1'b1;
assign digit1_en_o = 1'b1;
assign digit2_en_o = 1'b1;
assign digit3_en_o = 1'b1;
assign dino_hit = dino_pixel && (cactus_pixel || cactus_pixel2 || bird_pixel);

always_comb begin
    vga_r_d = vga_r_q;
    vga_b_d = vga_b_q;
    vga_g_d = vga_g_q;
    vga_b_d = 4'b0000;
    vga_r_d = 4'b0000;
    vga_g_d = 4'b0000;

    if(vga_y >= Ground) begin
        vga_b_d = 4'b1100;
        vga_r_d = 4'b1100;
        vga_g_d = 4'b1100;
    end

    case(state_q)
        TITLE: begin
            if(title_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(dino_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(bird_pixel) begin
                vga_r_d = 4'b0000;
                vga_b_d = 4'b0000;
                vga_g_d = 4'b0000;
            end
            if(cactus_pixel) begin
                vga_r_d = 4'b0000;
                vga_b_d = 4'b0000;
                vga_g_d = 4'b0000;
            end
            if(cactus_pixel2) begin
                vga_r_d = 4'b0000;
                vga_b_d = 4'b0000;
                vga_g_d = 4'b0000;
            end
        end
        PLAYING: begin
            if(title_pixel) begin
                vga_r_d = 4'b0000;
                vga_b_d = 4'b0000;
                vga_g_d = 4'b0000;
            end
            if(dino_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(bird_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(cactus_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(cactus_pixel2) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
        end
        HIT: begin
            if(title_pixel) begin
                vga_r_d = 4'b0000;
                vga_b_d = 4'b0000;
                vga_g_d = 4'b0000;
            end
            if(dino_pixel) begin
                vga_r_d = (flashing) ? 4'b1111 : 4'b1111;
                vga_b_d = (flashing) ? 4'b0000 : 4'b1111;
                vga_g_d = (flashing) ? 4'b0000 : 4'b1111;
            end
            if(bird_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(cactus_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(cactus_pixel2) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
        end
        GAMEOVER: begin
            if(title_pixel) begin
                vga_r_d = 4'b0000;
                vga_b_d = 4'b0000;
                vga_g_d = 4'b0000;
            end
            if(dino_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(bird_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(cactus_pixel) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
            if(cactus_pixel2) begin
                vga_r_d = 4'b1111;
                vga_b_d = 4'b1111;
                vga_g_d = 4'b1111;
            end
        end
        default: ;
    endcase
end

always_comb begin
    state_d = state_q;
    obs_rst_ni = rst_ni;
    score_rst_ni = rst_ni;
    flash_count_d = flash_count_q;
    flashing = flash_count_q[3];
    case(state_q)
        TITLE: begin
            score_rst_ni = 0;
            // waiting for start_i to move to playing
            if(start_i) begin
                state_d = PLAYING;
            end else begin
                state_d = TITLE;
            end
        end
        PLAYING: begin
            if(dino_hit) begin
                flash_count_d = 60;
                state_d = HIT;
            end
        end
        HIT: begin
            if (edge_det) begin
                flash_count_d = flash_count_q - 1;
                //flashing = flash_count_q[3];
                if (flash_count_q == 5'b0)begin
                    state_d = GAMEOVER;
                end
            end else begin
                state_d = HIT;
            end
        end
        GAMEOVER: begin
            if(start_i) begin
                obs_rst_ni = 0;
                score_rst_ni = 0;
                state_d = PLAYING;
            end
            if(up_i || down_i) begin
                obs_rst_ni = 0;
                state_d = TITLE;
            end
        end
        default: ;
    endcase
end

always_ff @(posedge clk_25_175_i) begin
    if (!rst_ni) begin
        state_q <= TITLE;
        vga_r_q <= 4'b0;
        vga_b_q <= 4'b0;
        vga_g_q <= 4'b0;
    end else begin
        state_q <= state_d;
        vga_r_q <= vga_r_d;
        vga_b_q <= vga_b_d;
        vga_g_q <= vga_g_d;
    end
end



logic [5:0] flash_count_d, flash_count_q;
logic flashing;
always_ff@(posedge clk_25_175_i) begin
    if(!rst_ni) begin
        flash_count_q <= 1'b0;
    end else begin
        flash_count_q <= flash_count_d;
    end
end

/*always_comb begin
    //flashing_d = ~flashing;
    flash_count_d = flash_count_q;
    if(state_q == HIT) begin
        flash_count_d = flash_count_q + 1;
    end
end*/

assign vga_red_o = vga_r_q;
assign vga_blue_o = vga_b_q;
assign vga_green_o = vga_g_q;

endmodule
