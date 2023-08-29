
module imathtest;
	reg [31:0] instruction;
	reg clk, reset;
	wire [31:0] addr, out;
	wire sys_dne, rw;

	processor i1 (
		.instruction(instruction),
		.clk(clk),
		.reset(reset),
		.addr(addr),
		.out(out),
		.sys_dne(sys_dne),
		.rw(rw)
	);

	task expect;
		input [31:0] r6, r9;
		if(r6 !== i1.r6.internal || r9 !== i1.r9.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R6=%0d R9=%0d", $time, i1.r6.internal, i1.r9.internal);
			$display("EXPECTED R6=%h R9=%h", r6, r9);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R6=%0d R9=%0d", $time, i1.c.state, i1.r6.internal, i1.r9.internal);
		end
	endtask

	initial begin
		$display("\t\tIMMEDIATE ADD AND SUBTRACT TEST");
		$display("This test bench tests the functionality of the immediate add and subtract functions. It will store a value in register 6 then try to add and subtract an immediate value from that value and store it in register 9.");
		$display("\t\t\tRUNNING TESTBENCH");

		clk = 1'b0;
		reset = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		instruction = 32'h28C00241;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(577, 32'dx);
		instruction = 32'h2CC60198;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(985, 32'dx);
		instruction = 32'h30C90185;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(985, 596);
		#10
		$display("TEST PASSED");
		$finish;
	end
endmodule
