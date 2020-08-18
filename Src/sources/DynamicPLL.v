`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2020 11:38:04 AM
// Design Name: 
// Module Name: DynamicPLL
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


module DynamicPLL#
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 6
	)(

    );
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
	wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;

	AXI_LITE_CODE_v1_0_S__AXIL #(
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
	) inst_AXI_LITE_CODE_v1_0_S__AXIL (
		.slv_reg0      (slv_reg0),
		.slv_reg1      (slv_reg1),
		.slv_reg2      (slv_reg2),
		.slv_reg3      (slv_reg3),
		.slv_reg4      (slv_reg4),
		.slv_reg5      (slv_reg5),
		.slv_reg6      (slv_reg6),
		.slv_reg7      (slv_reg7),
		.slv_reg8      (slv_reg8),
		.slv_reg9      (slv_reg9),
		.slv_reg10     (slv_reg10),
		.slv_reg11     (slv_reg11),
		.slv_reg12     (slv_reg12),
		.slv_reg13     (slv_reg13),
		.slv_reg14     (slv_reg14),
		.slv_reg15     (slv_reg15),
		.slv_wire0     (slv_reg0),
		.slv_wire1     (slv_reg1),
		.slv_wire2     (slv_reg2),
		.slv_wire3     (slv_reg3),
		.slv_wire4     (slv_reg4),
		.slv_wire5     (slv_reg5),
		.slv_wire6     (slv_reg6),
		.slv_wire7     (slv_reg7),
		.slv_wire8     (slv_reg8),
		.slv_wire9     (slv_reg9),
		.slv_wire10    (slv_reg10),
		.slv_wire11    (slv_reg11),
		.slv_wire12    (slv_reg12),
		.slv_wire13    (slv_reg13),
		.slv_wire14    (slv_reg14),
		.slv_wire15    (slv_reg15),
		.S_AXI_ACLK    (S_AXI_ACLK),
		.S_AXI_ARESETN (S_AXI_ARESETN),
		.S_AXI_AWADDR  (S_AXI_AWADDR),
		.S_AXI_AWPROT  (S_AXI_AWPROT),
		.S_AXI_AWVALID (S_AXI_AWVALID),
		.S_AXI_AWREADY (S_AXI_AWREADY),
		.S_AXI_WDATA   (S_AXI_WDATA),
		.S_AXI_WSTRB   (S_AXI_WSTRB),
		.S_AXI_WVALID  (S_AXI_WVALID),
		.S_AXI_WREADY  (S_AXI_WREADY),
		.S_AXI_BRESP   (S_AXI_BRESP),
		.S_AXI_BVALID  (S_AXI_BVALID),
		.S_AXI_BREADY  (S_AXI_BREADY),
		.S_AXI_ARADDR  (S_AXI_ARADDR),
		.S_AXI_ARPROT  (S_AXI_ARPROT),
		.S_AXI_ARVALID (S_AXI_ARVALID),
		.S_AXI_ARREADY (S_AXI_ARREADY),
		.S_AXI_RDATA   (S_AXI_RDATA),
		.S_AXI_RRESP   (S_AXI_RRESP),
		.S_AXI_RVALID  (S_AXI_RVALID),
		.S_AXI_RREADY  (S_AXI_RREADY)
	);

	reg [1:0] state,nextstate;
	reg ps_en;
	wire ps_incdec;
	wire ps_done;
	reg done;

    localparam IDLE = 2'd0;
	localparam SHIFT = 2'd1;
	localparam WAIT_SHIFT = 2'd2;
	localparam DONE = 2'd3;

	

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
		ps_en = 0;
		done = 0;
		nextstate = state;
		case(state)
			IDLE:begin
				ps_en = 0;
				done = 0;
				if(shift) begin
					nextstate = SHIFT;
				end
			end
			SHIFT:begin
				ps_en = 1;
				done = 0;
				nextstate = WAIT_SHIFT;
			end
			WAIT_SHIFT:begin
				done = 0;
				if(ps_done) begin
					nextstate = DONE;
				end
			end
			DONE:begin
				ps_en = 0;
				done = 1;
				if(shift == 1'b0) begin
					nextstate = IDLE;
				end
			end
			default:begin
				ps_en = 0;
				done = 0;
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
		.CLKOUT0(CLKOUT00),           // 1-bit output: CLKOUT0
		.CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(CLKOUT01),           // 1-bit output: Primary clock
		.CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(CLKOUT02),           // 1-bit output: CLKOUT2
		.CLKOUT2B(CLKOUT02B),         // 1-bit output: Inverted CLKOUT2
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
	BUFG BUFG_CLKOUT00 (
		.O(system_clk), // 1-bit output: Clock output
		.I(CLKOUT00)  // 1-bit input: Clock input
	);
	BUFG BUFG_CLKOUT01 (
		.O(shifting_clk0), // 1-bit output: Clock output
		.I(CLKOUT01)  // 1-bit input: Clock input
	);
	BUFG BUFG_CLKOUT02 (
		.O(delay1), // 1-bit output: Clock output
		.I(CLKOUT02)  // 1-bit input: Clock input
	);
	assign delay2 = ~delay1;
	assign trigger_long = ~delay2;
	assign trigger_short = CLKOUT02B;
	BUFG BUFG_CLKFB_0 (
		.O(CLKFB_IN_0), // 1-bit output: Clock output
		.I(CLKFB_OUT_0)  // 1-bit input: Clock input
	);

endmodule
