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
			7'd  2 : begin Average = 16'd22; end
			7'd  3 : begin Average = 16'd33; end
			7'd  4 : begin Average = 16'd44; end
			7'd  5 : begin Average = 16'd55; end
			7'd  6 : begin Average = 16'd66; end
			7'd  7 : begin Average = 16'd77; end
			7'd  8 : begin Average = 16'd88; end
			7'd  9 : begin Average = 16'd99; end
			7'd 10 : begin Average = 16'd110; end
			7'd 11 : begin Average = 16'd11; end
			7'd 12 : begin Average = 16'd132; end
			7'd 13 : begin Average = 16'd143; end
			7'd 14 : begin Average = 16'd154; end
			7'd 15 : begin Average = 16'd165; end
			7'd 16 : begin Average = 16'd176; end
			7'd 17 : begin Average = 16'd187; end
			7'd 18 : begin Average = 16'd198; end
			7'd 19 : begin Average = 16'd209; end
			7'd 20 : begin Average = 16'd220; end
			7'd 21 : begin Average = 16'd231; end
			7'd 22 : begin Average = 16'd22; end
			7'd 23 : begin Average = 16'd253; end
			7'd 24 : begin Average = 16'd264; end
			7'd 25 : begin Average = 16'd275; end
			7'd 26 : begin Average = 16'd286; end
			7'd 27 : begin Average = 16'd297; end
			7'd 28 : begin Average = 16'd308; end
			7'd 29 : begin Average = 16'd319; end
			7'd 30 : begin Average = 16'd330; end
			7'd 31 : begin Average = 16'd341; end
			7'd 32 : begin Average = 16'd352; end
			7'd 33 : begin Average = 16'd33; end
			7'd 34 : begin Average = 16'd374; end
			7'd 35 : begin Average = 16'd385; end
			7'd 36 : begin Average = 16'd396; end
			7'd 37 : begin Average = 16'd407; end
			7'd 38 : begin Average = 16'd418; end
			7'd 39 : begin Average = 16'd429; end
			7'd 40 : begin Average = 16'd440; end
			7'd 41 : begin Average = 16'd451; end
			7'd 42 : begin Average = 16'd462; end
			7'd 43 : begin Average = 16'd473; end
			7'd 44 : begin Average = 16'd44; end
			7'd 45 : begin Average = 16'd495; end
			7'd 46 : begin Average = 16'd506; end
			7'd 47 : begin Average = 16'd517; end
			7'd 48 : begin Average = 16'd528; end
			7'd 49 : begin Average = 16'd539; end
			7'd 50 : begin Average = 16'd550; end
			7'd 51 : begin Average = 16'd561; end
			7'd 52 : begin Average = 16'd572; end
			7'd 53 : begin Average = 16'd583; end
			7'd 54 : begin Average = 16'd594; end
			7'd 55 : begin Average = 16'd55; end
			7'd 56 : begin Average = 16'd616; end
			7'd 57 : begin Average = 16'd627; end
			7'd 58 : begin Average = 16'd638; end
			7'd 59 : begin Average = 16'd649; end
			7'd 60 : begin Average = 16'd660; end
			7'd 61 : begin Average = 16'd671; end
			7'd 62 : begin Average = 16'd682; end
			7'd 63 : begin Average = 16'd693; end
			7'd 64 : begin Average = 16'd704; end
			7'd 65 : begin Average = 16'd715; end
			7'd 66 : begin Average = 16'd66; end
			7'd 67 : begin Average = 16'd737; end
			7'd 68 : begin Average = 16'd748; end
			7'd 69 : begin Average = 16'd759; end
			7'd 70 : begin Average = 16'd770; end
			7'd 71 : begin Average = 16'd781; end
			7'd 72 : begin Average = 16'd792; end
			7'd 73 : begin Average = 16'd803; end
			7'd 74 : begin Average = 16'd814; end
			7'd 75 : begin Average = 16'd825; end
			7'd 76 : begin Average = 16'd836; end
			7'd 77 : begin Average = 16'd77; end
			7'd 78 : begin Average = 16'd858; end
			7'd 79 : begin Average = 16'd869; end
			7'd 80 : begin Average = 16'd880; end
			7'd 81 : begin Average = 16'd891; end
			7'd 82 : begin Average = 16'd902; end
			7'd 83 : begin Average = 16'd913; end
			7'd 84 : begin Average = 16'd924; end
			7'd 85 : begin Average = 16'd935; end
			7'd 86 : begin Average = 16'd946; end
			7'd 87 : begin Average = 16'd957; end
			7'd 88 : begin Average = 16'd88; end
			7'd 89 : begin Average = 16'd979; end
			7'd 90 : begin Average = 16'd990; end
			7'd 91 : begin Average = 16'd1001; end
			7'd 92 : begin Average = 16'd1012; end
			7'd 93 : begin Average = 16'd1023; end
			7'd 94 : begin Average = 16'd1034; end
			7'd 95 : begin Average = 16'd1045; end
			7'd 96 : begin Average = 16'd1056; end
			7'd 97 : begin Average = 16'd1067; end
			7'd 98 : begin Average = 16'd1078; end
			7'd 99 : begin Average = 16'd99; end
			7'd100 : begin Average = 16'd1100; end
			7'd101 : begin Average = 16'd1111; end
			7'd102 : begin Average = 16'd1122; end
			7'd103 : begin Average = 16'd1133; end
			7'd104 : begin Average = 16'd1144; end
			7'd105 : begin Average = 16'd1155; end
			7'd106 : begin Average = 16'd1166; end
			7'd107 : begin Average = 16'd1177; end
			7'd108 : begin Average = 16'd1188; end
			7'd109 : begin Average = 16'd1199; end
			7'd110 : begin Average = 16'd110; end
			7'd111 : begin Average = 16'd1221; end
			7'd112 : begin Average = 16'd1232; end
			7'd113 : begin Average = 16'd1243; end
			7'd114 : begin Average = 16'd1254; end
			7'd115 : begin Average = 16'd1265; end
			7'd116 : begin Average = 16'd1276; end
			7'd117 : begin Average = 16'd1287; end
			7'd118 : begin Average = 16'd1298; end
			7'd119 : begin Average = 16'd1320; end
			7'd120 : begin Average = 16'd1320; end
		endcase
	end
endmodule
