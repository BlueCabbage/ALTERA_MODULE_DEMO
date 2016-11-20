///////////////////////////////////////////////////////
//// KEY_DETECT_MODULE.v
//// 				ZHAOCHAO
////					2016-11-13
//////////////////////////////////
////

module DELAY_MODULE
(
	CLK, RSTn, H2L_Sig, L2H_Sig, Pin_Out
);

	input CLK;
	input RSTn;
	input H2L_Sig;
	input L2H_Sig;
	output [3:0]Pin_Out;
	
	
	//// 50M*0.001-1 = 49_999;
	parameter T1MS = 16'd49_999;
	
	
	
	// 1ms counter
	reg [15:0]Count1;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			Count1 <= 16'd0;
		else if(isCount && Count1 == T1MS)
			Count1 <= 16'd0;
		else if(isCount)
			Count1 <= Count1 + 1'b1;
		else if(!isCount)
			Count1 <= 16'd0;
			
	//////////////////////////////////////////
	
	// 10ms counter
	reg[3:0]Count_MS;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			Count_MS <= 4'd0;
		else if(isCount && Count1 == T1MS)
			Count_MS <= Count_MS + 1'b1;
		else if(!isCount)
			Count_MS <= 4'd0;
			
	////////////////////////////////////////////////////////
	
	reg rPin_Out;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			rPin_Out <= 1'b0;
		else if(rPin_Out_state)
			rPin_Out <= ~rPin_Out;
			

	///////////////////////////////////////////////////////////
	
	reg isCount;
	reg rPin_Out_state;
	reg[1:0]state_index;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			begin	
				isCount <= 1'b0;
				rPin_Out_state <= 1'b0;
				state_index <= 2'd0;
			end
		else
			case(state_index)
				3'd0:
					if(H2L_Sig)
						state_index <= 2'd1;
					else if(L2H_Sig)
						state_index <= 2'd3;
						
				3'd1:
					if(Count_MS == 4'd10)
						begin	
							isCount <= 1'b1;
							rPin_Out_state <= 1'b1;
							state_index <= 2'd2;
						end
					else 
						isCount <= 1'b1;
				
				3'd2:
					begin
						rPin_Out_state <= 1'b0;
						state_index <= 2'd0;
					end
						
				3'd3:
					if(Count_MS == 4'D10)
							begin 
								isCount <= 1'b0;
								//rPin_Out <= 1'b0;
								state_index <= 2'd0;
							end
						else 
							isCount <= 1'b1;
					
			endcase
			
	////////////////////////////////////////////////////
	
	assign Pin_Out = {4{rPin_Out}};
	
	
endmodule

	