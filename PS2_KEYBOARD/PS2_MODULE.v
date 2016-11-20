/////////////////////////////////////
//// PS2_MODULE.v
//// 				ZHAOCHAO
//// 					2016-11-14
/////////////////////////////////////////////////////
////

module PS2_MODULE
(
	CLK, RSTn,
	PS2_CLK_Pin_In, PS2_Data_Pin_In,
	PS2_Data, PS2_Done_Sig
);

	input CLK;
	input RSTn;
	input PS2_CLK_Pin_In;
	input PS2_Data_Pin_In;
	output [7:0]PS2_Data;
	output PS2_Done_Sig;
	
	
	////////////////////////////////////////////
	
	
	wire H2L_Sig;
	
	H2L_DETECT_MODULE U1
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.PS2_CLK_Pin_In(PS2_CLK_Pin_In),
		.H2L_Sig(H2L_Sig)
	);
	
	
	PS2_DECODE_MODULE U2 
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.H2L_Sig(H2L_Sig),
		.PS2_Data_Pin_In(PS2_Data_Pin_In),
		.PS2_Data(PS2_Data),
		.PS2_Done_Sig(PS2_Done_Sig)
	);
	
	
endmodule

	