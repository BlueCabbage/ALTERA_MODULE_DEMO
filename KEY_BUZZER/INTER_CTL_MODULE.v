///////////////////////////////////////////////////////
//// KEY_DETECT_MODULE.v
//// 				ZHAOCHAO
////					2016-11-13
//////////////////////////////////
////

module INTER_CTL_MODULE
(
	CLK, RSTn, Trig_Sig, En_Sig
);

	input CLK;
	input RSTn;
	input Trig_Sig;
	output En_Sig;
	
	
	
	reg state_index;
	reg isEn;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			begin
				state_index <= 1'd0;
				isEn = 1'b0;
			end
		else
			case(state_index)
				2'd0:
					if(Trig_Sig)
						begin 
							isEn <= 1'b1;
							state_index <= state_index + 1'b1;
						end
					else
						begin 
							isEn <= 1'b0;
							state_index <= 1'd0;
						end
			endcase
			
	///////////////////////////
	
	assign En_Sig = isEn;
	
	
endmodule
