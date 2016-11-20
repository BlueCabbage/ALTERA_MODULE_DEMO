///////////////////////////////////////////////
//// SMG_CTL_MODULE.v
//// 			ZHAOCHAO
//// 				2016-11-20
///////////////////////////////////////////////////////
////

module SMG_CTL_MODULE
(
	CLK, RSTn,
	Number_Sig,
	Number_Data
);

	input CLK;
	input RSTn;
	input [23:0]Number_Sig;
	output [3:0]Number_Data;
	
	//// 
	
	parameter T1MS = 16'd49999;
	
	reg [15:0]C1;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			C1 <= 16'd0;
		else if (C1 == T1MS)
			C1 <= 16'd0;
		else 
			C1 <= C1 + 1'b1;
			
	
	////////////////////////////////////
	
	reg [3:0]state_index;
	reg [3:0]rNumber;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			state_index <= 4'd0;
			rNumber <= 4'd0;
		else 
			case (state_index)
				4'd0:
					if (C1 == T1MS)
						state_index <= state_index + 1'b1;
					else 
						rNumber <= Number_Sig[23:20];
				
				4'd1:
					if (C1 == T1MS)
						state_index <= state_index + 1'b1;
					else
						rNumber <= Number_Sig[19:16];
					
				4'd2:
					if (C1 == T1MS)
						state_index <= state_index + 1'b1;
					else 
						rNumber <= Number_Sig[15:12];
				
				4'd3:
					if (C1 == T1MS)
						state_index <= state_index + 1'b1;
					else 
						rNumber <= Number_Sig[11:8];
						
				4'd4:
					if (C1 == T1MS)
						state_index <= state_index + 1'b1;
					else
						rNumber <= Number_Sig[7:4];
				
				4'd5:
					if (C1 == T1MS)
						state_index <= state_index + 1'b1;
					else
						rNumber <= Number_Sig[3:0];
						
			endcase
			
	////////////////////////////////////////////////
	
	assign Number_Data = rNumber;
	
endmodule


						