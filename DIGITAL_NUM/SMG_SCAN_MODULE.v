//////////////////////////////////////////////////
//// SMG_SCAN_MODULE.v
//// 					ZHAOCHAO
////						2016-11-13
///////////////////////////////////////////////////////////
////

module SMG_SCAN_MODULE 
(
	CLK, RSTn, 
	Ten_SMG_Data, One_SMG_Data,
	Row_Scan_Sig, Col_Scan_Sig
);

	input CLK;
	input RSTn;
	input [7:0]Ten_SMG_Data;
	input [7:0]One_SMG_Data;
	output [7:0]Row_Scan_Sig;
	output [1:0]Col_Scan_Sig;
	
	/////////////////////////////
	
	ROW_SCAN_MODULE  U_row_scan_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Ten_SMG_Data(Ten_SMG_Data),
		.One_SMG_Data(One_SMG_Data),
		.Row_Scan_Sig(Row_Scan_Sig)
	);
	
	
	COL_SCAN_MODULE U_col_scan_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Col_Scan_Sig(Col_Scan_Sig)
	);
	
	
endmodule
