
module mux_test;

	reg [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31;
	reg [4:0] sel;
	wire [31:0] out;

	mux i1 (
		.in0(in0),
		.in1(in1),
		.in2(in2),
		.in3(in3),
		.in4(in4),
		.in5(in5),
		.in6(in6),
		.in7(in7),
		.in8(in8),
		.in9(in9),
		.in10(in10),
		.in11(in11),
		.in12(in12),
		.in13(in13),
		.in14(in14),
		.in15(in15),
		.in16(in16),
		.in17(in17),
		.in18(in18),
		.in19(in19),
		.in20(in20),
		.in21(in21),
		.in22(in22),
		.in23(in23),
		.in24(in24),
		.in25(in25),
		.in26(in26),
		.in27(in27),
		.in28(in28),
		.in29(in29),
		.in30(in30),
		.in31(in31),
		.sel(sel),
		.out(out)
	);

	initial begin
		$display("Running Testbench");
		in0 = 32'h00000000;
		in1 = 32'h00000001;
		in2 = 32'h00000002;
		in3 = 32'h00000003;
		in4 = 32'h00000004;
		in5 = 32'h00000005;
		in6 = 32'h00000006;
		in7 = 32'h00000007;
		in8 = 32'h00000008;
		in9 = 32'h00000009;
		in10 = 32'h0000000A;
		in11 = 32'h0000000B;
		in12 = 32'h0000000C;
		in13 = 32'h0000000D;
		in14 = 32'h0000000E;
		in15 = 32'h0000000F;
		in16 = 32'h00000010;
		in17 = 32'h00000011;
		in18 = 32'h00000012;
		in19 = 32'h00000013;
		in20 = 32'h00000014;
		in21 = 32'h00000015;
		in22 = 32'h00000016;
		in23 = 32'h00000017;
		in24 = 32'h00000018;
		in25 = 32'h00000019;
		in26 = 32'h0000001A;
		in27 = 32'h0000001B;
		in28 = 32'h0000001C;
		in29 = 32'h0000001D;
		in30 = 32'h0000001E;
		in31 = 32'h0000001F;
		sel = 5'b00000;
		#10
		sel = 5'b00001;
		#10
		sel = 5'b00010;
		#10
		sel = 5'b00011;
		#10
		sel = 5'b00100;
		#10
		sel = 5'b00101;
		#10
		sel = 5'b00110;
		#10
		sel = 5'b00111;
		#10
		sel = 5'b01000;
		#10
		$finish;
	end
	
endmodule
