module list9(output heat, light, bell,
              input clk, nrst, door, start, finish);
  logic [2:0] q; 
  always_ff @(posedge clk or negedge nrst)
  if (!nrst) q <= 3'b000; 
  else unique case(q)
    3'b000: begin
      if(door) q <= 3'b100;
      else if(start) q <= 3'b001;
    end
    3'b001: begin
      if(door) q <= 3'b010;
      else if(finish) q <= 3'b011;
    end
    3'b010: if(!door) q <= 3'b001;
    3'b011: if(door) q <= 3'b100;
    3'b100: if(!door) q <= 3'b000;
  endcase
  assign heat = q[0] && !q[1]; 
  assign light = q[2] || q[0] ^ q[1]; 
  assign bell = q[1] && q[0]; 
endmodule

//		stany:
//	000 - closed
//	001 - cook
//	010 - pause
//	011 - bell
//	100 - open
