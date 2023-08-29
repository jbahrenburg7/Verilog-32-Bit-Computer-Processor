/*JB Bahrenburg
* bitm.v
* This module is a bit manipulator, when performing an immediate instruction this module will take the last 16 bits of the instruction and sign extend them*/
module bitm (
	input [31:0] instruction,
	input op,
	output reg [31:0] o
);

	always @ * begin
		if (op == 0)
			o = instruction;	// if not enabled then do nothing
		else
			o = {{16{instruction[15]}}, instruction[15:0]}; // If enabled then cut in half and sign-extend
	end

endmodule
