
module simpletest3;
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
		input [31:0] r1;
		if(r1 !== 0)
			$display("TEST FAILED");
	endtask

	initial begin
		$display("\t\tSIMPLE TEST 3");
		$display("This testbench tests the functionality of multiple different instructions, mimicing a real assembly program");
		$display("\t\tRUNNING TESTBENCH");

		clk = 0;
		reset = 0;
		#10
		clk = 1;
		#1
		instruction = 32'h2820002B;	// loading 43 to r1
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		if(i1.r1.internal !== 32'h0000002B) begin
			$display("TEST FAILED AT TIME %0t", $time);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R1=%0d", $time, i1.c.state, i1.r1.internal);
		end
		instruction = 32'h28400020;	// loading 32 to r2
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		if(i1.r2.internal !== 32'd32) begin
			$display("TEST FAILED AT TIME %0t", $time);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R2=%0d", $time, i1.c.state, i1.r2.internal);
		end
		instruction = 32'h28600000;	// loading 0 to r3;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		if(i1.r3.internal !== 0) begin
			$display("TEST FAILED AT TIME %0d", $time);
			$finish;
		end else begin
			$display("AT TIME %0d STATE=%0d R3=%0d", $time, i1.c.state, i1.r3.internal);
		end
		instruction = 32'h28800003;	// loading 3 to r4
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		if(i1.r4.internal !== 32'd3) begin
			$display("TEST FAILED AT TIME %0d", $time);
			$finish;
		end else begin
			$display("AT TIME %0d STATE=%0d R4=%0d", $time, i1.c.state, i1.r4.internal);
		end
		instruction = 32'h50EB347A;	// jumping to 0x03ACD1E8
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		if(addr !== 32'h03ACD1E8) begin
			$display("TEST FAILED AT TIME %0d", $time);
			$finish;
		end else begin
			$display("AT TIME %0d STATE=%0d ADDR=%h", $time, i1.c.state, addr);
		end
		instruction = 32'h54830000;	// comparing r4 to r3
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
		if(i1.cmp.internal !== -3) begin
		       $display("TEST FAILED AT TIME %0d", $time);
			$finish;
	 	end else begin
			$display("AT TIME %0d STATE=%0d COMP=%h", $time, i1.c.state, i1.cmp.internal);
		end
		instruction = 32'h6FFB0932;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		if(addr !== 32'h03ACD1EC) begin
			$display("TEST FAILED AT TIME %0d", $time);
			$finish;
		end else begin
			$display("AT TIME %0d STATE=%0d ADDR=%h", $time, i1.c.state, addr);
		end
		$display("TEST PASSED");
		$finish;
	end

endmodule
