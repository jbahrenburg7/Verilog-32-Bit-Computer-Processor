/*JB Bahrenburg
* controller.v
* The controller carries the brunt of the workload for the processor, relaying
* information, coordinating registers, and determining outputs. This is done
* using a form of a Mealy finite state machine*/
module controller (
	input [31:0] instruction, stack,	// current instruction & stack address
	input signed [31:0] comp,	// result from the comparator
	input clk, reset,		// clock and reset bits
	output reg [31:0] rst, en,	// register reset and enable bits
	output reg [4:0] sel, shamt,	// select for multiplexer, and shift amount for ALU
	output [4:0] state,		// current state
	output reg [3:0] alu_func,	// function for the alu
	output reg dne, rw, gtprev, encntr, aluen, op, compen, compopen, jumping, sp_pc, ensp, straddress, ret, dec	// various flags used by components throughout the system, mostly one-off enable bits
);

	// All states used for the system
	localparam [4:0] IDLE = 5'b00000, MOV = 5'b00001, LI = 5'b00011, CLR = 5'b00100, LD = 5'b00101, STR = 5'b00110, OUTADDR = 5'b00111, A1 = 5'b01000, A2 = 5'b01001, A3 = 5'b01010, NOT1 = 5'b01011, NOT2 = 5'b01100, RST = 5'b01101, CMP1 = 5'b01110, CMP2 = 5'b01111, JMP = 5'b10000, CALL1 = 5'b10001, CALL2 = 5'b10010, PUSH = 5'b10011, POP1 = 5'b10100, POP2 = 6'b10101;
	
	wire [4:0] current_state;	// states
	wire [4:0] prev_state;
       	reg [4:0] next_state;
	reg [31:0] i_instruction;	// internally stored instruction, prevents beginning a new instruction until after current instruction is complete (system returns to IDLE)

	always @ (posedge clk  or posedge reset) begin
		if (reset == 1) begin
			next_state = RST;	// resetting if rst is high
		end else begin
			if (current_state == IDLE) begin
				i_instruction = instruction;	// storing instruction
				case (i_instruction [31:26])	// case statement determining 
					6'b000010: next_state = MOV;
					6'b001010: next_state = LI;
					6'b000000: next_state = LD;
					6'b000001: next_state = STR;
					6'b000011: next_state = MOV;
					6'b000100: next_state = A1;
					6'b000101: next_state = A1;
					6'b000110: next_state = A1;
					6'b000111: next_state = A1;
					6'b001000: next_state = A1;
					6'b001001: next_state = NOT1;
					6'b001011: next_state = A1;
					6'b001100: next_state = A1;
					6'b001101: next_state = A1;
					6'b001110: next_state = A1;
					6'b001111: next_state = A1;
					6'b010000: next_state = NOT1;
					6'b010001: next_state = NOT1;
					6'b010010: next_state = NOT1;
					6'b010011: next_state = NOT1;
					6'b010101: next_state = CMP1;
					6'b010100: next_state = JMP;
					6'b011010: next_state = JMP;
					6'b011000: next_state = JMP;
					6'b010110: next_state = JMP;
					6'b010111: next_state = JMP;
					6'b011001: next_state = JMP;
					6'b011010: next_state = JMP;
					6'b011101: next_state = NOT1;
					6'b011110: next_state = NOT1;
					6'b011100: next_state = NOT1;
					6'b100000: next_state = A1;
					6'b100100: next_state = A1;
					6'b100001: next_state = CALL1;
					6'b100010: next_state = CALL1;
					6'b011111: next_state = PUSH;
					6'b100011: next_state = POP1;
					default: next_state = IDLE;
				endcase
				// defining all other state transitions
			end else if (current_state == MOV) begin
				if (i_instruction [31:26] == 6'b000010) begin
					next_state = CLR;
				end else begin
					next_state = IDLE;
				end
			end else if (current_state == LI) begin
				next_state = IDLE;
			end else if (current_state == CLR) begin
				next_state = IDLE;
			end else if (current_state == LD) begin
				next_state = LI;
			end else if (current_state == STR) begin
				next_state = OUTADDR;
			end else if (current_state == OUTADDR) begin
				next_state = IDLE;
			end else if (current_state == A1) begin
				next_state = A2;
			end else if (current_state == A2) begin
				next_state = A3;
			end else if (current_state == A3) begin
				next_state = IDLE;
			end else if (current_state == NOT1) begin
				next_state = NOT2;
			end else if (current_state == NOT2) begin
				next_state = IDLE;
			end else if (current_state === CMP1) begin
				next_state = CMP2;
			end else if (current_state === CALL1) begin
				next_state = CALL2;
			end else if (current_state === POP1) begin
				next_state = POP2;
			end else begin
				next_state = IDLE;
			end
		end
	end

	assign prev_state = current_state;	// changing states
	assign current_state = next_state;
	assign state = current_state;

	always @ (current_state) begin
		case (current_state)	// case statement to determine what to do at each state
			MOV: begin	// enabling destination register
				en = 32'h00000000;
				rst = 32'h00000000;
				en[i_instruction[20:16]] = 1'b1;
				sel = i_instruction[25:21];
				dne = 1'b0;
				rw = 1'b0;
				gtprev = 1'b0;
				encntr = 1'b0;
				alu_func = 4'b0000;
				aluen = 1'b0;
			end
			LI: begin	// enabling destination register
				rst = 32'h00000000;
				if(prev_state == IDLE) begin
					en = 32'h00000000;
					en[i_instruction[25:21]] = 1'b1;
				end
				sel = 5'b00000;
				dne = 1'b0;
				rw = 1'b0;
				if(prev_state == LD) begin
					gtprev = 1'b1;
				end else begin
					gtprev = 1'b0;
					op = 1'b1;
				end
				encntr = 1'b0;
				alu_func = 4'b0000;
				aluen = 1'b0;
			end
			CLR: begin	// resetting the source register on MOV
				en = 32'h00000000;
				rst[i_instruction[25:21]] = 1'b1;
				sel = 5'bxxxxx;
				dne = 1'b0;
				rw = 1'b0;
				gtprev = 1'b0;
				encntr = 1'b0;
				alu_func = 4'b0000;
				aluen = 1'b0;
			end
			LD: begin	// outputting address stored in register
				en = 32'h00000000;
				rst = 32'h00000000;
				rw = 1'b0;
				en[i_instruction[25:21]] = 1'b1;
				sel = i_instruction[20:16];
				dne = 1'b1;
				gtprev = 1'b0;
				encntr = 1'b0;
				ret = 1;
				alu_func = 4'b0000;
				aluen = 1'b0;
			end
			STR: begin	//outputting value stored in register
				en = 32'h00000000;
				rst = 32'h00000000;
				rw = 1'b1;
				sel = i_instruction[25:21];
				dne = 1'b0;
				gtprev = 1'b0;
				encntr = 1'b1;
				alu_func = 4'b0000;
				aluen = 1'b0;
			end
			OUTADDR: begin	// outputting a desired address
				rw = 1'b1;
				sel = i_instruction[20:16];
				gtprev = 1'b1;
				encntr = 1'b0;
				alu_func = 4'b0000;
				aluen = 1'b0;
			end
			A1: begin	// arithmetic state, handles most arithmetic and logic functions
				rw = 1'b0;
				en = 32'h00000000;
				en[31] = 1'b1;
				if(i_instruction[29:26] === 4'b1100)
					sel = 0;
				else
					sel = i_instruction[25:21];
				rst = 32'h00000000;
				dne = 1'b0;
				gtprev = 1'b0;
				encntr = 1'b0;
				if(i_instruction[31:26] === 6'b000100 || i_instruction[31:26] === 6'b001011) begin
					alu_func = 4'b0000;
				end else if (i_instruction[31:26] === 6'b000101 || i_instruction[31:26] === 6'b001100) begin
					alu_func = 4'b0001;
				end else if (i_instruction[31:26] === 6'b000110 || i_instruction[31:26] === 6'b001101) begin
					alu_func = 4'b0010;
				end else if (i_instruction[31:26] === 6'b000111 || i_instruction[31:26] === 6'b001110) begin
					alu_func = 4'b0011;
				end else if (i_instruction[31:26] === 6'b001000 || i_instruction[31:26] === 6'b001111) begin
					alu_func = 4'b0100;
				end else if (i_instruction[31:26] === 6'b100000 || i_instruction[31:26] === 6'b100100) begin
					alu_func = 4'b1100;
				end
				aluen = 1'b0;
				if(i_instruction[29:26] === 4'b1011 || i_instruction[29:26] === 4'b1100 || i_instruction[29:26] === 4'b1101 || i_instruction[29:26] === 4'b1110 || i_instruction[29:26] === 4'b1111 || i_instruction[31:26] === 6'b100100)
					op = 1;
				else
					op = 0;
			end
			A2: begin	// secondary arithmetic state
				en = 32'h00000000;
				aluen = 1'b1;
				if(i_instruction[29:26] === 4'b1011 || i_instruction[29:26] === 4'b1101 || i_instruction[29:26] === 4'b1110 || i_instruction[29:26] === 4'b1111 || i_instruction[31:26] === 6'b100100)
					sel = 0;
				else if (i_instruction[29:26] === 4'b1100)
					sel = i_instruction[25:21];
				else
					sel = i_instruction[20:16];
			end
			A3: begin	// third arithmetic state

				if(i_instruction[29:26] === 4'b1011 || i_instruction[29:26] === 4'b1100 || i_instruction[29:26] === 4'b1101 || i_instruction[29:26] === 4'b1110 || i_instruction[29:26] === 4'b1111 || i_instruction[31:26] === 6'b100100)
					en[i_instruction[20:16]] = 1'b1;
				else
					en[i_instruction[15:11]] = 1'b1;
				aluen = 1'b0;
				sel = 5'b11111;
			end
			NOT1: begin	// Not state, handles all arithmetic and logical operations that only require two states
				en = 32'h00000000;
				if(i_instruction[30:26] === 5'b10000) begin
					sel = 0;
					op = 1;
				end else begin
					sel = i_instruction[25:21];
					op = 0;
				end
				rst = 32'h00000000;
				dne = 1'b0;
				rw = 1'b0;
				gtprev = 1'b0;
				encntr = 1'b0;
				if(i_instruction [30:26] === 5'b10001) begin
					alu_func = 4'b0110;
					shamt = i_instruction[10:6];
				end else if (i_instruction[30:26] === 5'b10010) begin
					alu_func = 4'b0111;
					shamt = i_instruction[10:6];
				end else if (i_instruction[30:26] === 5'b10011) begin
					alu_func = 4'b1000;
					shamt = i_instruction[10:6];
				end else if (i_instruction[31:26] === 6'b011101) begin
					alu_func = 4'b1001;
				end else if (i_instruction[31:26] === 6'b011110) begin
					alu_func = 4'b1010;
				end else if (i_instruction[31:26] === 6'b011100) begin
					alu_func = 4'b1011;
				end else begin
					alu_func = 4'b0101;
				end
				aluen = 1'b1;
			end
			NOT2: begin	// Secondary not state
				if(i_instruction[30:26] === 5'b10000 || i_instruction[31:26] === 6'b011101 || i_instruction[31:26] === 6'b011110 || i_instruction[31:26] === 6'b011100)
					en[instruction[25:21]] = 1'b1;
				else
					en[instruction[20:16]] = 1'b1;
				aluen = 1'b0;
				sel = 5'b11111;
			end
			RST: begin	// Reset state
				sel = 5'bxxxxx;
				en = 32'h00000000;
				dne = 1'b0;
				rw = 1'b0;
				gtprev = 1'b0;
				encntr = 1'b0;
				alu_func = 4'b0000;
				aluen = 1'b0;
				rst = 32'hFFFFFFFF;
			end
			CMP1: begin	// First compare state
				sel = i_instruction[25:21];
				en = 32'h00000000;
				rst = 32'h00000000;
				dne = 0;
				rw = 0;
				gtprev = 0;
				encntr = 0;
				alu_func = 0;
				aluen = 0;
				op = 0;
				compen = 0;
				compopen = 1;
			end
			CMP2: begin	// Second compare state
				sel = i_instruction[20:16];
				compen = 1;
				compopen = 0;
			end
			JMP: begin	// Jumps state
				sel = 0;
				en = 32'h00000000;
				rst = 32'h00000000;
				dne = 0;
				rw = 0;
				gtprev = 0;
				encntr = 0;
				alu_func = 0;
				aluen = 0;
				op = 0;
				compen = 0;
				compopen = 0;
				if(i_instruction[31:26] === 6'b011010 && comp[31] !== 1'b1 && comp !== 0)
					jumping = 1;
				else if (i_instruction[31:26] === 6'b010100)
					jumping = 1;
				else if (i_instruction[31:26] === 6'b011000 && comp[31] !== 1'b0)
					jumping = 1;
				else if (i_instruction[31:26] === 6'b010110 && comp === 0)
					jumping = 1;
				else if (i_instruction[31:26] === 6'b010111 && comp !== 0)
					jumping = 1;
				else if (i_instruction[31:26] === 6'b011001 && (comp === 0 || comp[31] === 1))
					jumping = 1;
				else if (i_instruction[31:26] === 6'b011011 && comp[31] === 0)
					jumping = 1;
				else
					jumping = 0;
			end
			CALL1: begin	// First call state, also used for return
				sel = 0;
				dne = 1;
				sp_pc = 1;
				encntr = 0;
			end
			CALL2: begin	// Second call state
				encntr = 1;
				dne = 0;
				straddress = 1;
				rw = 1;
				if(i_instruction[31:26] === 6'b100010) begin
					ensp = 1;
					ret = 1;
				end else begin
					ensp = 0;
					ret = 0;
				end
			end
			PUSH: begin	// Push state
				if(stack !== 32'h20008C78) begin
					dne = 0;
					rw = 1;
					sel = i_instruction[25:21];
					sp_pc = 1;
					dec = 1;
				end
			end
			POP1: begin	// First pop state
				dne = 1;
				sel = 0;
				sp_pc = 1;
				en = 0;
			end
			POP2: begin	// Second pop state
				en[i_instruction[25:21]] = 1;
				dec = 0;
				sp_pc = 0;
				ensp = 1;
			end
			default: begin	// Default (IDLE) resets all flags and signals
				sel = 5'bxxxxx;
				en = 32'h00000000;
				rst = 32'h00000000;
				dne = 1'b1;
				rw = 1'b0;
				gtprev = 1'b0;
				encntr = 1'b0;
				alu_func = 4'b0000;
				aluen = 1'b0;
				op = 1'b0;
				compen = 0;
				compopen = 0;
				jumping = 0;
				sp_pc = 0;
				ensp = 0;
				straddress = 0;
				ret = 0;
				dec = 0;
			end
		endcase
	end

endmodule
