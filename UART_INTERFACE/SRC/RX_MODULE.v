////////////////////////////////////////////////////////////////
//// RX_MODULE.v
//// 			 		ZHAOCHAO
//// 						2016-11-14
////////////////////////////////////////////
////
	
module RX_MODULE
(
	CLK, RSTn,
	RX_Pin_In, RX_En_Sig,
	RX_Done_Sig, RX_Data,
	
	LED_OUT
);

	input CLK;
	input RSTn;
	
	input RX_Pin_In;
	input RX_En_Sig;
	
	output [7:0]RX_Data;
	output RX_Done_Sig;
	
	output [3:0]LED_OUT;
	
	
	///////////////////////////////////
	
	wire H2L_Sig;
	
	H2L_DETECT_MODULE U1 
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.RX_Pin_In(RX_Pin_In),
		.H2L_Sig(H2L_Sig)
	);
	
	
	/////////////////////////////////
	
	wire BPS_CLK;
	
	RX_BPS_MODULE U10
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Count_Sig(Count_Sig),
		.BPS_CLK(BPS_CLK)
	);
	
	//////////////////////////////////////
	
	wire Count_Sig;
	
	RX_CTL_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		
		.H2L_Sig(H2L_Sig),
		.RX_En_Sig(RX_En_Sig),
		.RX_Pin_In(RX_Pin_In),
		.BPS_CLK(BPS_CLK),
		
		.Count_Sig(Count_Sig),
		.RX_Data(RX_Data),
		.RX_Done_Sig(RX_Done_Sig),
		
		.LED_OUT(LED_OUT)
	);
	
	/////////////////////////
	
endmodule
