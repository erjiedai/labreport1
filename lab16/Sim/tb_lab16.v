`timescale 1ns / 1ns
 
module tb_lab16();
reg KEY1;
reg KEY2;
reg KEY3;
wire LED0;
wire LED1;
wire LED2;
wire LED3;
 
initial begin
    KEY1 <= 1'b0;
    KEY2 <= 1'b0;
	 KEY3 <= 1'b0;
	 
end
 
 always #10 KEY1 <= {$random} % 2;
 always #10 KEY2 <= {$random} % 2;
 always #10 KEY3 <= {$random} % 2;

initial begin
$timeformat(-9, 0, "ns", 6);
$monitor("@time %t:KEY1=%b KEY2=%b KEY3=%b LED3=%b LED2=%b LED1=%b LED0=%b",$time,KEY1,KEY2,KEY3,LED3,LED2,LED1,LED0);
end
 
 lab16 lab16_inst (
    .KEY1(KEY1 ),
    .KEY2(KEY2 ),
	 .KEY3(KEY3 ),
	  
    .LED0(LED0 ),
    .LED1(LED1 ),
    .LED2(LED2 ),
    .LED3(LED3 )
);
endmodule