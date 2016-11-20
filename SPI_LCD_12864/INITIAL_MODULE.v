////////////////////////////////////////////////////////////
//// INITIAL_MODULE.v
//// 			ZHAOCHAO
////				2016-11-15
////////////////////////////////////////////////////////////////////////
////

module INITIAL_MODULE
(
	CLK, RSTn,
	Start_Sig,
	Done_Sig,
	SPI_Out
);

	input CLK;
	input RSTn;
	input Start_Sig;
	output Done_Sig;
	//// [3]:CS, [2]:A0, [1]:CLK, [0]:DO
	output [3:0]SPI_Out; 	
	
	
	//////////////////////////////
	
	wire SPI_Start_Sig;
	wire [9:0]SPI_Data;
	
	
	INITIAL_CTL_MODULE U1
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(Start_Sig),
		.SPI_Done_Sig(SPI_Done_Sig),
		.SPI_Start_Sig(SPI_Start_Sig),
		.SPI_Data(SPI_Data),
		.Done_Sig(Done_Sig)
	);
	
	/////////////////////////////////////////////
	
	wire SPI_Done_Sig;
	
	SPI_WRITE_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(SPI_Start_Sig),
		.SPI_Data(SPI_Data),
		.Done_Sig(SPI_Done_Sig),
		.SPI_Out(SPI_Out)
	);
	
	
endmodule

 