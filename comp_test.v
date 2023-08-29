
module comp_test;
	reg [31:0] i1, i2;
	reg compen, clk;
	wire [31:0] comp;

	comparator c1 (
		.i1(i1),
		.i2(i2),
		.compen(compen),
		.comp(comp),
		.clk(clk)
	);

	initial begin
		i1 = 32'h96ABAA11;
		i2 = 32'h056221FE;
		compen = 1;
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		$finish;
	end
endmodule
