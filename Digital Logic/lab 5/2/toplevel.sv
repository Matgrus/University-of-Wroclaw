module gray_to_bin(output [31:0] o, input [31:0] i);
  	integer k;
	always_comb begin
      		o[31] = i[31];
      		for (k = 31; k > 0; k = k - 1)
          		o[k - 1] = i[k - 1] ^ o[k];
	end
endmodule