///////////////////////////////////////////////
//// top_module.v
//// 			ZHAOCHAO
////				2016-11-14
///////////////////////////////////////////////////////////
////

module top_module
(
	CLK, RSTn,
	Start_Sig,
	Done_Sig,
	Pin_Out
);
	input CLK;
	input RSTn;
	input Start_Sig;
	output Done_Sig;
	output Pin_Out;
	
	
	/////////////////////////////////////
	
	wire S_Done_Sig;
	wire S_Pin_Out;
	
	
	S_GEN_MODULE U1
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(S_Start_Sig),
		.Done_Sig(S_Done_Sig),
		.Pin_Out(S_Pin_Out)
	);
	
	
	
	/////////////////////
	
	wire O_Done_Sig;
	wire O_Pin_Out;
	
	O_GEN_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(O_Start_Sig),
		.Done_Sig(O_Done_Sig),
		.Pin_Out(O_Pin_Out)
	);
	
	
	
	/////////////////
	
	
	wire S_Start_Sig;
	wire O_Start_Sig;
	
	SOS_CTL_MODULE U3
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(Start_Sig),
		.S_Start_Sig(S_Start_Sig),
		.O_Start_Sig(O_Start_Sig),
		.S_Done_Sig(S_Done_Sig),
		.O_Done_Sig(O_Done_Sig)
	);
	
	
	//// selector
	
	reg Pin_Out;
	
	always@(*)
		if (S_Start_Sig)
			Pin_Out = S_Pin_Out;
		else if (O_Start_Sig)
			Pin_Out = O_Pin_Out;
		else
			Pin_Out = 1'bx;
			
	//////////
	
	
endmodule

			
		
		