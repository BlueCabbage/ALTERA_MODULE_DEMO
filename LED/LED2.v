///////////////////////////////////////
//// led2_module.v
////               ZHAOCHAO
//// 			           2016-11-13
////////////////////////////////////////////////////////
////

module led2_module
(
	CLK, RSTn, LED_Out
);

	input CLK;
	input RSTn;
	output LED_Out;

	//// System_clk = 50MHz, 50M*0.01 = 5_000_000;
	parameter T100MS = 23'd5_000_000;

	reg [22:0]Count1;

	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			Count1 <= 23'd0;
		else if(Count1 == T100MS)
			Count1 <= 23'd0;
		else
			Count1 <= Count1 + 1'b1;
			
	////////////////////////////////////////////

	reg rLED_Out;

	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			rLED_Out <= 0;
		else if(Count1 >= 23'd2_750_000 && Count1 < 23'd3_750_000)
			rLED_Out = 1'b1;
		else 
			rLED_Out = 1'b0;
			
	///////////////////////////////////////////

	assign LED_Out = rLED_Out;


endmodule
