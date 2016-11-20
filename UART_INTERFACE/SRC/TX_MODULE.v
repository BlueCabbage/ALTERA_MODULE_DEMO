////////////////////////////////////////////////
//// TX_MODULE.v
//// 				ZHAOCHAO
////					2016-11-14
//////////////////////////////////////////////////////////////
////

module TX_MODULE
(
	CLK, RSTn,
	TX_Data, TX_En_Sig,
	TX_Done_Sig, TX_Pin_Out
);

	input CLK;
	input RSTn;
	input [7:0]TX_Data;
	input TX_En_Sig;
	output TX_Done_Sig;
	output TX_Pin_Out;
	
	
	/////////////////////////////////////
	
	wire BPS_CLK;
	
	TX_BPS_MODULE U1
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Count_Sig(TX_En_Sig),
		.BPS_CLK(BPS_CLK)
	);
	
	
	/////////////////////////////////////////
	
	TX_CTL_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.TX_En_Sig(TX_En_Sig),
		.TX_Data(TX_Data),
		.BPS_CLK(BPS_CLK),
		.TX_Done_Sig(TX_Done_Sig),
		.TX_Pin_Out(TX_Pin_Out)
	);
	
	
endmodule
