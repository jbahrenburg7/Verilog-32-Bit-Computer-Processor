
module jmptest;
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
		input [31:0] address;
		if(address != addr) begin
			$display("TEST FAILED");
			$display("AT TIME %0t ADDR=%h", $time, addr);
			$display("EXPECTED ADDR=%h", address);
			//$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d ADDR=%h", $time, i1.c.state, addr);
		end
	endtask

	initial begin
		$display("\t\tJUMPING TEST");
		$display("This testbench tests the functionality of all of the conditional and unconditional jumping operations.");
		$display("\t\tRUNNING TESTBENCH");

		clk = 0;
		reset = 0;
		#10
		clk = 1;
		#1
		expect(32'h0);
		// loading value 33 to register 27
		instruction = 32'h2B790021;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h4);
		// loading value 51 to register 2
		instruction = 32'h285E0033;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h8);
		instruction = 32'h1362EF09;
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
		expect(32'hC);
		// jumping to address with offset 3AF0397
		instruction = 32'h53AF0397;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h0EBC0E5C);
		// comparing register 27 to register 2
		instruction = 32'h5762F513;
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
		expect(32'h0EBC0E60);
		instruction = 32'h68B7421E;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h02DD0878);
		//comparing register 2 to register 27
		instruction = 32'h545B0000;
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
		expect(32'h02DD087C);
		instruction = 32'h68B7421E;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h02DD0880);
		instruction = 32'h5762F513;
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
		expect(32'h02DD0884);
		instruction = 32'h609EB431;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h02DD0888);
		instruction = 32'h545B0000;
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
		expect(32'h02DD088C);
		instruction = 32'h609EB431;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h027AD0C4);
		instruction = 32'h28600033;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h027AD0C8);
		instruction = 32'h545B8EF5;
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
		expect(32'h027AD0CC);
		instruction = 32'h58FF56EB;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h027AD0D0);
		instruction = 32'h5443CA18;
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
		expect(32'h027AD0D4);
		instruction = 32'h5B981E55;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h0E607954);
		instruction = 32'h5462F553;
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
		expect(32'h0E607958);
		instruction = 32'h5F09CB12;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h0E60795C);
		instruction = 32'h545B0454;
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
		expect(32'h0E607960);
		instruction = 32'h5F09C31B;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h0C270C6C);
		instruction = 32'h84000000;
		#9
		clk = 0;
		#10
		clk = 1;
		instruction = 32'h54BBE901;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h54BBE901);
		instruction = 32'h0F6A98E0;
		#9
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h54BBE905);
		instruction = 32'h0958FE12;
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
		expect(32'h54BBE909);
		instruction = 32'h8A75BEB1;
		#9
		clk = 0;
		#10
		clk = 1;
		instruction = 32'h0C270C6C;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#1
		expect(32'h0C270C70);
		#9

		$display("TEST PASSED");
		$finish;
	end
endmodule
