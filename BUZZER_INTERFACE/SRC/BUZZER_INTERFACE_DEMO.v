/////////////////////////////////////////////////
//// BUZZER_INTERFACE_DEMO.v
//// 					ZHAOCHAO
//// 						2016-11-20
///////////////////////////////////////////////////////
////

module BUZZER_INTERFACE_DEMO
(
	CLK, RSTn,
	Pin_Out
);

	input CLK;
	input RSTn;
	output Pin_Out;

	

	reg [3:0]state_index;
	reg isWrite;
	reg [7:0]rData;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				state_index <= 4'd0;
				isWrite <= 1'b0;
				rData <= 8'h0;
			end
		else
			case (state_index)
			
			////////////////////////////////////////////////////////
			/*
				4'd0:
					if (!Full_Sig)
						begin
							isWrite <= 1'b1;
							rData <= 8'h1b;
							state_index <= state_index + 1'b1;
						end
					
				4'd1:
					if (!Full_Sig)
						begin
							rData <= 8'h44;
							state_index <= state_index + 1'b1;
						end
				4'd2:
					if (!Full_Sig)
						begin
							rData <= 8'h1b
							state_index <= state_index + 1'b1;
						end
				
				4'd3:
					begin
						isWrite <= 1'b0;
						state_index <= 4'd3;
					end
			*/
			///////////////////////////////////////////////////
			
				4'd0:
					if (!Full_Sig)
						begin
							isWrite <= 1'b1;
							rData <= 8'h1b;
							state_index <= state_index + 1'b1;
						end
						
				4'd1:
					begin
						isWrite <= 1'b0;
						state_index <= state_index + 1'b1;
					end 
					
				4'd2:
					if (!Full_Sig)
						begin
							isWrite <= 1'b1;
							rData <= 8'h44;
							state_index <= state_index + 1'b1;
						end
				
				4'd3:
					begin
						isWrite <= 1'b0;
						state_index <= state_index + 1'b1;
					end
					
				4'd4:
					if (!Full_Sig)
						begin
							isWrite <= 1'b1;
							rData <= 8'h1b;
							state_index <= state_index + 1'b1;
						end
						
				4'd5:
					begin
						isWrite <= 1'b0;
						state_index <= 4'd5;
					end
			
		endcase
		
		
		wire Full_Sig;
		
		BUZZER_INTERFACE U1
		(
			.CLK(CLK),
			.RSTn(RSTn),
			.Write_Req_Sig(isWrite),
			.FIFO_Write_Data(rData),
			.Full_Sig(Full_Sig),
			.Pin_Out(Pin_Out)
		);
		
		
endmodule

							
							
					
					