module select_sort(output [15:0] o, input [15:0] i);
  integer k, l;
  logic [1:0] max; 
  logic [3:0] swap;
  always_comb begin
    o = i;
    for (k = 3; k >= 0; k = k-1) begin
      max = k;
      for (l = k-1; l >= 0; l = l-1)
        if (o[l*4 + 3:l*4] > o[max*4 + 3:max*4]) max = l;
      if (max != k) begin
        swap = o[k*4 + 3:k*4];
        o[k*4 + 3:k*4] = o[max*4 + 3:max*4];
        o[max*4 + 3:max*4] = swap;
      end
    end
  end
endmodule
