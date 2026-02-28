//============================================================================
//
// Qix Platform Top-Level Module (STUB)
// Copyright (C) 2026 Rodimus
//
// This module ties together the Data CPU board, Video CPU board,
// and Audio board of the Qix arcade platform.
//
// Boards to implement:
//   - Data CPU board  : mc6809e + 3x PIA6821 + shared RAM port + local RAM + ROM
//   - Video CPU board : mc6809e + mc6845 + 64KB VRAM + palette RAM + address latch + ROM
//   - Audio board     : m6802 + 3x PIA6821 + DAC + volume control
//
// Inter-board connections:
//   - Shared RAM (2KB) accessed by both CPUs via arbitration
//   - FIRQ from Video CPU to Data CPU (sync signal)
//   - ROM loader via ioctl interface (MRA/MiSTer ROM download)
//
//============================================================================

module Qix
(
	input         reset,
	input         clk_20m,

	// Coin & start
	input  [1:0]  coin,           // active-low {coin2, coin1}
	input  [1:0]  start_buttons,  // active-low {start2, start1}

	// Player joysticks (active-low, packed {R,L,D,U})
	input  [3:0]  p1_joystick,
	input  [3:0]  p2_joystick,
	input         p1_fire,
	input         p2_fire,

	// DIP switches (active-low, two banks of 8)
	input  [15:0] dip_sw,

	// Video outputs
	output        video_hsync,
	output        video_vsync,
	output        video_vblank,
	output        video_hblank,
	output        ce_pix,
	output  [7:0] video_r,
	output  [7:0] video_g,
	output  [7:0] video_b,

	// Audio outputs (signed 16-bit stereo)
	output signed [15:0] sound_l,
	output signed [15:0] sound_r,

	// ROM loader (MiSTer ioctl)
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

// --- Stub outputs (safe defaults) ---
assign video_hsync  = 0;
assign video_vsync  = 0;
assign video_vblank = 0;
assign video_hblank = 0;
assign ce_pix       = 0;
assign video_r      = 8'h00;
assign video_g      = 8'h00;
assign video_b      = 8'h00;
assign sound_l      = 16'h0000;
assign sound_r      = 16'h0000;
assign hs_address   = 16'h0000;
assign hs_data_out  = 8'h00;

// --- TODO: Instantiate sub-boards ---
// Qix_CPU  cpu_board  ( ... );
// Qix_Video video_board( ... );
// Qix_Sound sound_board( ... );

endmodule
