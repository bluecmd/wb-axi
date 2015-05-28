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
  output [DW/8-1:0] m_axi_wstrb
);
  wire active;
  wire complete;
  reg complete_r;
  reg asserted_addr_r = 0;
  reg asserted_write_r = 0;

  assign active = wb_stb_i & wb_cyc_i;

  assign complete = active & (wb_we_i ? m_axi_bvalid : m_axi_rvalid);

  // TODO(bluecmd): Byte mask?
  assign wb_dat_o = m_axi_rdata;
  assign m_axi_wdata = wb_dat_i;

  assign wb_err_o = complete & (~wb_we_i ? m_axi_rresp[1] : m_axi_bresp[1]);
  // TEST
  reg wb_ack_r;
  always @(posedge wb_clk_i)
    wb_ack_r <= complete & (~complete_r);
  assign wb_ack_o = wb_ack_r;

  assign wb_rty_o = complete & wb_err_o &
    (~wb_we_i ? ~m_axi_rresp[0] : ~m_axi_bresp[0]);

  assign m_axi_arvalid = active & ~wb_we_i & ~asserted_addr_r;
  assign m_axi_awvalid = active & wb_we_i & ~asserted_addr_r;
  assign m_axi_rready = active & ~wb_we_i;
  assign m_axi_wvalid = active & wb_we_i & ~asserted_write_r;
  assign m_axi_arprot = 0;
  assign m_axi_awprot = 0;
  assign m_axi_araddr = wb_adr_i;
  assign m_axi_awaddr = wb_adr_i;
  assign m_axi_wstrb = wb_we_i ? wb_sel_i : 0;

  assign m_axi_bready = 1'b1;

  always @(posedge wb_clk_i)
  begin
    complete_r <= complete;

    asserted_addr_r <= asserted_addr_r;
    asserted_write_r <= asserted_write_r;

    if ((wb_we_i & m_axi_awvalid & m_axi_awready) |
       (~wb_we_i & m_axi_arvalid & m_axi_arready))
      asserted_addr_r <= 1'b1;
    if (wb_we_i & m_axi_wvalid & m_axi_wready)
      asserted_write_r <= 1'b1;
    if (wb_ack_o)
    begin
      asserted_addr_r <= 0;
      asserted_write_r <= 0;
    end
  end

endmodule
