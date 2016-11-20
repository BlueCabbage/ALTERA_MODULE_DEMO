////////////////////////////////////////////////////////////
//// TOP_MODULE.v
//// 					ZHAOCHAO
//// 						2016-11-13
//////////////////////////////////////////////////////////////
////

module top_module
(
	CLK, RSTn, Pin_Out
);

	input CLK;
	input RSTn;
	output Pin_Out;
	
	/////
	
	wire En_Sig;
	
	BUZZER_SOS_CTL_MODULE U_buzzer_sos_ctl_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.SOS_En_Sig(En_Sig)
	);
	
	
	////////////////////
	
	wire Pin_Out_Wire;
	
	BUZZER_SOS_MODULE U_buzzer_sos_module_Inst
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.En_Sig(En_Sig),
		.Pin_Out(Pin_Out_Wire)
	);
	
	
	/////////
	
	assign Pin_Out = !Pin_Out_Wire;

	
	
endmodule

