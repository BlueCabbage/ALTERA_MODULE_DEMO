////////////////////////////////////////////////////////
//// DRAW_MODULE.v
//// 			ZHAOCHAO
//// 				2016-11-16
////////////////////////////////////////////////////////////////
////

module DRAW_MODULE
(
	CLK, RSTn,
	Start_Sig,
	SPI_Out,
	Done_Sig
);

	input CLK;
	input RSTn;
	input Start_Sig;
	output [3:0]SPI_Out;
	output Done_Sig;
	
	//////////////////////////////////////////////
	
	wire SPI_Start_Sig;
	wire [9:0]SPI_Data;
	wire [9:0]Rom_Addr;
	
	
	DRAW_CTL_MODULE U10
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(Start_Sig),
		.Draw_Data(Draw_Data),
		.SPI_Done_Sig(SPI_Done_Sig),
		.SPI_Data(SPI_Data),
		.SPI_Start_Sig(SPI_Start_Sig),
		.Rom_Addr(Rom_Addr),
		.Done_Sig(Done_Sig)
	);
	
	
	////////////////////////////////////////////////////////////
	
	wire [7:0]Draw_Data;
	
	ROM U2
	(
		.clock(CLK),
		.address(Rom_Addr),
		.q(Draw_Data)
	);
	
	
	////////////////////////////////////////////
	
	wire SPI_Done_Sig;
	
	SPI_WRITE_MODULE U3
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(SPI_Start_Sig),
		.SPI_Data(SPI_Data),
		.Done_Sig(SPI_Done_Sig),
		.SPI_Out(SPI_Out)
	);
	
	
endmodule
