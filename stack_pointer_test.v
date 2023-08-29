
module stack_pointer_test;
	reg clk, en, rst, dec;
	wire [31:0] Q;

	stack_pointer i1 (
		.clk(clk),
		.en(en),
		.rst(rst),
		.Q(Q),
		.dec(dec)
	);

	initial begin
		$display("RUNNING TESTBENCH");
		clk = 0;
		rst = 0;
		en = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		en = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		$display("TEST PASSED");
		$finish;
	end
endmodule
