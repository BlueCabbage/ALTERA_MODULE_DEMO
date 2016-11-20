/////////////////////////////////////////////////////////
//// LCD_CTL_MODULE.v
////			ZHAOCHAO
//// 				2016-11-16
//////////////////////////////////////////////////////////
////

module LCD_CTL_MODULE
(
	CLK, RSTn,
	Init_Done_Sig, Draw_Done_Sig,
	Init_Start_Sig, Draw_Start_Sig
);

	input CLK;
	input RSTn;
	input Init_Done_Sig;
	input Draw_Done_Sig;
	output Init_Start_Sig;
	output Draw_Start_Sig;
	
	
	//////////////////////////////////////////////////
	
	
	reg [3:0]state_index;
	reg isInit;
	reg isDraw;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				state_index <= 4'd0;
				isInit <= 1'b0;
				isDraw <= 1'b0;
			end
		else 
			case (state_index)
		
				4'd0:
					if (Init_Done_Sig)
						begin
							isInit <= 1'b0;
							state_index <= state_index + 1'b1;
						end
					else
						begin
							isInit <= 1'b1;
						end
					
				4'd1:
					if (Draw_Done_Sig)
						begin
							isDraw <= 1'b0;
							state_index <= state_index + 1'b1;
						end
					else
						begin
							isDraw <= 1'b1;
						end
					
				4'd2:
					state_index <= 4'd2;
			
			endcase
			
	////////////////////////////////////////////////////
	
	assign Init_Start_Sig = isInit;
	assign Draw_Start_Sig = isDraw;
	
	
endmodule

						