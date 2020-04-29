module small_sum(output s, g, p, input c, x, y);
  assign s = x ^ y ^ c;
  assign g = x && y;
  assign p = x || y;
endmodule

module c1_calc(output c, input c0, p0, g0);
  assign c = c0 && p0 || g0;
endmodule

module c2_calc(output c, input c0, p0, p1, g0, g1);
  assign c = c0 && p0 && p1 || g0 && p1 || g1;
endmodule

module c3_calc(output c, input c0, p0, p1, p2, g0, g1, g2);
  assign c = c0 && p0 && p1 && p2 || g0 && p1 && p2 || g1 && p2 || g2;
endmodule

// dodawanie czworek za pomoca ukladu z przewidywaniem przeniesienia z drugiego zadania

module four_sum(output P, G, output [3:0] s, input c0, input [3:0] x, y);
  logic c1, c2, c3;
  logic [3:0] g, p;
  
  small_sum ss1(s[0], g[0], p[0], c0, x[0], y[0]);
  c1_calc cc1(c1, c0, p[0], g[0]);
  small_sum ss2(s[1], g[1], p[1], c1, x[1], y[1]);
  c2_calc cc2(c2, c0, p[0], p[1], g[0], g[1]);
  small_sum ss3(s[2], g[2], p[2], c2, x[2], y[2]);
  c3_calc cc3(c3, c0, p[0], p[1], p[2], g[0], g[1], g[2]);
  small_sum ss4(s[3], g[3], p[3], c3, x[3], y[3]);
  
  assign P = p[0] && p[1] && p[2] && p[3];
  assign G = g[0] && p[1] && p[2] && p[3] || g[1] && p[2] && p[3] || g[2] && p[3] || g[3];
    
endmodule

// sprawdzenie kiedy musimy dodac 6

module bcd_check(output o, input [3:0] a, input c, g);
  assign o = a[3] && (a[2] || a[1]) || c || a[3] && a[0] && g;
endmodule

module set_rep(output [3:0] o, input check, sub);
  assign o = 4'b0110 & {4{check}};
endmodule

// naprawianie zlej reprezentacji

module bcd_fix(output [7:0] o, input [7:0] i, input sub, c1, c2);
  logic first_4_check, second_4_check, p1, g1, p2, g2;
  logic [3:0] first_rep, second_rep;
  
  bcd_check ch1(first_4_check, i[3:0], c1, 1'b0);
  set_rep sr1(first_rep, first_4_check, sub);
  four_sum fs1(p1, g1, o[3:0], 1'b0, i[3:0], first_rep);
  
  bcd_check ch2(second_4_check, i[7:4], c2, g1);
  set_rep sr2(second_rep, second_4_check, sub);
  four_sum fs2(p2, g2, o[7:4], g1, i[7:4], second_rep);
        
endmodule

module bcd_adder(output [7:0] o, input [7:0] a, b, input sub);
  logic c1, c2;
  logic [1:0] g, p;
  logic [7:0] res, b_2;
  logic p1, g1, p2, g2;
  
  // x - y = x + 99 - y + 1 = x + ~y + 10 + 1
  four_sum bb1(p1, g1, b_2[3:0], 1'b0, ~b[3:0], 4'b1010);
  four_sum bb2(p2, g2, b_2[7:4], 1'b0, ~b[7:4], 4'b1010);
  
  four_sum first_4(p[0], g[0], res[3:0], sub, a[3:0], {4{sub}} & b_2[3:0] | ~{4{sub}} & b[3:0]);
  c1_calc cc1(c1, sub, p[0], g[0]);
  four_sum second_4(p[1], g[1], res[7:4], c1, a[7:4],{4{sub}} & b_2[7:4] | ~{4{sub}} & b[7:4]);
  c2_calc cc2(c2, sub, p[0], p[1], g[0], g[1]);
  
  bcd_fix f1(o, res, sub, c1, c2);
  
endmodule


