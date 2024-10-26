`timescale 1ns/1ns
module tb_lab23synchronized();
  reg RESET;
  reg KEY;
  reg KEY1;
  
  
 wire LED0;
 
initial 
     begin  // Other inputs use un-block assignments
KEY = 1'b1;
RESET <= 1'b0;
KEY1 <= 1'b0;
#20
RESET <= 1'b1;
#210
 //the reset button is pressed again after working 210ns.
RESET <= 1'b0;
#40
RESET <= 1'b1;

end
 //Simulate system clock 50M Hz. The period is 20ns. The half period is 10ns, 
 which means the clock signal is inversed every 10ns.
always #10 KEY = ~KEY;
always #20 KEY1 <= {$random} % 2;

initial begin
$timeformat(-9, 0, "ns", 6);
$monitor("@time %t:KEY1=%b LED0=%b",$time,KEY1,LED0);
end


lab23synchronized lab23synchronized_inst
(
  .RESET(RESET),
  .KEY(KEY),
  .KEY1(KEY1),

  .LED0(LED0)

  
  
  
  );
  
  endmodule