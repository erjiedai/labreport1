`timescale 1ns/1ns
module tb_lab23asynchronized();
  reg RESET;
  reg KEY;
  reg KEY1;
  
  
 wire LED0;
 
initial 
     begin
RESET = 1'b1;
KEY <= 1'b0;
KEY1 <= 1'b0;
#20
KEY <= 1'b1;
#210
KEY <= 1'b0;
#40
KEY <= 1'b1;

end

always #10 RESET = ~RESET;
always #20 KEY1 <= {$random} % 2;

initial begin
$timeformat(-9, 0, "ns", 6);
$monitor("@time %t:RESET=%b KEY=%b KEY1=%b LED0=%b",$time,RESET,KEY,KEY1,LED0);
end


lab23asynchronized lab23asynchronized_inst
(
  .RESET(RESET),
  .KEY(KEY),
  .KEY1(KEY1),

  .LED0(LED0)

  
  
  
  );
  
  endmodule