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
	output reg[31:0] data_out,
	output reg tlast,
	input start,
	output reg shift,
	input shift_done
    );
	localparam MAX_COUNT = 560;
	localparam IDLE = 4'd0;
	localparam INIT = 4'd1;
	localparam SAMP = 4'd2;
	localparam INCC = 4'd3;
	localparam INCP = 4'd4;
	localparam WAIP = 4'd5;
	localparam SOUT = 4'd6;
	localparam CHEC = 4'd7;
	localparam DONE = 4'd8;
	localparam HALT = 4'd9;
	wire [31:0] Average = VernierQ;

	reg [3:0] state,nextstate;
	wire [9:0] sample_done;
	reg enc;
	reg clc;
	(* max_fanout=2 *)reg ens;
	reg save;


	reg [15:0]counter;
	wire [31:0] data_wire_0;
	wire [31:0] data_wire_1;
	wire [31:0] data_wire_2;
	wire [31:0] data_wire_3;
	wire [31:0] data_wire_4;
	wire [31:0] data_wire_5;
	wire [31:0] data_wire_6;
	wire [31:0] data_wire_7;
	wire [31:0] data_wire_8;
	wire [31:0] data_wire_9;
	reg [31:0] data_reg;
	reg [9:0] enbubble = 0;
	wire bubble = ~(|enbubble);
	reg [3:0] outCounter,outCounter_next;
	reg halt;


	always @ (posedge sample_clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
			outCounter <= 0;
		end
		else begin
			state <= nextstate;
			outCounter <= outCounter_next;
		end
	end
	always @ (*) begin
		case(outCounter)
			4'd0: begin data_out = data_wire_0; end
			4'd1: begin data_out = data_wire_1; end
			4'd2: begin data_out = data_wire_2; end
			4'd3: begin data_out = data_wire_3; end
			4'd4: begin data_out = data_wire_4; end
			4'd5: begin data_out = data_wire_5; end
			4'd6: begin data_out = data_wire_6; end
			4'd7: begin data_out = data_wire_7; end
			4'd8: begin data_out = data_wire_8; end
			4'd9: begin data_out = data_wire_9; end
			default:begin
				data_out = 32'h12345678;
			end
		endcase
	end

	always @ (*) begin
		enc = 0;
		clc = 0;
		ens = 0;
		halt = 0;
		shift = 0;
		valid = 0;
		tlast = 0;
		outCounter_next = 0;
		nextstate = state;
		case(state)
			IDLE:begin
				clc = 1'b1;
				if(start) begin
					nextstate = INIT;
				end
			end
			INIT:begin
				if(enbubble[9]) begin
					nextstate = SAMP;
				end
			end
			SAMP:begin
				ens = 1'b1;
				if(&sample_done) begin
					nextstate = INCC;
				end
			end
			INCC:begin
				ens = 1'b1;
				shift = 1;
				enc = 1;
				nextstate = WAIP;
			end
			WAIP:begin
				ens = 1'b1;
				if(shift_done) begin
					nextstate = CHEC;
				end
			end
			CHEC: begin
				ens = 1'b1;
				outCounter_next = 0;
				if(counter == MAX_COUNT) begin
					nextstate = DONE;
				end
				else begin
					nextstate = SOUT;
				end
			end
			SOUT:begin
				ens = 1'b1;
				valid = 1'b1;
				if(ready) begin
					outCounter_next <= outCounter + 1;
				end
				if((outCounter == 4'd9) && ready) begin
					nextstate = INIT;
				end
			end
			DONE:begin
				ens = 1'b1;
				valid = 1'b1;
				tlast = (outCounter == 4'd9);
				if(ready) begin
					outCounter_next <= outCounter + 1;
				end
				if((outCounter == 4'd9) && ready) begin
					nextstate = HALT;
				end
			end
			HALT:begin
				halt = 1;
				nextstate = IDLE;
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

	always @ (posedge sample_clk) begin
		if(halt) begin
			enbubble <= {enbubble[7:0],enbubble[9:8]};
		end
		else begin
			enbubble <= {enbubble[8:0],enbubble[9] | bubble};
		end
	end
	//VernierPtMap inst_VernierPtMap (.T(VernierQ[7:0]), .Average(Average));

	ETS_Adder inst_ETS_Adder_0(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_0),
			.enc(enbubble[0]),
			.start(ens),
			.done(sample_done[0])
	    );
	ETS_Adder inst_ETS_Adder_1(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_1),
			.enc(enbubble[1]),
			.start(ens),
			.done(sample_done[1])
	    );
	ETS_Adder inst_ETS_Adder_2(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_2),
			.enc(enbubble[2]),
			.start(ens),
			.done(sample_done[2])
	    );
	ETS_Adder inst_ETS_Adder_3(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_3),
			.enc(enbubble[3]),
			.start(ens),
			.done(sample_done[3])
	    );
	ETS_Adder inst_ETS_Adder_4(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_4),
			.enc(enbubble[4]),
			.start(ens),
			.done(sample_done[4])
	    );
	ETS_Adder inst_ETS_Adder_5(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_5),
			.enc(enbubble[5]),
			.start(ens),
			.done(sample_done[5])
	    );
	ETS_Adder inst_ETS_Adder_6(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_6),
			.enc(enbubble[6]),
			.start(ens),
			.done(sample_done[6])
	    );
	ETS_Adder inst_ETS_Adder_7(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_7),
			.enc(enbubble[7]),
			.start(ens),
			.done(sample_done[7])
	    );
	ETS_Adder inst_ETS_Adder_8(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_8),
			.enc(enbubble[8]),
			.start(ens),
			.done(sample_done[8])
	    );
	ETS_Adder inst_ETS_Adder_9(
			.clk(sample_clk),
			.reset(~rst_n),
			.Average(Average),

			.data_in(cmp_data),
			.data(data_wire_9),
			.enc(enbubble[9]),
			.start(ens),
			.done(sample_done[9])
	    );
endmodule
