////////////////////////////////////////////////
////  FLASH_LED_MODULE.v
//// 					ZHAOCHAO
////						2016-11-13
/////////////////////////////////////////////////////////////////////
////

module run_module
(
	CLK, RSTn, LED_Out
);

	input CLK;
	input RSTn;
	output [2:0]LED_Out;

	//// System CLK = 50MHz, 50M*0.0001-1=49_999
	parameter T1MS = 16'd49_999;
	
	
	reg [15:0]Count1;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			Count1 <= 16'd0;
		else if(Count1 == T1MS)
			Count1 <= 16'd0;
		else 
			Count1 <= Count1 + 1'b1;
			
	//////////////////////////////////////////////////
	
	reg [9:0]Count_MS;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			Count_MS <= 10'd0;
		else if(Count_MS == 10'd100)
			Count_MS <= 10'd0;
		else if(Count1 == T1MS)
			Count_MS <= Count_MS + 1'b1;
			
	////////////////////////////////////////////////////
	
	
	reg [2:0]rLED_Out;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			rLED_Out <= 3'b001;
		else if(Count_MS == 10'd100)
			begin	
				if (rLED_Out == 3'b000)
					rLED_Out <= 3'b001;
				else 
					rLED_Out <= {rLED_Out[1:0], 1'b0};
					
			end
	
	///////////////////////////////////////////////////////////
	
	assign LED_Out = rLED_Out;
	
	
endmodule
