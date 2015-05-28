
.PHONY: work sim

work:
	vlog \
		-timescale "1 us / 1 ps" +acc -pedanticerrors -lint \
		+incdir+../../cores/orpsoc-cores/cores/wb_common/ \
		+incdir+../../cores/wb_bfm/ \
		../../cores/wb_bfm/wb_bfm_master.v \
		../../cores/wb_bfm/wb_bfm_transactor.v \
		testbench.v xilinx/*.v ../../src/*.v


sim: work
	vsim -i -t ps -L compile_simlib/unisims_ver work.testbench work.glbl \
		-do sim.do
