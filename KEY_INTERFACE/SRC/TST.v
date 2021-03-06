/////////////////////////////
//// tst.v
//// 
/////////////////////////////
////

module TST
(
	CLK, RSTn,
	Key_Input, 
	Key_Out
);
	
	input CLK;
	input RSTn;
	input [4:0]Key_Input;
	output [4:0]Key_Out;

	
	reg [4:0]rPin_State;

	always@(posedge CLK or negedge RSTn)
		if (!RSTn)
			rPin_State <= 5'd0;
		else if (Key_Input[4] == 1'b1)
			rPin_State[4] <= ~rPin_State[4];
		else if (Key_Input[3] == 1'b1)
			rPin_State[3] <= ~rPin_State[3];
		else if (Key_Input[2] == 1'b1)
			rPin_State[2] <= ~rPin_State[2];
		else if (Key_Input[1] == 1'b1)
			rPin_State[1] <= ~rPin_State[1];
		else if (Key_Input[0] == 1'b1)
			rPin_State[0] <= ~rPin_State[0];
			
			
	////////////////////////////////////
	
	assign Key_Out = rPin_State;
	
endmodule
			
			