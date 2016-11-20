/////////////////////////////////////////
//// BUZZER_CTL_MODULE.v
//// 				ZHAOCHAO
//// 					2016-11-20
//////////////////////////////////////////////////////
////

module BUZZER_CTL_MODULE
(
	CLK, RSTn,
	FIFO_Read_Data,
	Empty_Sig,
	Read_Req_Sig,
	Fun_Done_Sig,
	Fun_Start_Sig
);

	input CLK;
	input RSTn;
	
	input [7:0]FIFO_Read_Data;
	input Empty_Sig;
	output Read_Req_Sig;
	
	input Fun_Done_Sig;
	output Fun_Start_Sig;
	
	
	////
	
	reg [3:0]state_index;
	reg [1:0]rCmd;
	reg isRead;
	reg [1:0]isStart;  // [1]: S, [0]:O;
	
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				state_index <= 4'd0;
				rCmd <= 2'b00;
				isRead <= 1'b0;
				isStart <= 2'b00;
			end
		else 
			case (state_index )
				4'd0:
					if (!Empty_Sig) 
						state_index <= state_index + 1'b1;
				
				4'd1:
					begin
						isRead <= 1'b1;
						state_index <= state_index + 1'b1;
					end
				
				4'd2:
					begin
						isRead <= 1'b0;
						state_index <= state_index + 1'b1;
					end

				4'd3:
					begin
						if (FIFO_Read_Data == 8'h1b)
							rCmd <= 2'b10; // S
						else if (FIFO_Read_Data == 8'h44)
							rCmd <= 2'b01; // O
						else
							rCmd <= 2'b00;
							
						state_index <= state_index + 1'b1;
					end
					
				4'd4:
					if (rCmd == 2'b00)
						state_index <= 4'd0;
					else
						state_index <= state_index + 1'b1;
				
				4'd5:
					if (Fun_Done_Sig)
						begin
							rCmd <= 2'b00;
							isStart <= 2'b00;
							state_index <= 4'd0;
						end
					else
						isStart <= rCmd;
						
			endcase
			
	///////////////////////////////////
	
	assign Read_Req_Sig = isRead;
	assign Fun_Start_Sig = isStart;
	
endmodule
