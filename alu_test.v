
module alu_test;

	reg [31:0] i1, i2;
	reg [4:0] shamt;
	reg [3:0] func;
	wire [31:0] o;

	alu a1 (
		.i1(i1),
		.i2(i2),
		.shamt(shamt),
		.func(func),
		.o(o)
	);

	initial begin
	$display("Running Testbench");
		i1 = 45;
		i2 = 61;
		func = 0;
		#10
		func = 1;
		#10
		func = 2;
		#10
		func = 5;
		#10
		shamt = 7;
		func = 6;
		#10
		shamt = 3;
		i2 = 32'hA0341BB4;
		func = 7;
		#10
		func = 8;
		#10
	$finish;
	end

endmodule
