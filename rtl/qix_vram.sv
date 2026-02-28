// qix_vram.sv — 64KB Dual-Port Framebuffer, Address Latch, Scanline Latch
//
// Port A (CPU): muxed between direct ($0000-$7FFF) and latched ($9400) access.
//   Direct and latched accesses are mutually exclusive (different address
//   ranges in the caller), so we mux the address and drive both dout and
//   latch_dout from the same BRAM output register.
// Port B (Display): read-only scanout with optional cocktail-flip.
// Scanline latch: captured on rising edge of crtc_de.

module qix_vram (
    input             clk,
    input             flip,         // cocktail flip: XOR display addr with $FFFF

    // CPU direct access  ($0000-$7FFF region, upper bit from latch_addr_hi[7])
    input  [14:0]     addr,
    input             we,
    input  [7:0]      din,
    output [7:0]      dout,

    // CPU latched access ($9400/$9402/$9403 region)
    input  [7:0]      latch_addr_hi,
    input  [7:0]      latch_addr_lo,
    input             latch_we,
    input  [7:0]      latch_din,
    output [7:0]      latch_dout,

    // Display scanout — read-only
    input  [15:0]     display_addr,
    output reg [7:0]  display_dout,

    // Scanline latch inputs (from CRTC)
    input  [13:0]     crtc_ma,
    input  [4:0]      crtc_ra,
    input             crtc_de,
    output reg [7:0]  scanline_latch
);

// ---------------------------------------------------------------------------
// 64KB framebuffer (synthesises to M10K block RAM on Cyclone V)
// ---------------------------------------------------------------------------
reg [7:0] vram [0:65535];

// Full 16-bit addresses for each access mode
wire [15:0] cpu_direct_full = {latch_addr_hi[7], addr};
wire [15:0] cpu_latch_full  = {latch_addr_hi, latch_addr_lo};

// Port A: mux between direct and latched (they are mutually exclusive)
wire [15:0] cpu_addr_mux  = latch_we ? cpu_latch_full  : cpu_direct_full;
wire [7:0]  cpu_din_mux   = latch_we ? latch_din        : din;
wire        cpu_we_any    = we | latch_we;

// Port B: display address, optionally flipped
wire [15:0] disp_addr_eff = flip ? (display_addr ^ 16'hFFFF) : display_addr;

// ---------------------------------------------------------------------------
// Port A — CPU read/write (one BRAM port)
// ---------------------------------------------------------------------------
reg [7:0] cpu_q;

always @(posedge clk) begin
    if (cpu_we_any)
        vram[cpu_addr_mux] <= cpu_din_mux;
    cpu_q <= vram[cpu_addr_mux];
end

// Both CPU outputs come from the same BRAM read register.
// The caller uses dout during direct accesses and latch_dout during latched
// accesses — they are never both active in the same cycle.
assign dout       = cpu_q;
assign latch_dout = cpu_q;

// ---------------------------------------------------------------------------
// Port B — Display scanout (read-only)
// ---------------------------------------------------------------------------
always @(posedge clk)
    display_dout <= vram[disp_addr_eff];

// ---------------------------------------------------------------------------
// Scanline latch — capture on rising edge of crtc_de
// scanline_latch = { MA[9:5], RA[2:0] }
// ---------------------------------------------------------------------------
reg crtc_de_r;
always @(posedge clk) begin
    crtc_de_r <= crtc_de;
    if (crtc_de && !crtc_de_r)
        scanline_latch <= {crtc_ma[9:5], crtc_ra[2:0]};
end

endmodule
