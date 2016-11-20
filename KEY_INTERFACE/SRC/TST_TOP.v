///////////////////////////////////////////////
//// TST_TOP.v
////
///////////////////////////////
////

module TST_TOP
(
	CLK, RSTn,
	Key_In,
	Key_Out
);

	input CLK;
	input RSTn;
	input [4:0]Key_In;
	output [4:0]Key_Out;
	
	wire [4:0]wData;
	
	KEY_INTERFACE_MODULE U1
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Key_In(Key_Input),
		.Key_Out(wData)
	);
	
	TST U2
	(
		.CLK(CLK),
		.RSTn(RSTn),
		.Key_Input(wData),
		.Key_Out(Key_Out)
	);
	
endmodule

	