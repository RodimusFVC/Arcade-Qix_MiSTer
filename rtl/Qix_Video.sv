//============================================================================
//
// Qix Video CPU Board (STUB)
// Copyright (C) 2026 Rodimus
//
// Hardware: mc6809e + mc6845 CRTC + 64KB VRAM + palette RAM +
//           address latch + ROM
//
// Responsibilities:
//   - Video CPU (6809E @ ~5 MHz)
//   - CRTC (6845) generates H/V sync and address
//   - 64KB dual-port VRAM (bit-addressable, 2 planes)
//   - Palette RAM (256 entries, RRGGBBII format)
//   - Generates FIRQ to Data CPU on VSync
//   - Outputs RGB pixel data
//
//============================================================================

module Qix_Video
(
	input         reset,
	input         clk_20m,

	// Shared RAM interface (from Data CPU)
	input  [10:0] shared_ram_addr,
	input   [7:0] shared_ram_din,
	output  [7:0] shared_ram_dout,
	input         shared_ram_we,

	// FIRQ to Data CPU (active-low, asserted on VSync)
	output        firq_n,

	// ROM loader
	input  [24:0] ioctl_addr,
	input         ioctl_wr,
	input   [7:0] ioctl_data,
	input   [7:0] ioctl_index,

	// Pause
	input         pause,

	// Video outputs
	output        video_hsync,
	output        video_vsync,
	output        video_vblank,
	output        video_hblank,
	output        ce_pix,
	output  [7:0] video_r,
	output  [7:0] video_g,
	output  [7:0] video_b
);

// --- Stub outputs ---
assign shared_ram_dout = 8'h00;
assign firq_n          = 1'b1;
assign video_hsync     = 1'b0;
assign video_vsync     = 1'b0;
assign video_vblank    = 1'b0;
assign video_hblank    = 1'b0;
assign ce_pix          = 1'b0;
assign video_r         = 8'h00;
assign video_g         = 8'h00;
assign video_b         = 8'h00;

// --- TODO: Instantiate mc6809e, mc6845, VRAM, palette RAM, ROM ---

endmodule
