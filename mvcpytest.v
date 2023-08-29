
module mvcpytest;
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
		input [31:0] r7, r8;
		if(r7 !== i1.r7.internal || r8 !== i1.r8.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R7=%h R8=%h", $time, i1.r7.internal, i1.r8.internal);
			$display("EXPECTED R7=%h R8=%h", r7, r8);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%d R7=%h R8=%h", $time, i1.c.state, i1.r7.internal, i1.r8.internal);
		end
	endtask

	initial begin
		$display("\t\tMOVE AND COPY TEST");
		$display("This test bench covers the copy and move instructions, first by immediately loading a value into reigster 7, moving that value into register 8, then copying the value back into register 7.");
		$display("\t\tRUNNING TESTBENCH");

		clk = 1'b0;
		reset = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		instruction = 32'h28E0A51B;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hFFFFA51B, 32'hx);
		instruction = 32'h08E80000;
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
		expect(32'h0, 32'hFFFFA51B);
		instruction = 32'h0D070000;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hFFFFA51B, 32'hFFFFA51B);
		#10
		$display("TEST PASSED");
		$finish;
	end	
endmodule
