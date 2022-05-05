module PrintI(HEX, VALUE);
  input [19:0] VALUE;
  output [41:0] HEX;

  wire [23:0] number;

  assign number = parse(VALUE);

  function [23:0] parse;
    input [19:0] value;
    reg [19:0] tmp = value;
    reg [3:0] mod;
    integer i;

    for(i = 0; i < 24; i = i + 4) begin
      if(tmp != 20'd0) begin
        mod = tmp % 20'd10;
        parse[i] = mod[0];
        parse[i + 1] = mod[1];
        parse[i + 2] = mod[2];
        parse[i + 3] = mod[3];
        tmp = tmp / 20'd10;
      end
      else begin
        // ハイインピーダンス
        parse[i] = 1'b1;
        parse[i + 1] = 1'b1;
        parse[i + 2] = 1'b1;
        parse[i + 3] = 1'b1;
      end
    end
  endfunction

  Segment7 hex0(number[3:0], HEX[6:0]);
  Segment7 hex1(number[7:4], HEX[13:7]);
  Segment7 hex2(number[11:8], HEX[20:14]);
  Segment7 hex3(number[15:12], HEX[27:21]);
  Segment7 hex4(number[19:16], HEX[34:28]);
  Segment7 hex5(number[23:20], HEX[41:35]);
endmodule

module Segment7 (input [3:0] VALUE, output [6:0] HEX);
  assign HEX = convert(VALUE);

  function [6:0] convert;
    input [3:0] value;
    begin
      case ( value )
        4'h0:  convert = 7'b1000000;
        4'h1:  convert = 7'b1111001;
        4'h2:  convert = 7'b0100100;
        4'h3:  convert = 7'b0110000;
        4'h4:  convert = 7'b0011001;
        4'h5:  convert = 7'b0010010;
        4'h6:  convert = 7'b0000010;
        4'h7:  convert = 7'b1011000;
        4'h8:  convert = 7'b0000000;
        4'h9:  convert = 7'b0010000;
        default:  convert = 7'bzzzzzzz;
      endcase
    end
  endfunction
endmodule
