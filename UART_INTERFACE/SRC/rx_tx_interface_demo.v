//////////////////////////////////////////////////////////////////
//// rx_tx_interface_demo.v
//// 				ZHAOCHAO
//// 					2016-11-20
////////////////////////////////////////////////////////////////////////
////

module rx_tx_interface_demo
(
	CLK, RSTn,
	RX_Pin_In,
	TX_Pin_Out,
	LED_OUT
);

	input CLK;
	input RSTn;
	
	input RX_Pin_In;
	output TX_Pin_Out;
	output [3:0]LED_OUT;
	
	//////////////////////////
	
	
	wire [7:0]FIFO_Read_Data;
	wire Empty_Sig;
	
	wire [3:0]rLED;
	
	RX_INTERFACE U1
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.RX_Pin_In(RX_Pin_In),
		.Read_Req_Sig(Read_Req_Sig),
		.FIFO_Read_Data(FIFO_Read_Data),
		.Empty_Sig(Empty_Sig),
		.LED_OUT(rLED)
	);
	
	//////////////////////
	
	wire Read_Req_Sig;
	wire [7:0]FIFO_Write_Data;
	wire Write_Req_Sig;
	
	inter_ctl_module U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Empty_Sig(Empty_Sig),
		.FIFO_Read_Data(FIFO_Read_Data),
		.Read_Req_Sig(Read_Req_Sig),
		.Full_Sig(Full_Sig),
		.FIFO_Write_Data(FIFO_Write_Data),
		.Write_Req_Sig(Write_Req_Sig)
	);
	
	
	//////////////////////////////
	
	wire Full_Sig;
	
	TX_INTERFACE U3
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Write_Req_Sig(Write_Req_Sig),
		.FIFO_Write_Data(FIFO_Write_Data),
		.Full_Sig(Full_Sig),
		.TX_Pin_Out(TX_Pin_Out)
	);
	
	
///////////////////////////////

	//assign LED_OUT = {FIFO_Read_Data[3], FIFO_Read_Data[2], FIFO_Read_Data[1], FIFO_Read_Data[0] };
	//assign LED_OUT = FIFO_Read_Data[3:0];
	assign LED_OUT = rLED;
	
endmodule
