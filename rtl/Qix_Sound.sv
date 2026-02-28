//============================================================================
//
// Qix Audio Board (STUB)
// Copyright (C) 2026 Rodimus
//
// Hardware: m6802 + 3x PIA6821 + DAC + volume control
//
// Responsibilities:
//   - Sound CPU (6802 @ ~3.58 MHz, NTSC crystal)
//   - Receives sound commands from Data CPU via PIA
//   - Generates L/R audio via two independent DAC channels
//   - Independent volume control per channel
//
//============================================================================

module Qix_Sound
(
	input         reset,
	input         clk_20m,

	// Sound command from Data CPU (via PIA)
	input   [7:0] sound_cmd,
	input         sound_cmd_strobe,

	// ROM loader
	input  [24:0] ioctl_addr,
	input         ioctl_wr,
	input   [7:0] ioctl_data,
	input   [7:0] ioctl_index,

	// Pause
	input         pause,

	// Audio outputs (signed 16-bit stereo)
	output signed [15:0] sound_l,
	output signed [15:0] sound_r
);

// --- Stub outputs ---
assign sound_l = 16'h0000;
assign sound_r = 16'h0000;

// --- TODO: Instantiate m6802, PIA6821 x3, DAC, volume logic ---

endmodule
