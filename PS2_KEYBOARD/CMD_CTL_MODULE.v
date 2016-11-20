/////////////////////////////////////
//// CMD_CTL_MODULE.v
//// 				ZHAOCHAO
//// 					2016-11-14
/////////////////////////////////////////////////////
////

module CMD_CTL_MODULE
(
	CLK, RSTn,
	PS2_Done_Sig, PS2_Data,
	Data_Out
);

	input CLK;
	input RSTn;
	input PS2_Done_Sig;
	input [7:0]PS2_Data;
	output [3:0]Data_Out;
	
	
	///////////////////////////////////
	
	reg [3:0]rData;
	
	always@(posedge CLK or negedge RSTn)
		if(!RSTn)
			begin
				rData <= 4'b0001;
			end
		else if(PS2_Done_Sig)
			case (PS2_Data)
				
				8'h1d:
					rData <= {rData[2:0], rData[3]};
					
				8'h22:
					rData <= {rData[0], rData[3:1]};
				
				8'h14:
					rData <= {rData[0], rData[1], rData[2], rData[3]};
					
			endcase 
			
	/////////////////////////////////////
	
	assign Data_Out = rData;
	
	
endmodule
	