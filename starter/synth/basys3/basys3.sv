// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module basys3 (
    input  logic       clk_100,

    input  logic       btnC,
    input  logic       btnU,
    input  logic       btnR,
    input  logic       btnD,

    output logic [6:0] seg,
    output logic [3:0] an,

    output logic [3:0] vgaRed,
    output logic [3:0] vgaGreen,
    output logic [3:0] vgaBlue,
    output logic       Hsync,
    output logic       Vsync
);

logic clk_1k;
clk_100M_to_clk_1k clk_100M_to_clk_1k (
    .clk_100M_i(clk_100),
    .clk_1k_o(clk_1k)
);

logic clk_25_175;
mmcm_100_to_25_175 mmcm_100_to_25_175 (
    .clk_100,
    .clk_25_175
);

logic btnC_sync, btnU_sync, btnD_sync;
logic [2:0] game_synchronizer_in, game_synchronizer_out;

assign game_synchronizer_in = {btnC, btnU, btnD};
assign {btnC_sync, btnU_sync, btnD_sync} = game_synchronizer_out;

synchronizer #(
    .WIDTH($bits(game_synchronizer_in))
) game_synchronizer (
    .clk_sample_i(clk_100),
    .clk_target_i(Vsync),
    .async_data_i(game_synchronizer_in),
    .sync_data_o(game_synchronizer_out)
);

logic btnR_sync_25_175;
wire rst_ni = !btnR_sync_25_175;

synchronizer #(
    .WIDTH(1)
) synchronizer_25_175 (
    .clk_sample_i(clk_100),
    .clk_target_i(clk_25_175),
    .async_data_i(btnR),
    .sync_data_o(btnR_sync_25_175)
);

logic btnR_sync_7seg;
wire rst_7seg_n = !btnR_sync_7seg;

synchronizer #(
    .WIDTH(1)
) synchronizer_7seg (
    .clk_sample_i(clk_100),
    .clk_target_i(clk_1k),
    .async_data_i(btnR),
    .sync_data_o(btnR_sync_7seg)
);

logic       digit0_en;
logic [3:0] digit0;
logic       digit1_en;
logic [3:0] digit1;
logic       digit2_en;
logic [3:0] digit2;
logic       digit3_en;
logic [3:0] digit3;

dinorun dinorun (
    .clk_25_175_i(clk_25_175),
    .rst_ni,

    .start_i(btnC_sync),
    .up_i(btnU_sync),
    .down_i(btnD_sync),

    .digit0_en_o(digit0_en),
    .digit0_o(digit0),
    .digit1_en_o(digit1_en),
    .digit1_o(digit1),
    .digit2_en_o(digit2_en),
    .digit2_o(digit2),
    .digit3_en_o(digit3_en),
    .digit3_o(digit3),

    .vga_red_o(vgaRed),
    .vga_green_o(vgaGreen),
    .vga_blue_o(vgaBlue),
    .vga_hsync_o(Hsync),
    .vga_vsync_o(Vsync)
);

basys3_7seg_driver basys3_7seg_driver (
    .clk_1k_i(clk_1k),
    .rst_ni(rst_7seg_n),

    .digit0_en_i(digit0_en),
    .digit0_i(digit0),
    .digit1_en_i(digit1_en),
    .digit1_i(digit1),
    .digit2_en_i(digit2_en),
    .digit2_i(digit2),
    .digit3_en_i(digit3_en),
    .digit3_i(digit3),

    .anode_o(an),
    .segments_o(seg)
);

endmodule
