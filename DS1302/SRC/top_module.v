////////////////////////////////////////////////////////////////
//// top_module.v
//// 		ZHAOCHAO
//// 			2016-11-18
////////////////////////////////////////////////////////
////

module top_module
(
	CLK, RSTn,
	RST, 
	SCLK,
	SIO,
	LED
);
	
	input CLK;
	input RSTn;
	output RST;
	output SCLK;
	inout SIO;
	output [3:0]LED;
	
	
	
	reg [3:0]state_index;
	reg [7:0]isStart;
	reg [7:0]rData;
	reg [3:0]rLED;
	
	
	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			begin
				state_index <= 4'd0;
				isStart <= 8'd0;
				rData <= 8'd0;
				rLED <= 4'd0;
			end
		else 
			case (state_index)
				4'd0:
					if (Done_Sig)
						begin
							isStart <= 8'd0;
							state_index <= state_index + 1'b1;
						end
					else
						begin
							isStart <= 8'b1000_0000;
							rData <= 8'h00;
						end
						
				4'd1:
					if (Done_Sig)
						begin
							isStart <= 8'd0;
							state_index <= state_index + 1'b1;
						end
					else
						begin
							isStart <= 8'b0100_0000;
							rData <= { 4'd1, 4'd2};
						end
					
				4'd2:
					if (Done_Sig)
						begin
							isStart <= 8'd0;
							state_index <= state_index + 1'b1;
						end
					else 
						begin
							isStart <= 8'b0010_0000;
							rData <= {4'd2, 4'd2};
						end
						
				4'd3:
					if (Done_Sig)
						begin
							isStart <= 8'd0;
							state_index <= state_index + 1'b1;
						end
					else 
						begin
							isStart <= 8'b0001_0000;
							rData <= { 4'd2, 4'd2 };
						end
				
				4'd4:
					if (Done_Sig)
						begin
							rLED <= Time_Read_Data[3:0];
							isStart <= 8'd0;
							state_index <= 4'd4;
						end
					else
						begin	
							isStart <= 8'b0000_0001;
						end
						
			endcase
			
		
	/////////////////////////////////////////////
	
	wire Done_Sig;
	wire [7:0]Time_Read_Data;
	
	DS1302_MODULE U3
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Start_Sig(isStart),
		.Done_Sig(Done_Sig),
		.Time_Write_Data(rData),
		.Time_Read_Data(Time_Read_Data),
		.RST(RST),
		.SCLK(SCLK),
		.SIO(SIO)
	);
	
	
	///////////////////////////////////
							
	assign LED = rLED;
	
	
endmodule

		
		
			