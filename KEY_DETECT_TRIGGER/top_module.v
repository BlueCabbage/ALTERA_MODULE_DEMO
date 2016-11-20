///////////////////////////////////////////////////////
//// TOP_MODULE.v
//// 				ZHAOCHAO
////					2016-11-13
//////////////////////////////////
////


module top_module 
(
	CLK, RSTn, Pin_In, Pin_Out
);

	input CLK;
	input RSTn;
	input Pin_In;
	output Pin_Out;
	
	//////////////////
	
	wire H2L_Sig;
	wire L2H_Sig;
	
	KEY_DETECT_MODULE U_key_detect_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Pin_In(Pin_In),
		.H2L_Sig(H2L_Sig),
		.L2H_Sig(L2H_Sig)
	);
	
	///////////////////////////////
	
	DELAY_MODULE U_delay_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.H2L_Sig(H2L_Sig),
		.L2H_Sig(L2H_Sig),
		.Pin_Out(Pin_Out)
	);
	
	
endmodule
