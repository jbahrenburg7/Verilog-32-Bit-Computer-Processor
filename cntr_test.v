
module cntr_test;
	reg rst, en, gotoprev, jumping;
	reg [3:0] cstate;
	reg [31:0] D;
	wire [31:0] Q;

	cntr i1 (
		.cstate(cstate),
		.rst(rst),
		.en(en),
		.gotoprev(gotoprev),
		.D(D),
		.Q(Q),
		.jumping(jumping)
	);

	initial begin
		$display("Running Testbench");
		cstate = 0;
		en = 1'b1;
		D = 32'h00000000;
		rst = 1'b0;
		gotoprev = 1'b0;
		#10
		cstate = 1;
		#10
		cstate = 0;
		en = 1'b0;
		#10
		cstate = 1;
		#10
		cstate = 0;
		#10
		cstate = 1;
		D = 32'hFF789012;
		#10
		cstate = 0;
		en = 1'b1;
		#10
		cstate = 1;
		#10
		cstate = 0;
		en = 1'b0;
		#10
		cstate = 1;
		#10
		cstate = 0;
		#10
		cstate = 1;
		#10
		cstate = 0;
		gotoprev = 1'b1;
		#10
		cstate = 1;
		#10
		cstate = 0;
		gotoprev = 1'b0;
		#10
		cstate = 1;
		jumping = 1;
		D = 32'hF7831042;
		#10
		en = 1;
		#10
		$finish;
	end
endmodule
