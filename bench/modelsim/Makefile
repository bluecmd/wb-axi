
.PHONY: work sim

work:
	vlog \
		-timescale "1 ns / 1 ps" +acc\
		+incdir+../../orpsoc-cores/cores/wb_common/ \
		+incdir+../../orpsoc-cores/cores/wb_bfm/wb_bfm-0/ \
		../../orpsoc-cores/cores/wb_bfm/wb_bfm-0/wb_bfm_master.v \
		../../orpsoc-cores/cores/wb_bfm/wb_bfm-0/wb_bfm_transactor.v \
		testbench.v xilinx/*.v ../../src/*.v


sim:
	vsim -i -t ps -L compile_simlib/unisims_ver work.testbench work.glbl \
		-do sim.do
