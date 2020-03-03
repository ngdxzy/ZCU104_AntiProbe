// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Tue Mar  3 16:32:51 2020
// Host        : alfred-p330 running 64-bit Ubuntu 18.04.4 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/alfred/projects/vivado/ZCU104/ZCU_104_Anti_Probe/Src/IPs/gtwizard_ultrascale_0/gtwizard_ultrascale_0_stub.v
// Design      : gtwizard_ultrascale_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "gtwizard_ultrascale_0_gtwizard_top,Vivado 2019.1" *)
module gtwizard_ultrascale_0(gtwiz_userclk_tx_reset_in, 
  gtwiz_userclk_tx_srcclk_out, gtwiz_userclk_tx_usrclk_out, 
  gtwiz_userclk_tx_usrclk2_out, gtwiz_userclk_tx_active_out, gtwiz_userclk_rx_reset_in, 
  gtwiz_userclk_rx_srcclk_out, gtwiz_userclk_rx_usrclk_out, 
  gtwiz_userclk_rx_usrclk2_out, gtwiz_userclk_rx_active_out, 
  gtwiz_reset_clk_freerun_in, gtwiz_reset_all_in, gtwiz_reset_tx_pll_and_datapath_in, 
  gtwiz_reset_tx_datapath_in, gtwiz_reset_rx_pll_and_datapath_in, 
  gtwiz_reset_rx_datapath_in, gtwiz_reset_rx_cdr_stable_out, gtwiz_reset_tx_done_out, 
  gtwiz_reset_rx_done_out, gtwiz_userdata_tx_in, gtwiz_userdata_rx_out, gtrefclk01_in, 
  qpll1outclk_out, qpll1outrefclk_out, gthrxn_in, gthrxp_in, gthtxn_out, gthtxp_out, 
  gtpowergood_out, rxpmaresetdone_out, txpmaresetdone_out)
/* synthesis syn_black_box black_box_pad_pin="gtwiz_userclk_tx_reset_in[0:0],gtwiz_userclk_tx_srcclk_out[0:0],gtwiz_userclk_tx_usrclk_out[0:0],gtwiz_userclk_tx_usrclk2_out[0:0],gtwiz_userclk_tx_active_out[0:0],gtwiz_userclk_rx_reset_in[0:0],gtwiz_userclk_rx_srcclk_out[0:0],gtwiz_userclk_rx_usrclk_out[0:0],gtwiz_userclk_rx_usrclk2_out[0:0],gtwiz_userclk_rx_active_out[0:0],gtwiz_reset_clk_freerun_in[0:0],gtwiz_reset_all_in[0:0],gtwiz_reset_tx_pll_and_datapath_in[0:0],gtwiz_reset_tx_datapath_in[0:0],gtwiz_reset_rx_pll_and_datapath_in[0:0],gtwiz_reset_rx_datapath_in[0:0],gtwiz_reset_rx_cdr_stable_out[0:0],gtwiz_reset_tx_done_out[0:0],gtwiz_reset_rx_done_out[0:0],gtwiz_userdata_tx_in[31:0],gtwiz_userdata_rx_out[31:0],gtrefclk01_in[0:0],qpll1outclk_out[0:0],qpll1outrefclk_out[0:0],gthrxn_in[0:0],gthrxp_in[0:0],gthtxn_out[0:0],gthtxp_out[0:0],gtpowergood_out[0:0],rxpmaresetdone_out[0:0],txpmaresetdone_out[0:0]" */;
  input [0:0]gtwiz_userclk_tx_reset_in;
  output [0:0]gtwiz_userclk_tx_srcclk_out;
  output [0:0]gtwiz_userclk_tx_usrclk_out;
  output [0:0]gtwiz_userclk_tx_usrclk2_out;
  output [0:0]gtwiz_userclk_tx_active_out;
  input [0:0]gtwiz_userclk_rx_reset_in;
  output [0:0]gtwiz_userclk_rx_srcclk_out;
  output [0:0]gtwiz_userclk_rx_usrclk_out;
  output [0:0]gtwiz_userclk_rx_usrclk2_out;
  output [0:0]gtwiz_userclk_rx_active_out;
  input [0:0]gtwiz_reset_clk_freerun_in;
  input [0:0]gtwiz_reset_all_in;
  input [0:0]gtwiz_reset_tx_pll_and_datapath_in;
  input [0:0]gtwiz_reset_tx_datapath_in;
  input [0:0]gtwiz_reset_rx_pll_and_datapath_in;
  input [0:0]gtwiz_reset_rx_datapath_in;
  output [0:0]gtwiz_reset_rx_cdr_stable_out;
  output [0:0]gtwiz_reset_tx_done_out;
  output [0:0]gtwiz_reset_rx_done_out;
  input [31:0]gtwiz_userdata_tx_in;
  output [31:0]gtwiz_userdata_rx_out;
  input [0:0]gtrefclk01_in;
  output [0:0]qpll1outclk_out;
  output [0:0]qpll1outrefclk_out;
  input [0:0]gthrxn_in;
  input [0:0]gthrxp_in;
  output [0:0]gthtxn_out;
  output [0:0]gthtxp_out;
  output [0:0]gtpowergood_out;
  output [0:0]rxpmaresetdone_out;
  output [0:0]txpmaresetdone_out;
endmodule
