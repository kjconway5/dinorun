# Copyright (c) 2024 Ethan Sifferman.
# All rights reserved. Distribution Prohibited.

export YOSYS_DATDIR := $(shell yosys-config --datdir)
RTL := $(shell \
 YOSYS_DATDIR=$(YOSYS_DATDIR) \
 python3 scripts/convert_filelist.py rtl/rtl.f \
)

TOP := obstacle_tb
PART := xc7a35tcpg236-1

MEMS := bird_down.memb \
        bird_up.memb \
        cactus_0.memb \
        cactus_1.memb \
        cactus_2.memb \
        cactus_3.memb \
        dino_downleft.memb \
        dino_downright.memb \
        dino_hit.memb \
        dino_left.memb \
        dino_right.memb \
        dino_standing.memb \
        title.memb

%.memb: scripts/generate_image_rom.py images/%.png
	python3 scripts/generate_image_rom.py images/$*.png $@

sim: ${MEMS}
	verilator dv/lint/verilator.lint --Mdir ${TOP}_$@_dir -f rtl/rtl.f -f dv/dv.f --binary --top ${TOP}
#	./${TOP}_$@_dir/V${TOP} +verilator+rand+reset+0
#	./${TOP}_$@_dir/V${TOP} +verilator+rand+reset+1
	./${TOP}_$@_dir/V${TOP} +verilator+rand+reset+2

lint:
	verilator dv/lint/verilator.lint --lint-only -f rtl/rtl.f -f dv/dv.f synth/basys3/basys3.sv --top basys3
	verilator dv/lint/verilator.lint --lint-only -f rtl/rtl.f -f dv/dv.f --top dinorun
	verible-verilog-lint \
	 --waiver_files dv/lint/verible.waiver \
	 --rules_config dv/lint/verible.lint \
	 --autofix=inplace-interactive \
	 ${RTL} synth/basys3/basys3.sv

synth/yosys_common/build/rtl.sv2v.v: ${RTL} scripts/convert_filelist.py rtl/rtl.f
	mkdir -p $(dir $@)
	sv2v ${RTL} -w $@ -DSYNTHESIS

synth/yosys_common/build/synth.v: synth/yosys_common/build/rtl.sv2v.v synth/yosys_common/yosys.tcl ${MEMS}
	rm -rf slpp_all
	yosys -p 'tcl synth/yosys_common/yosys.tcl' -l synth/yosys_common/build/yosys.log

gls: synth/yosys_common/build/synth.v
	verilator dv/lint/verilator.lint --Mdir ${TOP}_$@_dir -f synth/yosys_common/gls.f -f dv/dv.f --binary --top ${TOP}
#	./${TOP}_$@_dir/V${TOP} +verilator+rand+reset+0
#	./${TOP}_$@_dir/V${TOP} +verilator+rand+reset+1
	./${TOP}_$@_dir/V${TOP} +verilator+rand+reset+2

synth/basys3/build/basys3/basys3.runs/impl_1/basys3.bit: ${RTL} synth/basys3/basys3.sv synth/basys3/Basys3_Master.xdc synth/basys3/constraints.xdc synth/basys3/vivado.tcl ${MEMS}
	rm -rf synth/basys3/build/basys3
	mkdir -p synth/basys3/build
	cd synth/basys3/build && \
	 YOSYS_DATDIR=${YOSYS_DATDIR} \
	 vivado -quiet -nolog -nojournal -notrace -mode tcl \
	  -source ../vivado.tcl

vivado-program: synth/basys3/build/basys3/basys3.runs/impl_1/basys3.bit
	cd synth/basys3/build && \
	 vivado -quiet -nolog -nojournal -notrace -mode tcl \
	  -source ../vivado-program.tcl -tclargs ${PART} ../../../$<

clean:
	rm -rf \
	 *.memb \
	 dump.fst \
	 *.gif \
	 *sim_dir *gls_dir \
	 synth/basys3/build \
	 synth/yosys_common/build
