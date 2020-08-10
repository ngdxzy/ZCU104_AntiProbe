`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2019 10:50:14 AM
// Design Name: 
// Module Name: ZCU104_AntiProbetop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ZCU104_AntiProbe_top(
	input ref_clk_in_p,
	input ref_clk_in_n,
	input reset,

	input gthrxn_in,
	input gthrxp_in,
	output gthtxn_out,
	output gthtxp_out,
	output ref_clk_fb_good,
	output system_clk_good,
	inout PAD_P,
	inout PAD_N,
	inout PAD_P1,
	inout PAD_N1,
	inout PAD_P2,
	inout PAD_N2
    );
	wire gthrefclk00_in;
	wire gtrefclk00_to_pl;
	wire ref_clk_fb;
	wire free_run_clk;
	wire free_run_rst_n;

	wire [79:0] GTH_DATA;
	wire swing_clk;
	wire sample_clk;
	wire jitter_clk;
	wire T_C,D_C;

	wire CMP_DATA_PAD0;
	wire CMP_DATA_PAD1;
	wire CMP_DATA_PAD2;


	(* max_fanout=2 *)reg cmp_data_PAD0_r;
	always @(posedge sample_clk) begin
		cmp_data_PAD0_r <= CMP_DATA_PAD0;
	end

	(* max_fanout=2 *)reg cmp_data_PAD1_r;
	always @(posedge sample_clk) begin
		cmp_data_PAD1_r <= CMP_DATA_PAD1;
	end

	(* max_fanout=2 *)reg cmp_data_PAD2_r;
	always @(posedge sample_clk) begin
		cmp_data_PAD2_r <= CMP_DATA_PAD2;
	end
	AnalogCMP inst_AnalogCMP0(
		.comp_out (CMP_DATA_PAD0),
		.PAD_P	  (PAD_P),
		.PAD_N    (PAD_N),
		.m_in_p   (jitter_clk),
		.m_in_n   (D_C),
		.m_en_n   (T_C)
	);
	AnalogCMP inst_AnalogCMP1(
		.comp_out (CMP_DATA_PAD1),
		.PAD_P	  (PAD_P1),
		.PAD_N    (PAD_N1),
		.m_in_p   (jitter_clk),
		.m_in_n   (D_C),
		.m_en_n   (T_C)
	);
	AnalogCMP inst_AnalogCMP2(
		.comp_out (CMP_DATA_PAD2),
		.PAD_P	  (PAD_P2),
		.PAD_N    (PAD_N2),
		.m_in_p   (jitter_clk),
		.m_in_n   (D_C),
		.m_en_n   (T_C)
	);

	ZCU104_AntiProbetop inst_ZCU104_AntiProbetop_wrapper(
		.GTH_DATA        (GTH_DATA),
		.cmp_data_p0     (cmp_data_PAD0_r),
		.cmp_data_p1     (cmp_data_PAD1_r),
		.cmp_data_p2     (cmp_data_PAD2_r),
		.cmp_data_p3     (cmp_data_PAD0_r),
		.free_run_clk    (free_run_clk),
		.free_run_rst_n  (free_run_rst_n),
		.ref_clk         (ref_clk_fb),
		.ref_clk_good    (ref_clk_fb_good),
		.reset           (reset),
		.sample_clk      (sample_clk),
		.T 				 (T_C),
		.D 				 (D_C),
		.sample_clk_good (system_clk_good),
		.swing_clk       (swing_clk),
		.jitter_clk      (jitter_clk)
	);

	

	gtwizard_ultrascale_0 GTH_inst (
		.gtwiz_userclk_tx_reset_in(~free_run_rst_n),                    // input wire [0 : 0] gtwiz_userclk_tx_reset_in
		.gtwiz_userclk_tx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_srcclk_out
		.gtwiz_userclk_tx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_usrclk_out
		.gtwiz_userclk_tx_usrclk2_out(ref_clk_fb),              // output wire [0 : 0] gtwiz_userclk_tx_usrclk2_out
		.gtwiz_userclk_tx_active_out(),                // output wire [0 : 0] gtwiz_userclk_tx_active_out
		.gtwiz_userclk_rx_reset_in(~free_run_rst_n),                    // input wire [0 : 0] gtwiz_userclk_rx_reset_in
		.gtwiz_userclk_rx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_srcclk_out
		.gtwiz_userclk_rx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_usrclk_out
		.gtwiz_userclk_rx_usrclk2_out(),              // output wire [0 : 0] gtwiz_userclk_rx_usrclk2_out
		.gtwiz_userclk_rx_active_out(),                // output wire [0 : 0] gtwiz_userclk_rx_active_out
		.gtwiz_reset_clk_freerun_in(free_run_clk),                  // input wire [0 : 0] gtwiz_reset_clk_freerun_in
		.gtwiz_reset_all_in(~free_run_rst_n),                                  // input wire [0 : 0] gtwiz_reset_all_in
		.gtwiz_reset_tx_pll_and_datapath_in(~free_run_rst_n),  // input wire [0 : 0] gtwiz_reset_tx_pll_and_datapath_in
		.gtwiz_reset_tx_datapath_in(~free_run_rst_n),                  // input wire [0 : 0] gtwiz_reset_tx_datapath_in
		.gtwiz_reset_rx_pll_and_datapath_in(~free_run_rst_n),  // input wire [0 : 0] gtwiz_reset_rx_pll_and_datapath_in
		.gtwiz_reset_rx_datapath_in(~free_run_rst_n),                  // input wire [0 : 0] gtwiz_reset_rx_datapath_in
		.gtwiz_reset_rx_cdr_stable_out(),            // output wire [0 : 0] gtwiz_reset_rx_cdr_stable_out
		.gtwiz_reset_tx_done_out(),                        // output wire [0 : 0] gtwiz_reset_tx_done_out
		.gtwiz_reset_rx_done_out(),                        // output wire [0 : 0] gtwiz_reset_rx_done_out
		.gtwiz_userdata_tx_in(GTH_DATA),                              // input wire [31 : 0] gtwiz_userdata_tx_in
		.gtwiz_userdata_rx_out(),                            // output wire [79 : 0] gtwiz_userdata_rx_out
		.gtrefclk01_in(gtrefclk00_in),                                            // input wire [0 : 0] gtrefclk00_in
		.qpll1outclk_out(),                                        // output wire [0 : 0] qpll1outclk_out

		.gthrxn_in(gthrxn_in),                                                    // input wire [0 : 0] gthrxn_in
		.gthrxp_in(gthrxp_in),                                                    // input wire [0 : 0] gthrxp_in
		.gthtxn_out(gthtxn_out),                                                  // output wire [0 : 0] gthtxn_out
		.gthtxp_out(gthtxp_out),                                                  // output wire [0 : 0] gthtxp_out
		.gtpowergood_out(),                                        // output wire [0 : 0] gtpowergood_out
		.rxpmaresetdone_out(),                                  // output wire [0 : 0] rxpmaresetdone_out
		.txpmaresetdone_out()                                  // output wire [0 : 0] txpmaresetdone_out
	);

	IBUFDS_GTE4 #(
		.REFCLK_EN_TX_PATH(1'b0),   // Refer to Transceiver User Guide
		.REFCLK_HROW_CK_SEL(2'b00), // Refer to Transceiver User Guide
		.REFCLK_ICNTL_RX(2'b00)     // Refer to Transceiver User Guide
	)IBUFDS_GTE4_inst (
		.O(gtrefclk00_in),         // 1-bit output: Refer to Transceiver User Guide
		.ODIV2(gtrefclk00_to_pl), // 1-bit output: Refer to Transceiver User Guide
		.CEB(0),     // 1-bit input: Refer to Transceiver User Guide
		.I(ref_clk_in_p),         // 1-bit input: Refer to Transceiver User Guide
		.IB(ref_clk_in_n)        // 1-bit input: Refer to Transceiver User Guide
	);


	// BUFG_GT BUFG_GT_inst (
	// 	.O(ref_clk_fb),             // 1-bit output: Buffer
	// 	.CE(1),           // 1-bit input: Buffer enable
	// 	.CEMASK(1'b1),   // 1-bit input: CE Mask
	// 	.CLR(1'b0),         // 1-bit input: Asynchronous clear
	// 	.CLRMASK(1'b0), // 1-bit input: CLR Mask
	// 	.DIV(3'b000),         // 3-bit input: Dynamic divide Value
	// 	.I(gtrefclk00_to_pl)              // 1-bit input: Buffer
	// );
endmodule
