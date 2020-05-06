`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2020 11:56:16 AM
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
	input sample_clk,
	input rst_n,
	input cmp_data,
	input [31:0] VernierQ,
	output reg valid,
	input ready,
	output [31:0] data_out,
	output reg tlast,
	input start,
	output reg shift,
	input shift_done
    );
	localparam MAX_COUNT = 5600;
	localparam IDLE = 4'd0;
	localparam INIT = 4'd1;
	localparam SAMP = 4'd2;
	localparam INCC = 4'd3;
	localparam INCP = 4'd4;
	localparam WAIP = 4'd5;
	localparam SOUT = 4'd6;
	localparam CHEC = 4'd7;
	localparam DONE = 4'd8;
	wire [31:0] Average;

	reg [3:0] state,nextstate;
	wire sample_done;
	reg enc;
	reg clc;
	reg ens;
	reg save;


	reg [15:0]counter;
	wire [31:0] data_wire;
	reg [31:0] data_reg;


	always @ (posedge sample_clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end
		else begin
			state <= nextstate;
		end
	end

	always @ (*) begin
		nextstate = state;
		case(state)
			IDLE:begin
				if(start) begin
					nextstate = INIT;
				end
			end
			INIT:begin
				clc = 1'b1;
				nextstate = SAMP;
			end
			SAMP:begin
				ens = 1'b1;
				if(sample_done) begin
					nextstate = INCC;
				end
			end
			INCC:begin
				save = 1'b1;
				ens = 1'b1;
				shift = 1;
				enc = 1;
				nextstate = WAIP;
			end
			WAIP:begin
				if(shift_done) begin
					nextstate = CHEC;
				end
			end
			CHEC: begin
				if(counter == MAX_COUNT) begin
					nextstate = DONE;
				end
				else begin
					nextstate = SOUT;
				end
			end
			SOUT:begin
				valid = 1'b1;
				if(ready) begin
					nextstate = SAMP;
				end
			end
			DONE:begin
				tlast = 1;
				valid = 1;
				if(ready) begin
					nextstate = IDLE;
				end
			end
		endcase
	end

	always @ (posedge sample_clk or negedge rst_n) begin
		if(~rst_n) begin
			counter <= 16'd0;
		end
		else if(clc) begin
			counter <= 16'd0;
		end
		else if(enc) begin
			counter <= counter + 1;
		end
	end

	always @ (posedge sample_clk or negedge rst_n) begin
		if(~rst_n) begin
			data_reg <= 16'd0;
		end
		else if(save) begin
			data_reg <= data_wire;
		end
	end
	VernierPtMap inst_VernierPtMap (.T(VernierQ[7:0]), .Average(Average));
	ETS_Adder inst_ETS_Adder(
		.clk(sample_clk),
		.reset(~rst_n),
		.Average(Average),

		.data_in(cmp_data),
		.data(data_wire),

		.start(ens),
		.done(sample_done)
    );
    assign data_out = data_reg;
endmodule
