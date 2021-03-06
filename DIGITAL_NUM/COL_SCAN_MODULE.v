//////////////////////////////////////////////////
//// COL_SCAN_MODULE.v
//// 					ZHAOCHAO
////						2016-11-13
///////////////////////////////////////////////////////////
////

module COL_SCAN_MODULE
(
	CLK, RSTn, Col_Scan_Sig
);

	input CLK;
	input RSTn;
	output [1:0]Col_Scan_Sig;
	
	//// system clock: 50MHz, 50M*0.01-1=499_999;
	parameter T10MS = 19'd499_9999;
	
	
	reg [18:0]Count1;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
				Count1 <= 19'd0;
		else if(Count1 == T10MS)
			Count1 <= 19'd0;
		else
			Count1 <= Count1 + 1'b1;
			
			
	//////////////////////////////////////////////		
	
	reg [1:0]rSel_index;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			rSel_index <= 2'd0;
		else if(rSel_index == 2'd2)
			rSel_index <= 2'd0;
		else if(Count1 == T10MS)
			rSel_index <= rSel_index + 1'b1;
			
			
	////////////////////////////////////
	
	reg [1:0]rCol_Scan_Sig;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			rCol_Scan_Sig <= 2'b10;
		else if(Count1 == T10MS)
			case(rSel_index)
				2'd0:
					rCol_Scan_Sig <= 2'b10;
				2'd1:
					rCol_Scan_Sig <= 2'b10;
			endcase
			
	//////////////////////////////
	
	assign Col_Scan_Sig = rCol_Scan_Sig;
	
	
endmodule
			