module tff(output q, nq, input t, c, nrst);
logic ns, nr, ns1, nr1, j, k;
  nand n1(ns, c, j), n2(nr, c, k),
n3(q, ns, nq), n4(nq, nr, q, nrst),
  n5(ns1, !c, t, nq), n6(nr1, !c, t, q),
n7(j, ns1, k), n8(k, nr1, j, nrst);
endmodule
module syncnt(output [3:0] out, input step, clk, nrst, down);
  logic [3:0] nq;
  tff tf0(out[0], nq[0], step ? (1'b0) : (1'b1), clk, nrst);
  tff tf1(out[1], nq[1], step ? (1'b1) : (down ? nq[0] : out[0]), clk, nrst);
  tff tf2(out[2], nq[2], step ? (down ? nq[1] : out[1]) : (down ? nq[0] & nq[1] : out[0] & out[1]), clk, nrst);
  tff tf3(out[3], nq[3], step ? (down ? nq[1] & nq[2] : out[1] & out[2]) : (down ? nq[0] & nq[1] & nq[2] : out[0] & out[1] & out[2]), clk, nrst);
endmodule