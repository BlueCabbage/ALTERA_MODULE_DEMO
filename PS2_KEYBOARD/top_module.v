/////////////////////////////////////
//// top_module.v
//// 				ZHAOCHAO
//// 					2016-11-14
/////////////////////////////////////////////////////
////

module top_module
(
	CLK, RSTn,
	PS2_CLK_Pin_In, PS2_Data_Pin_In,
	Data_Out
);

	input CLK;
	input RSTn;
	input PS2_CLK_Pin_In;
	input PS2_Data_Pin_In;
	output [3:0]Data_Out;
	
	
	/////////////////////////////////////////////////
	
	wire [7:0]PS2_Data;
	wire PS2_Done_Sig;
	
	PS2_MODULE U5
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.PS2_CLK_Pin_In(PS2_CLK_Pin_In),
		.PS2_Data_Pin_In(PS2_Data_Pin_In),
		.PS2_Data(PS2_Data),
		.PS2_Done_Sig(PS2_Done_Sig)
	);
	
	////////////
	
	CMD_CTL_MODULE U6
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.PS2_Done_Sig(PS2_Done_Sig),
		.PS2_Data(PS2_Data),
		.Data_Out(Data_Out)
	);
	
	
endmodule
