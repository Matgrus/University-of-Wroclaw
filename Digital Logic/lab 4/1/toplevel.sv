module zad1(output [3:0] o, input [3:0] i, input l, r);
  assign o[0] = r && i[1] || !(l || r) && i[0];
  assign o[1] = l && i[0] || r && i[2] || !(l || r) && i[1];
  assign o[2] = l && i[1] || r && i[3] || !(l || r) && i[2];
  assign o[3] = l && i[2] || !(l || r) && i[3];
  
endmodule