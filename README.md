wb-axi
======

Wishbone &lt;-> AXI interfaces and modules

### Status

Currently only conversions from Wishbone to AXI4 and AXI4-Lite are supported.
Bursts are not implemented and will fall back to single read/writes.

All extra features that AXI allows (permissions, locking, caching, etc.) is not currently supported.

### Example
  
     wb_to_axi4_bridge #(
       .DW(32), .AW(32), .IDW(4)
     ) wb_to_axi4_bridge_i (
       .wb_clk_i(sys_clk_i),
       .wb_rst_i(sys_rst_i),
       .wb_adr_i(wb_adr),
       .wb_dat_i(wb_dat),
       .wb_sel_i(wb_sel),
       .wb_we_i (wb_we),
       .wb_cyc_i(wb_cyc),
       .wb_stb_i(wb_stb),
       .wb_cti_i(wb_cti),
       .wb_bte_i(wb_bte),
       .wb_dat_o(wb_rdt),
       .wb_ack_o(wb_ack),
       .wb_err_o(wb_err),
       .wb_rty_o(wb_rty),
       .m_axi_awaddr  (axi_awaddr),
       .m_axi_awlen   (axi_awlen),
       .m_axi_awsize  (axi_awsize),
       .m_axi_awburst (axi_awburst),
       .m_axi_awlock  (axi_awlock),
       .m_axi_awcache (axi_awcache),
       .m_axi_awprot  (axi_awprot),
       .m_axi_awregion(axi_awregion),
       .m_axi_awqos   (axi_awqos),
       .m_axi_awvalid (axi_awvalid),
       .m_axi_awready (axi_awready),
       .m_axi_wdata   (axi_wdata),
       .m_axi_wstrb   (axi_wstrb),
       .m_axi_wlast   (axi_wlast),
       .m_axi_wvalid  (axi_wvalid),
       .m_axi_wready  (axi_wready),
       .m_axi_bresp   (axi_bresp),
       .m_axi_bvalid  (axi_bvalid),
       .m_axi_bready  (axi_bready),
       .m_axi_araddr  (axi_araddr),
       .m_axi_arlen   (axi_arlen),
       .m_axi_arsize  (axi_arsize),
       .m_axi_arburst (axi_arburst),
       .m_axi_arlock  (axi_arlock),
       .m_axi_arcache (axi_arcache),
       .m_axi_arprot  (axi_arprot),
       .m_axi_arregion(axi_arregion),
       .m_axi_arqos   (axi_arqos),
       .m_axi_arvalid (axi_arvalid),
       .m_axi_arready (axi_arready),
       .m_axi_rdata   (axi_rdata),
       .m_axi_rresp   (axi_rresp),
       .m_axi_rlast   (axi_rlast),
       .m_axi_rvalid  (axi_rvalid),
       .m_axi_rready  (axi_rready),
       .m_axi_awid    (axi_awid),
       .m_axi_arid    (axi_arid),
       .m_axi_rid     (axi_rid),
       .m_axi_bid     (axi_bid)
     );
