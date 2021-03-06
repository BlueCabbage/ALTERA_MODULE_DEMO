//////////////////////////////////////////////////////
//// RX_TOP_CTL_MODULE.v
//// 				ZHAOCHAO
//// 					2016-11-20
///////////////////////////////////////////////////////////
////

module RX_TOP_CTL_MODULE
(
	CLK, RSTn,
	RX_Done_Sig,
	RX_Data,
	RX_En_Sig,
	Full_Sig,
	Write_Req_Sig,
	FIFO_Write_Data
);

	input CLK;
	input RSTn;
	
	input RX_Done_Sig;
	input [7:0]RX_Data;
	output RX_En_Sig;
	
	input Full_Sig;
	output Write_Req_Sig;
	output [7:0]FIFO_Write_Data;
	

	
	reg [1:0]state_index;
	reg isWrite;
	reg isRX;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				state_index <= 2'd0;
				isWrite <= 1'b0;
				isRX <= 1'b0;
			end
		else
			case (state_index)
				2'd0:
					if (RX_Done_Sig)
						begin
							state_index <= state_index + 1'b1;
							isRX <= 1'b0;
						end
					else
						isRX <= 1'b1;
					
				2'd1:
					if (!Full_Sig)
						state_index <= state_index + 1'b1;
						
				2'd2:
					begin
						isWrite <= 1'b1;
						state_index <= state_index + 1'b1;
					end
					
				2'd3:
					begin
						isWrite <= 1'b0;
						state_index <= 2'd0;
					end
			
			endcase
			
	//////////////////////////////////////////
	
	assign RX_En_Sig = isRX;
	assign Write_Req_Sig = isWrite;
	assign FIFO_Write_Data = RX_Data;
	
endmodule
