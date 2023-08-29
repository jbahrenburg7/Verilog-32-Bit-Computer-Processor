/*JB Bahrenburg
* comparator.v
* This module "compares" the values of two inputs by subtracting the
* difference and storing it. Then the controller will determine the result of
* conditional statements based on the stored value.
* INPUTS: two 32-bit numbers to be compared, an enable bit and a clock
* OUTPUTS: the 32-bit result of the subtraction*/
module comparator (
	input [31:0] i1, i2,
	input compen, clk,
	output [31:0] comp
);
	reg [31:0] internal;

	always @ (negedge clk) begin
		if(compen === 1)
			internal = i1-i2;	// if enabled then subtract
		else
			internal = internal;	// otherwise store the same result
	end

	assign comp = internal;	// assigning the output to the stored value
endmodule
