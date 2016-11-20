/////////////////////////////////////////////////
//// DS1302_CMD_CTL_MODULE.v
////				ZHAOCHAO
////					2016-11-18
///////////////////////////////////////////////////////////
////

module DS1302_CMD_CTL_MODULE
(
	CLK, RSTn,
	
	Start_Sig, 
	Done_Sig,
	
	Time_Write_Data,
	Time_Read_Data,
	
	Access_Done_Sig,
	Access_Start_Sig,
	
	Read_Data,
	Words_Addr,
	Write_Data
);

	input CLK;
	input RSTn;
	
	input [7:0]Start_Sig;
	output Done_Sig;
	
	input [7:0]Time_Write_Data;
	output [7:0]Time_Read_Data;
	
	input Access_Done_Sig;
	output [1:0]Access_Start_Sig;
	
	input [7:0]Read_Data;
	output [7:0]Words_Addr;
	output [7:0]Write_Data;
	
	
	
	reg [7:0]rAddr;
	reg [7:0]rData;
	
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				rAddr <= 8'd0;
				rData <= 8'd0;
			end
		else if(Start_Sig[7:0])
			case(Start_Sig)
				8'b1000_0000: // Write unprotect
					begin
						rAddr <= { 2'b10, 5'd7, 1'b0};
						rData <= 8'h00;
					end
					
				8'b0100_0000: // Write hour
					begin
						rAddr <= {2'b10, 5'd2, 1'b0};
						rData <= Time_Write_Data;
					end
					
				8'b0010_0000: // Write minit
					begin
						rAddr <= {2'b10, 5'd1, 1'b0};
						rData <= Time_Write_Data;
					end
					
				8'b0001_0000: // Write second
					begin
						rAddr <= {2'b10, 5'd0, 1'b0};
						rData <= Time_Write_Data;
					end
					
				8'b0000_1000: // Write protect
					begin
						rAddr <= {2'b10, 5'd7, 1'b0};
						rData <= 8'b1000_0000;
					end
					
				8'b0000_0100: // Read hour
					begin
						rAddr <= {2'b10, 5'd2, 1'b1};
					end

				8'b0000_0010: // Read minit
					begin
						rAddr <= {2'b10, 5'd1, 1'b1};
					end
					
				8'b0000_0001: // Read second
					begin
						rAddr <= {2'b10, 5'd0, 1'b1};
					end
			endcase
			
	//////////////////////////////////////
	
	reg [1:0]state_index;
	reg [7:0]rRead;
	reg [1:0]isStart;
	reg isDone;
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				state_index <= 2'd0;
				rRead <= 8'd0;
				isStart <= 2'b00;
				isDone <= 1'b0;
			end 
		else if (Start_Sig[7:3]) // Write action
			case (state_index)
				2'd0:
					if (Access_Done_Sig)
						begin	
							isStart <= 2'b00;
							state_index <= state_index + 1'b1;
						end
					else
						begin
							isStart <= 2'b10;
						end
						
				2'd1:
					begin
						isDone <= 1'b1;
						state_index <= state_index + 1'b1;
					end
					
				2'd2:
					begin
						isDone <= 1'b0;
						state_index <= 2'd0;
					end	
			endcase 
		
		else if(Start_Sig[2:0]) // Read action
			case (state_index)
				2'd0:
					if (Access_Done_Sig)
						begin
							rRead <= Read_Data;
							isStart <= 2'b00;
							state_index <= state_index + 1'b1;
						end
					else 
						begin
							isStart <= 2'b01;
						end
				2'd1:
					begin 
						isDone <= 1'b1;
						state_index <= state_index + 1'b1;
					end
					
				2'd3:
					begin
						isDone <= 1'b0;
						state_index <= 2'd0;
					end
					
			endcase
			
	/////////////////////////////////////////////////////////////////////////
	
	assign Done_Sig = isDone;
	assign Time_Read_Data = rData;
	assign Access_Start_Sig = isStart;
	assign Words_Addr = rAddr;
	assign Write_Data = rData;
	
	
endmodule


	 
								
		