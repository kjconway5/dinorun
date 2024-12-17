
# Dino Run

```bash
# install libgif
sudo apt install giflib-tools libgif-dev

# open in VS Code
code .

# lint with Verilator and Verible
make lint

# simulate with Verilator
make sim TOP=basys3_7seg_driver_tb
make sim TOP=dino_tb
make sim TOP=lfsr16_tb
make sim TOP=obstacle_tb
make sim TOP=title_tb
make sim TOP=dinorun_tb

# synthesize with Yosys, then simulate with Verilator
make gls TOP=basys3_7seg_driver_tb
make gls TOP=dino_tb
make gls TOP=lfsr16_tb
make gls TOP=obstacle_tb
make gls TOP=title_tb
make gls TOP=dinorun_tb

# view waveforms
gtkwave dump.fst

# synthesize, place-and-route, and program with Vivado
make vivado-program
```
