////////////////////////////////////////////////
//// TX_INTERFACE.v
//// 			ZHAOCHAO
//// 				2016-11-20
////////////////////////////////////////////////////////
////

module TX_INTERFACE
(
	CLK, RSTn,
	Write_Req_Sig,
	FIFO_Write_Data,
	Full_Sig,
	TX_Pin_Out
);

	input CLK;
	input RSTn;
	
	input Write_Req_Sig;
	input [7:0]FIFO_Write_Data;
	output Full_Sig;
	
	output TX_Pin_Out;

	
	wire [7:0]FIFO_Read_Data;
	wire Empty_Sig;
	
	TX_FIFO_MODULE U1 
	(
		.clock(CLK),
		.wrreq(Write_Req_Sig),
		.data(FIFO_Write_Data),
		.full(Full_Sig),
		.rdreq(Read_Req_Sig),
		.q(FIFO_Read_Data),
		.empty(Empty_Sig)
	);
	
	///////////////////////////////////////
	
	
	wire Read_Req_Sig;
	wire [7:0]TX_Data;
	wire TX_En_Sig;
	
	TX_TOP_CTL_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Empty_Sig(Empty_Sig),
		.FIFO_Read_Data(FIFO_Read_Data),
		.Read_Req_Sig(Read_Req_Sig),
		.TX_Done_Sig(TX_Done_Sig),
		.TX_Data(TX_Data),
		.TX_En_Sig(TX_En_Sig)
	);
	
	//////////////////////////////
	
	wire TX_Done_Sig;
	
	TX_MODULE U3
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.TX_Data(TX_Data),
		.TX_En_Sig(TX_En_Sig),
		.TX_Done_Sig(TX_Done_Sig),
		.TX_Pin_Out(TX_Pin_Out)
	);
	
	
endmodule
