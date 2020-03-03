`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2019 03:07:54 PM
// Design Name: 
// Module Name: ETS_Core
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


module ETS_Core(
	input clk,
	input reset,

	input [31:0] Average,
	input  data_in,
	output [31:0] data,

	input en,
	input ready,
	output reg valid,
	output reg ps_en,
    output reg ps_incdec,
    output ps_clk,
    input ps_done
    );
	localparam IDLE = 3'b100;
	localparam START_SAMPLE = 3'b001;
	localparam WAIT_CAPTURE = 3'b011;
	localparam INC_PHASE = 3'b010;
	localparam WAIT_PHASE_INC  = 3'b110;
	reg [2:0]state,nextstate;
	reg start;
	wire done;
	assign ps_clk = clk;
	always @ (posedge clk or posedge reset) begin
		if(reset) begin
			state <= IDLE;
		end
		else begin
			state <= nextstate;
		end
	end
	always @ (*) begin
		ps_en = 0;
		ps_incdec = 0;
		nextstate = state;
		valid = 0;
		start = 0;
		case(state)
			IDLE:begin
				if(en) begin
					nextstate = START_SAMPLE;
				end
			end
			START_SAMPLE:begin
				start = 1;
				if(done) begin
					nextstate = WAIT_CAPTURE;
				end
			end
			WAIT_CAPTURE:begin
				start = 1;
				valid = 1;
				if(ready == 1) begin
					nextstate = INC_PHASE;
				end
			end
			INC_PHASE:begin
				ps_en = 1;
				ps_incdec = 1;
				nextstate = WAIT_PHASE_INC;
			end
			WAIT_PHASE_INC:begin
				ps_en = 0;
				ps_incdec = 0;
				if(ps_done) begin
					nextstate = IDLE;
				end
			end
			default:begin
				nextstate = IDLE;
			end
		endcase
	end
	ETS_Adder inst_ETS_Adder(
		.clk     (clk),
		.reset   (reset),
		.Average (Average),
		.data_in (data_in),
		.data    (data),
		.start   (start),
		.done    (done)
	);

endmodule
