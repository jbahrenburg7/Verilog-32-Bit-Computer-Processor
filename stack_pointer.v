/*JB Bahreburg
* stack_pointer.v
* This file contains the behavior for a stack pointer, a special register which points to the
* address for the top of the stack.*/
module stack_pointer (
	input clk, en, rst, dec,
	output [31:0] Q
);
	/*Four inputs: a clock, a reset input, and enable pin, and a decrement
	* pin
	* The single output is the address of hte current top of the stack*/
	reg [31:0] internal;
	
	always @ (negedge clk) begin
		if(rst === 1)
			internal = 32'h20008C78;	// if resetting, go back to 0x20008C78, the address for the first stack value in memory
		else if (internal === 32'hx)
			internal = 32'h20008C78;	// if undefined the stack pointer should also reset
		else if (en === 1)
			internal = internal + 4;	// if enabled then it needs to be incremented
		else if (dec === 1)
			internal = internal - 4;	// if decrement is active then go to the previous address
	end

	assign Q = internal;

endmodule
