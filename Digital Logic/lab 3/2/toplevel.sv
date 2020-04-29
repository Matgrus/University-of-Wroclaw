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


module adder(output [15:0] o, input [15:0] a, b);
  logic c1, c2, c3;
  logic [3:0] g, p;
  
  four_sum first_4(p[0], g[0], o[3:0], 1'b0, a[3:0], b[3:0]);
  c1_calc cc1(c1, 1'b0, p[0], g[0]);
  four_sum second_4(p[1], g[1], o[7:4], c1, a[7:4], b[7:4]);
  c2_calc cc2(c2, 1'b0, p[0], p[1], g[0], g[1]);
  four_sum third_4(p[2], g[2], o[11:8], c2, a[11:8], b[11:8]);
  c3_calc cc3(c3, 1'b0, p[0], p[1], p[2], g[0], g[1], g[2]);
  four_sum fourth_4(p[3], g[3], o[15:12], c3, a[15:12], b[15:12]);
  
endmodule
