module SYNC(CLK, RST, VGA_HS, VGA_VS, HCOUNT, VCOUNT);
  input CLK;
  input RST;
  output reg VGA_HS = 1'd0;
  output reg VGA_VS = 1'd0;
  output reg [9:0] HCOUNT = 10'd0;
  output reg [9:0] VCOUNT = 10'd0;

  // 水平カウント用の定数(テストのためparameterで可変)
  parameter hdisplay = 10'd640;
  parameter hborder1 = 10'd8;
  parameter hfront_poarch = 10'd8;
  parameter hsync = 10'd96;
  parameter hborder2 = 10'd8;
  parameter hback_poarch = 10'd40;

  localparam start_hsync = hdisplay + hborder1 + hfront_poarch; // 640 + 8 + 8, 3
  localparam end_hsync = start_hsync + hsync; // 640 + 8 + 8 + 96, 5
  localparam max_hcount = end_hsync + hback_poarch + hborder2; // 640 + 8 + 8 + 96 + 40 + 8, 7

  // 0を表示部分の開始位置とする. 0を含むので1を引く
  always @(posedge CLK) begin
    VGA_HS <= (start_hsync - 10'd1 <= HCOUNT && HCOUNT < end_hsync - 10'd1);
    if(RST)
      HCOUNT <= 10'b0;
    else if(HCOUNT == max_hcount - 10'd1)
      HCOUNT <= 10'b0;
    else
      HCOUNT <= HCOUNT + 10'b1;
  end
endmodule
