
module testbench (
  input           sys_clk_i,
  input           sys_rst_i
);
  wire wb_clk /* verilator public */;
  wire wb_rst /* verilator public */;

  /* Reset generation for wishbone */
  reg [15:0]  wb_rst_shr;

  assign wb_clk = sys_clk_i;
  assign wb_rst = wb_rst_shr[15];

  always @(posedge wb_clk or posedge sys_rst_i)
  begin
    if (sys_rst_i)
      wb_rst_shr <= 16'hffff;
    else
      wb_rst_shr <= {wb_rst_shr[14:0], sys_rst_i};
  end



  `include "wb_intercon.vh"

  initial
  begin
    $display("Testbench for wb-axi started");
  end

endmodule
