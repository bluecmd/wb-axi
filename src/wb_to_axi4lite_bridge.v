module wb_to_axi4lite_bridge #(
  parameter DW = 32,
  parameter AW = 32
)(
  input       wb_clk_i,
  input       wb_rst_i,

  input [AW-1:0]    wb_adr_i,
  input [DW-1:0]    wb_dat_i,
  input [DW/8-1:0]  wb_sel_i,
  input             wb_we_i,
  input             wb_cyc_i,
  input             wb_stb_i,
  input [2:0]       wb_cti_i,
  input [1:0]       wb_bte_i,
  output [DW-1:0]   wb_dat_o,
  output            wb_ack_o,
  output            wb_err_o,
  output            wb_rty_o,

  input             m_axi_arready,
  input             m_axi_awready,
  input             m_axi_bvalid,
  input             m_axi_rvalid,
  input             m_axi_wready,
  input [1:0]       m_axi_bresp,
  input [1:0]       m_axi_rresp,
  input [DW-1:0]    m_axi_rdata,
  output            m_axi_arvalid,
  output            m_axi_awvalid,
  output            m_axi_bready,
  output            m_axi_rready,
  output            m_axi_wvalid,
  output [2:0]      m_axi_arprot,
  output [2:0]      m_axi_awprot,
  output [AW-1:0]   m_axi_araddr,
  output [AW-1:0]   m_axi_awaddr,
  output [DW-1:0]   m_axi_wdata,
  output [3:0]      m_axi_wstrb
);

  assign wb_dat_o = m_axi_rdata;
  assign wb_ack_o = m_axi_rvalid;
  assign wb_err_o = 0;
  assign wb_rty_o = 0;

  assign m_axi_arvalid = wb_stb_i;
  assign m_axi_awvalid = wb_stb_i;
  assign m_axi_bready = 0;
  assign m_axi_rready = ~wb_we_i & wb_stb_i;
  assign m_axi_wvalid = wb_we_i & wb_stb_i;
  assign m_axi_arprot = 0;
  assign m_axi_awprot = 0;
  assign m_axi_araddr = wb_adr_i;
  assign m_axi_awaddr = wb_adr_i;
  assign m_axi_wdata = wb_dat_i;
  assign m_axi_wstrb = wb_stb_i & wb_we_i;

endmodule
