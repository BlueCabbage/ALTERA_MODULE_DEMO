////////////////////////////////////////////////////////////////////////
//// SYS CTL module 
//// 				ZHAOCHAO
//// 					2016-11-11
/////////////////////////////////////////////////////////////////////////
////

module SYS_CTL (
		ext_clk, ext_rst_n,
		sys_rst_n, clk_25m, clk_33m, clk_50m, clk_65m, clk_100m
	);
	// fpga ext input and reset
	input ext_clk;				// 25MHz input ext_clk.
	input ext_rst_n; 			// ext reset input, low level enable.
	// PLL ouput clk and reset signal, use for inner system.
	output reg sys_rst_n; 	// system reset signal, low level enable.
	output clk_25m; 		// ouput of pll module.
	output clk_33m;
	output clk_50m;
	output clk_65m;
	output clk_100m;
	
	// generate reset signal, up level enable.
	// async reset, sync free.
	reg rst_r1, rst_r2;
	
	always @(posedge ext_clk or negedge ext_rst_n)
		if (!ext_rst_n)
			rst_r1 <= 1'b0;
		else
			rst_r1 <= 1'b1;
			
	always @(posedge ext_clk or negedge ext_rst_n)
		if (!ext_rst_n)
			rst_r2 <= 1'b0;
		else
			rst_r2 <= rst_r1;
			
	// instance pll module.
	wire locked; 				// the output lock state of pll instance.
	/*
	module PLL_CTL (
	areset,
	inclk0,
	c0,
	c1,
	c2,
	c3,
	c4,
	locked);
	*/
	PLL_CTL pll_ctl_inst (
					.areset ( !rst_r2),
					.inclk0 ( ext_clk),
					.c0 (clk_25m),
					.c1 (clk_33m),
					.c2 (clk_50m),
					.c3 (clk_65m),
					.c4 (clk_100m),
					.locked (locked)
			);
			
	// system reset logic.
	reg sys_rst_nr;
	
	always @(posedge clk_100m)
		if (!locked)
			sys_rst_nr <= 1'b0;
		else 
			sys_rst_nr <= sys_rst_nr;
	
endmodule
	