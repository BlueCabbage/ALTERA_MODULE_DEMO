////////////////////////////////////////////////
//// TX_BPS_MODULE.v
//// 				ZHAOCHAO
////					2016-11-14
//////////////////////////////////////////////////////////////
////

module TX_BPS_MODULE
(
	CLK, RSTn,
	Count_Sig,
	BPS_CLK
);

	input CLK;
	input RSTn;
	input Count_Sig;
	output BPS_CLK;
	
	
	//// 9600bps, T = 0.0001041666666666667s
	//// 50M*0.0001041666667 = 5208, 5208/2=2604;
	
	reg [12:0]Count_BPS;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			Count_BPS <= 13'd0;
		else if (Count_BPS == 13'd5207)
			Count_BPS <= 13'd0;
		else if (Count_Sig)
			Count_BPS <= Count_BPS + 1'b1;
		else 
			Count_BPS <= 13'd0;
			
	////////////////////////////////
	
	assign BPS_CLK = (Count_BPS == 13'd2604) ? 1'b1 : 1'b0;
	
	
endmodule
