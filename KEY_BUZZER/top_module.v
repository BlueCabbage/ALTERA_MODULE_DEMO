///////////////////////////////////////////////////////
//// top_module.v
//// 				ZHAOCHAO
////					2016-11-13
//////////////////////////////////
////

module top_module
(
	CLK, RSTn, Pin_In, Pin_Out
);

	input CLK;
	inout RSTn;
	input Pin_In;
	output Pin_Out;
	
	
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
	
	////////////////////////////////////////////////
	
	DELAY_MODULE U_delay_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.H2L_Sig(H2L_Sig),
		.L2H_Sig(L2H_Sig),
		.Pin_Out(Trig_Sig)
	);
	
	///////////////////////////////////////
	
	
	wire En_Sig;
	
	INTER_CTL_MODULE U_inter_ctl_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Trig_Sig(Trig_Sig),
		.En_Sig(En_Sig)
	);
	
	////////////////////////////////////
	
	BUZZER_SOS_MODULE U_buzzer_sos_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.En_Sig(En_Sig),
		.Pin_Out(Pin_Out)
	);
	
	
endmodule
