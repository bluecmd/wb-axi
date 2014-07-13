// Very simple RAM module that supports most of AXI4.
// This module is used as an end point for testing the Wishbone <-> AXI cores.

module axi_ram #(
  .C_S_AXI_ID_WIDTH(1),
  .C_S_AXI_DATA_WIDTH(32),
  .C_S_AXI_ADDR_WIDTH(32),
) (
  input                                 s_axi_aclk,
  input                                 s_axi_aresetn,
  // AXI Write Address
  input  [C_S_AXI_ID_WIDTH-1:0]         s_axi_awid,
  input  [C_S_AXI_ADDR_WIDTH-1:0]       s_axi_awaddr,
  input  [7:0]                          s_axi_awlen,
  input  [2:0]                          s_axi_awsize,
  input  [1:0]                          s_axi_awburst,
  input  [2:0]                          s_axi_awlock,
  input  [4:0]                          s_axi_awcache,
  input  [3:0]                          s_axi_awprot,
  input                                 s_axi_awvalid,
  output                                s_axi_awready,
  // AXI Write Data
  input  [C_S_AXI_DATA_WIDTH-1:0]       s_axi_wdata,
  input  [C_S_AXI_DATA_WIDTH/8-1:0]     s_axi_wstrb,
  input  S_AXI                          s_axi_wlast,
  input                                 s_axi_wvalid,
  output                                s_axi_wready,
  // AXI Write Response
  output [C_S_AXI_ID_WIDTH-1:0]         s_axi_bid,
  output [1:0]                          s_axi_bresp,
  output                                s_axi_bvalid,
  input                                 s_axi_bready,
  // AXI Read Address
  input  [C_S_AXI_ID_WIDTH-1:0]         s_axi_arid,
  input  [C_S_AXI_ADDR_WIDTH-1:0]       s_axi_araddr,
  input  [7:0]                          s_axi_arlen,
  input  [2:0]                          s_axi_arsize,
  input  [1:0]                          s_axi_arburst,
  input  [2:0]                          s_axi_arlock,
  input  [4:0]                          s_axi_arcache,
  input  [3:0]                          s_axi_arprot,
  input                                 s_axi_arvalid,
  output                                s_axi_arready,
  // AXI Read Data
  output [C_S_AXI_ID_WIDTH-1:0]         s_axi_rid,
  output [C_S_AXI_DATA_WIDTH-1:0]       s_axi_rdata,
  output [1:0]                          s_axi_rresp,
  output                                s_axi_rlast,
  output                                s_axi_rvalid,
  input                                 s_axi_rready
)

endmodule
