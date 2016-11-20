/////////////////////////////////////////////////
//// SMG_ENCODE_MODULE.v
//// 				ZHAOCHAO
//// 					2016-11-20
/////////////////////////////////////////////////////////
////

module SMG_ENCODE_MODULE
(
	CLK, RSTn,
	Number_Data,
	SMG_Data
);

	input CLK;
	input RSTn;
	input [3:0]Number_Data;
	output [8:0]SMG_Data;
	
	
	