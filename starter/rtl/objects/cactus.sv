// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module cactus import dinorun_pkg::*; (
    input  logic       clk_i,
    input  logic       rst_ni,
    input  logic       next_frame_i,

    input  logic       spawn_i,
    input  logic [1:0] rand_i,

    input  logic [9:0] pixel_x_i,
    input  logic [9:0] pixel_y_i,
    output logic       pixel_o
);

// TODO

// placeholder ints
localparam int CACTUS_WIDTH = 15;
localparam int CACTUS_HEIGHT = 33;
localparam int SCALAR = 3;
localparam int SCREEN_X = 640;
localparam int SCREEN_Y = 480;
localparam int GROUND_LEVEL = Ground - (CACTUS_HEIGHT * SCALAR);

// variables to hold roms
logic [CACTUS_WIDTH*SCALAR:0] cactus_rom_0[CACTUS_HEIGHT*SCALAR:0];
logic [CACTUS_WIDTH*SCALAR:0] cactus_rom_1[CACTUS_HEIGHT*SCALAR:0];
logic [CACTUS_WIDTH*SCALAR:0] cactus_rom_2[CACTUS_HEIGHT*SCALAR:0];
logic [CACTUS_WIDTH*SCALAR:0] cactus_rom_3[CACTUS_HEIGHT*SCALAR:0];

initial $readmemb("cactus_0.memb", cactus_rom_0);
initial $readmemb("cactus_1.memb", cactus_rom_1);
initial $readmemb("cactus_2.memb", cactus_rom_2);
initial $readmemb("cactus_3.memb", cactus_rom_3);

logic x_valid, y_valid;
logic [CACTUS_WIDTH:0] selected_row;

always_comb begin
    x_valid = (pixel_x_i >= pos_q) && (pixel_x_i < pos_q + (CACTUS_WIDTH * SCALAR));
    y_valid = (pixel_y_i >= GROUND_LEVEL) && (pixel_y_i < GROUND_LEVEL + (CACTUS_HEIGHT * SCALAR));

    case(rand_type)
        2'b00: selected_row = cactus_rom_0[(pixel_y_i - GROUND_LEVEL)/SCALAR];
        2'b01: selected_row = cactus_rom_1[(pixel_y_i - GROUND_LEVEL)/SCALAR];
        2'b10: selected_row = cactus_rom_2[(pixel_y_i - GROUND_LEVEL)/SCALAR];
        2'b11: selected_row = cactus_rom_3[(pixel_y_i - GROUND_LEVEL)/SCALAR];
        default: selected_row = '0;
    endcase

    if (x_valid && y_valid) begin
        pixel_o = selected_row[(pixel_x_i - pos_q)/SCALAR];
    end else begin
        pixel_o = 1'b0;
    end
end

//logic [1:0] type_d, type_q;
logic [1:0] rand_type;

always_comb begin
    active_d = active_q;
    pos_d = pos_q;
    //type_d = type_q;

    if(!active_q && spawn_i) begin
        rand_type = rand_i[1:0];
        active_d = 1'b1;
        pos_d = SCREEN_X - 1;
        //type_d = rand_i[12:8];
        rand_type = rand_i[1:0];
    end else if (active_q && next_frame_i) begin
        pos_d = pos_q - 10;
        if(pos_d < 0) begin
            active_d = 1'b0;
        end
    end
end

// flip flop
logic [9:0] pos_d, pos_q;
logic active_d, active_q;

always_ff @(posedge clk_i) begin
    if(!rst_ni) begin
        pos_q <= 10'b1010000001;
        active_q <= 1'b0;
        //type_q <= 5'b0;
    end else begin
        pos_q <= pos_d;
        active_q <= active_d;
        //type_q <= type_d;
    end
end

endmodule
