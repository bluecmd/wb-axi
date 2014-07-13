
WB_INTERCON=orpsoc-cores/cores/wb_intercon/sw
VERILATOR_FLAGS = -Wno-fatal -Wall
VERILATOR_INCLUDE = \
	-I${CURDIR}/cores/axi_ram \
	-I${CURDIR}/orpsoc-cores/cores/wb_intercon \
	-I${CURDIR}/orpsoc-cores/cores/ram_wb \
	-I${CURDIR}/orpsoc-cores/cores/ram_wb \
	-I${CURDIR}/orpsoc-cores/cores/verilog_utils \
	-I${CURDIR}/verilog-arbiter/src \
	-I${CURDIR}/include

DEPS = bench/testbench.sv bench/testbench.cpp include/wb_intercon.v

.PHONY: obj_dir/Vtestbench

all: obj_dir/Vtestbench

include/wb_intercon.v: include/wb_intercon.conf
	$(WB_INTERCON)/wb_intercon_gen $< $@

obj_dir/Vtestbench: $(DEPS)
	 verilator $(VERILATOR_FLAGS) -cc bench/testbench.sv --top-module testbench \
		 --exe bench/testbench.cpp $(VERILATOR_INCLUDE)
	 make -C obj_dir -f Vtestbench.mk Vtestbench CXXFLAGS=$(CXXFLAGS)

sim: obj_dir/Vtestbench
	obj_dir/Vtestbench

clean:
	rm -rf obj_dir/
	rm -f include/wb_intercon.v
	rm -f include/wb_intercon.vh


