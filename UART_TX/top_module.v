////////////////////////////////////////////////
//// top_module.v
//// 				ZHAOCHAO
////					2016-11-14
//////////////////////////////////////////////////////////////
////

module top_module
(
	CLK, RSTn,
	TX_Pin_Out
);

	input CLK;
	input RSTn;
	output TX_Pin_Out;
	
	
	wire [7:0]TX_Data;
	wire TX_En_Sig;
	
	CTL_MODULE U3
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.TX_Done_Sig(TX_Done_Sig),
		.TX_En_Sig(TX_En_Sig),
		.TX_Data(TX_Data)
	);
	
	
	/////////////////////////////////////////////////
	
	wire TX_Done_Sig;
	
	TX_MODULE U4
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.TX_Data(TX_Data),
		.TX_En_Sig(TX_En_Sig),
		.TX_Pin_Out(TX_Pin_Out)
	);
	
endmodule
