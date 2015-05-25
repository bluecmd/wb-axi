/*
 * WB AXI Verilator testbench
 *
 * Author: Christian Svensson <blue@cmd.nu>
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 */

#include <signal.h>
#include <stdint.h>

#include "Vtestbench__Syms.h"

#define RESET_TIME    2

bool done;

void signal_int(int signal) {
  done = true;
}

int main(int argc, char **argv, char **env) {
  int t = 0;
  bool wb_reset_released = false;

  Verilated::commandArgs(argc, argv);

  Vtestbench* top = new Vtestbench;

  top->sys_clk_i = 0;
  top->sys_rst_i = 1;

  done = false;
  signal(SIGINT, signal_int);

  while (!done) {

    top->eval();

    if (t > RESET_TIME && top->sys_rst_i == 1) {
      printf("Reset released\n");
      top->sys_rst_i = 0;
    }

    if (!wb_reset_released && top->v->wb_rst == 0) {
      printf("Wishbone reset released\n");
      wb_reset_released = true;
    }

    top->sys_clk_i = !top->sys_clk_i;

    t++;

    done = done || Verilated::gotFinish();
  }

  printf("Simulation ended\n");
  return 0;
}
