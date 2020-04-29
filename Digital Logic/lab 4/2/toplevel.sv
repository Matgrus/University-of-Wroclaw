module funnel_shifter(output [7:0] o, input [7:0] a, b, input [3:0] n);
  logic [15:0] res;
  assign res = {a, b};
  assign o = res[n+7: n];
  
endmodule

module zad2(output [7:0] o, input [7:0] i, input [3:0] n, input ar, lr, rot);
  logic [7:0] funnel_a, funnel_b;
  logic [4:0] funnel_n;
  
  assign funnel_a = (rot || lr) ? i : (ar ? {8{i[7]}} : {8{0}});
  assign funnel_b = (rot || !lr) ? i : {8{0}};
  assign funnel_n = lr ? (8 - n) : n;
  
  funnel_shifter res(o, funnel_a, funnel_b, funnel_n);
  
endmodule
