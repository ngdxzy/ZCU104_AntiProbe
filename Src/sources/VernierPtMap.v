`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2020 10:24:42 AM
// Design Name: 
// Module Name: VernierPtMap
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


module VernierPtMap(
	input [7:0] T,
	output reg [31:0] Average
    );

	always @ (*) begin
		case(T[6:0])
			7'd  2 : begin Average = 32'd170;		end
			7'd  3 : begin Average = 32'd50;		end
			7'd  4 : begin Average = 32'd330;		end
			7'd  5 : begin Average = 32'd410;		end
			7'd  6 : begin Average = 32'd490;		end
			7'd  7 : begin Average = 32'd570;		end
			7'd  8 : begin Average = 32'd130;		end
			7'd  9 : begin Average = 32'd730;		end
			7'd 10 : begin Average = 32'd810;		end
			7'd 11 : begin Average = 32'd890;		end
			7'd 12 : begin Average = 32'd970;		end
			7'd 13 : begin Average = 32'd210;		end
			7'd 14 : begin Average = 32'd1130;		end
			7'd 15 : begin Average = 32'd1210;		end
			7'd 16 : begin Average = 32'd1290;		end
			7'd 17 : begin Average = 32'd1370;		end
			7'd 18 : begin Average = 32'd290;		end
			7'd 19 : begin Average = 32'd1530;		end
			7'd 20 : begin Average = 32'd1610;		end
			7'd 21 : begin Average = 32'd1690;		end
			7'd 22 : begin Average = 32'd1770;		end
			7'd 23 : begin Average = 32'd370;		end
			7'd 24 : begin Average = 32'd1930;		end
			7'd 25 : begin Average = 32'd2010;		end
			7'd 26 : begin Average = 32'd2090;		end
			7'd 27 : begin Average = 32'd2170;		end
			7'd 28 : begin Average = 32'd450;		end
			7'd 29 : begin Average = 32'd2330;		end
			7'd 30 : begin Average = 32'd2410;		end
			7'd 31 : begin Average = 32'd2490;		end
			7'd 32 : begin Average = 32'd2570;		end
			7'd 33 : begin Average = 32'd530;		end
			7'd 34 : begin Average = 32'd2730;		end
			7'd 35 : begin Average = 32'd2810;		end
			7'd 36 : begin Average = 32'd2890;		end
			7'd 37 : begin Average = 32'd2970;		end
			7'd 38 : begin Average = 32'd610;		end
			7'd 39 : begin Average = 32'd3130;		end
			7'd 40 : begin Average = 32'd3210;		end
			7'd 41 : begin Average = 32'd3290;		end
			7'd 42 : begin Average = 32'd3370;		end
			7'd 43 : begin Average = 32'd690;		end
			7'd 44 : begin Average = 32'd3530;		end
			7'd 45 : begin Average = 32'd3610;		end
			7'd 46 : begin Average = 32'd3690;		end
			7'd 47 : begin Average = 32'd3770;		end
			7'd 48 : begin Average = 32'd770;		end
			7'd 49 : begin Average = 32'd3930;		end
			7'd 50 : begin Average = 32'd4010;		end
			7'd 51 : begin Average = 32'd4090;		end
			7'd 52 : begin Average = 32'd4170;		end
			7'd 53 : begin Average = 32'd850;		end
			7'd 54 : begin Average = 32'd4330;		end
			7'd 55 : begin Average = 32'd4410;		end
			7'd 56 : begin Average = 32'd4490;		end
			7'd 57 : begin Average = 32'd4570;		end
			7'd 58 : begin Average = 32'd930;		end
			7'd 59 : begin Average = 32'd4730;		end
			7'd 60 : begin Average = 32'd4810;		end
			7'd 61 : begin Average = 32'd4890;		end
			7'd 62 : begin Average = 32'd4970;		end
			7'd 63 : begin Average = 32'd1010;		end
			7'd 64 : begin Average = 32'd5130;		end
			7'd 65 : begin Average = 32'd5210;		end
			7'd 66 : begin Average = 32'd5290;		end
			7'd 67 : begin Average = 32'd5370;		end
			7'd 68 : begin Average = 32'd1090;		end
			7'd 69 : begin Average = 32'd5530;		end
			7'd 70 : begin Average = 32'd5610;		end
			7'd 71 : begin Average = 32'd5690;		end
			7'd 72 : begin Average = 32'd5770;		end
			7'd 73 : begin Average = 32'd1170;		end
			7'd 74 : begin Average = 32'd5930;		end
			7'd 75 : begin Average = 32'd6010;		end
			7'd 76 : begin Average = 32'd6090;		end
			7'd 77 : begin Average = 32'd6170;		end
			7'd 78 : begin Average = 32'd1250;		end
			7'd 79 : begin Average = 32'd6330;		end
			7'd 80 : begin Average = 32'd6410;		end
			7'd 81 : begin Average = 32'd6490;		end
			7'd 82 : begin Average = 32'd6570;		end
			7'd 83 : begin Average = 32'd1330;		end
			7'd 84 : begin Average = 32'd6730;		end
			7'd 85 : begin Average = 32'd6810;		end
			7'd 86 : begin Average = 32'd6890;		end
			7'd 87 : begin Average = 32'd6970;		end
			7'd 88 : begin Average = 32'd1410;		end
			7'd 89 : begin Average = 32'd7130;		end
			7'd 90 : begin Average = 32'd7210;		end
			7'd 91 : begin Average = 32'd7290;		end
			7'd 92 : begin Average = 32'd7370;		end
			7'd 93 : begin Average = 32'd1490;		end
			7'd 94 : begin Average = 32'd7530;		end
			7'd 95 : begin Average = 32'd7610;		end
			7'd 96 : begin Average = 32'd7690;		end
			7'd 97 : begin Average = 32'd7770;		end
			7'd 98 : begin Average = 32'd1570;		end
			7'd 99 : begin Average = 32'd7930;		end
			7'd100 : begin Average = 32'd8010;		end
			7'd101 : begin Average = 32'd8090;		end
			7'd102 : begin Average = 32'd8170;		end
			7'd103 : begin Average = 32'd1650;		end
			7'd104 : begin Average = 32'd8330;		end
			7'd105 : begin Average = 32'd8410;		end
			7'd106 : begin Average = 32'd8490;		end
			7'd107 : begin Average = 32'd8570;		end
			7'd108 : begin Average = 32'd1730;		end
			7'd109 : begin Average = 32'd8730;		end
			7'd110 : begin Average = 32'd8810;		end
			7'd111 : begin Average = 32'd8890;		end
			7'd112 : begin Average = 32'd8970;		end
			7'd113 : begin Average = 32'd1810;		end
			7'd114 : begin Average = 32'd9130;		end
			7'd115 : begin Average = 32'd9210;		end
			7'd116 : begin Average = 32'd9290;		end
			7'd117 : begin Average = 32'd9370;		end
			7'd118 : begin Average = 32'd1890;		end
			7'd119 : begin Average = 32'd9530;		end
			7'd120 : begin Average = 32'd9610;		end
		endcase
	end
endmodule
