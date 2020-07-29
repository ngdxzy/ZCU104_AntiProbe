`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2020 11:56:16 AM
// Design Name: 
// Module Name: ClockSources
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


module ClockSources#(
	parameter CLK_PERIOD = 10.000
	)(
	input free_run_clk,
	input rst_n,
	input shift,
	output shift_done,

	output trigger_clk,

	output system_clk,
	output sample_clk,
	output swing_clk,

	output jitter_clk,

	input jitter_shift,
	output reg jitter_shift_done,
	input jitter_incdec,

	input [15:0] drp_di,
	input drp_dclk,
	input drp_den,
	input drp_dwe,
	input [6:0] drp_daddr,
	output [15:0] drp_do,
	output drp_drdy
    );
    localparam PLL0_MUL = 10;
    localparam PLL1_MUL = 10;
    localparam PLL11_MUL =9;
    localparam PLL2_MUL = 16;

    wire CLKOUT00,CLKOUT01;
    wire CLKOUT10;
    wire CLKOUT110;
    wire CLKOUT20,CLKOUT21;
    wire CLKOUT30;
    wire CLKFB_IN_0,CLKFB_OUT_0;
    wire CLKFB_IN_1,CLKFB_OUT_1;
    wire CLKFB_IN_11,CLKFB_OUT_11;
    wire CLKFB_IN_2,CLKFB_OUT_2;
    wire CLKFB_IN_3,CLKFB_OUT_3;
    wire shifting_clk0,shifting_clk1;
    wire shifting_clk2;
    wire ps_clk = system_clk;
    wire locked1,locked2;
    (* dont_touch="true" *) wire t_p,t_n;
    (* dont_touch="true" *) wire t_n1,t_n2;
    (* dont_touch="true" *) wire trigger_clk;
    //assign system_clk = shifting_clk0;
    reg ps_en1;
    wire ps_done1;

    reg ps_en2;
    wire ps_done2;
    
    reg [2:0] state,nextstate;
    localparam IDLE = 3'd0;
	localparam SHIFT1 = 3'd1;
	localparam WAIT_SHIFT1 = 3'd2;
	localparam WAIT_LOCK1 = 3'd3;
	localparam SHIFT2 = 3'd4;
	localparam WAIT_SHIFT2 = 3'd5;
	localparam WAIT_LOCK2 = 3'd6;
	localparam DONE = 3'd7;

	

	always @(posedge system_clk or negedge rst_n) begin
		if (~rst_n) begin
			// reset
			state <= IDLE;
		end
		else begin
			state <= nextstate;
		end
	end

	always @ (*) begin
		ps_en2 = 0;
		ps_en1 = 0;
		jitter_shift_done = 0;
		nextstate = state;
		case(state)
			IDLE:begin
				ps_en1 = 0;
				jitter_shift_done = 0;
				if(jitter_shift) begin
					nextstate = SHIFT1;
				end
			end
			SHIFT1:begin
				ps_en1 = 1;
				jitter_shift_done = 0;
				nextstate = WAIT_SHIFT1;
			end
			WAIT_SHIFT1:begin
				jitter_shift_done = 0;
				if(ps_done1) begin
					nextstate = SHIFT2;
				end
			end
			WAIT_LOCK1:begin
				if(locked1) begin
					nextstate = SHIFT2;
				end
			end
			SHIFT2:begin
				ps_en2 = 1;
				jitter_shift_done = 0;
				nextstate = WAIT_SHIFT2;
			end
			WAIT_SHIFT2:begin
				jitter_shift_done = 0;
				if(ps_done2) begin
					nextstate = DONE;
				end
			end
			WAIT_LOCK2:begin
				if(locked2) begin
					nextstate = DONE;
				end
			end
			DONE:begin
				ps_en2 = 0;
				jitter_shift_done = 1;
				if(jitter_shift == 1'b0) begin
					nextstate = IDLE;
				end
			end
			default:begin
				ps_en1 = 0;
				ps_en2 = 0;
				jitter_shift_done = 0;
				nextstate = IDLE;
			end
		endcase
	end

    MMCME3_ADV #(
		.BANDWIDTH("OPTIMIZED"),        // Jitter programming (HIGH, LOW, OPTIMIZED)
		.CLKFBOUT_MULT_F(PLL0_MUL),          // Multiply value for all CLKOUT (2.000-64.000)
		.CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000)
		// CLKIN_PERIOD: Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
		.CLKIN1_PERIOD(CLK_PERIOD),
		.CLKIN2_PERIOD(0.0),
		.CLKOUT0_DIVIDE_F(PLL0_MUL),         // Divide amount for CLKOUT0 (1.000-128.000)
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
		.CLKOUT1_DIVIDE(PLL0_MUL),
		.CLKOUT2_DIVIDE(PLL0_MUL),
		.CLKOUT3_DIVIDE(PLL0_MUL),
		.CLKOUT4_CASCADE("FALSE"),
		.CLKOUT4_DIVIDE(PLL0_MUL),
		.CLKOUT5_DIVIDE(PLL0_MUL),
		.CLKOUT6_DIVIDE(PLL0_MUL),
		.COMPENSATION("AUTO"),          // AUTO, BUF_IN, EXTERNAL, INTERNAL, ZHOLD
		.DIVCLK_DIVIDE(1),              // Master division value (1-106)
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
		.CLKOUT3_USE_FINE_PS("FALSE"),
		.CLKOUT4_USE_FINE_PS("FALSE"),
		.CLKOUT5_USE_FINE_PS("FALSE"),
		.CLKOUT6_USE_FINE_PS("FALSE") 
	)
	MMCME3_ADV_inst_0 (
	// Clock Outputs outputs: User configurable clock outputs
		.CLKOUT0(),           // 1-bit output: CLKOUT0
		.CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(CLKOUT01),           // 1-bit output: Primary clock
		.CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(),           // 1-bit output: CLKOUT2
		.CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
		.CLKOUT3(),           // 1-bit output: CLKOUT3
		.CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
		.CLKOUT4(),           // 1-bit output: CLKOUT4
		.CLKOUT5(),           // 1-bit output: CLKOUT5
		.CLKOUT6(),           // 1-bit output: CLKOUT6
		// Feedback outputs: Clock feedback ports
		.CLKFBIN(CLKFB_IN_0),            // 1-bit input: Feedback clock
		.CLKFBOUT(CLKFB_OUT_0),         // 1-bit output: Feedback clock
		.CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
		// Status Ports outputs: MMCM status ports
		.CDDCDONE(),         // 1-bit output: Clock dynamic divide done
		.CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
		.CLKINSTOPPED(), // 1-bit output: Input clock stopped
		.LOCKED(),             // 1-bit output: LOCK
		.CDDCREQ(1'b0),           // 1-bit input: Request to dynamic divide clock
		// Clock Inputs inputs: Clock inputs
		.CLKIN1(free_run_clk),             // 1-bit input: Primary clock
		.CLKIN2(),             // 1-bit input: Secondary clock
		// Control Ports inputs: MMCM control ports
		.CLKINSEL(1'b1),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
		.PWRDWN(1'b0),             // 1-bit input: Power-down
		// Feedback inputs: Clock feedback ports
		.RST(free_run_rst),                   // 1-bit input: Reset
		// DRP Ports inputs: Dynamic reconfiguration ports
		.DO(),                     // 16-bit output: DRP data
		.DRDY(),                 // 1-bit output: DRP ready
		.DADDR(0),               // 7-bit input: DRP address
		.DCLK(drp_dclk),                 // 1-bit input: DRP clock
		.DEN(1'b0),                   // 1-bit input: DRP enable
		.DI(0),                     // 16-bit input: DRP data
		.DWE(0),                   // 1-bit input: DRP write enable
		// Dynamic Phase Shift Ports inputs: Ports used for dynamic phase shifting of the outputs
		.PSCLK(sample_clk),               // 1-bit input: Phase shift clock
		.PSEN(shift),                 // 1-bit input: Phase shift enable
		.PSINCDEC(1),         // 1-bit input: Phase shift increment/decrement
		.PSDONE(shift_done)             // 1-bit output: Phase shift done
	);

	// BUFG BUFG_CLKOUT00 (
	// 	.O(shifting_clk0), // 1-bit output: Clock output
	// 	.I(CLKOUT00)  // 1-bit input: Clock input
	// );

	BUFG BUFG_CLKOUT01 (
		.O(shifting_clk0), // 1-bit output: Clock output
		.I(CLKOUT01)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKFB_0 (
		.O(CLKFB_IN_0), // 1-bit output: Clock output
		.I(CLKFB_OUT_0)  // 1-bit input: Clock input
	);
	MMCME3_ADV #(
		.BANDWIDTH("OPTIMIZED"),        // Jitter programming (HIGH, LOW, OPTIMIZED)
		.CLKFBOUT_MULT_F(PLL1_MUL),          // Multiply value for all CLKOUT (2.000-64.000)
		.CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000)
		// CLKIN_PERIOD: Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
		.CLKIN1_PERIOD(CLK_PERIOD),
		.CLKIN2_PERIOD(0.0),
		.CLKOUT0_DIVIDE_F(PLL1_MUL),         // Divide amount for CLKOUT0 (1.000-128.000)
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
		.CLKOUT1_DIVIDE(PLL1_MUL),
		.CLKOUT2_DIVIDE(PLL1_MUL),
		.CLKOUT3_DIVIDE(PLL1_MUL),
		.CLKOUT4_CASCADE("FALSE"),
		.CLKOUT4_DIVIDE(PLL1_MUL),
		.CLKOUT5_DIVIDE(PLL1_MUL),
		.CLKOUT6_DIVIDE(PLL1_MUL),
		.COMPENSATION("AUTO"),          // AUTO, BUF_IN, EXTERNAL, INTERNAL, ZHOLD
		.DIVCLK_DIVIDE(1),              // Master division value (1-106)
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
		.SS_MODE("CENTER_LOW"),        // CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
		.SS_MOD_PERIOD(4001),          // Spread spectrum modulation period (ns) (4000-40000)
		// USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
		.CLKFBOUT_USE_FINE_PS("FALSE"),
		.CLKOUT0_USE_FINE_PS("TRUE"),
		.CLKOUT1_USE_FINE_PS("TRUE"),
		.CLKOUT2_USE_FINE_PS("FALSE"),
		.CLKOUT3_USE_FINE_PS("FALSE"),
		.CLKOUT4_USE_FINE_PS("FALSE"),
		.CLKOUT5_USE_FINE_PS("FALSE"),
		.CLKOUT6_USE_FINE_PS("FALSE") 
	)
	MMCME3_ADV_inst_1 (
	// Clock Outputs outputs: User configurable clock outputs
		.CLKOUT0(),           // 1-bit output: CLKOUT0
		.CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(CLKOUT10),           // 1-bit output: Primary clock
		.CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(),           // 1-bit output: CLKOUT2
		.CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
		.CLKOUT3(),           // 1-bit output: CLKOUT3
		.CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
		.CLKOUT4(),           // 1-bit output: CLKOUT4
		.CLKOUT5(),           // 1-bit output: CLKOUT5
		.CLKOUT6(),           // 1-bit output: CLKOUT6
		// Feedback outputs: Clock feedback ports
		.CLKFBIN(CLKFB_IN_1),            // 1-bit input: Feedback clock
		.CLKFBOUT(CLKFB_OUT_1),         // 1-bit output: Feedback clock
		.CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
		// Status Ports outputs: MMCM status ports
		.CDDCDONE(),         // 1-bit output: Clock dynamic divide done
		.CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
		.CLKINSTOPPED(), // 1-bit output: Input clock stopped
		.LOCKED(locked1),             // 1-bit output: LOCK
		.CDDCREQ(1'b0),           // 1-bit input: Request to dynamic divide clock
		// Clock Inputs inputs: Clock inputs
		.CLKIN1(shifting_clk0),             // 1-bit input: Primary clock
		.CLKIN2(),             // 1-bit input: Secondary clock
		// Control Ports inputs: MMCM control ports
		.CLKINSEL(1'b1),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
		.PWRDWN(1'b0),             // 1-bit input: Power-down
		// Feedback inputs: Clock feedback ports
		.RST(free_run_rst),                   // 1-bit input: Reset
		// DRP Ports inputs: Dynamic reconfiguration ports
		.DO(),                     // 16-bit output: DRP data
		.DRDY(),                 // 1-bit output: DRP ready
		.DADDR(0),               // 7-bit input: DRP address
		.DCLK(drp_dclk),                 // 1-bit input: DRP clock
		.DEN(1'b0),                   // 1-bit input: DRP enable
		.DI(0),                     // 16-bit input: DRP data
		.DWE(0),                   // 1-bit input: DRP write enable
		// Dynamic Phase Shift Ports inputs: Ports used for dynamic phase shifting of the outputs
		.PSCLK(system_clk),               // 1-bit input: Phase shift clock
		.PSEN(ps_en1),                 // 1-bit input: Phase shift enable
		.PSINCDEC(~jitter_incdec),         // 1-bit input: Phase shift increment/decrement
		.PSDONE(ps_done1)             // 1-bit output: Phase shift done
	);

	BUFG BUFG_CLKOUT10 (
		.O(shifting_clk2), // 1-bit output: Clock output
		.I(CLKOUT10)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKFB_1 (
		.O(CLKFB_IN_1), // 1-bit output: Clock output
		.I(CLKFB_OUT_1)  // 1-bit input: Clock input
	);


	MMCME3_ADV #(
		.BANDWIDTH("OPTIMIZED"),        // Jitter programming (HIGH, LOW, OPTIMIZED)
		.CLKFBOUT_MULT_F(PLL11_MUL),          // Multiply value for all CLKOUT (2.000-64.000)
		.CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000)
		// CLKIN_PERIOD: Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
		.CLKIN1_PERIOD(CLK_PERIOD),
		.CLKIN2_PERIOD(0.0),
		.CLKOUT0_DIVIDE_F(PLL11_MUL),         // Divide amount for CLKOUT0 (1.000-128.000)
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
		.CLKOUT1_DIVIDE(PLL11_MUL),
		.CLKOUT2_DIVIDE(PLL11_MUL),
		.CLKOUT3_DIVIDE(PLL11_MUL),
		.CLKOUT4_CASCADE("FALSE"),
		.CLKOUT4_DIVIDE(PLL11_MUL),
		.CLKOUT5_DIVIDE(PLL11_MUL),
		.CLKOUT6_DIVIDE(PLL11_MUL),
		.COMPENSATION("AUTO"),          // AUTO, BUF_IN, EXTERNAL, INTERNAL, ZHOLD
		.DIVCLK_DIVIDE(1),              // Master division value (1-106)
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
		.SS_MODE("CENTER_LOW"),        // CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
		.SS_MOD_PERIOD(4001),          // Spread spectrum modulation period (ns) (4000-40000)
		// USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
		.CLKFBOUT_USE_FINE_PS("FALSE"),
		.CLKOUT0_USE_FINE_PS("TRUE"),
		.CLKOUT1_USE_FINE_PS("TRUE"),
		.CLKOUT2_USE_FINE_PS("FALSE"),
		.CLKOUT3_USE_FINE_PS("FALSE"),
		.CLKOUT4_USE_FINE_PS("FALSE"),
		.CLKOUT5_USE_FINE_PS("FALSE"),
		.CLKOUT6_USE_FINE_PS("FALSE") 
	)
	MMCME3_ADV_inst_11 (
	// Clock Outputs outputs: User configurable clock outputs
		.CLKOUT0(CLKOUT110),           // 1-bit output: CLKOUT0
		.CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(),           // 1-bit output: Primary clock
		.CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(),           // 1-bit output: CLKOUT2
		.CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
		.CLKOUT3(),           // 1-bit output: CLKOUT3
		.CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
		.CLKOUT4(),           // 1-bit output: CLKOUT4
		.CLKOUT5(),           // 1-bit output: CLKOUT5
		.CLKOUT6(),           // 1-bit output: CLKOUT6
		// Feedback outputs: Clock feedback ports
		.CLKFBIN(CLKFB_IN_11),            // 1-bit input: Feedback clock
		.CLKFBOUT(CLKFB_OUT_11),         // 1-bit output: Feedback clock
		.CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
		// Status Ports outputs: MMCM status ports
		.CDDCDONE(),         // 1-bit output: Clock dynamic divide done
		.CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
		.CLKINSTOPPED(), // 1-bit output: Input clock stopped
		.LOCKED(locked2),             // 1-bit output: LOCK
		.CDDCREQ(1'b0),           // 1-bit input: Request to dynamic divide clock
		// Clock Inputs inputs: Clock inputs
		.CLKIN1(shifting_clk2),             // 1-bit input: Primary clock
		.CLKIN2(),             // 1-bit input: Secondary clock
		// Control Ports inputs: MMCM control ports
		.CLKINSEL(1'b1),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
		.PWRDWN(1'b0),             // 1-bit input: Power-down
		// Feedback inputs: Clock feedback ports
		.RST(free_run_rst),                   // 1-bit input: Reset
		// DRP Ports inputs: Dynamic reconfiguration ports
		.DO(),                     // 16-bit output: DRP data
		.DRDY(),                 // 1-bit output: DRP ready
		.DADDR(0),               // 7-bit input: DRP address
		.DCLK(drp_dclk),                 // 1-bit input: DRP clock
		.DEN(1'b0),                   // 1-bit input: DRP enable
		.DI(0),                     // 16-bit input: DRP data
		.DWE(0),                   // 1-bit input: DRP write enable
		// Dynamic Phase Shift Ports inputs: Ports used for dynamic phase shifting of the outputs
		.PSCLK(system_clk),               // 1-bit input: Phase shift clock
		.PSEN(ps_en2),                 // 1-bit input: Phase shift enable
		.PSINCDEC(jitter_incdec),         // 1-bit input: Phase shift increment/decrement
		.PSDONE(ps_done2)             // 1-bit output: Phase shift done
	);

	BUFG BUFG_CLKOUT110 (
		.O(jitter_clk), // 1-bit output: Clock output
		.I(CLKOUT110)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKFB_11 (
		.O(CLKFB_IN_11), // 1-bit output: Clock output
		.I(CLKFB_OUT_11)  // 1-bit input: Clock input
	);


	MMCME3_ADV #(
		.BANDWIDTH("OPTIMIZED"),        // Jitter programming (HIGH, LOW, OPTIMIZED)
		.CLKFBOUT_MULT_F(PLL2_MUL),          // Multiply value for all CLKOUT (2.000-64.000)
		.CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000)
		// CLKIN_PERIOD: Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
		.CLKIN1_PERIOD(CLK_PERIOD),
		.CLKIN2_PERIOD(0.0),
		.CLKOUT0_DIVIDE_F(43.125),         // Divide amount for CLKOUT0 (1.000-128.000)
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
		.CLKOUT1_DIVIDE(PLL2_MUL),
		.CLKOUT2_DIVIDE(PLL2_MUL),
		.CLKOUT3_DIVIDE(PLL2_MUL),
		.CLKOUT4_CASCADE("FALSE"),
		.CLKOUT4_DIVIDE(PLL2_MUL),
		.CLKOUT5_DIVIDE(PLL2_MUL),
		.CLKOUT6_DIVIDE(PLL2_MUL),
		.COMPENSATION("AUTO"),          // AUTO, BUF_IN, EXTERNAL, INTERNAL, ZHOLD
		.DIVCLK_DIVIDE(1),              // Master division value (1-106)
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
		.CLKOUT1_USE_FINE_PS("FALSE"),
		.CLKOUT2_USE_FINE_PS("FALSE"),
		.CLKOUT3_USE_FINE_PS("FALSE"),
		.CLKOUT4_USE_FINE_PS("FALSE"),
		.CLKOUT5_USE_FINE_PS("FALSE"),
		.CLKOUT6_USE_FINE_PS("FALSE") 
	)
	MMCME3_ADV_inst_2 (
	// Clock Outputs outputs: User configurable clock outputs
		.CLKOUT0(CLKOUT20),           // 1-bit output: CLKOUT0
		.CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(CLKOUT21),           // 1-bit output: Primary clock
		.CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(),           // 1-bit output: CLKOUT2
		.CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
		.CLKOUT3(),           // 1-bit output: CLKOUT3
		.CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
		.CLKOUT4(),           // 1-bit output: CLKOUT4
		.CLKOUT5(),           // 1-bit output: CLKOUT5
		.CLKOUT6(),           // 1-bit output: CLKOUT6
		// Feedback outputs: Clock feedback ports
		.CLKFBIN(CLKFB_IN_2),            // 1-bit input: Feedback clock
		.CLKFBOUT(CLKFB_OUT_2),         // 1-bit output: Feedback clock
		.CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
		// Status Ports outputs: MMCM status ports
		.CDDCDONE(),         // 1-bit output: Clock dynamic divide done
		.CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
		.CLKINSTOPPED(), // 1-bit output: Input clock stopped
		.LOCKED(),             // 1-bit output: LOCK
		.CDDCREQ(1'b0),           // 1-bit input: Request to dynamic divide clock
		// Clock Inputs inputs: Clock inputs
		.CLKIN1(shifting_clk0),             // 1-bit input: Primary clock
		.CLKIN2(),             // 1-bit input: Secondary clock
		// Control Ports inputs: MMCM control ports
		.CLKINSEL(1'b1),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
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
		.PSCLK(sample_clk),               // 1-bit input: Phase shift clock
		.PSEN(1'b0),                 // 1-bit input: Phase shift enable
		.PSINCDEC(1),         // 1-bit input: Phase shift increment/decrement
		.PSDONE()             // 1-bit output: Phase shift done
	);

	BUFG BUFG_CLKOUT20 (
		.O(swing_clk), // 1-bit output: Clock output
		.I(CLKOUT20)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKOUT21 (
		.O(sample_clk), // 1-bit output: Clock output
		.I(CLKOUT21)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKFB_2 (
		.O(CLKFB_IN_2), // 1-bit output: Clock output
		.I(CLKFB_OUT_2)  // 1-bit input: Clock input
	);
	MMCME3_ADV #(
		.BANDWIDTH("OPTIMIZED"),        // Jitter programming (HIGH, LOW, OPTIMIZED)
		.CLKFBOUT_MULT_F(PLL1_MUL),          // Multiply value for all CLKOUT (2.000-64.000)
		.CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000)
		// CLKIN_PERIOD: Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
		.CLKIN1_PERIOD(CLK_PERIOD),
		.CLKIN2_PERIOD(0.0),
		.CLKOUT0_DIVIDE_F(9.875),         // Divide amount for CLKOUT0 (1.000-128.000)
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
		.CLKOUT1_DIVIDE(PLL1_MUL),
		.CLKOUT2_DIVIDE(PLL1_MUL),
		.CLKOUT3_DIVIDE(PLL1_MUL),
		.CLKOUT4_CASCADE("FALSE"),
		.CLKOUT4_DIVIDE(PLL1_MUL),
		.CLKOUT5_DIVIDE(PLL1_MUL),
		.CLKOUT6_DIVIDE(PLL1_MUL),
		.COMPENSATION("AUTO"),          // AUTO, BUF_IN, EXTERNAL, INTERNAL, ZHOLD
		.DIVCLK_DIVIDE(1),              // Master division value (1-106)
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
		.SS_MODE("DOWN_HIGH"),        // CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
		.SS_MOD_PERIOD(5400),          // Spread spectrum modulation period (ns) (4000-40000)
		// USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
		.CLKFBOUT_USE_FINE_PS("FALSE"),
		.CLKOUT0_USE_FINE_PS("FALSE"),
		.CLKOUT1_USE_FINE_PS("FALSE"),
		.CLKOUT2_USE_FINE_PS("FALSE"),
		.CLKOUT3_USE_FINE_PS("FALSE"),
		.CLKOUT4_USE_FINE_PS("FALSE"),
		.CLKOUT5_USE_FINE_PS("FALSE"),
		.CLKOUT6_USE_FINE_PS("FALSE") 
	)
	MMCME3_ADV_inst_3 (
	// Clock Outputs outputs: User configurable clock outputs
		.CLKOUT0(CLKOUT30),           // 1-bit output: CLKOUT0
		.CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(t_p),           // 1-bit output: Primary clock
		.CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(),           // 1-bit output: CLKOUT2
		.CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
		.CLKOUT3(),           // 1-bit output: CLKOUT3
		.CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
		.CLKOUT4(),           // 1-bit output: CLKOUT4
		.CLKOUT5(),           // 1-bit output: CLKOUT5
		.CLKOUT6(),           // 1-bit output: CLKOUT6
		// Feedback outputs: Clock feedback ports
		.CLKFBIN(CLKFB_IN_3),            // 1-bit input: Feedback clock
		.CLKFBOUT(CLKFB_OUT_3),         // 1-bit output: Feedback clock
		.CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
		// Status Ports outputs: MMCM status ports
		.CDDCDONE(),         // 1-bit output: Clock dynamic divide done
		.CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
		.CLKINSTOPPED(), // 1-bit output: Input clock stopped
		.LOCKED(),             // 1-bit output: LOCK
		.CDDCREQ(1'b0),           // 1-bit input: Request to dynamic divide clock
		// Clock Inputs inputs: Clock inputs
		.CLKIN1(free_run_clk),             // 1-bit input: Primary clock
		.CLKIN2(),             // 1-bit input: Secondary clock
		// Control Ports inputs: MMCM control ports
		.CLKINSEL(1'b1),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
		.PWRDWN(1'b0),             // 1-bit input: Power-down
		// Feedback inputs: Clock feedback ports
		.RST(free_run_rst),                   // 1-bit input: Reset
		// DRP Ports inputs: Dynamic reconfiguration ports
		.DO(),                     // 16-bit output: DRP data
		.DRDY(),                 // 1-bit output: DRP ready
		.DADDR(0),               // 7-bit input: DRP address
		.DCLK(drp_dclk),                 // 1-bit input: DRP clock
		.DEN(1'b0),                   // 1-bit input: DRP enable
		.DI(0),                     // 16-bit input: DRP data
		.DWE(0),                   // 1-bit input: DRP write enable
		// Dynamic Phase Shift Ports inputs: Ports used for dynamic phase shifting of the outputs
		.PSCLK(sample_clk),               // 1-bit input: Phase shift clock
		.PSEN(1'b0),                 // 1-bit input: Phase shift enable
		.PSINCDEC(1),         // 1-bit input: Phase shift increment/decrement
		.PSDONE()             // 1-bit output: Phase shift done
	);

	// BUFG BUFG_CLKOUT00 (
	// 	.O(shifting_clk0), // 1-bit output: Clock output
	// 	.I(CLKOUT00)  // 1-bit input: Clock input
	// );

	BUFG BUFG_CLKOUT30 (
		.O(system_clk), // 1-bit output: Clock output
		.I(CLKOUT30)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKFB_3 (
		.O(CLKFB_IN_3), // 1-bit output: Clock output
		.I(CLKFB_OUT_3)  // 1-bit input: Clock input
	);
	assign t_n = ~t_p;
	assign t_n1 = ~t_n;
	assign t_n2 = ~t_n1;
	assign trigger_clk = t_p & t_n2;
endmodule
