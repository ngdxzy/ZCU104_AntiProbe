`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2019 10:51:35 AM
// Design Name: 
// Module Name: TripleBufferController
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


module TripleBufferController(
	output reg[2:0] w_buffer_id,
	output reg[2:0] r_buffer_id,

	input w_clk,
	input r_clk,

	input reset,

	input w_request,
	output reg w_frame_ready,
	input r_finish
    );
	
	localparam IDLE = 2'b00;
	localparam READ_SWITCH = 2'b01;
	localparam WRITE_SWITCH = 2'b10;
	localparam WAIT = 2'b11;

	reg [2:0] w_buffer_id_sync;
	reg r_change,w_change;
	reg [1:0]state,nextstate;
	reg w_request_r;
	always @ (posedge r_clk) begin
		w_request_r <= w_request;
	end

	always @ (posedge w_clk) begin
		w_buffer_id <= w_buffer_id_sync;
	end

	always @ (posedge r_clk or posedge reset) begin
		if(reset) begin
			state <= IDLE;
		end
		else begin
			state <= nextstate;
		end
	end
	
	always @ (*) begin
		r_change = 0;
		w_change = 0;
		w_frame_ready = 0;
		nextstate = state;
		case(state)
			IDLE:begin
				if(r_finish) begin
					nextstate = READ_SWITCH;
				end
				else if(w_request_r) begin
					nextstate = WRITE_SWITCH;
				end
			end
			READ_SWITCH:begin
				r_change = 1;
				nextstate = IDLE;
			end
			WRITE_SWITCH:begin
				w_change = 1;
				nextstate = WAIT;
			end
			WAIT:begin
				w_frame_ready = 1;
				if(~w_request_r)
					nextstate = IDLE;
			end
			default:begin
				nextstate = state;
			end
		endcase
	end
	always @ (posedge r_clk or posedge reset) begin
		if(reset) begin
			r_buffer_id <= 3'b010;
		end
		else begin
			if(r_change) begin
				r_buffer_id <= (r_buffer_id ~^ w_buffer_id_sync);
			end
		end
	end

	always @ (posedge r_clk or posedge reset) begin
		if(reset) begin
			w_buffer_id_sync <= 3'b001;
		end
		else begin
			if(w_change) begin
				w_buffer_id_sync <= (r_buffer_id ~^ w_buffer_id_sync);
			end
		end
	end


endmodule