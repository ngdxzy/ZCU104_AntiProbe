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
	input cmp_in_p,
	input cmp_in_n,
	// input gthrxn_in,
	// input gthrxp_in,
	// output gthtxn_out,
	// output gthtxp_out,
	input clk_in_p,
	input clk_in_n,
	output sma_swing,
	output ref_clk_fb_good,
	output system_clk_good,
	output LE_p,
	output LE_n,
	output tri_data
    );
	wire gthrefclk00_in;
	wire gtrefclk00_to_pl;
	wire ref_clk_fb;
	wire free_run_clk;
	wire free_run_rst_n;
	wire REF_CLK_IN;
	wire REF_CLK;
	wire imp_clk_s;

	wire swing_out;
	wire cmp_data;
	wire s11_rx;
	wire s21_rx;
	wire [31:0] GTH_DATA;

	wire [6:0] mmcm_drp_daddr;
	wire [15:0] mmcm_drp_do;
	wire [15:0] mmcm_drp_di;
	wire mmcm_drp_den;
	wire mmcm_drp_dwe;
	wire mmcm_drp_drdy;

	OBUF #(
	.DRIVE(12),   // Specify the output drive strength
	.IOSTANDARD("DEFAULT"), // Specify the output I/O standard
	.SLEW("FAST") // Specify the output slew rate
	) OBUF_inst_sma (
	.O(sma_swing),     // Buffer output (connect directly to top-level port)
	.I(swing_out)      // Buffer input
	);

	OBUFDS #(
		.IOSTANDARD("DEFAULT"), // Specify the output I/O standard
		.SLEW("FAST")           // Specify the output slew rate
	) OBUFDS_inst (
		.O(LE_p),     // Diff_p output (connect directly to top-level port)
		.OB(LE_n),   // Diff_n output (connect directly to top-level port)
		.I(~shifting_clk)      // Buffer input
	);
	wire [7:0] CMP_DATA_0;
	// ila_0 your_instance_name (
	// 	.clk(ref_clk_fb), // input wire clk


	// 	.probe0(cmp_data_r), // input wire [0:0]  probe0  
	// 	.probe1(CMP_DATA_0), // input wire [7:0]  probe1
	// 	.probe2(s11_rx), // input wire [0:0]  probe2 
	// 	.probe3(1'b1) // input wire [0:0]  probe3
	// );
	reg cmp_data_r;
	always @(posedge shifting_clk) begin
		cmp_data_r <= cmp_data;
	end

	ZCU104_MCU ZCU104_MCU_i(
		.tri_data (),
		.GTH_DATA (GTH_DATA),
		.CMP_DATA_0(CMP_DATA_0),
		.CMP_DATA_1(cmp_data_r),
		.REF_CLK_IN(fixed_clk),
		.free_run_clk(free_run_clk),
		.free_run_rst_n(free_run_rst_n),
		.mmcm_drp_clk(mmcm_drp_clk),
		.mmcm_drp_daddr(mmcm_drp_daddr),
		.mmcm_drp_den(mmcm_drp_den),
		.mmcm_drp_di(mmcm_drp_di),
		.mmcm_drp_do(mmcm_drp_do),
		.mmcm_drp_drdy(mmcm_drp_drdy),
		.mmcm_drp_dwe(mmcm_drp_dwe),
		.ps_clk(ps_clk),
		.ps_done(ps_done),
		.ps_en(ps_en),
		.ps_incdec(ps_incdec),
		.ref_clk_fb(ref_clk_fb),
		.reset(reset),
		.shifting_clk_0(shifting_clk),
		.ref_clk_fb_good(ref_clk_fb_good),
		.system_clk_good(system_clk_good)
	);
	ETS_Serve_top inst_ETS_Serve_top(
		.free_run_rst (~free_run_rst_n),
		.free_run_clk (free_run_clk),	
		.op_clk		  (ref_clk_fb),
		.clk_in_p     (clk_in_p),
		.clk_in_n     (clk_in_n),
		.hp_rx_p      (),
		.hp_rx_n      (),
		.rx_clk       (),
		.rx_data      (CMP_DATA_0),
		.drp_daddr    (mmcm_drp_daddr),
		.drp_di       (mmcm_drp_di),
		.drp_do       (mmcm_drp_do),
		.drp_den      (mmcm_drp_den),
		.drp_dwe      (mmcm_drp_dwe),
		.drp_drdy     (mmcm_drp_drdy),
		.drp_dclk     (mmcm_drp_clk),
		.s11_rx_p	  (),
		.s11_rx_n	  (),
		.s21_rx_p	  (),
		.s21_rx_n	  (),

		.cmp_in_p	  (cmp_in_p),
	    .cmp_in_n	  (cmp_in_n),
	    .cmp_data	  (cmp_data),
		.s11_rx		  (),
		.s21_rx		  (),
		.ps_en        (ps_en),
		.ps_incdec    (ps_incdec),
		.ps_clk       (ps_clk),
		.ps_done      (ps_done),
		.locked       (locked),
		.shifting_clk (shifting_clk),
		.swing_out    (swing_out),
		.fixed_clk    (fixed_clk),
		.imp_clk      (tri_data)
	);
	reg [31:0] gth_inv_data;
	reg invert;
	always @ (posedge REF_CLK or negedge free_run_rst_n) begin
		if(~free_run_rst_n) begin
			gth_inv_data <= 3;
		end
		else begin			
			gth_inv_data <= gth_inv_data * 123 + 59;
		end
	end

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


	BUFG_GT BUFG_GT_inst (
		.O(ref_clk_fb),             // 1-bit output: Buffer
		.CE(1),           // 1-bit input: Buffer enable
		.CEMASK(1'b1),   // 1-bit input: CE Mask
		.CLR(1'b0),         // 1-bit input: Asynchronous clear
		.CLRMASK(1'b0), // 1-bit input: CLR Mask
		.DIV(3'b000),         // 3-bit input: Dynamic divide Value
		.I(gtrefclk00_to_pl)              // 1-bit input: Buffer
	);
endmodule
