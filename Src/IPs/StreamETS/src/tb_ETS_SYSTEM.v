`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2020 11:51:00 AM
// Design Name: 
// Module Name: tb_ETS_SYSTEM
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


module tb_ETS_SYSTEM(

    );
	reg sample_clk;
	reg rst_n;
	reg cmp_data;
	reg [31:0] VernierQ;
	wire valid;
	reg ready;
	wire[31:0] data_out;
	wire tlast;
	reg start;
	wire shift;
	reg shift_done;
	ETS_System inst_ETS_System
		(
			.sample_clk (sample_clk),
			.rst_n      (rst_n),
			.cmp_data   (cmp_data),
			.VernierQ   (VernierQ),
			.valid      (valid),
			.ready      (ready),
			.data_out   (data_out),
			.tlast      (tlast),
			.start      (start),
			.shift      (shift),
			.shift_done (shift_done)
		);
	always begin
		#5 sample_clk = ~sample_clk;
	end
	initial begin
		sample_clk = 0;rst_n = 1; VernierQ = 4;ready = 1; shift_done = 1;start = 0;
		#10 rst_n = 0;
		#10 rst_n = 1;
		#10 start = 1;
	end
	reg [3:0] counter;
	always @(posedge sample_clk or negedge rst_n) begin
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
			4'd0: begin cmp_data = 1; end
			4'd1: begin cmp_data = 1; end
			4'd2: begin cmp_data = 0; end
			4'd3: begin cmp_data = 0; end
			4'd4: begin cmp_data = 0; end
			4'd5: begin cmp_data = 1; end
			4'd6: begin cmp_data = 0; end
			4'd7: begin cmp_data = 0; end
			4'd8: begin cmp_data = 1; end
			4'd9: begin cmp_data = 0; end
			default: begin
				cmp_data = 0;
			end
		endcase
	end
endmodule
