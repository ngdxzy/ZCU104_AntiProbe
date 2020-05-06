`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2019 09:59:03 AM
// Design Name: 
// Module Name: TripleBuffer
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


module TripleBuffer#(
	parameter integer MAX_TAP = 12'd616
	)(
	input w_clk,
	input r_clk,
	input [11:0] waddr,
	input [11:0] raddr,
	input [31:0] wdata,
	output reg [31:0] rdata,
	input [2:0]w_buffer_id,
	input [2:0]r_buffer_id,
	input w_occur,
	input r_occur,
	output reg w_ready,
	output reg r_valid,
	output r_finish
    );

	wire [31:0] doutb_0;
	wire [31:0] doutb_1;
	wire [31:0] doutb_2;
	always @ (*) begin
		case(r_buffer_id)
			3'b001:begin rdata = doutb_0; end
			3'b010:begin rdata = doutb_1; end
			3'b100:begin rdata = doutb_2; end
			default:begin
				rdata = {13'd0,r_buffer_id};
			end
		endcase
	end
	always @ (posedge r_clk) begin
		w_ready <= w_occur;
		r_valid <= r_occur;
	end

	BRAM Frame1 (
		.clka(w_clk),    // input wire clka
		.wea(w_occur & w_buffer_id[0]),      // input wire [0 : 0] wea
		.addra(waddr),  // input wire [8 : 0] addra
		.dina(wdata),    // input wire [15 : 0] dina
		.clkb(r_clk),    // input wire clkb
		.addrb(raddr),  // input wire [8 : 0] addrb
		.doutb(doutb_0)  // output wire [15 : 0] doutb
	);

	BRAM Frame2 (
		.clka(w_clk),    // input wire clka
		.wea(w_occur & w_buffer_id[1]),      // input wire [0 : 0] wea
		.addra(waddr),  // input wire [8 : 0] addra
		.dina(wdata),    // input wire [15 : 0] dina
		.clkb(r_clk),    // input wire clkb
		.addrb(raddr),  // input wire [8 : 0] addrb
		.doutb(doutb_1)  // output wire [15 : 0] doutb
	);

	BRAM Frame3 (
		.clka(w_clk),    // input wire clka
		.wea(w_occur & w_buffer_id[2]),      // input wire [0 : 0] wea
		.addra(waddr),  // input wire [8 : 0] addra
		.dina(wdata),    // input wire [15 : 0] dina
		.clkb(r_clk),    // input wire clkb
		.addrb(raddr),  // input wire [8 : 0] addrb
		.doutb(doutb_2)  // output wire [15 : 0] doutb
	);

	assign r_finish = r_occur & (raddr == (MAX_TAP-1));
endmodule
