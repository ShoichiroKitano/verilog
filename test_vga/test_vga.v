module test_vga(
  input CLK,
  input RST,
  input [9:0] SW,
  input [9:0] KEY,
  output [9:0] LEDR,
  output [6:0] HEX0,
  output [6:0] HEX1,
  output [6:0] HEX2,
  output [6:0] HEX3,
  output [6:0] HEX4,
  output [6:0] HEX5
);

  wire clk;
  wire no_use;

  RSFF rsff(KEY[0], KEY[1], clk, no_use);

  wire [9:0] hcount;
  wire [9:0] vcount;
  wire vga_hs;
  wire vga_vs;

  SYNC sync(
    .CLK(clk),
    .RST(RST),
    .VGA_HS(vga_hs),
    .VGA_VS(vga_vs),
    .HCOUNT(hcount),
    .VCOUNT(vcount)
  );

  defparam sync.hdisplay = 10'd1;
  defparam sync.hborder1 = 10'd1;
  defparam sync.hfront_poarch = 10'd1;
  defparam sync.hsync = 10'd2;
  defparam sync.hborder2 = 10'd1;
  defparam sync.hback_poarch = 10'd1;

  assign LEDR[0] = vga_hs;
  PrintI({HEX5, HEX4, HEX3, HEX2, HEX1, HEX0}, hcount);

endmodule
