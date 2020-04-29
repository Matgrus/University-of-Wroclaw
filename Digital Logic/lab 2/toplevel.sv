module zad2(output o, input [3:0] i);
  logic x, y, z, w;
  assign x = i[3];
  assign y = i[2];
  assign z = i[1];
  assign w = i[0];
  assign o = (x && y && !z) || (x && !z && w) || (x && !y && w) || (x && !y && z) || \
    	     (x && z && !w) || (y && z && !w) || (!x && y && z) || (!x && y && w) || \
             (!x && z && w) || (y && !z && w) || (x && y && !w) || (!y && z && w);
endmodule