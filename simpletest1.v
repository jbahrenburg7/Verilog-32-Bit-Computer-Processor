
module cpu_test;
	reg [31:0] instruction;
	reg clk, reset;
	wire [31:0] out, addr;
	wire sys_dne, rw;

	processor i1 (
		.instruction(instruction),
		.clk(clk),
		.reset(reset),
		.out(out),
		.sys_dne(sys_dne),
		.addr(addr),
		.rw(rw)
	);

	task expect;
		input [31:0] r12, r21, r3;
		if(i1.r12.Q !== r12 || i1.r21.Q !== r21 || i1.r3.Q !== r3) begin
			$display("TEST FAILED");
			$display("AT TIME %0d R12=%h R21=%h R3=%h", $time, i1.r12.Q, i1.r21.Q, i1.r3.Q);
			$display("EXPECTING R12=%h R21=%h R3=%h", r12, r21, r3);
			$finish;
		end
		else begin
			$display("At time %0d State=%d R12=%h R21=%h R3=%h", $time, i1.c.state, i1.r12.Q, i1.r21.Q, i1.r3.Q);
		end
	endtask

	initial begin
		$display("\t\tSIMPLE TEST 1\t\t");
		$display("This test bench code performs an LI instruction to load a value to register 12, then performs a LOAD instruction to load a value to register 21. Finally it will add the two values together and store the sum in register 3.");
		$display("\t\tRUNNING TESTBENCH\t\t");
		instruction = 32'h00000000;
		clk = 1'b0;
		reset = 1'b1;
		#10
		clk = 'b1;
		#10
		clk = 1'b0;
		#1
		reset = 1'b0;
		#9
		clk = 1'b1;
		expect(0, 0, 0);
		//instruction = 32'h298006E3;
		#10
		clk = 1'b0;
		instruction = 32'h298006E3;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		expect(32'h000006E3, 0, 0);
		#10
		clk = 1'b0;
		instruction = 32'h02AC0000;
		#10
		clk = 1'b1;
		//instruction = 32'h00000029;
		#10
		clk = 1'b0;
		instruction = 32'h00000029;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		expect(32'h000006E3, 32'h00000029, 0);
		//instruction = 32'h12AC1800;
		#10
		clk = 1'b0;
		instruction = 32'h12AC1800;
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
		expect(32'h000006E3, 32'h00000029, 32'h0000070C);
		#10
		clk = 1'b0;
		instruction = 32'h15951800;
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
		expect(32'h000006E3, 32'h00000029, 32'hFFFFF946);
		$display("TEST PASSED");
		$finish;
	end
endmodule
