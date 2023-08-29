
module reg32_test;
	reg [31:0] D;
	reg en, clk, rst;
	wire [31:0] Q;

	reg32 i1 (
		.D(D),
		.en(en),
		.clk(clk),
		.rst(rst),
		.Q(Q)
	);

	initial begin
		$display("Running Testbench");
		clk = 1'b0;
		en = 1'b1;
		rst = 1'b0;
		D = 32'hBA09F533;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		D = 32'h7887BA09;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		en = 1'b0;
		D = 32'hFFFFFFFF;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		en = 1'b1;
		rst = 1'b1;
		#10
		clk = 1'b1;
		#10
		$finish;
	end
endmodule
