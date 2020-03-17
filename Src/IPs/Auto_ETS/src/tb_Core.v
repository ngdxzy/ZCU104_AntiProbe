`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 03:58:08 PM
// Design Name: 
// Module Name: tb_Core
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


module tb_Core(

    );
	reg shifting_clk;
	reg sys_clk;
	reg reset;
	wire ps_en;
    wire ps_incdec;
    wire ps_clk;
    reg ps_done;
    reg en;

    reg CMP_DATA_ref;
    reg [7:0] T_ref;
    wire [15:0] A_ref;
	reg [9:0] waddr_ref;
	reg [9:0] raddr_ref;
	wire [31:0] rdata_ref;
	reg w_occur_ref;
	reg r_occur_ref;
	wire w_ready_ref;
	wire r_valid_ref;

    reg CMP_DATA_S11;
    reg [7:0] T_S11;
    wire [15:0] A_S11;
	reg [9:0] waddr_S11;
	reg [9:0] raddr_S11;
	wire [31:0] rdata_S11;
	reg w_occur_S11;
	reg r_occur_S11;
	wire w_ready_S11;
	wire r_valid_S11;

    reg CMP_DATA_S21;
    reg [7:0] T_S21;
    wire [15:0] A_S21;
	reg [9:0] waddr_S21;
	reg [9:0] raddr_S21;
	wire [31:0] rdata_S21;
	reg w_occur_S21;
	reg r_occur_S21;
	wire w_ready_S21;
	wire r_valid_S21;
	always @(posedge shifting_clk or posedge reset) begin
		if (reset) begin
			// reset
			ps_done <= 0;
		end
		else begin
			ps_done <= ps_en;
		end
	end
	always begin
		#5 shifting_clk = !shifting_clk; sys_clk = !sys_clk;
	end

	initial begin
		shifting_clk = 0; sys_clk = 0; reset = 0;
		#10 reset = 1; CMP_DATA_S11 = 1;CMP_DATA_S21 = 1;CMP_DATA_ref = 1; T_S11=11;T_S21=11;T_ref=11;
		#10 reset = 0;
		#100000 $stop;
	end
	ETS_System inst_ETS_System
		(
			.shifting_clk (shifting_clk),
			.sys_clk      (sys_clk),
			.reset        (reset),
			.ps_en        (ps_en),
			.ps_incdec    (ps_incdec),
			.ps_clk       (ps_clk),
			.ps_done      (r_ps_done),
			.en           (en),
			.CMP_DATA_ref (CMP_DATA_ref),
			.T_ref        (T_ref),
			.A_ref        (A_ref),
			.waddr_ref    (waddr_ref),
			.raddr_ref    (raddr_ref),
			.rdata_ref    (rdata_ref),
			.w_occur_ref  (w_occur_ref),
			.r_occur_ref  (r_occur_ref),
			.w_ready_ref  (w_ready_ref),
			.r_valid_ref  (r_valid_ref),
			.CMP_DATA_S11 (CMP_DATA_S11),
			.T_S11        (T_S11),
			.A_S11        (A_S11),
			.waddr_S11    (waddr_S11),
			.raddr_S11    (raddr_S11),
			.rdata_S11    (rdata_S11),
			.w_occur_S11  (w_occur_S11),
			.r_occur_S11  (r_occur_S11),
			.w_ready_S11  (w_ready_S11),
			.r_valid_S11  (r_valid_S11),
			.CMP_DATA_S21 (CMP_DATA_S21),
			.T_S21        (T_S21),
			.A_S21        (A_S21),
			.waddr_S21    (waddr_S21),
			.raddr_S21    (raddr_S21),
			.rdata_S21    (rdata_S21),
			.w_occur_S21  (w_occur_S21),
			.r_occur_S21  (r_occur_S21),
			.w_ready_S21  (w_ready_S21),
			.r_valid_S21  (r_valid_S21)
		);

endmodule
