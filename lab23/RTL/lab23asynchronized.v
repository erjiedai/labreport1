module lab23asynchronized
(
  input wire RESET,
  input wire KEY,
  input wire KEY1,
  
  
  output reg LED0

  
  
  
  );
  
  always@(posedge RESET or negedge KEY)
  if(KEY == 1'b0)
     LED0 <= 1'b0;
  else
     LED0 <= KEY1;
  
  endmodule