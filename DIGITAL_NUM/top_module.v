//////////////////////////////////////////////////
//// TOP_MODUEL.v
//// 					ZHAOCHAO
////						2016-11-13
///////////////////////////////////////////////////////////
////

module top_module
(
	CLK,
	RSTn,
	Number_Data,
	Row_Scan_Sig,
	Col_Scan_Sig
);

	input CLK;
	input RSTn;
	input [7:0]Number_Data;
	output [7:0]Row_Scan_Sig;
	output [7:0]Col_Scan_Sig;
	
	
	////////////////////////////////////////
	
	wire [3:0]Ten_Data;
	wire [3:0]One_Data;
	
	NUMBER_MOD_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Num_Data(Number_Data),
		.Ten_Data(Ten_Data),
		.One_Data(One_Data)	);

	
	
	wire [7:0]Ten_SMG_Data;
	wire [7:0]One_SMG_Data;
	
	SMG_ENCODER_MODULE U3
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Ten_Data(Ten_Data),
		.One_Data(One_Data),
		.Ten_SMG_Data(Ten_SMG_Data),
		.One_SMG_Data(One_SMG_Data)
	);
	
	
	SMG_SCAN_MODULE U4
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Ten_SMG_Data(Ten_SMG_Data),
		.One_SMG_Data(One_SMG_Data),
		.Row_Scan_Sig(Row_Scan_Sig),
		.Col_Scan_Sig(Col_Scan_Sig)
	);
	
	
endmodule
