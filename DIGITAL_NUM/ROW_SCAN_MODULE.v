//////////////////////////////////////////////////
//// ROW_SCAN_MODULE.v
//// 					ZHAOCHAO
////						2016-11-13
///////////////////////////////////////////////////////////
////

module ROW_SCAN_MODULE
(
	CLK, RSTn, 
	Ten_SMG_Data, One_SMG_Data,
	Row_Scan_Sig
);

	input CLK;
	input RSTn;
	input [7:0]Ten_SMG_Data;
	input [7:0]One_SMG_Data;
	output [7:0]Row_Scan_Sig;
	
	
	//// 50M*0.01=499_999
	parameter T10MS = 19'd499_999;
	
	
	reg [18:0]Count1;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			Count1 <= 19'd0;
		else if(Count1 == T10MS)
			Count1 <= 19'd0;
		else 
			Count1 <= Count1 + 1'b1;
			
	//////////////////////////////
	
	
	reg [1:0]rSel_index;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			rSel_index <= 2'd0;
		else if(rSel_index == 2'd2)
			rSel_index <= 2'd0;
		else if(Count1 == T10MS)
			rSel_index <= rSel_index + 1'b1;
			

	
	///////////////////////////////////////////
	
	reg [7:0]rData;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			rData <= 8'd0;
		else if(Count1 == T10MS)
			case (rSel_index)
				2'd0:
					rData <= Ten_SMG_Data;
				2'd1:
					rData <= One_SMG_Data;
			endcase
			
	/////////////////////////////////////
	
	assign Row_Scan_Sig = rData;
	
endmodule
