//////////////////////////////////////////////////////
////  OPTION_PWM_MODULE.v
////				ZHAOCHAO
//// 					2016-11-19
//////////////////////////////////////////////////////////////////
////

module OPTION_PWM_MODULE
(
	CLK, RSTn,
	Option_Key,
	Out_Pin
);

	input CLK;
	input RSTn;
	input [4:0]Option_Key;
	output Out_Pin;
	
	
	//// output frequece: 1K, min step: (1/256)*1K
	parameter SEGMENT = 8'd195; // 3.9us
	
	//// Key[4]: PWM += 10 step;
	//// Key[3]: PWM -= 10 step;
	//// Key[2]: PWM += 1  step;
	//// Key[1]: PWM -= 1  step;
	//// Key[0]: PWM ==    (1/2)max step;
	
	reg [7:0]C1;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			C1 <= 8'd0;
		else if (C1 == SEGMENT)
			C1 <= 8'd0;
		else 
			C1 <= C1 + 1'b1;
		

	/////////////////////////////////////////////////////////
	
	reg [7:0]System_Seg;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			System_Seg <= 8'd0;
		else if (System_Seg == 8'd255)
			System_Seg <= 8'd0;
		else if (C1 == SEGMENT)
			System_Seg <= System_Seg + 1'b1;
		
		
		
	////////////////////////////////////////////////////

	reg [7:0]Option_Seg;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			Option_Seg <= 8'd0;
			
		else if (Option_Key[4]) // segment + 10;
			if (Option_Seg < 8'd245)
				Option_Seg <= Option_Seg + 8'd10;
			else
				Option_Seg <= 8'd255;
			
		else if (Option_Key[3]) // segment - 10;
			if (Option_Seg > 8'd10)
				Option_Seg <= Option_Seg - 8'd10;
			else
				Option_Seg <= 8'd0; 
				
		else if (Option_Key[2]) // segment + 1;
			if (Option_Seg < 8'd255)
				Option_Seg <= Option_Seg + 8'd1;
			else 
				Option_Seg <= 8'd255;
				
		else if (Option_Key[1]) // segment - 1;
			if (Option_Seg > 8'd1)
				Option_Seg <= Option_Seg + 8'd1;
			else
				Option_Seg <= 8'd0;
				
		else if (Option_Key[0]) // segment / 2;
			Option_Seg <= 8'd127;
			
			
	////////////////////////////////////////////////////////////
	
	assign Pin_Out = ( System_Seg < Option_Seg) ? 1'b1 : 1'b0;
	
	
endmodule
	