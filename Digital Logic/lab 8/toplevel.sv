module pwm(output logic [15:0] cnt, cmp, top, output out,
           input clk, input [15:0] d, input [1:0] sel);
  
  always_ff @(posedge clk)
    if(sel == 2'b01) cmp <= d;
  
  always_ff @(posedge clk)
    if(sel == 2'b10) top <= d;
  
  always_ff @(posedge clk)
    if(sel == 2'b11) cnt <= d;
  	else if(cnt >= top) cnt <= 16'b0;
  	else cnt <= cnt + 1'b1;
  
  assign out = (cnt >= cmp) ? 1'b0 : 1'b1;
  
endmodule