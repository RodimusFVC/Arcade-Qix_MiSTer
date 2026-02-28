//============================================================================
//
// Qix Data CPU Board (STUB)
// Copyright (C) 2026 Rodimus
//
// Hardware: mc6809e + 3x PIA6821 + shared RAM port + local RAM + ROM
//
// Responsibilities:
//   - Game logic CPU (6809E @ ~1.25 MHz)
//   - Controls: reads joystick/coin/start via PIA
//   - DIP switch inputs via PIA
//   - Communicates with Video CPU via shared 2KB RAM + FIRQ
//   - Drives Audio board via PIA
//
//============================================================================

module Qix_CPU
(
	input         reset,
	input         clk_20m,

	// Coin & start (active-low)
	input  [1:0]  coin,
	input  [1:0]  start_buttons,

	// Joystick inputs (active-low)
	input  [3:0]  p1_joystick,
	input  [3:0]  p2_joystick,
	input         p1_fire,
	input         p2_fire,

	// DIP switches (active-low)
	input  [15:0] dip_sw,

	// Shared RAM interface (to Video CPU)
	output [10:0] shared_ram_addr,
	output  [7:0] shared_ram_dout,
	input   [7:0] shared_ram_din,
	output        shared_ram_we,

	// FIRQ from Video CPU
	input         firq_n,

	// ROM loader
	input  [24:0] ioctl_addr,
	input         ioctl_wr,
	input   [7:0] ioctl_data,
	input   [7:0] ioctl_index,

	// Pause
	input         pause,

	// Hiscore interface
	output [15:0] hs_address,
	output  [7:0] hs_data_out,
	input   [7:0] hs_data_in,
	input         hs_write
);

// --- Stub outputs ---
assign shared_ram_addr = 11'h000;
assign shared_ram_dout = 8'h00;
assign shared_ram_we   = 1'b0;
assign hs_address      = 16'h0000;
assign hs_data_out     = 8'h00;

// --- TODO: Instantiate mc6809e, PIA6821 x3, local RAM, ROM ---

endmodule
