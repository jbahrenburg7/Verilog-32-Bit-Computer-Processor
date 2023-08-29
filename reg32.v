/*JB Bahrenburg
* reg32.v
* This describes a basic 32-bit register which is synchronous with the
* negative-edge of a clock
* INPUTS: D which is the 32-bit input value to be stored, a clock, an aneable
* pin, and a reset pin
* OUTPUTS: Q which is the 32-bit stored value*/
module reg32 (
	input [31:0] D,
	input en, clk, rst,
	output [31:0] Q
);

	reg [31:0] internal;	// The internally stored value
	
	always @ (negedge clk) begin
		if(rst == 1)
			internal = {32{1'b0}};	// if reset is active, set stored value to 0
		else if (en == 1)
			internal = D;	// If enabled set the internal value to the input
		else
			internal = internal;	// Otherwise the internally stored value should remain the same
	end
	
	assign Q = internal;	// Assign the output to the internally stored value

endmodule
