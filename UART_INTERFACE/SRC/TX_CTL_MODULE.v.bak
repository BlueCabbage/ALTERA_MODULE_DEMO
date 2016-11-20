////////////////////////////////////////////////
//// TX_CTL_MODULE.v
//// 				ZHAOCHAO
////					2016-11-14
//////////////////////////////////////////////////////////////
////

module TX_CTL_MODULE
(
	CLK, RSTn,
	TX_En_Sig, TX_Data, BPS_CLK,
	TX_Done_Sig, TX_Pin_Out
);

	input CLK;
	input RSTn;
	input TX_En_Sig;
	input [7:0]TX_Data;
	input BPS_CLK;
	output TX_Done_Sig;
	output TX_Pin_Out;
	
	////////////////////////////////
	
	reg [3:0]state_index;
	reg rTX;
	reg isDone;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin 	
				state_index <= 4'd0;
				rTX <= 1'b1;
				isDone <= 1'b0;
				
			end
		else if (TX_En_Sig)
			case (state_index)
				4'd0:
					if (BPS_CLK)
						begin 
							state_index <= state_index + 1'b1;
							rTX <= 1'b0;
						end
					
				4'd1, 4'd2, 4'd3, 4'd4,
				4'd5, 4'd6, 4'd7, 4'd8:
					if (BPS_CLK)
						begin	
							state_index <= state_index + 1'b1;
							rTX <= TX_Data[state_index - 1];
						end
					
				4'd9:
					if (BPS_CLK)
						begin
							state_index <= state_index + 1'b1;
							rTX <= 1'b1;
						end
				
				4'd10:
					if (BPS_CLK)
						begin 
							state_index <= state_index + 1'b1;
							rTX <= 1'b1;
						end
						
				4'd11:
					if (BPS_CLK)
						begin
							state_index <= state_index + 1'b1;
							isDone <= 1'b1;
						end
				
				4'd12:
					begin
						state_index <= 1'b0;
						isDone <= 1'b0;
					end
			endcase
	
	//////////////////////////////////////////////////
	
	assign TX_Pin_Out = rTX;
	assign TX_Done_Sig = isDone;
	
	
endmodule
		