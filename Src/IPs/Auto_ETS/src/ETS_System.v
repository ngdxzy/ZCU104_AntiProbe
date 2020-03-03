`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2019 03:07:35 PM
// Design Name: 
// Module Name: ETS_System
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


module ETS_System(
	input shifting_clk,
	input sys_clk,
	input reset,
	output ps_en,
    output ps_incdec,
    output ps_clk,
    input ps_done,
    input en,

    input CMP_DATA_ref,
    input [7:0] T_ref,
    output [15:0] A_ref,
	input [9:0] waddr_ref,
	input [9:0] raddr_ref,
	output [31:0] rdata_ref,
	input w_occur_ref,
	input r_occur_ref,
	output w_ready_ref,
	output r_valid_ref,

    input CMP_DATA_S11,
    input [7:0] T_S11,
    output [15:0] A_S11,
	input [9:0] waddr_S11,
	input [9:0] raddr_S11,
	output [31:0] rdata_S11,
	input w_occur_S11,
	input r_occur_S11,
	output w_ready_S11,
	output r_valid_S11,

    input CMP_DATA_S21,
    input [7:0] T_S21,
    output [15:0] A_S21,
	input [9:0] waddr_S21,
	input [9:0] raddr_S21,
	output [31:0] rdata_S21,
	input w_occur_S21,
	input r_occur_S21,
	output w_ready_S21,
	output r_valid_S21
    );


	localparam MAX_ADDR = 10'd616;

	wire valid_ref;
	wire valid_S11;
	wire valid_S21;

	wire [31:0] data_ref;
	wire [31:0] data_S11;
	wire [31:0] data_S21;

	reg ready;
	reg [8:0]w_addr;
	reg clr;
	reg en_c;
	reg wea;
	reg w_request;
	wire frame_ready;
	reg [2:0] state,nextstate;
	wire r_finish_ref,r_finish_S11,r_finish_S21;

	VernierPtMap inst_VernierPtMap_ref (.T(T_ref), .Average(A_ref));
	VernierPtMap inst_VernierPtMap_S11 (.T(T_S11), .Average(A_S11));
	VernierPtMap inst_VernierPtMap_S21 (.T(T_S21), .Average(A_S21));


	localparam IDLE = 3'd1;
	localparam REQUEST = 3'd0;
	localparam WRITING = 3'd2;
	localparam CHECK = 3'd3;
	localparam INC_MSB = 3'd4;
	localparam DONE = 3'd5;
	localparam CLR_MSB = 3'd6;
	localparam WAIT = 3'd7;

	always @ (posedge shifting_clk or posedge reset) begin
		if(reset) begin
			state <= IDLE;
		end
		else begin
			state <= nextstate;
		end
	end

	always @ (*) begin
		nextstate = state;
		ready = 0;
		wea = 0;
		en_c = 0;
		clr = 0;
		w_request = 0;
		case(state)
			IDLE:begin
				if(valid_ref & valid_S21 & valid_S11) begin
					nextstate = WRITING;
				end
			end
			WRITING:begin
				wea = 1;
				nextstate = WAIT;
			end
			WAIT:begin
				wea = 1;
				nextstate = INC_MSB;
			end
			INC_MSB:begin
				en_c = 1;
				nextstate = CHECK;
			end
			CHECK:begin
				if(w_addr == MAX_ADDR) begin
					nextstate = REQUEST;
				end
				else begin
					nextstate = DONE;
				end
			end
			DONE:begin
				ready = 1;
				if((~valid_S21) & (~valid_S11) & (~valid_ref)) begin
					nextstate = IDLE;
				end
			end
			REQUEST:begin
				w_request = 1;
				clr = 1;
				if(frame_ready) begin
					nextstate = DONE;
				end
			end
			default:begin
				nextstate = IDLE;
			end
		endcase
	end

	always @ (posedge shifting_clk or posedge reset) begin
		if(reset) begin
			w_addr <= 0;
		end
		else begin
			if(clr) begin
				w_addr <= 0;
			end
			else if(en_c) begin
				w_addr <= w_addr + 1;
			end
		end
	end


	ETS_Core inst_ETS_Core_ref(
		.clk       (shifting_clk),
		.reset     (reset),
		.Average   (A_ref),
		.data_in   (CMP_DATA_ref),
		.data      (data_ref),
		.en        (en),
		.ready     (ready),
		.valid     (valid_ref),
		.ps_en     (),
		.ps_incdec (),
		.ps_clk    (),
		.ps_done   (ps_done)
	);


	ETS_Core inst_ETS_Core_S11(
		.clk       (shifting_clk),
		.reset     (reset),
		.Average   (A_S11),
		.data_in   (CMP_DATA_S11),
		.data      (data_S11),
		.en        (en),
		.ready     (ready),
		.valid     (valid_S11),
		.ps_en     (),
		.ps_incdec (),
		.ps_clk    (),
		.ps_done   (ps_done)
	);

	ETS_Core inst_ETS_Core_S21(
		.clk       (shifting_clk),
		.reset     (reset),
		.Average   (A_S21),
		.data_in   (CMP_DATA_S21),
		.data      (data_S21),
		.en        (en),
		.ready     (ready),
		.valid     (valid_S21),
		.ps_en     (ps_en),
		.ps_incdec (ps_incdec),
		.ps_clk    (ps_clk),
		.ps_done   (ps_done)
	);

	TripleBufferController inst_TripleBufferController(
		.w_buffer_id   (w_buffer_id),
		.r_buffer_id   (r_buffer_id),
		.w_clk         (shifting_clk),
		.r_clk         (sys_clk),
		.reset         (reset),
		.w_request     (w_request),
		.w_frame_ready (frame_ready),
		.r_finish      (r_finish_ref & r_finish_S11 & r_finish_S21)
	);

	TripleBuffer #(
			.MAX_TAP(MAX_ADDR)
	)inst_TripleBuffer_ref(
		.w_clk       (shifting_clk),
		.r_clk       (sys_clk),
		.waddr       (w_addr),
		.raddr       (raddr_ref),
		.wdata       (data_ref),
		.rdata       (rdata_ref),
		.w_buffer_id (w_buffer_id),
		.r_buffer_id (r_buffer_id),
		.w_occur     (wea),
		.r_occur     (r_occur_ref),
		.w_ready     (w_ready_ref),
		.r_valid     (r_valid_ref),
		.r_finish    (r_finish_ref)
	);

	TripleBuffer #(
			.MAX_TAP(MAX_ADDR)
	)inst_TripleBuffer_S11(
		.w_clk       (shifting_clk),
		.r_clk       (sys_clk),
		.waddr       (w_addr),
		.raddr       (raddr_S11),
		.wdata       (data_S11),
		.rdata       (rdata_S11),
		.w_buffer_id (w_buffer_id),
		.r_buffer_id (r_buffer_id),
		.w_occur     (wea),
		.r_occur     (r_occur_S11),
		.w_ready     (w_ready_S11),
		.r_valid     (r_valid_S11),
		.r_finish    (r_finish_S11)
	);

	TripleBuffer #(
			.MAX_TAP(MAX_ADDR)
	)inst_TripleBuffer_S21(
		.w_clk       (shifting_clk),
		.r_clk       (sys_clk),
		.waddr       (w_addr),
		.raddr       (raddr_S21),
		.wdata       (data_S21),
		.rdata       (rdata_S21),
		.w_buffer_id (w_buffer_id),
		.r_buffer_id (r_buffer_id),
		.w_occur     (wea),
		.r_occur     (r_occur_S21),
		.w_ready     (w_ready_S21),
		.r_valid     (r_valid_S21),
		.r_finish    (r_finish_S21)
	);
endmodule
