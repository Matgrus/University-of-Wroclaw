module mux(output o, input [1:0] s, input i3, i2, i1, i0);
  logic and1, and2, and3, and4;
  and a1(and1, i0, !s[0], !s[1]), a2(and2, i1, s[0], !s[1]),
      a3(and3, i2, !s[0], s[1]), a4(and4, i3, s[0], s[1]);
  or o1(o, and1, and2, and3, and4);
endmodule

module dff(output q, nq, input c, d);
  logic r, s, nr, ns;
  nand gq(q, nr, nq), gnq(nq, ns, q),
       gr(nr, c, r), gs(ns, nr, c, s),
       gr1(r, nr, s), gs1(s, ns, d);
endmodule

module shift_reg(output [7:0] q, input [7:0] d, input i, c, l, r);
  logic mux0, mux1, mux2, mux3, mux4, mux5, mux6, mux7;
  logic q0, q1, q2, q3, q4, q5, q6, q7, nq0, nq1, nq2, nq3, nq4, nq5, nq6, nq7;
  
  mux m7(mux7, {r, l}, d[7], q6, i, q7), m6(mux6, {r, l}, d[6], q5, q7, q6),
      m5(mux5, {r, l}, d[5], q4, q6, q5), m4(mux4, {r, l}, d[4], q3, q5, q4),
      m3(mux3, {r, l}, d[3], q2, q4, q3), m2(mux2, {r, l}, d[2], q1, q3, q2),
      m1(mux1, {r, l}, d[1], q0, q2, q1), m0(mux0, {r, l}, d[0], i, q1, q0);
  
  dff d7(q7, nq7, c, mux7), d6(q6, nq6, c, mux6),
      d5(q5, nq5, c, mux5), d4(q4, nq4, c, mux4),
      d3(q3, nq3, c, mux3), d2(q2, nq2, c, mux2),
      d1(q1, nq1, c, mux1), d0(q0, nq0, c, mux0);
  
  assign q = {q7, q6, q5, q4, q3, q2, q1, q0};
endmodule