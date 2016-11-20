/////////////////////////////////////
//// H2L_DETECT_MODULE.v
//// 				ZHAOCHAO
//// 					2016-11-14
/////////////////////////////////////////////////////
////

module H2L_DETECT_MODULE
(
	CLK, RSTn,
	PS2_CLK_Pin_In,
	H2L_Sig
);

	input CLK;
	input RSTn;
	input PS2_CLK_Pin_In;
	output H2L_Sig;
	
	////////////////////
	
	reg rH2L_F1;
	reg rH2L_F2;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			begin	
				rH2L_F1 <= 1'b0;
				rH2L_F2 <= 1'b0;
			end
		else 
			begin 
				rH2L_F1 <= PS2_CLK_Pin_In;
				rH2L_F2 <= rH2L_F1;
			end
			
	/////////////////////////////////////////
	
	assign H2L_Sig = rH2L_F2 & !rH2L_F1;
	
	
endmodule
