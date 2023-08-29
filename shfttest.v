
module shfttest;
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
		input [31:0] r12;
		if(r12 !== i1.r12.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R12=%h", $time, i1.r12.internal);
			$display("EXPECTED R12=%h", $time, r12);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R12=%h", $time, i1.c.state, i1.r12.internal);
		end
	endtask

	initial begin
		$display("\t\tSHIFTING OPERATION TEST");
		$display("This test bench code covers the three shifting operations: logical shift left, logical shift right and arithmetic shift right");
		$display("\t\tRUNNING TESTBENCH");

		clk = 1'b0;
		reset = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		instruction = 32'h2AA0ABCD;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		instruction = 32'h01950000;
		#10
		clk = 1'b1;
		instruction = 32'hA081BD73;
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
		expect(32'hA081BD73);
		instruction = 32'h458C0280;
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
		expect(32'h06F5CC00);
		instruction = 32'h498C0040;
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
		expect(32'h037AE600);
		instruction = 32'h458C0180;
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
		expect(32'hDEB98000);
		instruction = 32'h4D8C013F;
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
		expect(32'hFDEB9800);
		#10

		$display("TEST PASSED");
		$finish;
	end
endmodule
