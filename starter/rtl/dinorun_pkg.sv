// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

package dinorun_pkg;

localparam int ScreenWidth = 640;
localparam int ScreenHeight = 480;

localparam int Ground = 400;
localparam int ObstacleInitialX = 640;

typedef enum logic [1:0] {
    // TODO
    TITLE,
    PLAYING,
    HIT,
    GAMEOVER
} state_t;

endpackage
