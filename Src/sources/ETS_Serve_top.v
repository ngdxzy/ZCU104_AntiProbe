`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2019 11:15:32 AM
// Design Name: 
// Module Name: ETS_Serve_top
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


module ETS_Serve_top(
	input free_run_rst,

	input free_run_clk,
 	input clk_in_p,
    input clk_in_n,

    input hp_rx_p,
    input hp_rx_n,
    output rx_clk,
    output [7:0] rx_data,

    // MMCM/PLL DRP
    input [6:0] drp_daddr,
    input [15:0] drp_di,
    output [15:0] drp_do,
    input drp_den,
    input drp_dwe,
    output drp_drdy,
    input drp_dclk,
    input s11_rx_p,
	input s11_rx_n,
	input s21_rx_p,
	input s21_rx_n,
    input cmp_in_p,
    input  cmp_in_n,
    output cmp_data,

	output s11_rx,
	output s21_rx,
    //step phase shift
    input ps_en,
    input ps_incdec,
    input ps_clk,
    output ps_done,

    output locked,

    output shifting_clk,
    output swing_out,
    output fixed_clk,
    output imp_clk,
    input op_clk
    );


	wire clk_in;
	wire phy_clk;
	wire div_clk;
	wire swing_clk;
	HP_dock inst_HP_dock(
		.free_run_rst (free_run_rst),
		.clk_in_p     (clk_in_p),
		.clk_in_n     (clk_in_n),
		.clk_in       (clk_in),
		.phy_clk      (phy_clk),
		.div_clk      (shifting_clk),
		.hp_rx_p      (hp_rx_p),
		.hp_rx_n      (hp_rx_n),
		.s11_rx_p	  (s11_rx_p),
		.s11_rx_n	  (s11_rx_n),
		.s21_rx_p	  (s21_rx_p),
		.s21_rx_n	  (s21_rx_n),
		.cmp_in_p	  (cmp_in_p),
	    .cmp_in_n	  (cmp_in_n),
	    .cmp_data	  (cmp_data),
		.rx_clk       (rx_clk),
		.rx_data      (rx_data),
		.s11_rx		  (s11_rx),
		.s21_rx		  (s21_rx),
		.swing_in     (swing_clk),
		.swing_out    (swing_out)
	);


	MMCM_host #(
		.CLK_SW(1),
		.CLK_IN_PEO(6.4),
		.VCO_MUL(8),
		.VCO_DIV(1),
		.SHIFTING_DIV(8),
		.FIXED_DIV(8),
		.IMPULSE_DIV(8),
		.PHY_DIV(8),
		.SWING_DIV(8)
	) inst_MMCM_host (
		.free_run_clk (free_run_clk),
		.clk_in       (clk_in),
		.op_clk		  (op_clk),
		.free_run_rst (free_run_rst),
		.drp_daddr    (drp_daddr),
		.drp_di       (drp_di),
		.drp_do       (drp_do),
		.drp_den      (drp_den),
		.drp_dwe      (drp_dwe),
		.drp_drdy     (drp_drdy),
		.drp_dclk     (drp_dclk),
		.ps_en        (ps_en),
		.ps_incdec    (ps_incdec),
		.ps_clk       (ps_clk),
		.ps_done      (ps_done),
		.locked       (locked),
		.shifting_clk (shifting_clk),
		.fixed_clk    (fixed_clk),
		.imp_clk      (imp_clk),
		.phy_clk      (phy_clk),
		.swing_clk    (swing_clk)
	);

endmodule
