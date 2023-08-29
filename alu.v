/*JB Bahrenburg
* alu.v
* The ALU performs all arithmetic, logic and shifting operations required by
* the processor
* INPUTS: two 32-bit values to be operated on, 5 bits defining how many bits
* to shift (0-32) and a 4 bit value which needs to be decoded to determine the
* function to perform
* OUTPUTS: a 32-bit value which is the result of the operation*/
module alu (
	input signed [31:0] i1, i2,
	input [4:0] shamt,
	input [3:0] func,
	output reg signed [31:0] o
);
	always @ (*) begin
		if (func == 4'b0000)
			o = i1 + i2;	// adding inputs
		else if (func == 4'b0001)
			o = i2 - i1;	// subtracting inputs
		else if (func == 4'b0010)
			o = i1 & i2;	// AND inputs
		else if (func == 4'b0011)
			o = i1 | i2;	// OR inputs
		else if (func == 4'b0100)
			o = i1 ^ i2;	// XOR inputs
		else if (func == 4'b0101)
			o = ~i2;	// NOT input 2 (mux_output)
		else if (func == 4'b0110)
			o = (i2 << shamt);	// Shifting left
		else if (func === 4'b0111)
			o = (i2 >> shamt);	// Shifting right, unsigned
		else if (func === 4'b1000)
			o = (i2 >>> shamt);	// Shifting right, signed
		else if (func === 4'b1001)
			o = i2+1;	// Incrementing input 2 by 1
		else if (func === 4'b1010)
			o = (i2 << 1);	// Doubling input 2 by shifting left 1
		else if (func === 4'b1011)
			o = (~i2) + 1;	// Negating input 2
		else if (func === 4'b1100)
			o = i1 / i2;	// Dividing inputs
		else
			o = i1;
	end
endmodule
