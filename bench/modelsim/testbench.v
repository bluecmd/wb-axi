`timescale 1ns / 1ps

/* TODO(bluecmd): Clean this mess up */

module testbench(
  input         sys_clk_i,
  input         sys_rst_i,
  output        done_o,
  output        err_o
);
/* TODO: Replace values with parameters from 
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0534b/CIHEAHHH.html

ATA_WIDTH	Width of the system data buses.	64	64
RID_WIDTH	
Number of read channel ID bits required.
  4	-
  WID_WIDTH	Number of write channel ID bits required.	4	-
  MAXRBURSTS	Size of FIFOs for storing outstanding read bursts. This must be greater than or equal to the maximum number of outstanding read bursts that can be active at the slave interface.	16	16
  MAXWBURSTS	Size of FIFOs for storing outstanding write bursts. This must be greater than or equal to the maximum number of outstanding write bursts that can be active at the slave interface.	16	16
ADDR_WIDTH	Width of the address bus.	32	32
EXMON_WIDTH	Width of the exclusive access monitor required.	4	-
  AWUSER_WIDTH	Width of the user AW sideband field.	32	-
  WUSER_WIDTH	Width of the user W sideband field.	32	-
  BUSER_WIDTH	Width of the user B sideband field.	32	-
  ARUSER_WIDTH	Width of the user AR sideband field.	32	-
  RUSER_WIDTH	Width of the user R sideband field.	32	-

  */
 localparam MEMORY_SIZE = 1024;
 localparam ID_WIDTH = 4;
 localparam USER_WIDTH = 0;

 /* Wishbone signals */
 wire [31:0] wb_adr;
 wire [31:0] wb_dat;
 wire [3:0]  wb_sel;
 wire        wb_we;
 wire        wb_cyc;
 wire        wb_stb;
 wire [2:0]  wb_cti;
 wire [1:0]  wb_bte;
 wire [31:0] wb_rdt;
 wire        wb_ack;
 wire        wb_err;
 wire        wb_rty;

 /* AXI4-Lite signals */
 wire           lite_arready;
 wire           lite_arvalid;
 wire           lite_awready;
 wire           lite_awvalid;
 wire           lite_bready;
 wire           lite_bvalid;
 wire           lite_rready;
 wire           lite_rvalid;
 wire           lite_wready;
 wire           lite_wvalid;
 wire [1:0]     lite_bresp;
 wire [1:0]     lite_rresp;
 wire [2:0]     lite_arprot;
 wire [2:0]     lite_awprot;
 wire [31:0]    lite_araddr;
 wire [31:0]    lite_awaddr;
 wire [31:0]    lite_rdata;
 wire [31:0]    lite_wdata;
 wire [3:0]     lite_wstrb;

 /* AXI4 signals */
 wire  [ID_WIDTH-1:0]     axi_awid     ;
 wire  [31 : 0]  axi_awaddr   ;
 wire  [7 : 0 ]  axi_awlen    ;
 wire  [2 : 0 ]  axi_awsize   ;
 wire  [1 : 0 ]  axi_awburst  ;
 wire  [0 : 0 ]  axi_awlock   ;
 wire  [3 : 0 ]  axi_awcache  ;
 wire  [2 : 0 ]  axi_awprot   ;
 wire  [3 : 0 ]  axi_awregion ;
 wire  [3 : 0 ]  axi_awqos    ;
 wire  [USER_WIDTH-1:0]     axi_awuser   ;
 wire            axi_awvalid  ;
 wire            axi_awready  ;
 wire  [ID_WIDTH-1:0]     axi_wid      ;
 wire  [31 : 0]  axi_wdata    ;
 wire  [3 : 0 ]  axi_wstrb    ;
 wire            axi_wlast    ;
 wire  [USER_WIDTH-1:0]     axi_wuser    ;
 wire            axi_wvalid   ;
 wire            axi_wready   ;
 wire  [ID_WIDTH-1:0]  axi_bid      ;
 wire  [1 : 0 ]  axi_bresp    ;
 wire  [USER_WIDTH-1:0]     axi_buser    ;
 wire            axi_bvalid   ;
 wire            axi_bready   ;
 wire  [ID_WIDTH-1:0]  axi_arid     ;
 wire  [31 : 0]  axi_araddr   ;
 wire  [7 : 0 ]  axi_arlen    ;
 wire  [2 : 0 ]  axi_arsize   ;
 wire  [1 : 0 ]  axi_arburst  ;
 wire  [0 : 0 ]  axi_arlock   ;
 wire  [3 : 0 ]  axi_arcache  ;
 wire  [2 : 0 ]  axi_arprot   ;
 wire  [3 : 0 ]  axi_arregion ;
 wire  [3 : 0 ]  axi_arqos    ;
 wire  [USER_WIDTH-1:0]  axi_aruser   ;
 wire            axi_arvalid  ;
 wire            axi_arready  ;
 wire  [ID_WIDTH-1:0]  axi_rid      ;
 wire  [31 : 0]  axi_rdata    ;
 wire  [1 : 0 ]  axi_rresp    ;
 wire  [USER_WIDTH-1:0]  axi_ruser    ;
 wire            axi_rlast    ;
 wire            axi_rvalid   ;
 wire            axi_rready   ;

 wire            sys_rst_n;
 assign sys_rst_n = ~sys_rst_i;

 wb_bfm_transactor #(
   .MEM_HIGH(MEMORY_SIZE-1), .VERBOSE(1)
 ) wb_bfm_transactor_i (
   .wb_clk_i (sys_clk_i),
   .wb_rst_i (sys_rst_i),
   .wb_adr_o (wb_adr),
   .wb_dat_o (wb_dat),
   .wb_sel_o (wb_sel),
   .wb_we_o  (wb_we), 
   .wb_cyc_o (wb_cyc),
   .wb_stb_o (wb_stb),
   .wb_cti_o (wb_cti),
   .wb_bte_o (wb_bte),
   .wb_dat_i (wb_rdt),
   .wb_ack_i (wb_ack),
   .wb_err_i (wb_err),
   .wb_rty_i (wb_rty),
   .done(done_o));

 wb_to_axi4lite_bridge #(
   .DW(32), .AW(32)
 ) wb_to_axi4lite_bridge_i (
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
   .m_axi_awaddr(lite_awaddr),
   .m_axi_awprot(lite_awprot),
   .m_axi_awvalid(lite_awvalid),
   .m_axi_awready(lite_awready),
   .m_axi_wdata(lite_wdata),
   .m_axi_wstrb(lite_wstrb),
   .m_axi_wvalid(lite_wvalid),
   .m_axi_wready(lite_wready),
   .m_axi_bresp(lite_bresp),
   .m_axi_bvalid(lite_bvalid),
   .m_axi_bready(lite_bready),
   .m_axi_araddr(lite_araddr),
   .m_axi_arprot(lite_arprot),
   .m_axi_arvalid(lite_arvalid),
   .m_axi_arready(lite_arready),
   .m_axi_rdata(lite_rdata),
   .m_axi_rresp(lite_rresp),
   .m_axi_rvalid(lite_rvalid),
   .m_axi_rready(lite_rready)
 );

 // AXI4-Lite -> AXI4
 axi4lite_to_axi4_bridge axi4lite_to_axi4_bridge_i (
   .aclk    (sys_clk_i              ),
   .aresetn (sys_rst_n              ),
   .s_axi_awaddr(lite_awaddr),
   .s_axi_awprot(lite_awprot),
   .s_axi_awvalid(lite_awvalid),
   .s_axi_awready(lite_awready),
   .s_axi_wdata(lite_wdata),
   .s_axi_wstrb(lite_wstrb),
   .s_axi_wvalid(lite_wvalid),
   .s_axi_wready(lite_wready),
   .s_axi_bresp(lite_bresp),
   .s_axi_bvalid(lite_bvalid),
   .s_axi_bready(lite_bready),
   .s_axi_araddr(lite_araddr),
   .s_axi_arprot(lite_arprot),
   .s_axi_arvalid(lite_arvalid),
   .s_axi_arready(lite_arready),
   .s_axi_rdata(lite_rdata),
   .s_axi_rresp(lite_rresp),
   .s_axi_rvalid(lite_rvalid),
   .s_axi_rready(lite_rready),

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
   .m_axi_rready  (axi_rready)
 );

 // Set all IDs we drive to 0
 assign axi_awid = 0;
 assign axi_arid = 0;

 // We just set the user signals to 0
 assign axi_awuser = 0;
 assign axi_aruser = 0;
 assign axi_wuser = 0;
 assign axi_ruser = 0;
 assign axi_buser = 0;

 // Base AXI4 memory
 mem mem_i (
   .s_aclk        (sys_clk_i),
   .s_aresetn     (sys_rst_n),
   .s_axi_awid    (axi_awid),
   .s_axi_awaddr  (axi_awaddr),
   .s_axi_awlen   (axi_awlen),
   .s_axi_awsize  (axi_awsize),
   .s_axi_awburst (axi_awburst),
   .s_axi_awvalid (axi_awvalid),
   .s_axi_awready (axi_awready),
   .s_axi_wdata   (axi_wdata),
   .s_axi_wstrb   (axi_wstrb),
   .s_axi_wlast   (axi_wlast),
   .s_axi_wvalid  (axi_wvalid),
   .s_axi_wready  (axi_wready),
   .s_axi_bid     (axi_bid),
   .s_axi_bresp   (axi_bresp),
   .s_axi_bvalid  (axi_bvalid),
   .s_axi_bready  (axi_bready),
   .s_axi_arid    (axi_arid),
   .s_axi_araddr  (axi_araddr),
   .s_axi_arlen   (axi_arlen),
   .s_axi_arsize  (axi_arsize),
   .s_axi_arburst (axi_arburst),
   .s_axi_arvalid (axi_arvalid),
   .s_axi_arready (axi_arready),
   .s_axi_rid     (axi_rid),
   .s_axi_rdata   (axi_rdata),
   .s_axi_rresp   (axi_rresp),
   .s_axi_rlast   (axi_rlast),
   .s_axi_rvalid  (axi_rvalid),
   .s_axi_rready  (axi_rready)
 );


 axi_protocol_checker checker_i (
   .pc_axi_awaddr(axi_awaddr),
   .pc_axi_awprot(axi_awprot),
   .pc_axi_awvalid(axi_awvalid),
   .pc_axi_awready(axi_awready),
   .pc_axi_awsize(axi_awsize),
   .pc_axi_awburst(axi_awburst),
   .pc_axi_awcache(axi_awcache),
   .pc_axi_awlen(axi_awlen),
   .pc_axi_awlock(axi_awlock),
   .pc_axi_awqos(axi_awqos),
   .pc_axi_awregion(axi_awregion),
   .pc_axi_wdata(axi_wdata),
   .pc_axi_wstrb(axi_wstrb),
   .pc_axi_wvalid(axi_wvalid),
   .pc_axi_wready(axi_wready),
   .pc_axi_wlast(axi_wlast),
   .pc_axi_bresp(axi_bresp),
   .pc_axi_bvalid(axi_bvalid),
   .pc_axi_bready(axi_bready),
   .pc_axi_araddr(axi_araddr),
   .pc_axi_arprot(axi_arprot),
   .pc_axi_arvalid(axi_arvalid),
   .pc_axi_arready(axi_arready),
   .pc_axi_arsize(axi_arsize),
   .pc_axi_arburst(axi_arburst),
   .pc_axi_arcache(axi_arcache),
   .pc_axi_arlock(axi_arlock),
   .pc_axi_arlen(axi_arlen),
   .pc_axi_arqos(axi_arqos),
   .pc_axi_arregion(axi_arregion),
   .pc_axi_rdata(axi_rdata),
   .pc_axi_rresp(axi_rresp),
   .pc_axi_rvalid(axi_rvalid),
   .pc_axi_rready(axi_rready),
   .pc_axi_rlast(axi_rlast),

   .aclk(sys_clk_i),
   .aresetn(sys_rst_n),
   .pc_status(),
   .pc_asserted(err_o)

 );

 endmodule
