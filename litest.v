
module litest;
	reg [31:0] instruction;
	reg clk, reset;
	wire [31:0] out, addr;
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
		input [31:0] r26, r27, r28, r29;
		if(i1.r26.internal !== r26 || i1.r27.internal !== r27 || i1.r28.internal !== r28 || i1.r29.internal !== r29) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R26=%h R27=%h R28=%h R29=%h", $time, i1.r26.internal, i1.r27.internal, i1.r28.internal, i1.r29.internal);
			$display("EXPECTING R26=%h R27=%h R28=%h R29=%h", r26, r27, r28, r29);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R26=%h R27=%h R28=%h R29=%h", $time, i1.c.state, i1.r26.internal, i1.r27.internal, i1.r28.internal, i1.r29.internal);
		end
	endtask

	initial begin
		$display("\t\tLOAD IMMEDIATE TEST 1");
		$display("This testbench performs 4 immediate load instructions testing the functionality of this operation. This involves loading 4 different integer values into registers 26-29");
		$display("RUNNING TESTBENCH");

		clk = 1'b0;
		reset = 1'b0;
		#10
		clk = 1'b1;
		instruction = 32'h2B40FA37;
		#10
		clk = 1'b0;
		expect(32'hx, 32'hx, 32'hx, 32'hx);
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hFFFFFA37, 32'hx, 32'hx, 32'hx);
		instruction = 32'h2BA0600B;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hFFFFFA37, 32'hx, 32'hx, 32'h0000600B);
		instruction = 32'h2B800035;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hFFFFFA37, 32'hx, 32'h00000035, 32'h0000600B);
		instruction = 32'h2B600183;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hFFFFFA37, 32'h00000183, 32'h00000035, 32'h0000600B);
		#10
		$display("TEST PASSED");
		$finish;
	end

endmodule
