module zad1(output ready, output [15:0] out, 
            input clk, nrst, start, input [15:0] inx, input [7:0] inn);
  const logic READY = 1'b0;
  const logic BUSY = 1'b1;
  logic state;
  logic [15:0] a, x, mult, mult_res;
  logic [7:0] n;
  always_ff @(posedge clk or negedge nrst)
    if (!nrst) begin
      state <= READY;
    end else case (state)
      READY: if(start) begin
        a <= 16'b1;
        x <= inx;
        n <= inn;
        state <= BUSY;
      end
      BUSY: if(n == 8'b0) begin
        out <= a;
        state <= READY;
      end else if(!n[0]) begin
        n <= n >> 1;
        x <= mult_res;
      end else begin
        n <= n - 1;
        a <= mult_res;
      end
    endcase
    
  assign mult = !n[0] ? x : a;
  assign mult_res = mult * x;
  assign ready = state ? 1'b0 : 1'b1;
  
      
endmodule
