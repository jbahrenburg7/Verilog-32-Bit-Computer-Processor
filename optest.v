
module optest;
	reg [31:0] instruction;
	reg clk, reset;
	wire [31:0] out, addr;
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
		input [31:0] r23;
		if(r23 !== i1.r23.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R23=%0d", $time, i1.r23.internal);
			$display("EXPECTED R23=%0d", r23);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R23=%0d", $time, i1.c.state, i1.r23.internal);
		end
	endtask

	initial begin
		$display("\t\tOPERATIONS TEST");
		$display("This testbench tests the functionality of several operations such as two's complement, increment, and double");
		$display("\t\tRUNNING TESTBENCH");
		clk = 0;
		reset = 0;
		#10
		clk = 1;
		#1
		instruction = 32'h2AF6418E;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'd16782);
		instruction = 32'h76E09E51;
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
		#1
		expect(32'd16783);
		instruction = 32'h2AF60580;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'd1408);
		instruction = 32'h7AF098FF;
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
		#1
		expect(32'd2816);
		instruction = 32'h72E0E781;
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
		#1
		expect(32'hFFFFF500);
		#9
		$display("TEST PASSED");
		$finish;
	end
endmodule
