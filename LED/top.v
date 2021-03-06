///////////////////////////////////////
//// top_module
////               ZHAOCHAO
//// 			           2016-11-13
////////////////////////////////////////////////////////
////

module top_module
(
	CLK, RSTn, LED_Out
);

	input CLK;
	input RSTn;
	output [3:0]LED_Out;
	
	
	//////////////////////////////////////////////////
	
	wire LED0_Out;
	
	led0_module U_LED0_Inst(
		.CLK(CLK),
		.RSTn(RSTn),
		.LED_Out(LED0_Out)
	);
	
	
	//////////////////////////////////////////////////////
	
	wire LED1_Out;
	
	led1_module U_LED1_Inst(
		.CLK(CLK),
		.RSTn(RSTn),
		.LED_Out(LED1_Out)
	);
	
	//////////////////////////////////////////////////////
	
	wire LED2_Out;
	
	led2_module U_LED2_Inst(
		.CLK(CLK),
		.RSTn(RSTn),
		.LED_Out(LED2_Out)
	);
	
	/////////////////////////////////////////////////////////
	
	wire LED3_Out;
	
	led3_module U_LED3_Inst(
		.CLK(CLK),
		.RSTn(RSTn),
		.LED_Out(LED3_Out)
	);
	
	////////////////////////////////////////////////////////////
	
	
	assign LED_Out = {LED3_Out, LED2_Out, LED1_Out, LED0_Out};
	
endmodule
	