`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2019 09:53:27 AM
// Design Name: 
// Module Name: Auto_ETS
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


module Auto_ETS#(
	parameter CLK_SW = 1,
	parameter CLK_IN_PEO = 6.4,
	parameter integer VCO_MUL = 10,
	parameter integer VCO_DIV = 1,
	parameter FIXED_DIV = 11,
	parameter SWING_DIV = 40,

	parameter IMP_DIV = 11.125,

	parameter integer C_S_AXI_DATA_WIDTH	= 32,
	parameter integer C_S_AXI_ADDR_WIDTH	= 6,
	parameter ADDR_WIDTH       = 10,                
	parameter DATA_WIDTH       = 32,
	parameter S_AXI_ADDR_WIDTH     = 12,               
	parameter S_AXI_DATA_WIDTH     = 32,
	parameter IMP_PHASE = 0.091
	)(

	input free_run_clk,
	output shifting_clk,
	output system_clk,
	output triger,

	output swing_clk,

	output [31:0] gth_data,

 	input                             S_AXI_DATA_REF_aclk,
    input                             S_AXI_DATA_REF_aresetn,

    input  [S_AXI_ADDR_WIDTH-1:0]     S_AXI_DATA_REF_araddr,
    output 	                          S_AXI_DATA_REF_arready,
    input                             S_AXI_DATA_REF_arvalid,
    input  [2:0]                      S_AXI_DATA_REF_arprot,

    input [S_AXI_ADDR_WIDTH-1:0]      S_AXI_DATA_REF_awaddr,
    output 	                          S_AXI_DATA_REF_awready,
    input                             S_AXI_DATA_REF_awvalid,
    input  [2:0]                      S_AXI_DATA_REF_awprot,

    output  [1:0]                     S_AXI_DATA_REF_bresp,  
    input                             S_AXI_DATA_REF_bready,
    output 	                          S_AXI_DATA_REF_bvalid,

    output 	   [S_AXI_DATA_WIDTH-1:0] S_AXI_DATA_REF_rdata,
    input                             S_AXI_DATA_REF_rready,
    output 	                          S_AXI_DATA_REF_rvalid,
    output  [1:0]                     S_AXI_DATA_REF_rresp,

    input  [S_AXI_DATA_WIDTH-1:0]     S_AXI_DATA_REF_wdata,
    output                            S_AXI_DATA_REF_wready,
    input                             S_AXI_DATA_REF_wvalid,
    input  [S_AXI_DATA_WIDTH/8-1:0]   S_AXI_DATA_REF_wstrb,


	input CMP_DATA_ref,
	input CMP_DATA_S11,
	input CMP_DATA_S21,

	input [6:0] drp_daddr,
    input [15:0] drp_di,
    output [15:0] drp_do,
    input drp_den,
    input drp_dwe,
    output drp_drdy,
    input drp_dclk,

   
    input wire  S_AXI_ACLK,
	input wire  S_AXI_ARESETN,
	input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
	input wire [2 : 0] S_AXI_AWPROT,
	input wire  S_AXI_AWVALID,
	output wire  S_AXI_AWREADY,
	input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
	input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
	input wire  S_AXI_WVALID,
	output wire  S_AXI_WREADY,
	output wire [1 : 0] S_AXI_BRESP,
	output wire  S_AXI_BVALID,
	input wire  S_AXI_BREADY,
	input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
	input wire [2 : 0] S_AXI_ARPROT,
	input wire  S_AXI_ARVALID,
	output wire  S_AXI_ARREADY,
	output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// read transfer.
	output wire [1 : 0] S_AXI_RRESP,
	output wire  S_AXI_RVALID,
	input wire  S_AXI_RREADY
    );
	
	wire triger_imp;
	wire triger_squ;

	wire [9:0] w_addr_ref,r_addr_ref;
	wire w_occur_ref,r_occur_ref;
	wire w_ready_ref,r_valid_ref;
	wire [31:0] w_data_ref,r_data_ref;

	wire [15:0] A_ref;
	wire [7:0] T_ref;
	wire [1:0] switcher;
	reg data_in;

	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire0;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire1;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire2;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire3;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire4;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire5;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire6;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire7;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire8;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire9;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire10;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_wire11;



	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg0;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg1;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg2;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg3;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg4;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg5;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg6;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg7;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg8;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg9;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg10;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg11;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg12;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg13;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg14;
	wire [C_S_AXI_DATA_WIDTH-1 : 0] slv_reg15;


	assign en_auto = slv_reg0[0];
	assign switcher = slv_reg1[1:0];
	assign T_ref = slv_reg2[15:0];
	assign gth_data = slv_reg3;
	wire ps_en;
    wire ps_incdec;
    wire ps_clk;
    wire ps_done;

    always @ (shifting_clk) begin
    	case(switcher)
    		2'b00: begin
    			data_in <= CMP_DATA_ref;
    		end
    		2'b01: begin
    			data_in <= CMP_DATA_S11;
    		end
    		2'b10: begin
    			data_in <= CMP_DATA_S21;
    		end
    		2'b11: begin
    			data_in <= CMP_DATA_ref;
    		end
    	endcase
    end


	ETS_System inst_ETS_System(
			.shifting_clk (shifting_clk),
			.sys_clk      (S_AXI_ACLK),
			.reset        (~S_AXI_ARESETN),
			.ps_en        (ps_en),
			.ps_incdec    (ps_incdec),
			.ps_clk       (ps_clk),
			.ps_done      (ps_done),
			.en           (en_auto),
			.CMP_DATA_ref (data_in),
			.T_ref        (T_ref),
			.A_ref        (A_ref),
			.waddr_ref    (w_addr_ref),
			.raddr_ref    (r_addr_ref),
			.rdata_ref    (r_data_ref),
			.w_occur_ref  (w_occur_ref),
			.r_occur_ref  (r_occur_ref),
			.w_ready_ref  (w_ready_ref),
			.r_valid_ref  (r_valid_ref)
		);

	AXI_Interface #(
			.ADDR_WIDTH(ADDR_WIDTH),
			.DATA_WIDTH(DATA_WIDTH),
			.S_AXI_ADDR_WIDTH(S_AXI_ADDR_WIDTH),
			.S_AXI_DATA_WIDTH(S_AXI_DATA_WIDTH)
		) inst_AXI_Interface_ref (
			.S_AXI_aclk    (S_AXI_DATA_REF_aclk),
			.S_AXI_aresetn (S_AXI_DATA_REF_aresetn),
			.S_AXI_araddr  (S_AXI_DATA_REF_araddr),
			.S_AXI_arready (S_AXI_DATA_REF_arready),
			.S_AXI_arvalid (S_AXI_DATA_REF_arvalid),
			.S_AXI_arprot  (S_AXI_DATA_REF_arprot),
			.S_AXI_awaddr  (S_AXI_DATA_REF_awaddr),
			.S_AXI_awready (S_AXI_DATA_REF_awready),
			.S_AXI_awvalid (S_AXI_DATA_REF_awvalid),
			.S_AXI_awprot  (S_AXI_DATA_REF_awprot),
			.S_AXI_bresp   (S_AXI_DATA_REF_bresp),
			.S_AXI_bready  (S_AXI_DATA_REF_bready),
			.S_AXI_bvalid  (S_AXI_DATA_REF_bvalid),
			.S_AXI_rdata   (S_AXI_DATA_REF_rdata),
			.S_AXI_rready  (S_AXI_DATA_REF_rready),
			.S_AXI_rvalid  (S_AXI_DATA_REF_rvalid),
			.S_AXI_rresp   (S_AXI_DATA_REF_rresp),
			.S_AXI_wdata   (S_AXI_DATA_REF_wdata),
			.S_AXI_wready  (S_AXI_DATA_REF_wready),
			.S_AXI_wvalid  (S_AXI_DATA_REF_wvalid),
			.S_AXI_wstrb   (S_AXI_DATA_REF_wstrb),
			.w_addr        (w_addr_ref),
			.r_addr        (r_addr_ref),
			.w_data        (w_data_ref),
			.r_data        (r_data_ref),
			.w_occur       (w_occur_ref),
			.r_occur       (r_occur_ref),
			.w_ready       (w_ready_ref),
			.r_valid       (r_valid_ref)
		);

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
			.slv_wire4     ({16'd0,A_ref}),
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

	wire CLKOUT0;
	wire CLKOUT1;
	wire CLKOUT2;
	wire CLKOUT3;
	wire CLKOUT4;
	wire CLKOUT5;
	wire CLKFB_IN,CLKFB_OUT;

	MMCME3_ADV #(
		.BANDWIDTH("OPTIMIZED"),        // Jitter programming (HIGH, LOW, OPTIMIZED)
		.CLKFBOUT_MULT_F(VCO_MUL),          // Multiply value for all CLKOUT (2.000-64.000)
		.CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB (-360.000-360.000)
		// CLKIN_PERIOD: Input clock period in ns units, ps resolution (i.e. 33.333 is 30 MHz).
		.CLKIN1_PERIOD(CLK_IN_PEO),
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
		.CLKOUT1_DIVIDE(FIXED_DIV),
		.CLKOUT2_DIVIDE(FIXED_DIV),
		.CLKOUT3_DIVIDE(FIXED_DIV),
		.CLKOUT4_CASCADE("FALSE"),
		.CLKOUT4_DIVIDE(FIXED_DIV),
		.CLKOUT5_DIVIDE(FIXED_DIV),
		.CLKOUT6_DIVIDE(FIXED_DIV),
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
		.CLKOUT1_USE_FINE_PS("FALSE"),
		.CLKOUT2_USE_FINE_PS("FALSE"),
		.CLKOUT3_USE_FINE_PS("TRUE"),
		.CLKOUT4_USE_FINE_PS("FALSE"),
		.CLKOUT5_USE_FINE_PS("FALSE"),
		.CLKOUT6_USE_FINE_PS("FALSE") 
	)
	MMCME3_ADV_inst (
	// Clock Outputs outputs: User configurable clock outputs
		.CLKOUT0(CLKOUT0),           // 1-bit output: CLKOUT0
		.CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
		.CLKOUT1(CLKOUT1),           // 1-bit output: Primary clock
		.CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
		.CLKOUT2(CLKOUT2),           // 1-bit output: CLKOUT2
		.CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
		.CLKOUT3(CLKOUT3),           // 1-bit output: CLKOUT3
		.CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
		.CLKOUT4(CLKOUT4),           // 1-bit output: CLKOUT4
		.CLKOUT5(CLKOUT5),           // 1-bit output: CLKOUT5
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
		.CLKIN1(free_run_clk),             // 1-bit input: Primary clock
		.CLKIN2(),             // 1-bit input: Secondary clock
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

	BUFG BUFG_CLKOUT0_swing_clk (
		.O(swing_clk), // 1-bit output: Clock output
		.I(CLKOUT0)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKOUT1_system (
		.O(system_clk), // 1-bit output: Clock output
		.I(CLKOUT1)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKOUT2_shifing (
		.O(shifting_clk), // 1-bit output: Clock output
		.I(CLKOUT2)  // 1-bit input: Clock input
	);

	BUFG BUFG_CLKOUT3_imp (
		.O(triger), // 1-bit output: Clock output
		.I(CLKOUT3)  // 1-bit input: Clock input
	);


	BUFG BUFG_CLKFB (
		.O(CLKFB_IN), // 1-bit output: Clock output
		.I(CLKFB_OUT)  // 1-bit input: Clock input
	);
endmodule
