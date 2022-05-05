module test_print_i(
  output [6:0] HEX0,
  output [6:0] HEX1,
  output [6:0] HEX2,
  output [6:0] HEX3,
  output [6:0] HEX4,
  output [6:0] HEX5
);


  PrintI({HEX5, HEX4, HEX3, HEX2, HEX1, HEX0}, 1234);
endmodule
