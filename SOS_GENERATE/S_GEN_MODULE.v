////////////////////////////////////////////////////////
//// S_GEN_MODULE.v
////				ZHAOCHAO
////					2016-11-14
/////////////////////////////////////
////

module S_GEN_MODULE
(
	CLK, RSTn,
	Start_Sig,
	Done_Sig,
	Pin_Out
);

	input CLK;
	input RSTn;
	input Start_Sig;
	output Done_Sig;
	output Pin_Out;
	
	
	//// 50M * 0.001 - 1 = 49_999;
	parameter T1MS = 16'd49_999;
	
	
	reg [15:0]Count1;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			Count1 <= 16'd0;
		else if (Count1 == T1MS)
			Count1 <= 16'd0;
		else if (isCount)
			Count1 <= Count1 + 1'b1;
		else if (!isCount)
			Count1 <= 16'd0;
			
	/////////////////////////////////
	
	
	reg [9:0]Count_MS;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			Count_MS <= 10'd0;
		else if (Count_MS == rTimes)
			Count_MS <= 10'd0;
		else if (Count1 == T1MS)
			Count_MS <= Count_MS + 1'b1;
			
			
	////////////////////////////////////////////
	
	reg [3:0]state_index;
	reg rPin_Out;
	reg [9:0]rTimes;
	reg isCount;
	reg isDone;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin 
				state_index <= 4'd0;
				rPin_Out <= 1'b1;
				rTimes <= 10'd1000;
				isCount <= 1'b0;
				isDone <= 1'b0;
			end
			
		else if (Start_Sig)
			case (state_index)
				
				4'd0, 4'd2, 4'd4:
					if (Count_MS == rTimes)
						begin	
							rPin_Out <= 1'b0;
							isCount <= 1'b0;
							state_index <= state_index + 1'b1;
						end
					else 
						begin
							isCount <= 1'b1;
							rPin_Out <= 1'b1;
							rTimes <= 10'd100;
						end
					
				4'd1, 4'd3, 4'd5:
					if (Count_MS == rTimes)
						begin 
							isCount <= 1'b0; 
							state_index <= state_index + 1'b1;
						end
					else
						begin
							isCount <= 1'b1;
							rTimes <= 10'd50;
						end
						
				4'd6:
					begin
						isDone <= 1'b1;
						state_index <= state_index + 1'b1;
					end
				
				4'd7:
					begin 
						isDone <= 1'b0;
						state_index <= 4'd0;
					end		
		endcase
		
		
	//////////////////////////////////////////
	
	assign Done_Sig = isDone;
	assign Pin_Out = !rPin_Out;
	
endmodule
	
	
	
	