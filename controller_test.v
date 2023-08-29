
module controller_test;
	reg [31:0] instruction, stack, comp;
	reg clk, reset;
	wire [31:0] rst, en;
	wire [3:0] alu_func;
	wire [4:0] sel, shamt, state;
	wire dne, rw, gtprev, encntr, aluen, jumping, op, compen, compopen, sp_pc, ensp, straddress, ret, dec;

	controller i1 (
		.instruction(instruction),
		.clk(clk),
		.reset(reset),
		.rst(rst),
		.en(en),
		.sel(sel),
		.dne(dne),
		.rw(rw),
		.gtprev(gtprev),
		.encntr(encntr),
		.alu_func(alu_func),
		.aluen(aluen),
		.jumping(jumping),
		.shamt(shamt),
		.state(state),
		.op(op),
		.compen(compen),
		.compopen(compopen),
		.sp_pc(sp_pc),
		.ensp(ensp),
		.straddress(straddress),
		.ret(ret),
		.dec(dec),
		.stack(stack),
		.comp(comp)

	);

	initial begin
		$display("Running Testbench");
		clk = 1'b0;
		reset = 1'b0;
		instruction = 32'h08220000;
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
		instruction = 32'h28B10000;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		instruction = 32'h01C80000;
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
		instruction = 32'h0FFE0000;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		instruction = 32'h10642800;
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
		$finish;
	end
endmodule
