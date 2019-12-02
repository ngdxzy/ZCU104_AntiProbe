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
	parameter integer C_S_AXI_DATA_WIDTH	= 32,
	parameter integer C_S_AXI_ADDR_WIDTH	= 6,
	parameter ADDR_WIDTH       = 9,                
	parameter DATA_WIDTH       = 32,
	parameter S_AXI_ADDR_WIDTH     = 11,               
	parameter S_AXI_DATA_WIDTH     = 32
	)(
	input shifting_clk,

 	input                             S_AXI_DATA_aclk,
    input                             S_AXI_DATA_aresetn,

    input  [S_AXI_ADDR_WIDTH-1:0]     S_AXI_DATA_araddr,
    output 	                          S_AXI_DATA_arready,
    input                             S_AXI_DATA_arvalid,
    input  [2:0]                      S_AXI_DATA_arprot,

    input [S_AXI_ADDR_WIDTH-1:0]      S_AXI_DATA_awaddr,
    output 	                          S_AXI_DATA_awready,
    input                             S_AXI_DATA_awvalid,
    input  [2:0]                      S_AXI_DATA_awprot,

    output  [1:0]                     S_AXI_DATA_bresp,  
    input                             S_AXI_DATA_bready,
    output 	                          S_AXI_DATA_bvalid,

    output 	   [S_AXI_DATA_WIDTH-1:0] S_AXI_DATA_rdata,
    input                             S_AXI_DATA_rready,
    output 	                          S_AXI_DATA_rvalid,
    output  [1:0]                     S_AXI_DATA_rresp,

    input  [S_AXI_DATA_WIDTH-1:0]     S_AXI_DATA_wdata,
    output                            S_AXI_DATA_wready,
    input                             S_AXI_DATA_wvalid,
    input  [S_AXI_DATA_WIDTH/8-1:0]   S_AXI_DATA_wstrb,


	input CMP_DATA,
	output [31:0] GTH_DATA,
    output ps_en,
    output ps_incdec,
    output ps_clk,
    input ps_done,
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
	input wire  S_AXI_RREADY,
	output reg tri_data
    );
	
	wire [8:0] w_addr,r_addr;
	wire w_occur,r_occur;
	wire w_ready,r_valid;
	wire [31:0] w_data,r_data;

	wire [31:0] data_0;
	wire [31:0] data_1;
	wire [31:0] data_2;
	wire [31:0] data_3;
	wire [31:0] data_4;
	wire [31:0] data_5;
	wire [31:0] data_6;
	wire [31:0] data_7;


	wire [2:0] w_buffer_id;
	wire [2:0] r_buffer_id;

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
	wire [31:0] phase_counter;

	wire en_auto = slv_reg0[0];
	wire [8:0] w_addr_o;
	wire [31:0] Average = slv_reg1;
	assign GTH_DATA = slv_reg5;
	(* MARK_DEBUG="true" *)reg data_r;
	(* MARK_DEBUG="true" *)reg data_sync;
	always @(posedge shifting_clk) begin
		data_r <= test_trigger ;//&& data_sync;
	end

	reg [255:0] random;
	reg [255:0] random_s;

	always @ (posedge S_AXI_DATA_aclk or negedge S_AXI_DATA_aresetn) begin
		if(~S_AXI_DATA_aresetn) begin
			tri_data <= 0;
			//random <= 256'h15195_81609_ace84_b8653_54025_29395_67761_7782d_74239_84161_e5a5c_81ae2_2513;
			random <= 256'haaaaa_aaaaa_aaaaa_aaaaa_aaaaa_aaaaa_aaaaa_aaaaa_aaaaa_aaaaa_aaaaa_aaaaa_aaaa;
		end
		else begin
			tri_data <= random[0];
			random <= {random[0],random[255:1]};
		end
	end
	
	(* MARK_DEBUG="true" *)reg test_trigger;
	(* MARK_DEBUG="true" *)reg inverse;

	always @(posedge S_AXI_DATA_aclk) begin
		test_trigger = ~test_trigger;
	end

	(* MARK_DEBUG="true" *)reg r_sample0,r_sample1;
	(* MARK_DEBUG="true" *)reg f_sample0,f_sample1;
	always @(posedge shifting_clk) begin
		r_sample0 <= test_trigger;
		r_sample1 <= r_sample0;
	end
	always @(negedge shifting_clk) begin
		f_sample0 <= test_trigger;
		f_sample1 <= f_sample0;
	end

	(* MARK_DEBUG="true" *)wire r_sample_false = (r_sample0 == r_sample1);
	(* MARK_DEBUG="true" *)wire f_sample_false = (f_sample0 == f_sample1);

	always @(posedge shifting_clk or negedge S_AXI_DATA_aresetn) begin
		if (~S_AXI_DATA_aresetn) begin
			inverse <= 0;
		end
		else begin
			if(inverse == 0) begin
				if(r_sample_false == 1) begin
					inverse <= 1;
				end
			end
			else begin
				if(f_sample_false == 1) begin
					inverse <= 0;
				end
			end
		end
	end


	(* MARK_DEBUG="true" *)reg rising_detector;
	(* MARK_DEBUG="true" *)reg sync_tri;
	always @(posedge S_AXI_DATA_aclk) begin
		rising_detector <= test_trigger;
	end
	(* MARK_DEBUG="true" *)wire rise_occ = (~rising_detector) && test_trigger;
	(* MARK_DEBUG="true" *)reg rise_occ_r,rise_occ_r_i;
	always @(negedge shifting_clk) begin
		rise_occ_r_i <= rise_occ;
	end
	always @(posedge shifting_clk) begin
		rise_occ_r <= rise_occ;
	end
	always @(posedge shifting_clk) begin
		data_sync <= sync_tri;
	end
	always @(posedge shifting_clk) begin
		if(inverse) begin
			sync_tri <= rise_occ_r_i;
		end
		else begin
			sync_tri <= rise_occ;
		end
	end
	ETS_System inst_ETS_System(
		.shifting_clk (shifting_clk),
		.sys_clk      (S_AXI_DATA_aclk),
		.reset        (~S_AXI_DATA_aresetn),
		.CMP_DATA     (data_r),
		.ps_en        (ps_en),
		.trigger      (data_sync),
		.ps_incdec    (ps_incdec),
		.ps_clk       (ps_clk),
		.ps_done      (ps_done),
		.en           (en_auto),
		.phase_counter(phase_counter),
		.Average      (Average),
		.waddr        (w_addr),
		.raddr        (r_addr),
		.rdata        (r_data),
		.w_occur      (w_occur),
		.r_occur      (r_occur),
		.w_ready      (w_ready),
		.r_valid      (r_valid),
		.ready        (ready),
		.data         (data),
		.w_buffer_id   (w_buffer_id),
		.r_buffer_id   (r_buffer_id),
		.w_addr		   (w_addr_o)
	);

	AXI_Interface #(
			.ADDR_WIDTH(ADDR_WIDTH),
			.DATA_WIDTH(DATA_WIDTH),
			.S_AXI_ADDR_WIDTH(S_AXI_ADDR_WIDTH),
			.S_AXI_DATA_WIDTH(S_AXI_DATA_WIDTH)
		) inst_AXI_Interface (
			.S_AXI_aclk    (S_AXI_DATA_aclk),
			.S_AXI_aresetn (S_AXI_DATA_aresetn),
			.S_AXI_araddr  (S_AXI_DATA_araddr),
			.S_AXI_arready (S_AXI_DATA_arready),
			.S_AXI_arvalid (S_AXI_DATA_arvalid),
			.S_AXI_arprot  (S_AXI_DATA_arprot),
			.S_AXI_awaddr  (S_AXI_DATA_awaddr),
			.S_AXI_awready (S_AXI_DATA_awready),
			.S_AXI_awvalid (S_AXI_DATA_awvalid),
			.S_AXI_awprot  (S_AXI_DATA_awprot),
			.S_AXI_bresp   (S_AXI_DATA_bresp),
			.S_AXI_bready  (S_AXI_DATA_bready),
			.S_AXI_bvalid  (S_AXI_DATA_bvalid),
			.S_AXI_rdata   (S_AXI_DATA_rdata),
			.S_AXI_rready  (S_AXI_DATA_rready),
			.S_AXI_rvalid  (S_AXI_DATA_rvalid),
			.S_AXI_rresp   (S_AXI_DATA_rresp),
			.S_AXI_wdata   (S_AXI_DATA_wdata),
			.S_AXI_wready  (S_AXI_DATA_wready),
			.S_AXI_wvalid  (S_AXI_DATA_wvalid),
			.S_AXI_wstrb   (S_AXI_DATA_wstrb),
			.w_addr        (w_addr),
			.r_addr        (r_addr),
			.w_data        (w_data),
			.r_data        (r_data),
			.w_occur       (w_occur),
			.r_occur       (r_occur),
			.w_ready       (w_ready),
			.r_valid       (r_valid)
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
			.slv_wire2     (phase_counter),
			.slv_wire3     ({16'd0,5'd0,w_buffer_id,5'd0,r_buffer_id}),
			.slv_wire4     ({'d0,w_addr_o}),
			.slv_wire5     (slv_reg5),
			.slv_wire6     (slv_reg6),
			.slv_wire7     (slv_reg7),
			.slv_wire8     (data),
			.slv_wire9     (data),
			.slv_wire10    (data),
			.slv_wire11    (data),
			.slv_wire12    (data),
			.slv_wire13    (data),
			.slv_wire14    (data),
			.slv_wire15    (data),
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

endmodule
