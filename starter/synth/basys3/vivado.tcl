# Copyright (c) 2024 Ethan Sifferman.
# All rights reserved. Distribution Prohibited.

# start_gui

create_project basys3 basys3 -part xc7a35tcpg236-1

add_files -norecurse {
 ../../../bird_down.memb
 ../../../bird_up.memb
 ../../../cactus_0.memb
 ../../../cactus_1.memb
 ../../../cactus_2.memb
 ../../../cactus_3.memb
 ../../../dino_downleft.memb
 ../../../dino_downright.memb
 ../../../dino_hit.memb
 ../../../dino_left.memb
 ../../../dino_right.memb
 ../../../dino_standing.memb
 ../../../title.memb
}
set_property file_type {Memory File} [get_files -all]

add_files -norecurse $::env(YOSYS_DATDIR)/simlib.v
add_files -norecurse {
 ../../../rtl/dinorun_pkg.sv
 ../../../rtl/objects/bird.sv
 ../../../rtl/objects/cactus.sv
 ../../../rtl/objects/dino.sv
 ../../../rtl/objects/title.sv
 ../../../rtl/edge_detector.sv
 ../../../rtl/vga_timer.sv
 ../../../rtl/score_counter.sv
 ../../../rtl/lfsr16.sv
 ../../../rtl/basys3/synchronizer.sv
 ../../../rtl/basys3/basys3_7seg_driver.sv
 ../../../rtl/basys3/hex7seg.sv
 ../../../rtl/basys3/clk_100M_to_clk_1k.sv
 ../../../rtl/dinorun.sv
 ../basys3.sv
}
add_files -fileset constrs_1 -norecurse {
 ../Basys3_Master.xdc
 ../constraints.xdc
}

set_property top basys3 [current_fileset]

# Generate Clock
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name mmcm_100_to_25_175
set_property -dict [list \
  CONFIG.CLK_OUT1_PORT {clk_25_175} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25.175} \
  CONFIG.PRIMARY_PORT {clk_100} \
  CONFIG.USE_LOCKED {false} \
  CONFIG.USE_RESET {false} \
] [get_ips mmcm_100_to_25_175]

# Run Synthesis
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
launch_runs synth_1 -jobs [exec nproc]
wait_on_run synth_1

# Run PNR
launch_runs impl_1
wait_on_run impl_1

# Create Bitstream
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

exit
