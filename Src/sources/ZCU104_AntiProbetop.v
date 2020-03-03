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


module ZCU104_AntiProbetop(
	input ref_clk_in_p,
	input ref_clk_in_n,
	input reset,

	input S11_CMP_p,
	input S11_CMP_n,	
	input S21_CMP_p,
	input S21_CMP_n,	
	input ref_CMP_p,
	input ref_CMP_n,
	input gthrxn_in,
	input gthrxp_in,
	output gthtxn_out,
	output gthtxp_out,
	output S11_swing,
	output S21_swing,
	output ref_swing,
	output ref_clk_fb_good,
	output system_clk_good,
	output LE_ref_p,
	output LE_ref_n,
	output LE_S21_p,
	output LE_S21_n,
	output LE_S11_p,
	output LE_S11_n,
	output triger
    );
	wire gthrefclk00_in;
	wire gtrefclk00_to_pl;
	wire ref_clk_fb;
	wire free_run_clk;
	wire free_run_rst_n;

	wire [31:0] GTH_DATA;

	wire CMP_DATA_ref;
	wire CMP_DATA_S11;
	wire CMP_DATA_S21;

	IBUFDS IBUFDS_ref (
		.O(CMP_DATA_ref),   // 1-bit output: Buffer output
		.I(ref_CMP_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
		.IB(ref_CMP_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
	);

	IBUFDS IBUFDS_S11 (
		.O(CMP_DATA_S11),   // 1-bit output: Buffer output
		.I(S11_CMP_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
		.IB(S11_CMP_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
	);

	IBUFDS IBUFDS_S21 (
		.O(CMP_DATA_S21),   // 1-bit output: Buffer output
		.I(S21_CMP_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
		.IB(S21_CMP_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
	);

	OBUFDS #(
		.IOSTANDARD("DEFAULT"), // Specify the output I/O standard
		.SLEW("FAST")           // Specify the output slew rate
	) OBUFDS_ref (
		.O(LE_ref_p),     // Diff_p output (connect directly to top-level port)
		.OB(LE_ref_n),   // Diff_n output (connect directly to top-level port)
		.I(shifting_clk)      // Buffer input
	);
	OBUFDS #(
		.IOSTANDARD("DEFAULT"), // Specify the output I/O standard
		.SLEW("FAST")           // Specify the output slew rate
	) OBUFDS_S11 (
		.O(LE_S11_p),     // Diff_p output (connect directly to top-level port)
		.OB(LE_S11_n),   // Diff_n output (connect directly to top-level port)
		.I(shifting_clk)      // Buffer input
	);
	OBUFDS #(
		.IOSTANDARD("DEFAULT"), // Specify the output I/O standard
		.SLEW("FAST")           // Specify the output slew rate
	) OBUFDS_S21 (
		.O(LE_S21_p),     // Diff_p output (connect directly to top-level port)
		.OB(LE_S21_n),   // Diff_n output (connect directly to top-level port)
		.I(shifting_clk)      // Buffer input
	);


	reg cmp_data_ref_r;
	always @(posedge shifting_clk) begin
		cmp_data_ref_r <= CMP_DATA_ref;
	end
	reg cmp_data_S11_r;
	always @(posedge shifting_clk) begin
		cmp_data_S11_r <= CMP_DATA_S11;
	end
	reg cmp_data_S21_r;
	always @(posedge shifting_clk) begin
		cmp_data_S21_r <= CMP_DATA_S21;
	end

	ZCU104_MCU ZCU104_MCU_i(
		.free_run_clk(free_run_clk),
		.gth_data(GTH_DATA),
       	.CMP_DATA_S11(cmp_data_S11_r),
        .CMP_DATA_S21(cmp_data_S21_r),
        .CMP_DATA_ref(cmp_data_ref_r),
        .S11_swing(S11_swing),
        .S21_swing(S21_swing),
        .free_run_rst_n(free_run_rst_n),
        .ref_clk_fb(ref_clk_fb),
        .ref_clk_fb_good(ref_clk_fb_good),
        .ref_swing(ref_swing),
        .reset(reset),
        .shifting_clk(shifting_clk),
        .system_clk_good(system_clk_good),
        .triger(triger)
    );
	

	gtwizard_ultrascale_0 GTH_inst (
		.gtwiz_userclk_tx_reset_in(~free_run_rst_n),                    // input wire [0 : 0] gtwiz_userclk_tx_reset_in
		.gtwiz_userclk_tx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_srcclk_out
		.gtwiz_userclk_tx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_usrclk_out
		.gtwiz_userclk_tx_usrclk2_out(),              // output wire [0 : 0] gtwiz_userclk_tx_usrclk2_out
		.gtwiz_userclk_tx_active_out(),                // output wire [0 : 0] gtwiz_userclk_tx_active_out
		.gtwiz_userclk_rx_reset_in(~free_run_rst_n),                    // input wire [0 : 0] gtwiz_userclk_rx_reset_in
		.gtwiz_userclk_rx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_srcclk_out
		.gtwiz_userclk_rx_usrclk_out(ref_clk_fb),                // output wire [0 : 0] gtwiz_userclk_rx_usrclk_out
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
		.gtwiz_userdata_rx_out(),                            // output wire [31 : 0] gtwiz_userdata_rx_out
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
