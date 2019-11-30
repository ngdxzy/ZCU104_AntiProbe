`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2019 11:45:48 AM
// Design Name: 
// Module Name: HP_dock
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


module HP_dock(
	input free_run_rst,
	//clock manage 
    input clk_in_p,
    input clk_in_n,
    output clk_in,

	input s11_rx_p,
	input s11_rx_n,
	input s21_rx_p,
	input s21_rx_n,

    input phy_clk,
    input div_clk,
    input hp_rx_p,
    input hp_rx_n,

    input cmp_in_p,
    input  cmp_in_n,
    output cmp_data,

	output s11_rx,
	output s21_rx,
    output rx_clk,
    output [7:0] rx_data,

    input swing_in,
    output swing_out
    );
	
	wire clk_in;
	wire hp_rx;
	wire phy_clk;
	wire imp_clk;
	wire fixed_clk;
	wire shifting_clk;

	IBUFDS #(
		.DQS_BIAS("FALSE")  // (FALSE, TRUE)
	)
	IBUFDS_clock_in (
		.O(clk_in),   // 1-bit output: Buffer output
		.I(clk_in_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
		.IB(clk_in_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
	);

	// IBUFDS #(
	// 	.DQS_BIAS("FALSE")  // (FALSE, TRUE)
	// )
	// IBUFDS_rx_in (
	// 	.O(hp_rx),   // 1-bit output: Buffer output
	// 	.I(hp_rx_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
	// 	.IB(hp_rx_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
	// );

	// IBUFDS #(
	// 	.DQS_BIAS("FALSE")  // (FALSE, TRUE)
	// )
	// IBUFDS_s11_rx_in (
	// 	.O(s11_rx),   // 1-bit output: Buffer output
	// 	.I(s11_rx_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
	// 	.IB(s11_rx_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
	// );

	// IBUFDS #(
	// 	.DQS_BIAS("FALSE")  // (FALSE, TRUE)
	// )
	// IBUFDS_s21_rx_in (
	// 	.O(s21_rx),   // 1-bit output: Buffer output
	// 	.I(s21_rx_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
	// 	.IB(s21_rx_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
	// );

	IBUFDS #(
		.DQS_BIAS("TRUE")  // (FALSE, TRUE)
	)
	IBUFDS_cmp_in (
		.O(cmp_data),   // 1-bit output: Buffer output
		.I(cmp_in_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
		.IB(cmp_in_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
	);
/*
	wire VREF;
	IBUFE3 #(
	.SIM_INPUT_BUFFER_OFFSET(0)  // Offset value for simulation (-50-50)
	)
	IBUFE3_inst (
		.O(hp_rx),                     // 1-bit output: Buffer output
		.I(hp_rx_p),                     // 1-bit input: Buffer input (connect directly to top-level port)
		.IBUFDISABLE(1'b0), // 1-bit input: Buffer disable input, high=disable
		.OSC(4'd0),                 // 4-bit input: Offset cancellation value
		.OSC_EN(1'b0),           // 1-bit input: Offset cancellation enable
		.VREF(VREF)                // 1-bit input: Vref input from HPIO_VREF
	);
	HPIO_VREF #(
		.VREF_CNTR("OFF")  // FABRIC_RANGE1, FABRIC_RANGE2, OFF
	)HPIO_VREF_inst (
	  .VREF(VREF),                         // 1-bit output: Tuned output (connect to associated IBUFE3
	                                       // component)

	  .FABRIC_VREF_TUNE(FABRIC_VREF_TUNE)  // 7-bit input: VREF tuning value
	);
*/

	OBUF OBUF_inst (
		.O(swing_out), // 1-bit output: Buffer output (connect directly to top-level port)
		.I(swing_in)  // 1-bit input: Buffer input
	);

	// ISERDESE3 #(
	// 	.DATA_WIDTH(8),            // Parallel data width (4,8)
	// 	.FIFO_ENABLE("FALSE"),     // Enables the use of the FIFO
	// 	.FIFO_SYNC_MODE("FALSE"),  // Enables the use of internal 2-stage synchronizers on the FIFO
	// 	.IS_CLK_B_INVERTED(1'b1),  // Optional inversion for CLK_B
	// 	.IS_CLK_INVERTED(1'b0),    // Optional inversion for CLK
	// 	.IS_RST_INVERTED(1'b0),    // Optional inversion for RST
	// 	.SIM_DEVICE("ULTRASCALE_PLUS")  // Set the device version (ULTRASCALE, ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
	// )
	// ISERDESE3_inst (
	// 	.FIFO_EMPTY(),           // 1-bit output: FIFO empty flag
	// 	.INTERNAL_DIVCLK(), // 1-bit output: Internally divided down clock used when FIFO is disabled (do not connect)	                             
	// 	.Q(rx_data),                             // 8-bit registered output
	// 	.CLK(phy_clk),                         // 1-bit input: High-speed clock
	// 	.CLKDIV(div_clk),                   // 1-bit input: Divided Clock
	// 	.CLK_B(phy_clk),                     // 1-bit input: Inversion of High-speed clock CLK
	// 	.D(s21_rx),                             // 1-bit input: Serial Data Input
	// 	.FIFO_RD_CLK(1'b1),         // 1-bit input: FIFO read clock
	// 	.FIFO_RD_EN(1'b0),           // 1-bit input: Enables reading the FIFO when asserted
	// 	.RST(free_run_rst)                          // 1-bit input: Asynchronous Reset
	// );

	assign rx_clk = div_clk;
endmodule
