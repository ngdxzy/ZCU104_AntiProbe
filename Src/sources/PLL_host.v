`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2019 09:51:22 AM
// Design Name: 
// Module Name: PLL_host
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


module PLL_host#(
	parameter CLK_IN_PEO = 6.4,
	parameter integer VCO_MUL = 10,
	parameter integer VCO_DIV = 1,
	parameter integer FIXED_DIV = 10,
	parameter integer IMPULSE_DIV = 10,
	parameter CLKOUTPHY_MODE = "VCO"
	)(
	input clk_in,
	input free_run_rst,

    // MMCM/PLL DRP
    input [6:0] drp_daddr,
    input [15:0] drp_di,
    output [15:0] drp_do,
    input drp_den,
    input drp_dwe,
    output drp_drdy,
    input drp_dclk,


    output locked,

    output phy_clk,
    output fixed_clk,
    output imp_clk
    );
	wire CLKOUT0;
	wire CLKOUT1;
	wire clock_fb;
	PLLE3_ADV #(
		.CLKFBOUT_MULT(VCO_MUL),          // Multiply value for all CLKOUT, (1-19)x
		.CLKFBOUT_PHASE(0.0),       // Phase offset in degrees of CLKFB, (-360.000-360.000)
		.CLKIN_PERIOD(CLK_IN_PEO),         // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
		// CLKOUT0 Attributes: Divide, Phase and Duty Cycle for the CLKOUT0 output
		.CLKOUT0_DIVIDE(FIXED_DIV),         // Divide amount for CLKOUT0 (1-128)
		.CLKOUT0_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT0 (0.001-0.999)
		.CLKOUT0_PHASE(0.0),        // Phase offset for CLKOUT0 (-360.000-360.000)
		// CLKOUT1 Attributes: Divide, Phase and Duty Cycle for the CLKOUT1 output
		.CLKOUT1_DIVIDE(IMPULSE_DIV),         // Divide amount for CLKOUT1 (1-128)
		.CLKOUT1_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT1 (0.001-0.999)
		.CLKOUT1_PHASE(0.0),        // Phase offset for CLKOUT1 (-360.000-360.000)
		.CLKOUTPHY_MODE(CLKOUTPHY_MODE),  // Frequency of the CLKOUTPHY (VCO, VCO_2X, VCO_HALF)
		.COMPENSATION("AUTO"),      // AUTO, BUF_IN, INTERNAL
		.DIVCLK_DIVIDE(VCO_DIV),          // Master division value, (1-15)
		// Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
		.IS_CLKFBIN_INVERTED(1'b0), // Optional inversion for CLKFBIN
		.IS_CLKIN_INVERTED(1'b0),   // Optional inversion for CLKIN
		.IS_PWRDWN_INVERTED(1'b0),  // Optional inversion for PWRDWN
		.IS_RST_INVERTED(1'b0),     // Optional inversion for RST
		.REF_JITTER(0.0),           // Reference input jitter in UI (0.000-0.999)
		.STARTUP_WAIT("FALSE")      // Delays DONE until PLL is locked (FALSE, TRUE)
		)
	PLLE3_ADV_inst (
	// Clock Outputs outputs: User configurable clock outputs
		.CLKOUT0(CLKOUT0),         // 1-bit output: General Clock output
		.CLKOUT0B(),       // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(CLKOUT1),         // 1-bit output: General Clock output
		.CLKOUT1B(),       // 1-bit output: Inverted CLKOUT1
		.CLKOUTPHY(phy_clk),     // 1-bit output: Bitslice clock
		// Feedback Clocks outputs: Clock feedback ports
		.CLKFBOUT(clock_fb),       // 1-bit output: Feedback clock
		// Feedback Clocks inputs: Clock feedback ports
		.CLKFBIN(clock_fb),          // 1-bit input: Feedback clock

		.LOCKED(locked),           // 1-bit output: LOCK
		.CLKIN(clk_in),             // 1-bit input: Input clock
		// Control Ports inputs: PLL control ports
		.CLKOUTPHYEN(1'b1), // 1-bit input: CLKOUTPHY enable
		.PWRDWN(1'b0),           // 1-bit input: Power-down
		.RST(free_run_rst),                 // 1-bit input: Reset
		// DRP Ports inputs: Dynamic reconfiguration ports
		// DRP Ports outputs: Dynamic reconfiguration ports
		.DO(drp_do),                   // 16-bit output: DRP data
		.DRDY(drp_drdy),               // 1-bit output: DRP ready
		.DADDR(drp_daddr),             // 7-bit input: DRP address
		.DCLK(drp_dclk),               // 1-bit input: DRP clock
		.DEN(drp_den),                 // 1-bit input: DRP enable
		.DI(drp_di),                   // 16-bit input: DRP data
		.DWE(drp_dwe)                 // 1-bit input: DRP write enable
	);
	BUFG BUFG_CLKOUT0 (
		.O(fixed_clk), // 1-bit output: Clock output
		.I(CLKOUT0)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKOUT1 (
		.O(imp_clk), // 1-bit output: Clock output
		.I(CLKOUT1)  // 1-bit input: Clock input
	);

endmodule
