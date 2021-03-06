////////////////////////////////////////////////////
//// BUZZER_INTERFACE.v
//// 				ZHAOCHAO
//// 					2016-11-20
////////////////////////////////////////////////////////////
////

module BUZZER_INTERFACE
(
	CLK, RSTn,
	Write_Req_Sig,
	FIFO_Write_Data,
	Full_Sig,
	Pin_Out
);

	input CLK;
	input RSTn;
	input Write_Req_Sig;
	input [7:0]FIFO_Write_Data;
	output Full_Sig;
	output Pin_Out;
	
	
	
	wire [7:0]FIFO_Read_Data;
	wire Empty_Sig;
	
	BUZZER_FIFO_MODULE U1 
	(
		.clock(CLK),
		.wrreq(Write_Req_Sig),
		.full(Full_Sig),
		.rdreq(Read_Req_Sig),
		.q(FIFO_Read_Data),
		.empty(Empty_Sig)
	);
	
	
	////////////////////////////////////
	
	wire Read_Req_Sig;
	wire [1:0]Function_Start_Sig;
	
	BUZZER_CTL_MODULE U3
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.FIFO_Read_Data(FIFO_Read_Data),
		.Empty_Sig(Empty_Sig),
		.Read_Req_Sig(Read_Req_Sig),
		.Fun_Done_Sig(Function_Done_Sig),
		.Fun_Start_Sig(Function_Start_Sig)
	);
	

	/////////////////////////
	
	
	wire Function_Done_Sig;
	
	BUZZER_FUN_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(Function_Start_Sig),
		.Done_Sig(Function_Done_Sig),
		.Pin_Out(Pin_Out)
	);
	
endmodule
	
	
	