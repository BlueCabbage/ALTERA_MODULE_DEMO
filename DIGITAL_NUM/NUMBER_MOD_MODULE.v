//////////////////////////////////////////////////
//// NUMBER_MOD_MODULE.v
//// 					ZHAOCHAO
////						2016-11-13
///////////////////////////////////////////////////////////
////

module NUMBER_MOD_MODULE
(
	CLK, RSTn, Num_Data,
	Ten_Data, One_Data
);

	input CLK;
	input RSTn;
	input Num_Data;
	output Ten_Data;
	output One_Data;
	
	/////
	
	reg [31:0]rTen;
	reg [31:0]rOne;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			begin
				rTen <= 32'd0;
				rOne <= 32'd0;
			end
		else 
			begin
				rTen <= Num_Data / 10;
				rOne <= Num_Data % 10;
			end
	
	///////////////////////////////////////////////////////////
	
	assign Ten_Data = rTen;
	assign One_Data = rOne;
	
	
endmodule
