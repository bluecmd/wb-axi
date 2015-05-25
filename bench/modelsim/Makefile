
.PHONY: work sim

work:
	vlog +incdir+../../orpsoc-cores/cores/wb_common/ \
		+incdir+../../orpsoc-cores/cores/wb_bfm/wb_bfm-0/ \
		../../orpsoc-cores/cores/wb_bfm/wb_bfm-0/wb_bfm_master.v \
		../../orpsoc-cores/cores/wb_bfm/wb_bfm-0/wb_bfm_transactor.v \
		testbench.v xilinx/*.v


sim:
	vsim -L compile_simlib/unisims_ver work.testbench
