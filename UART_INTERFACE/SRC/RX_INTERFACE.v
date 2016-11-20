//////////////////////////////////////////////////////////
//// RX_INTERFACE.v
//// 			ZHAOCHAO
//// 				2016-11-20
///////////////////////////////////////////////////////
////

module RX_INTERFACE
(
	CLK, RSTn,
	RX_Pin_In,
	Read_Req_Sig,
	FIFO_Read_Data,
	Empty_Sig,
	LED_OUT
);

	
	input CLK;
	input RSTn;
	
	input RX_Pin_In;
	
	input Read_Req_Sig;
	output Empty_Sig;
	output [7:0]FIFO_Read_Data;
	
	output [3:0]LED_OUT;
	
	
	
	wire [7:0]RX_Data;
	wire RX_Done_Sig;
	
	RX_MODULE U1
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.RX_Pin_In(RX_Pin_In),
		.RX_En_Sig(RX_En_Sig),
		.RX_Data(RX_Data),
		.RX_Done_Sig(RX_Done_Sig),
		
		.LED_OUT(LED_OUT)
	);
	
	
	///////////////////////////////////////
	
	wire RX_En_Sig;
	wire Write_Req_Sig;
	wire [7:0]FIFO_Write_Data;
	
	RX_TOP_CTL_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.RX_Done_Sig(RX_Done_Sig),
		.RX_Data(RX_Data),
		.RX_En_Sig(RX_En_Sig),
		.Full_Sig(Full_Sig),
		.Write_Req_Sig(Write_Req_Sig),
		.FIFO_Write_Data(FIFO_Write_Data)
	);
	
	
	////////////////////////////////////////////////
	
	wire Full_Sig;
	
	RX_FIFO_MODULE U3 
	(
		.clock(CLK),
		.wrreq(Write_Req_Sig),
		.data(FIFO_Write_Data),
		.full(Full_Sig),
		.rdreq(Read_Req_Sig),
		.q(FIFO_Read_Data),
		.empty(Empty_Sig)
	);
	
	//////////////////////////////////////////
	
	//assign LED_OUT = RX_Data[3:0];
	
	
endmodule

	