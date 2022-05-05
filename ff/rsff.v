module RSFF(input set, input reset, output q, output nq);
  assign q = ~(set & nq);
  assign nq = ~(reset & q);
endmodule
