
module bitm_test;

	reg [31:0] instruction;
	reg op;
	wire [31:0] o;

	bitm i1 (
		.instruction(instruction),
		.op(op),
		.o(o)
	);

	task expect;
		input [31:0] exp;
		if(o != exp) begin
			$display("TEST FAILED");
			$display("At time %0d instruction=%h op=%b, o=%h", $time, instruction, op, o);
			$display("o should be %h", exp, instruction[15]);
			$finish;
		end
		else begin
			$display("At time %0d instruction=%h op=%b, o=%h", $time, instruction, op, o);
		end
	endtask

	initial begin
		$display("RUNNING TESTBENCH");
		instruction = 32'h89081BA6;
		op = 1'b0;
		expect(32'h89081BA6);
		#10
		instruction = 32'hFFFF00AD;
		op = 1'b1;
		#1
		expect(32'h000000AD);
		#9
		instruction = 32'h0000FD72;
		#1
		expect(32'hFFFFFD72);
		#9
		$display("TEST PASSED");
		$finish;
	end

endmodule
