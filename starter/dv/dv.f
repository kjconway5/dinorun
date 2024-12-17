// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

rtl/dinorun_pkg.sv
${YOSYS_DATDIR}/simlib.v

-LDFLAGS "-lgif"
dv/gif_writer.cpp

dv/basys3_7seg_driver_tb.sv
dv/dino_tb.sv
dv/lfsr16_tb.sv
dv/obstacle_tb.sv
dv/title_tb.sv
dv/dinorun_tb.sv

dv/mmcm_100_to_25_175.sv

--timing
-j 0
-Wall
--assert
--trace-fst
--trace-structs
--main-top-name "-"

// Run with +verilator+rand+reset+2
--x-assign unique
--x-initial unique
