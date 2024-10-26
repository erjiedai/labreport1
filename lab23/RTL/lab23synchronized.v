module lab23synchronized
(
  input wire KEY,
  input wire RESET,
  input wire KEY1,
  
  
  output reg LED0

  
  
  
  );
  
  always@(posedge KEY)
  if(RESET == 1'b0)
     LED0 <= 1'b0;
  else
     LED0 <= KEY1;
  
  endmodule