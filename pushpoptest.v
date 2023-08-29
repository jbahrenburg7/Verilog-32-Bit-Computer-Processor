
module pushpoptest;
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
		input [31:0] r15, mux_out, address;
		if(address !== addr || mux_out !== i1.mux_out || r15 !== i1.r15.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R15=%h MUX_OUT=%h ADDRESS=%h", $time, i1.r15.internal, i1.mux_out, addr);
			$display("EXPECTED R15=%h MUX_OUT=%h ADDRESS=%h", r15, mux_out, address);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R15=%h MUX_OUT=%h ADDR=%h", $time, i1.c.state, i1.r15.internal, i1.mux_out, addr);
		end
	endtask

	initial begin
		$display("\t\tPUSH AND POP TEST");
		$display("This test bench is testing the functionality of the push and pop instructions. Pushing will store a value from a register into the top of the stack, popping will store the top value from a stack into a register");
		$display("\t\tRUNNING TESTBENCH");
		clk = 0;
		reset = 0;
		#10
		clk = 1;
		#1
		instruction = 32'h8DE09123;
		#9
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'hx, 32'h8DE09123, 32'h20008C78);
		instruction = 32'h00000128;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#1
		expect(32'h00000128, 32'h00000128, 32'h00000000);
		#9
		clk = 1;
		#1
		expect(32'h00000128, 32'h00000128, 32'h00000004);
		instruction = 32'h7DE175BE;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#1
		expect(32'h00000128, 32'h00000128, 32'h20008C78);
		#9
		clk = 1;
		#1
		instruction = 32'h7C4091ED;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#1
		expect(32'h00000128, 32'h00000128, 32'h00000008);
		#9
		clk = 1;
		$display("TEST PASSED");
		$finish;
	end

endmodule

