`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2019 04:55:54 PM
// Design Name: 
// Module Name: MMCM_host
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


module MMCM_host#(
	parameter CLK_SW = 1,
	parameter CLK_IN_PEO = 6.4,
	parameter integer VCO_MUL = 10,
	parameter integer VCO_DIV = 1,
	parameter integer SHIFTING_DIV = 10,
	parameter integer FIXED_DIV = 10,
	parameter integer IMPULSE_DIV = 10,
	parameter integer PHY_DIV = 2,
	parameter  SWING_DIV = 11
	)(
	//
	input free_run_clk,
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

    //step phase shift
    input ps_en,
    input ps_incdec,
    input ps_clk,
    output ps_done,

    output locked,

    output shifting_clk,
    output fixed_clk,
    output imp_clk,
    output phy_clk,
    output swing_clk,
    input op_clk
    );
	wire CLKFB_OUT;
	wire CLKFB_IN;
	wire CLKOUT1;
	wire CLKOUT2;
	wire CLKOUT3;
	wire CLKOUT4;
	MMCME3_ADV #(
		.BANDWIDTH("OPTIMIZED"),        // Jitter programming (HIGH, LOW, OPTIMIZED)
		.CLKFBOUT_MULT_F(VCO_MUL),          // Multiply value for all CLKOUT (2.000-64.000)
		.CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000)
		// CLKIN_PERIOD: Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
		.CLKIN1_PERIOD(CLK_IN_PEO),
		.CLKIN2_PERIOD(0.0),
		.CLKOUT0_DIVIDE_F(SWING_DIV),         // Divide amount for CLKOUT0 (1.000-128.000)
		// CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for CLKOUT outputs (0.001-0.999).
		.CLKOUT0_DUTY_CYCLE(0.5),
		.CLKOUT1_DUTY_CYCLE(0.5),
		.CLKOUT2_DUTY_CYCLE(0.5),
		.CLKOUT3_DUTY_CYCLE(0.5),
		.CLKOUT4_DUTY_CYCLE(0.5),
		.CLKOUT5_DUTY_CYCLE(0.5),
		.CLKOUT6_DUTY_CYCLE(0.5),
		// CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for CLKOUT outputs (-360.000-360.000).
		.CLKOUT0_PHASE(0.0),
		.CLKOUT1_PHASE(0.0),
		.CLKOUT2_PHASE(0.0),
		.CLKOUT3_PHASE(0.0),
		.CLKOUT4_PHASE(0.0),
		.CLKOUT5_PHASE(0.0),
		.CLKOUT6_PHASE(0.0),
		// CLKOUT1_DIVIDE - CLKOUT6_DIVIDE: Divide amount for CLKOUT (1-128)
		.CLKOUT1_DIVIDE(SHIFTING_DIV),
		.CLKOUT2_DIVIDE(IMPULSE_DIV),
		.CLKOUT3_DIVIDE(PHY_DIV),
		.CLKOUT4_CASCADE("FALSE"),
		.CLKOUT4_DIVIDE(FIXED_DIV),
		.CLKOUT5_DIVIDE(10),
		.CLKOUT6_DIVIDE(10),
		.COMPENSATION("AUTO"),          // AUTO, BUF_IN, EXTERNAL, INTERNAL, ZHOLD
		.DIVCLK_DIVIDE(VCO_DIV),              // Master division value (1-106)
		// Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
		.IS_CLKFBIN_INVERTED(1'b0),     // Optional inversion for CLKFBIN
		.IS_CLKIN1_INVERTED(1'b0),      // Optional inversion for CLKIN1
		.IS_CLKIN2_INVERTED(1'b0),      // Optional inversion for CLKIN2
		.IS_CLKINSEL_INVERTED(1'b0),    // Optional inversion for CLKINSEL
		.IS_PSEN_INVERTED(1'b0),        // Optional inversion for PSEN
		.IS_PSINCDEC_INVERTED(1'b0),    // Optional inversion for PSINCDEC
		.IS_PWRDWN_INVERTED(1'b0),      // Optional inversion for PWRDWN
		.IS_RST_INVERTED(1'b0),         // Optional inversion for RST
		// REF_JITTER: Reference input jitter in UI (0.000-0.999).
		.REF_JITTER1(0.0),
		.REF_JITTER2(0.0),
		.STARTUP_WAIT("FALSE"),         // Delays DONE until MMCM is locked (FALSE, TRUE)
		// Spread Spectrum: Spread Spectrum Attributes
		.SS_EN("FALSE"),                // Enables spread spectrum (FALSE, TRUE)
		.SS_MODE("CENTER_HIGH"),        // CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
		.SS_MOD_PERIOD(10000),          // Spread spectrum modulation period (ns) (4000-40000)
		// USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
		.CLKFBOUT_USE_FINE_PS("FALSE"),
		.CLKOUT0_USE_FINE_PS("FALSE"),
		.CLKOUT1_USE_FINE_PS("TRUE"),
		.CLKOUT2_USE_FINE_PS("FALSE"),
		.CLKOUT3_USE_FINE_PS("TRUE"),
		.CLKOUT4_USE_FINE_PS("FALSE"),
		.CLKOUT5_USE_FINE_PS("FALSE"),
		.CLKOUT6_USE_FINE_PS("FALSE") 
	)
	MMCME3_ADV_inst (
		// Clock Outputs outputs: User configurable clock outputs
		.CLKOUT0(swing_clk),           // 1-bit output: CLKOUT0
		.CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(CLKOUT1),           // 1-bit output: Primary clock
		.CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(CLKOUT2),           // 1-bit output: CLKOUT2
		.CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
		.CLKOUT3(CLKOUT3),           // 1-bit output: CLKOUT3
		.CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
		.CLKOUT4(CLKOUT4),           // 1-bit output: CLKOUT4
		.CLKOUT5(),           // 1-bit output: CLKOUT5
		.CLKOUT6(),           // 1-bit output: CLKOUT6
		// Feedback outputs: Clock feedback ports
		.CLKFBIN(CLKFB_IN),            // 1-bit input: Feedback clock
		.CLKFBOUT(CLKFB_OUT),         // 1-bit output: Feedback clock
		.CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
		// Status Ports outputs: MMCM status ports
		.CDDCDONE(),         // 1-bit output: Clock dynamic divide done
		.CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
		.CLKINSTOPPED(), // 1-bit output: Input clock stopped
		.LOCKED(locked),             // 1-bit output: LOCK
		.CDDCREQ(1'b0),           // 1-bit input: Request to dynamic divide clock
		// Clock Inputs inputs: Clock inputs
		.CLKIN1(op_clk),             // 1-bit input: Primary clock
		.CLKIN2(clk_in),             // 1-bit input: Secondary clock
		// Control Ports inputs: MMCM control ports
		.CLKINSEL(CLK_SW),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
		.PWRDWN(1'b0),             // 1-bit input: Power-down
		// Feedback inputs: Clock feedback ports
		.RST(free_run_rst),                   // 1-bit input: Reset
		// DRP Ports inputs: Dynamic reconfiguration ports
		.DO(drp_do),                     // 16-bit output: DRP data
		.DRDY(drp_drdy),                 // 1-bit output: DRP ready
		.DADDR(drp_daddr),               // 7-bit input: DRP address
		.DCLK(drp_dclk),                 // 1-bit input: DRP clock
		.DEN(drp_den),                   // 1-bit input: DRP enable
		.DI(drp_di),                     // 16-bit input: DRP data
		.DWE(drp_dwe),                   // 1-bit input: DRP write enable
		// Dynamic Phase Shift Ports inputs: Ports used for dynamic phase shifting of the outputs
		.PSCLK(ps_clk),               // 1-bit input: Phase shift clock
		.PSEN(ps_en),                 // 1-bit input: Phase shift enable
		.PSINCDEC(ps_incdec),         // 1-bit input: Phase shift increment/decrement
		.PSDONE(ps_done)             // 1-bit output: Phase shift done
	);

	BUFG BUFG_CLKOUT4 (
		.O(fixed_clk), // 1-bit output: Clock output
		.I(CLKOUT4)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKOUT1 (
		.O(shifting_clk), // 1-bit output: Clock output
		.I(CLKOUT1)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKOUT2 (
		.O(imp_clk), // 1-bit output: Clock output
		.I(CLKOUT2)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKOUT3 (
		.O(phy_clk), // 1-bit output: Clock output
		.I(CLKOUT3)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKFB (
		.O(CLKFB_IN), // 1-bit output: Clock output
		.I(CLKFB_OUT)  // 1-bit input: Clock input
	);
endmodule
