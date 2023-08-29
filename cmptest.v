
module cmptest;
	reg [31:0] instruction;
	reg clk, reset;
	wire [31:0] addr, out;
	wire sys_dne, rw;

	processor i1 (
		.instruction(instruction),
		.clk(clk),
		.reset(reset),
		.out(out),
		.addr(addr),
		.sys_dne(sys_dne),
		.rw(rw)
	);

	task expect;
		input [31:0] compres;
		if(compres !== i1.cmp.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t CMP=%d", $time, i1.cmp.internal);
			$display("EXPECTED CMP=%d", compres);
		end else begin
			$display("AT TIME %0t STATE=%0d CMP=%0d", $time, i1.c.state, i1.cmp.internal);
		end
	endtask


	initial begin
		$display("\t\tCOMPARATOR TEST");
		$display("This test bench code tests the functionality of the comparator register, which takes two register values as inputs, and stores the result of the difference between the two. This result is later used for conditional branching instructions.");
		$display("\t\tRUNNING TESTBENCH");

		clk = 1'b0;
		reset = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		instruction = 32'h29A00049;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		instruction = 32'h28200011;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		instruction = 32'h542DF710;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		expect(32'd56);
		#10
		$display("TEST PASSED");
		$finish;
	end
endmodule
