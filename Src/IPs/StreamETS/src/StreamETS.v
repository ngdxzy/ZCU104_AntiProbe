`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2020 11:56:16 AM
// Design Name: 
// Module Name: StreamETS
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


module StreamETS#(	
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 6,
		parameter CLK_PERIOD = 10.000
	)(
		(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 free_run_clk CLK" *)
		(* X_INTERFACE_PARAMETER = "FREQ_HZ 100000000" *)
		input free_run_clk,
		input rst_n,
		(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 system_clk CLK" *)
		(* X_INTERFACE_PARAMETER = "FREQ_HZ 100000000" *)
		output system_clk,
		(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 sample_clk CLK" *)
		(* X_INTERFACE_PARAMETER = "FREQ_HZ 100000000" *)
		output sample_clk,
		(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 swing_clk CLK" *)
		(* X_INTERFACE_PARAMETER = "FREQ_HZ 23188000" *)
		output swing_clk,
		output reg [79:0] GTH_DATA,

		input cmp_data,
		(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M_AXIS_aclk CLK" *)
		(* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF M_AXIS ASSOCIATED_RESET M_AXIS_aresetn, FREQ_HZ 100000000" *)
		input M_AXIS_aclk,
		input M_AXIS_aresetn,

		input wire M_AXIS_tready,
		output wire M_AXIS_tvalid,
		output wire M_AXIS_tlast,
		output [31:0] M_AXIS_tdata,
		output [3:0] M_AXIS_tkeep,

		input [15:0] drp_di,
		input drp_dclk,
		input drp_den,
		input drp_dwe,
		input [6:0] drp_daddr,
		output [15:0] drp_do,
		output drp_drdy,



		(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK" *)
		(* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF S_AXI ASSOCIATED_RESET S_AXI_ARESETN, FREQ_HZ 100000000" *)
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
		output wire [1 : 0] S_AXI_RRESP,
		output wire  S_AXI_RVALID,
		input wire  S_AXI_RREADY
    );
	assign M_AXIS_tkeep = 4'b1111;
    wire [31:0] ets_data_out;
    wire ets_valid;
    wire ets_ready;
    wire ets_tlast;
    wire shift;
    wire shift_done;

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
	wire start = slv_reg0[0];
	wire [31:0] VernierQ = slv_reg1;
	wire [31:0] gth_data_phase_0 = slv_reg2;
	wire [31:0] gth_data_phase_1 = slv_reg3;
	wire [31:0] gth_data_phase_2 = slv_reg4;
	wire [31:0] gth_data_phase_3 = slv_reg5;
	wire [31:0] gth_data_phase_4 = slv_reg6;
	wire [31:0] gth_data_phase_5 = slv_reg7;
	wire [31:0] gth_data_phase_6 = slv_reg8;
	wire [31:0] gth_data_phase_7 = slv_reg9;
	wire [31:0] gth_data_phase_8 = slv_reg10;
	wire [31:0] gth_data_phase_9 = slv_reg11;

	reg [3:0] counter;
	always @(posedge system_clk or negedge rst_n) begin
		if (~rst_n) begin
			counter <= 0;
		end
		else if (counter < 9) begin
			counter <= counter + 1;
		end
		else begin
			counter <= 0;
		end
	end

	always @ (*) begin
		case(counter)
			4'd0: begin GTH_DATA = {gth_data_phase_0,48'd0}; end
			4'd1: begin GTH_DATA = {gth_data_phase_1,48'd0}; end
			4'd2: begin GTH_DATA = {gth_data_phase_2,48'd0}; end
			4'd3: begin GTH_DATA = {gth_data_phase_3,48'd0}; end
			4'd4: begin GTH_DATA = {gth_data_phase_4,48'd0}; end
			4'd5: begin GTH_DATA = {gth_data_phase_5,48'd0}; end
			4'd6: begin GTH_DATA = {gth_data_phase_6,48'd0}; end
			4'd7: begin GTH_DATA = {gth_data_phase_7,48'd0}; end
			4'd8: begin GTH_DATA = {gth_data_phase_8,48'd0}; end
			4'd9: begin GTH_DATA = {gth_data_phase_9,48'd0}; end
			default: begin
				GTH_DATA = 0;
			end
		endcase
	end

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
	ETS_System inst_ETS_System(
		.sample_clk (sample_clk),
		.rst_n      (rst_n),
		.cmp_data   (cmp_data),
		.VernierQ   (VernierQ),
		.valid      (ets_valid),
		.ready      (ets_ready),
		.data_out   (ets_data_out),
		.tlast      (ets_tlast),
		.start      (start),
		.shift      (shift),
		.shift_done (shift_done)
	);

	axis_cdc_fifo inst_axis_cdc_fifo (
	  .s_axis_aresetn(rst_n),  // input wire s_axis_aresetn
	  .s_axis_aclk(sample_clk),        // input wire s_axis_aclk
	  .s_axis_tvalid(ets_valid),    // input wire s_axis_tvalid
	  .s_axis_tready(ets_ready),    // output wire s_axis_tready
	  .s_axis_tdata(ets_data_out),      // input wire [31 : 0] s_axis_tdata
	  .s_axis_tlast(ets_tlast),      // input wire s_axis_tlast
	  .m_axis_aclk(M_AXIS_aclk),        // input wire m_axis_aclk
	  .m_axis_tvalid(M_AXIS_tvalid),    // output wire m_axis_tvalid
	  .m_axis_tready(M_AXIS_tready),    // input wire m_axis_tready
	  .m_axis_tdata(M_AXIS_tdata),      // output wire [31 : 0] m_axis_tdata
	  .m_axis_tlast(M_AXIS_tlast)      // output wire m_axis_tlast
	);
	ClockSources #(
		.CLK_PERIOD(CLK_PERIOD)
	) inst_ClockSources (
		.free_run_clk (free_run_clk),
		.rst_n        (rst_n),
		.shift        (shift),
		.shift_done   (shift_done),
		.system_clk   (system_clk),
		.sample_clk   (sample_clk),
		.swing_clk    (swing_clk),
		.drp_di       (drp_di),
		.drp_dclk     (drp_dclk),
		.drp_den      (drp_den),
		.drp_dwe      (drp_dwe),
		.drp_daddr    (drp_daddr),
		.drp_do       (drp_do),
		.drp_drdy     (drp_drdy)
	);

endmodule
