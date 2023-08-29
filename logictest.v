
module logictest;
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
		input [31:0] r5, r17, r21, r30, r11, r12;
		if (r5 !== i1.r5.internal || r17 !== i1.r17.internal || r21 !== i1.r21.internal || r30 !== i1.r30.internal || r11 !== i1.r11.internal || r12 !== i1.r12.internal) begin
			$display("TEST FAILED");
			$display("AT TIME %0t R5=%h R17=%h R21=%h R30=%h R11=%h R12=%h", $time, i1.r5.internal, i1.r17.internal, i1.r21.internal, i1.r30.internal, i1.r11.internal, i1.r12.internal);
			$display("EXPECTING R5=%h R17=%h R21=%h R30=%h R11=%h R12=%h", r5, r17, r21, r30, r11, r12);
			$finish;
		end else begin
			$display("AT TIME %0t STATE=%0d R5=%h R17=%h R21=%h R30=%h R11=%h R12=%h", $time, i1.c.state, i1.r5.internal, i1.r17.internal, i1.r21.internal, i1.r30.internal, i1.r11.internal, i1.r12.internal);
		end
	endtask

	initial begin
		$display("\t\tLOGIC TEST");
		$display("This testbench covers all of the non-immediate logical operations. This includes AND, OR, XOR, and NOT. It begins by performing two immediate loads, then performing the operations and storing in registers 5, 17, 21, and 30.");
		$display("RUNNING TESTBENCH");
		
		clk = 1'b0;
		reset = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hx, 32'hx, 32'hx, 32'hx, 32'hx, 32'hx);
		instruction = 32'h2960731A;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hx, 32'hx, 32'hx, 32'hx, 32'h0000731A, 32'hx);
		instruction = 32'h29802250;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		expect(32'hx, 32'hx, 32'hx, 32'hx, 32'h0000731A, 32'h00002250);
		instruction = 32'h196C2800;
		$display("BEGINNING AND OPERATION");
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
		expect(32'h00002210, 32'hx, 32'hx, 32'hx, 32'h0000731A, 32'h00002250);
		instruction = 32'h1D6CA800;
		$display("BEGINNING OR OPERATION");
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
		expect(32'h00002210, 32'hx, 32'h0000735A, 32'hx, 32'h0000731A, 32'h00002250);
		instruction = 32'h216C8800;
		$display("BEGINNING XOR OPERATION");
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
		expect(32'h00002210, 32'h0000514A, 32'h0000735A, 32'hx, 32'h0000731A, 32'h00002250);
		instruction = 32'h257E0000;
		$display("BEGINNING NOT OPERATION");
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
		expect(32'h00002210, 32'h0000514A, 32'h0000735A, 32'hFFFF8CE5, 32'h0000731A, 32'h00002250);
		#10
		$display("TEST PASSED");
		$finish;
	end
endmodule
