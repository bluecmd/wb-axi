add wave -noupdate /testbench/done_o
add wave -noupdate /testbench/err_o
add wave -noupdate -group System /testbench/sys_clk_i
add wave -noupdate -group System /testbench/sys_rst_i
add wave -noupdate -group System /testbench/sys_rst_n
add wave -noupdate -group Debug /testbench/wb_to_axi4lite_bridge_i/active
add wave -noupdate -group Debug /testbench/wb_to_axi4lite_bridge_i/complete
add wave -noupdate -group Debug /testbench/wb_to_axi4lite_bridge_i/complete_r
add wave -noupdate -group Debug /testbench/wb_to_axi4lite_bridge_i/asserted*
add wave -noupdate -group Debug /testbench/checker_i/pc_status
add wave -noupdate -group Wishbone /testbench/wb_adr
add wave -noupdate -group Wishbone /testbench/wb_dat
add wave -noupdate -group Wishbone /testbench/wb_sel
add wave -noupdate -group Wishbone /testbench/wb_we
add wave -noupdate -group Wishbone /testbench/wb_cyc
add wave -noupdate -group Wishbone /testbench/wb_stb
add wave -noupdate -group Wishbone /testbench/wb_cti
add wave -noupdate -group Wishbone /testbench/wb_bte
add wave -noupdate -group Wishbone /testbench/wb_rdt
add wave -noupdate -group Wishbone /testbench/wb_ack
add wave -noupdate -group Wishbone /testbench/wb_err
add wave -noupdate -group Wishbone /testbench/wb_rty
add wave -noupdate -group AXI4-Lite /testbench/lite_arready
add wave -noupdate -group AXI4-Lite /testbench/lite_arvalid
add wave -noupdate -group AXI4-Lite /testbench/lite_awready
add wave -noupdate -group AXI4-Lite /testbench/lite_awvalid
add wave -noupdate -group AXI4-Lite /testbench/lite_bready
add wave -noupdate -group AXI4-Lite /testbench/lite_bvalid
add wave -noupdate -group AXI4-Lite /testbench/lite_rready
add wave -noupdate -group AXI4-Lite /testbench/lite_rvalid
add wave -noupdate -group AXI4-Lite /testbench/lite_wready
add wave -noupdate -group AXI4-Lite /testbench/lite_wvalid
add wave -noupdate -group AXI4-Lite /testbench/lite_bresp
add wave -noupdate -group AXI4-Lite /testbench/lite_rresp
add wave -noupdate -group AXI4-Lite /testbench/lite_arprot
add wave -noupdate -group AXI4-Lite /testbench/lite_awprot
add wave -noupdate -group AXI4-Lite /testbench/lite_araddr
add wave -noupdate -group AXI4-Lite /testbench/lite_awaddr
add wave -noupdate -group AXI4-Lite /testbench/lite_rdata
add wave -noupdate -group AXI4-Lite /testbench/lite_wdata
add wave -noupdate -group AXI4-Lite /testbench/lite_wstrb
add wave -noupdate -group AXI4 /testbench/axi_awid
add wave -noupdate -group AXI4 /testbench/axi_awaddr
add wave -noupdate -group AXI4 /testbench/axi_awlen
add wave -noupdate -group AXI4 /testbench/axi_awsize
add wave -noupdate -group AXI4 /testbench/axi_awburst
add wave -noupdate -group AXI4 /testbench/axi_awlock
add wave -noupdate -group AXI4 /testbench/axi_awcache
add wave -noupdate -group AXI4 /testbench/axi_awprot
add wave -noupdate -group AXI4 /testbench/axi_awregion
add wave -noupdate -group AXI4 /testbench/axi_awqos
add wave -noupdate -group AXI4 /testbench/axi_awuser
add wave -noupdate -group AXI4 /testbench/axi_awvalid
add wave -noupdate -group AXI4 /testbench/axi_awready
add wave -noupdate -group AXI4 /testbench/axi_wid
add wave -noupdate -group AXI4 /testbench/axi_wdata
add wave -noupdate -group AXI4 /testbench/axi_wstrb
add wave -noupdate -group AXI4 /testbench/axi_wlast
add wave -noupdate -group AXI4 /testbench/axi_wuser
add wave -noupdate -group AXI4 /testbench/axi_wvalid
add wave -noupdate -group AXI4 /testbench/axi_wready
add wave -noupdate -group AXI4 /testbench/axi_bid
add wave -noupdate -group AXI4 /testbench/axi_bresp
add wave -noupdate -group AXI4 /testbench/axi_buser
add wave -noupdate -group AXI4 /testbench/axi_bvalid
add wave -noupdate -group AXI4 /testbench/axi_bready
add wave -noupdate -group AXI4 /testbench/axi_arid
add wave -noupdate -group AXI4 /testbench/axi_araddr
add wave -noupdate -group AXI4 /testbench/axi_arlen
add wave -noupdate -group AXI4 /testbench/axi_arsize
add wave -noupdate -group AXI4 /testbench/axi_arburst
add wave -noupdate -group AXI4 /testbench/axi_arlock
add wave -noupdate -group AXI4 /testbench/axi_arcache
add wave -noupdate -group AXI4 /testbench/axi_arprot
add wave -noupdate -group AXI4 /testbench/axi_arregion
add wave -noupdate -group AXI4 /testbench/axi_arqos
add wave -noupdate -group AXI4 /testbench/axi_aruser
add wave -noupdate -group AXI4 /testbench/axi_arvalid
add wave -noupdate -group AXI4 /testbench/axi_arready
add wave -noupdate -group AXI4 /testbench/axi_rid
add wave -noupdate -group AXI4 /testbench/axi_rdata
add wave -noupdate -group AXI4 /testbench/axi_rresp
add wave -noupdate -group AXI4 /testbench/axi_ruser
add wave -noupdate -group AXI4 /testbench/axi_rlast
add wave -noupdate -group AXI4 /testbench/axi_rvalid
add wave -noupdate -group AXI4 /testbench/axi_rready

force -drive sim:/testbench/sys_clk_i 1 0, 0 {500 ns} -r 1000 ns
force -drive sim:/testbench/sys_rst_i 1 0
run 1us
force -drive sim:/testbench/sys_rst_i 0 0
run 30ms

wave zoom full
