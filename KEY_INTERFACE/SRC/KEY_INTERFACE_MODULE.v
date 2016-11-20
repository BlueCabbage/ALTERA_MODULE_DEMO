///////////////////////////////////////////////////////////
//// KEY_INTERFACE_MODULE.v
//// 				   ZHAOCHAO
//// 						2016-11-19
//////////////////////////////////////////////////////////////////////
////

module KEY_INTERFACE_MODULE
(
	CLK, RSTn,
	Key_In,
	Key_Out
);

	input CLK;
	input RSTn;
	input [4:0]Key_In;
	output [4:0]Key_Out;
	
	// [4]UP, [3]Down, [2]Left, [1]Right, [0]Middle
	
	genvar key_index;
	generate
	
		for ( key_index = 0; key_index < 5; key_index = key_index + 1'b1 )
		begin : gen_key_module

			KEY_MODULE U11
			(
				.CLK(CLK),
				.RSTn(RSTn),
				.Pin_In(Key_In[4 - key_index]),
				.Pin_Out(Key_Out[4 - key_index])
			);
		end
		
	endgenerate

	
	
endmodule
