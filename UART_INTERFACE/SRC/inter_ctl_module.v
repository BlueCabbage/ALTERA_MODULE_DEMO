///////////////////////////////////////////////
//// inter_ctl_module.v
//// 				ZHAOCHAO
//// 					2016-11-20
///////////////////////////////////////////////////////////
////

module inter_ctl_module
(
	CLK, RSTn,
	Empty_Sig,
	FIFO_Read_Data,
	Read_Req_Sig,
	Full_Sig,
	FIFO_Write_Data,
	Write_Req_Sig
);

	input CLK;
	input RSTn;
	
	input Empty_Sig;
	input [7:0]FIFO_Read_Data;
	output Read_Req_Sig;
	
	input Full_Sig;
	output Write_Req_Sig;
	output [7:0]FIFO_Write_Data;

	
	///////////////////////////////////////////////////
	
	parameter isTST = 1'b0;
	
	reg [2:0]state_index;
	reg isRead;
	reg isWrite;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				state_index <= 3'd0;
				isRead <= 1'b0;
				isWrite <= 1'b0;
			end
		else
			case (state_index)
				3'd0:
					if (!Empty_Sig)
						state_index <= state_index + 1'b1;
				
				3'd1:
					begin
						isRead <= 1'b1;
						state_index <= state_index + 1'b1;
					end
					
				3'd2:
					begin
						isRead <= 1'b0;
						state_index <= state_index + 1'b1;
					end
				
				3'd3:
					if (!Full_Sig)
						state_index <= state_index + 1'b1;
				
				3'd4:
					begin
						isWrite <= 1'b1;
						state_index <= state_index + 1'b1;
					end
				
				3'd5:
					begin
						isWrite <= 1'b0;
						state_index <= 3'd0;
					end
			endcase

/*			
	///////////////////////
	
	reg isTSTWrite;
	reg rTX_DATA;
	reg rFIFO_Write_Data;
	reg [2:0]tst_state_index;
	
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				tst_state_index <= 3'd0;
				isTSTWrite <= 1'b0;
				rFIFO_Write_Data <= 8'd0;
			end
		else
			case (tst_state_index)
				3'd0:
					if (!Full_Sig)
						begin
							tst_state_index <= tst_state_index + 1'b1;
							rFIFO_Write_Data <= rTX_DATA;
						end
				
				3'd1:
					begin
						isTSTWrite <= 1'b1;
						tst_state_index <= tst_state_index + 1'b1;
					end
					
				3'd2:
					begin
						isTSTWrite <= 1'b0;
						tst_state_index <= tst_state_index + 1'b1;
					end
					
				3'd3:
					if (rTX_DATA == 8'hff)
						rTX_DATA <= 8'h00;
					else
						begin
							rTX_DATA <= rTX_DATA + 1'b1;
							tst_state_index <= 3'd0;
						end
				
			endcase
			
	*/					
	
	////////////////////////////////////////////////////////
	
	assign Read_Req_Sig = isRead;
	//assign Write_Req_Sig = (isTST == 1) ? isTSTWrite : isWrite;
	assign Write_Req_Sig = isWrite;
	assign FIFO_Write_Data = FIFO_Read_Data;
	//assign FIFO_Write_Data = rFIFO_Write_Data;
	
endmodule
