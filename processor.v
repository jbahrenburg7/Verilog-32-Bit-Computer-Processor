/* JB Bahrenburg
 * processor.v
 * This file contains the connections between all subcomponents such as the
 * controller, multiplexers and registers. This is the top-level design for
 * the processor procject.
 */

module processor (
	input [31:0] instruction,
	input clk, reset,
	output [31:0] out, addr,
	output sys_dne, rw
);
	wire [31:0] reg_en, reg_rst, ir_out, irtobitm, bitm_mux, mux_out, r1_mux, r2_mux, r3_mux, r4_mux, r5_mux, r6_mux, r7_mux, r8_mux, r9_mux, r10_mux, r11_mux, r12_mux, r13_mux, r14_mux, r15_mux, r16_mux, r17_mux, r18_mux, r19_mux, r20_mux, r21_mux, r22_mux, r23_mux, r24_mux, r25_mux, r26_mux, r27_mux, r28_mux, r29_mux, r30_mux, optoalu, acctomux, alutoa, cmpop_cmp, comp, addr1, addr2, prev;
	wire [4:0] mux_sel, shamt, cstate;
	wire [3:0] fnc;
	wire done, enc, gtp, aluena, opb, compen, compopen, jumping, sp_pc, ensp, straddress, ret, dec;

	controller c (
		.instruction(ir_out),
		.clk(clk),
		.reset(reset),
		.rst(reg_rst),
		.en(reg_en),
		.dne(done),
		.sel(mux_sel),
		.encntr(enc),
		.gtprev(gtp),
		.aluen(aluena),
		.alu_func(fnc),
		.op(opb),
		.state(cstate),
		.shamt(shamt),
		.compen(compen),
		.compopen(compopen),
		.comp(comp),
		.jumping(jumping),
		.rw(rw),
		.ensp(ensp),
		.sp_pc(sp_pc),
		.straddress(straddress),
		.ret(ret),
		.dec(dec),
		.stack(addr2)
	);
	comparator cmp (
		.i1(mux_out),
		.i2(cmpop_cmp),
		.compen(compen),
		.clk(clk),
		.comp(comp)
	);
	/*Assigning output sys_dne, displays whether or not the system has
	* completed an instruction*/
	assign sys_dne = done;
	assign out = (straddress === 1 ? prev : mux_out);
	/*Output should always be connected to the multiplexer's output,
	* occasionally it will be set to the previous instruction if that
	* needs to be stored on the stack*/
	mux m (
		.sel(mux_sel),
		.out(mux_out),
		.in0(bitm_mux),
		.in1(r1_mux),
		.in2(r2_mux),
		.in3(r3_mux),
		.in4(r4_mux),
		.in5(r5_mux),
		.in6(r6_mux),
		.in7(r7_mux),
		.in8(r8_mux),
		.in9(r9_mux),
		.in10(r10_mux),
		.in11(r11_mux),
		.in12(r12_mux),
		.in13(r13_mux),
		.in14(r14_mux),
		.in15(r15_mux),
		.in16(r16_mux),
		.in17(r17_mux),
		.in18(r18_mux),
		.in19(r19_mux),
		.in20(r20_mux),
		.in21(r21_mux),
		.in22(r22_mux),
		.in23(r23_mux),
		.in24(r24_mux),
		.in25(r25_mux),
		.in26(r26_mux),
		.in27(r27_mux),
		.in28(r28_mux),
		.in29(r29_mux),
		.in30(r30_mux),
		.in31(acctomux)
	);
	alu a (
		.i1(optoalu),
		.i2(mux_out),
		.func(fnc),
		.o(alutoa),
		.shamt(shamt)
	);
	stack_pointer sp (
		.clk(clk),
		.en(ensp),
		.rst(reset),
		.Q(addr2),
		.dec(dec)
	);
	cntr pc (
		.cstate(cstate),
		.D(mux_out),
		.en(enc),
		.gotoprev(gtp),
		.rst(reset),
		.Q(addr1),
		.jumping(jumping),
		.clk(clk),
		.prev(prev),
		.ret(ret)
	);
	assign addr = (sp_pc === 0 ? addr1 : addr2);
	/*Switching the address output between the program counter and the
	* stack pointer*/
       /*Below is the instruction register, it operates the exact same as
       * a normal 32-bit register but takes the instruction as an input*/
	reg32 ir (
		.D(instruction),
		.en(done),
		.clk(clk),
		.rst(reg_rst[0]),
		.Q(ir_out)
	);
	bitm b (
		.instruction(ir_out),
		.op(opb),
		.o(bitm_mux)
	);
	reg32 cmpop (
		.D(mux_out),
		.en(compopen),
		.clk(clk),
		.rst(reset),
		.Q(cmpop_cmp)
	);
	reg32 operand (
		.D(mux_out),
		.en(reg_en[31]),
		.clk(clk),
		.rst(reg_rst[31]),
		.Q(optoalu)
	);
	reg32 accumulator (
		.D(alutoa),
		.en(aluena),
		.clk(clk),
		.rst(reset),
		.Q(acctomux)
	);
	reg32 r1 (
		.D(mux_out),
		.en(reg_en[1]),
		.clk(clk),
		.rst(reg_rst[1]),
		.Q(r1_mux)
	);
	reg32 r2 (
		.D(mux_out),
		.en(reg_en[2]),
		.clk(clk),
		.rst(reg_rst[2]),
		.Q(r2_mux)
	);
	reg32 r3 (
		.D(mux_out),
		.en(reg_en[3]),
		.clk(clk),
		.rst(reg_rst[3]),
		.Q(r3_mux)
	);
	reg32 r4 (
		.D(mux_out),
		.en(reg_en[4]),
		.clk(clk),
		.rst(reg_rst[4]),
		.Q(r4_mux)
	);
	reg32 r5 (
		.D(mux_out),
		.en(reg_en[5]),
		.clk(clk),
		.rst(reg_rst[5]),
		.Q(r5_mux)
	);
	reg32 r6 (
		.D(mux_out),
		.en(reg_en[6]),
		.clk(clk),
		.rst(reg_rst[6]),
		.Q(r6_mux)
	);
	reg32 r7 (
		.D(mux_out),
		.en(reg_en[7]),
		.clk(clk),
		.rst(reg_rst[7]),
		.Q(r7_mux)
	);
	reg32 r8 (
		.D(mux_out),
		.en(reg_en[8]),
		.clk(clk),
		.rst(reg_rst[8]),
		.Q(r8_mux)
	);
	reg32 r9 (
		.D(mux_out),
		.en(reg_en[9]),
		.clk(clk),
		.rst(reg_rst[9]),
		.Q(r9_mux)
	);
	reg32 r10 (
		.D(mux_out),
		.en(reg_en[10]),
		.clk(clk),
		.rst(reg_rst[10]),
		.Q(r10_mux)
	);
	reg32 r11 (
		.D(mux_out),
		.en(reg_en[11]),
		.clk(clk),
		.rst(reg_rst[11]),
		.Q(r11_mux)
	);
	reg32 r12 (
		.D(mux_out),
		.en(reg_en[12]),
		.clk(clk),
		.rst(reg_rst[12]),
		.Q(r12_mux)
	);
	reg32 r13 (
		.D(mux_out),
		.en(reg_en[13]),
		.clk(clk),
		.rst(reg_rst[13]),
		.Q(r13_mux)
	);
	reg32 r14 (
		.D(mux_out),
		.en(reg_en[14]),
		.clk(clk),
		.rst(reg_rst[14]),
		.Q(r14_mux)
	);
	reg32 r15 (
		.D(mux_out),
		.en(reg_en[15]),
		.clk(clk),
		.rst(reg_rst[15]),
		.Q(r15_mux)
	);
	reg32 r16 (
		.D(mux_out),
		.en(reg_en[16]),
		.clk(clk),
		.rst(reg_rst[16]),
		.Q(r16_mux)
	);
	reg32 r17 (
		.D(mux_out),
		.en(reg_en[17]),
		.clk(clk),
		.rst(reg_rst[17]),
		.Q(r17_mux)
	);
	reg32 r18 (
		.D(mux_out),
		.en(reg_en[18]),
		.clk(clk),
		.rst(reg_rst[18]),
		.Q(r18_mux)
	);
	reg32 r19 (
		.D(mux_out),
		.en(reg_en[19]),
		.clk(clk),
		.rst(reg_rst[19]),
		.Q(r19_mux)
	);
	reg32 r20 (
		.D(mux_out),
		.en(reg_en[20]),
		.clk(clk),
		.rst(reg_rst[20]),
		.Q(r20_mux)
	);
	reg32 r21 (
		.D(mux_out),
		.en(reg_en[21]),
		.clk(clk),
		.rst(reg_rst[21]),
		.Q(r21_mux)
	);
	reg32 r22 (
		.D(mux_out),
		.en(reg_en[22]),
		.clk(clk),
		.rst(reg_rst[22]),
		.Q(r22_mux)
	);
	reg32 r23 (
		.D(mux_out),
		.en(reg_en[23]),
		.clk(clk),
		.rst(reg_rst[23]),
		.Q(r23_mux)
	);
	reg32 r24 (
		.D(mux_out),
		.en(reg_en[24]),
		.rst(reg_rst[24]),
		.clk(clk),
		.Q(r24_mux)
	);
	reg32 r25 (
		.D(mux_out),
		.en(reg_en[25]),
		.rst(reg_rst[25]),
		.clk(clk),
		.Q(r25_mux)
	);
	reg32 r26 (
		.D(mux_out),
		.en(reg_en[26]),
		.clk(clk),
		.rst(reg_rst[26]),
		.Q(r26_mux)
	);
	reg32 r27 (
		.D(mux_out),
		.en(reg_en[27]),
		.clk(clk),
		.rst(reg_rst[27]),
		.Q(r27_mux)
	);
	reg32 r28 (
		.D(mux_out),
		.en(reg_en[28]),
		.clk(clk),
		.rst(reg_rst[28]),
		.Q(r28_mux)
	);
	reg32 r29 (
		.D(mux_out),
		.en(reg_en[29]),
		.clk(clk),
		.rst(reg_rst[29]),
		.Q(r29_mux)
	);
	reg32 r30 (
		.D(mux_out),
		.en(reg_en[30]),
		.clk(clk),
		.rst(reg_rst[30]),
		.Q(r30_mux)
	);
endmodule
