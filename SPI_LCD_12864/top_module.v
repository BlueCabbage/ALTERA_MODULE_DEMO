//////////////////////////////////////////////////////////////
//// top_module.v
//// 		ZHAOCHAO
//// 			2016-11-16
////////////////////////////////////////////////////////
////

module top_module
(
	CLK, RSTn,
	SPI_Out
);

	input CLK;
	input RSTn;
	output [3:0]SPI_Out;
	
	
	/////////////////////////////////////////
	
	wire Init_Start_Sig;
	wire Draw_Start_Sig;
	
	LCD_CTL_MODULE U4
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Init_Done_Sig(Init_Done_Sig),
		.Draw_Done_Sig(Draw_Done_Sig),
		.Init_Start_Sig(Init_Start_Sig),
		.Draw_Start_Sig(Draw_Start_Sig)
	);
	
	
	//////////////////////////////////
	
	wire Init_Done_Sig;
	wire [3:0]Init_SPI_Out;
	
	INITIAL_MODULE U5
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(Init_Start_Sig),
		.Done_Sig(Init_Done_Sig),
		.SPI_Out(Init_SPI_Out)
	);
	
	
	///////////////////////////////////////
	
	wire Draw_Done_Sig;
	wire [3:0]Draw_SPI_Out;
	
	DRAW_MODULE U6
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(Draw_Start_Sig),
		.Done_Sig(Draw_Done_Sig),
		.SPI_Out(Draw_SPI_Out)
	);
	
	
	///////////////////////////////////
	
	reg [3:0]rSPI_Out;
	
	always@(*)
		if (Init_Start_Sig)
			rSPI_Out = Init_SPI_Out;
		else if (Draw_Start_Sig)
			rSPI_Out = Draw_SPI_Out;
		else
			rSPI_Out <= 3'bx;
			
	/////////////////////////////////////////////////////////////
	
	assign SPI_Out = rSPI_Out;
	
endmodule
