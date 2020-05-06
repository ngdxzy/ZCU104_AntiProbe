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
	output reg [15:0] Average
    );

	always @ (*) begin
		case(T[6:0])
			7'd  2 : begin Average = 16'd187;	end
			7'd  3 : begin Average = 16'd275;		end
			7'd  4 : begin Average = 16'd33;		end
			7'd  5 : begin Average = 16'd451;		end
			7'd  6 : begin Average = 16'd539;		end
			7'd  7 : begin Average = 16'd627;		end
			7'd  8 : begin Average = 16'd715;	end
			7'd  9 : begin Average = 16'd803;		end
			7'd 10 : begin Average = 16'd891;		end
			7'd 11 : begin Average = 16'd979;		end
			7'd 12 : begin Average = 16'd1067;		end
			7'd 13 : begin Average = 16'd1155;		end
			7'd 14 : begin Average = 16'd1243;		end
			7'd 15 : begin Average = 16'd121;		end
			7'd 16 : begin Average = 16'd1419;		end
			7'd 17 : begin Average = 16'd1507;		end
			7'd 18 : begin Average = 16'd1595;		end
			7'd 19 : begin Average = 16'd1683;	end
			7'd 20 : begin Average = 16'd1771;		end
			7'd 21 : begin Average = 16'd1859;		end
			7'd 22 : begin Average = 16'd1947;		end
			7'd 23 : begin Average = 16'd2035;		end
			7'd 24 : begin Average = 16'd2123;		end
			7'd 25 : begin Average = 16'd2211;		end
			7'd 26 : begin Average = 16'd209;		end
			7'd 27 : begin Average = 16'd2387;		end
			7'd 28 : begin Average = 16'd2475;		end
			7'd 29 : begin Average = 16'd2563;		end
			7'd 30 : begin Average = 16'd2651;		end
			7'd 31 : begin Average = 16'd2739;		end
			7'd 32 : begin Average = 16'd2827;		end
			7'd 33 : begin Average = 16'd2915;		end
			7'd 34 : begin Average = 16'd3003;		end
			7'd 35 : begin Average = 16'd3091;		end
			7'd 36 : begin Average = 16'd3179;		end
			7'd 37 : begin Average = 16'd297;		end
			7'd 38 : begin Average = 16'd3355;		end
			7'd 39 : begin Average = 16'd3443;		end
			7'd 40 : begin Average = 16'd3531;		end
			7'd 41 : begin Average = 16'd3619;		end
			7'd 42 : begin Average = 16'd3707;		end
			7'd 43 : begin Average = 16'd3795;		end
			7'd 44 : begin Average = 16'd3883;		end
			7'd 45 : begin Average = 16'd3971;		end
			7'd 46 : begin Average = 16'd4059;		end
			7'd 47 : begin Average = 16'd4147;		end
			7'd 48 : begin Average = 16'd385;		end
			7'd 49 : begin Average = 16'd4323;		end
			7'd 50 : begin Average = 16'd4411;		end
			7'd 51 : begin Average = 16'd4499;		end
			7'd 52 : begin Average = 16'd4587;		end
			7'd 53 : begin Average = 16'd4675;		end
			7'd 54 : begin Average = 16'd4763;		end
			7'd 55 : begin Average = 16'd4851;		end
			7'd 56 : begin Average = 16'd4939;		end
			7'd 57 : begin Average = 16'd5027;		end
			7'd 58 : begin Average = 16'd5115;		end
			7'd 59 : begin Average = 16'd473;		end
			7'd 60 : begin Average = 16'd5291;		end
			7'd 61 : begin Average = 16'd5379;		end
			7'd 62 : begin Average = 16'd5467;		end
			7'd 63 : begin Average = 16'd5555;		end
			7'd 64 : begin Average = 16'd5643;		end
			7'd 65 : begin Average = 16'd5731;		end
			7'd 66 : begin Average = 16'd5819;		end
			7'd 67 : begin Average = 16'd5907;		end
			7'd 68 : begin Average = 16'd5995;		end
			7'd 69 : begin Average = 16'd6083;		end
			7'd 70 : begin Average = 16'd561;		end
			7'd 71 : begin Average = 16'd6259;		end
			7'd 72 : begin Average = 16'd6347;		end
			7'd 73 : begin Average = 16'd6435;		end
			7'd 74 : begin Average = 16'd6523;		end
			7'd 75 : begin Average = 16'd6611;		end
			7'd 76 : begin Average = 16'd6699;		end
			7'd 77 : begin Average = 16'd6787;		end
			7'd 78 : begin Average = 16'd6875;		end
			7'd 79 : begin Average = 16'd6963;		end
			7'd 80 : begin Average = 16'd7051;		end
			7'd 81 : begin Average = 16'd649;		end
			7'd 82 : begin Average = 16'd7227;		end
			7'd 83 : begin Average = 16'd7315;		end
			7'd 84 : begin Average = 16'd7403;		end
			7'd 85 : begin Average = 16'd7491;		end
			7'd 86 : begin Average = 16'd7579;		end
			7'd 87 : begin Average = 16'd7667;		end
			7'd 88 : begin Average = 16'd7755;		end
			7'd 89 : begin Average = 16'd7843;		end
			7'd 90 : begin Average = 16'd7931;		end
			7'd 91 : begin Average = 16'd8019;				end
			7'd 92 : begin Average = 16'd737;				end
			7'd 93 : begin Average = 16'd8195;				end
			7'd 94 : begin Average = 16'd8283;				end
			7'd 95 : begin Average = 16'd8371;				end
			7'd 96 : begin Average = 16'd8459;				end
			7'd 97 : begin Average = 16'd8547;				end
			7'd 98 : begin Average = 16'd8635;				end
			7'd 99 : begin Average = 16'd8723;		end
			7'd100 : begin Average = 16'd8811;				end
			7'd101 : begin Average = 16'd8899;				end
			7'd102 : begin Average = 16'd8987;				end
			7'd103 : begin Average = 16'd825;				end
			7'd104 : begin Average = 16'd9163;				end
			7'd105 : begin Average = 16'd9251;				end
			7'd106 : begin Average = 16'd9339;				end
			7'd107 : begin Average = 16'd9427;				end
			7'd108 : begin Average = 16'd9515;				end
			7'd109 : begin Average = 16'd9603;				end
			7'd110 : begin Average = 16'd9691;		end
			7'd111 : begin Average = 16'd9779;				end
			7'd112 : begin Average = 16'd9867;				end
			7'd113 : begin Average = 16'd9955;		 		end
			7'd114 : begin Average = 16'd913;		 		end
			7'd115 : begin Average = 16'd10131;		 		end
			7'd116 : begin Average = 16'd10219;		 		end
			7'd117 : begin Average = 16'd10307;		 		end
			7'd118 : begin Average = 16'd10395;		 		end
			7'd119 : begin Average = 16'd10483;		 		end
			7'd120 : begin Average = 16'd10571;		 		end
		endcase
	end
endmodule
