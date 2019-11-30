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
    input CMP_DATA,
    input [31:0] Average,
	input [8:0] waddr,
	input [8:0] raddr,
	output [31:0] rdata,
	input w_occur,
	input trigger,
	input r_occur,
	output w_ready,
	output r_valid,
	output reg ready,

	output [8:0] w_addr,

	output [2:0] w_buffer_id,
	output [2:0] r_buffer_id,

	output reg [31:0] phase_counter,

	output [31:0] data
    );
	reg [8:0]w_addr;
	reg clr;
	reg en_c;
	reg wea;
	reg w_request;
	wire frame_ready;
	reg [2:0] state,nextstate;



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
				if(valid) begin
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
				if(w_addr == 9'd448) begin
					nextstate = REQUEST;
				end
				else begin
					nextstate = DONE;
				end
			end
			DONE:begin
				ready = 1;
				if(~valid) begin
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

	always @ (posedge shifting_clk or posedge reset) begin
		if(reset) begin
			phase_counter <= 0;
		end
		else begin
			if(ps_done) begin
				phase_counter <= phase_counter + 1;
			end
		end
	end


	ETS_Core inst_ETS_Core(
		.clk       (shifting_clk),
		.reset     (reset),
		.Average   (Average),
		.data_in   (CMP_DATA),
		.data      (data),
		.en        (en),
		.trigger   (trigger),
		.ready     (ready),
		.valid     (valid),
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
		.r_finish      (r_finish)
	);

	TripleBuffer #(
			.MAX_TAP(448)
	)inst_TripleBuffer(
		.w_clk       (shifting_clk),
		.r_clk       (sys_clk),
		.waddr       (w_addr),
		.raddr       (raddr),
		.wdata       (data),
		.rdata       (rdata),
		.w_buffer_id (w_buffer_id),
		.r_buffer_id (r_buffer_id),
		.w_occur     (w_occur | wea),
		.r_occur     (r_occur),
		.w_ready     (w_ready),
		.r_valid     (r_valid),
		.r_finish    (r_finish)
	);

endmodule
