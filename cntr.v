/*JB Bahrenburg
* cntr.v
* This file contains the behavior for the program counter. The program counter
* stores two values: the next instruction to be performed and the previous
* instruction to be performed. After each instruction, the PC increments the
* address by 4 unless a jump or call instruction is performed.
* INPUTS: a reset bit, an enable bit, a bit to enable jumping to the previous
* instruction, a bit to enable a jump, a clock, and a bit to return, 5 bits
* determining the current state, and an 32-bit input for loading new addresses
* OUTPUTS: The address of the current instruction and the address of the
* previous instruction*/
module cntr (
	input rst, en, gotoprev, jumping, clk, ret,
	input [4:0] cstate,
	input [31:0] D,
	output [31:0] Q, prev
);
	reg [31:0] internal, previ;	// internally stored values

	always @ (posedge gotoprev) begin
		if(rst === 1)
			internal = -4;	// resets to -4 (will increment to 0)
		else if (gotoprev === 1)
			internal = previ;	// jumping to previous if need be
	end

	always @ (negedge clk) begin
		if(jumping === 1)
			internal[27:0] = {D[25:0], 2'b00} - 4;	// jump to next instruction, jumping is done by concatenating the first 4 bits of the current instruction, the last 26 bits of the jump input and two zeros
		else if (ret === 1)
			internal = D;	// storing new value
		else if (en === 1) begin
			previ = internal;
			internal = D - 4;	// storing new value
		end
	end


	always @ (cstate) begin
		if(rst == 1) begin
			internal <= -4;	// resetting to -4 if reset is active
		end else if (cstate === 0 && internal >= 0) begin
			internal <= internal+4;	// incrementing when instruction is complete
		end else if (internal === 32'hXXXXXXXX) begin
			internal <= 0;	// setting to 0 if the current instruction saved is undefined
		end else begin
			internal = internal;	// otherwise value remains the same
		end
	end

	assign Q = internal;
	assign prev = previ;
endmodule
