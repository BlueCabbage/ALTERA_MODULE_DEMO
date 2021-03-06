//////////////////////////////////////////////////////////////////////
//// DS1302_MODULE.v
//// 			ZHAOCHAO
//// 				2016-11-18
//////////////////////////////////////////////////////
////

module DS1302_MODULE
(
	CLK, RSTn,
	Start_Sig,
	Done_Sig,
	
	Time_Write_Data,
	Time_Read_Data,
	
	RST,
	SCLK,
	SIO
);

	input CLK;
	input RSTn;
	
	input [7:0]Start_Sig;
	output Done_Sig;
	
	input [7:0]Time_Write_Data;
	output [7:0]Time_Read_Data;
	
	output RST;
	output SCLK;
	inout SIO;
	
	
	
	wire [7:0]Words_Addr;
	wire [7:0]Write_Data;
	wire [1:0]Access_Start_Sig;
	
	
	DS1302_CMD_CTL_MODULE U1 
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(Start_Sig),
		.Done_Sig(Done_Sig),
		.Time_Write_Data(Time_Write_Data),
		.Time_Read_Data(Time_Read_Data),
		.Access_Start_Sig(Access_Start_Sig),
		.Access_Done_Sig(Access_Done_Sig),
		.Read_Data(Read_Data),
		.Words_Addr(Words_Addr),
		.Write_Data(Write_Data)
	);
	
	
	
	wire [7:0]Read_Data;
	wire Access_Done_Sig;
	
	
	FUNCTION_MODULE U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(Access_Start_Sig),
		.Words_Addr(Words_Addr),
		.Write_Data(Write_Data),
		.Done_Sig(Access_Done_Sig),
		.Read_Data(Read_Data),
		.RST(RST),
		.SCLK(SCLK),
		.SIO(SIO)
	);
	
	
	
endmodule

		