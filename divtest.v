
module divtest;
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
		input [31:0] r7, r15;
		if(r7 !== i1.r7.internal || r15 !== i1.r15.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R7=%0d R15=%0d", $time, i1.r7.internal, i1.r15.internal);
			$display("EXPECTED R7=%0d R15=%0d", r7, r15);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R7=%0d R15=%0d", $time, i1.c.state, i1.r7.internal, i1.r15.internal);
		end
	endtask

	initial begin
		$display("\t\tDIVIDE TEST");
		$display("This testbench tests the functionality of the divide and immediate divide instruction");
		$display("\t\tRUNNING TESTBENCH");
		clk = 0;
		reset = 0;
		#10
		clk = 1;
		#1
		instruction = 32'h29E50007;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'hx, 32'd7);
		instruction = 32'h28F3001C;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'd28, 32'd7);
		instruction = 32'h80EF3800;
		#9
		clk = 0;
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
		#10
		clk = 1;
		#1
		expect(32'd4, 32'd7);
		instruction = 32'h90E70002;
		#9
		clk = 0;
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
		#10
		clk = 1;
		#1
		expect(32'd2, 32'd7);
		#9
		$display("TEST PASSED");
		$finish;
	end	
endmodule
