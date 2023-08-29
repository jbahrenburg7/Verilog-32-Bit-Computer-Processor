
module ilogictest;
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
		input [31:0] r15, r18, r4;
		if (r15 !== i1.r15.internal || r18 !== i1.r18.internal || r4 !== i1.r4.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R15=%h R18=%h R4=%h", $time, i1.r15.internal, i1.r18.internal, i1.r4.internal);
			$display("EXPECTED R15=%h R18=%h R4=%h", r15, r18, r4);
		end else begin
			$display ("AT TIME %0t STATE=%0d R15=%h R18=%h R4=%h", $time, i1.c.state, i1.r15.internal, i1.r18.internal, i1.r4.internal);
		end
	endtask

	initial begin
		$display("\t\tIMMEDIATE LOGIC OPERATIONS TEST");
		$display("This test bench covers the immedate logical AND, OR, and XOR operations.");
		$display("\t\t\tRUNNING TESTBENCH");
		
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		instruction = 32'h29E0E756;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hFFFFE756, 32'hx, 32'hx);
		instruction = 32'h35E4A163;
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
		expect(32'hFFFFE756, 32'hx, 32'hFFFFA142);
		instruction = 32'h39F221F0;
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
		expect(32'hFFFFE756, 32'hFFFFE7F6, 32'hFFFFA142);
		instruction = 32'h3DE4BB34;
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
		expect(32'hFFFFE756, 32'hFFFFE7F6, 32'h00005C62);
		instruction = 32'h41E06AB3;
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
		expect(32'hFFFF954C, 32'hFFFFE7F6, 32'h00005C62);
		#10
		$display("TEST PASSED");
		$finish;
	end
endmodule
