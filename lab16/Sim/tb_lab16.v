`timescale 1ns / 1ns
 // Define simulation parameter
 // The first number is the time unit.
 // The second number is the time precision.

 
 
 // Define the testbench module
 module tb_lab16();
reg KEY1;
reg KEY2;
reg KEY3;
wire LED0;
wire LED1;
wire LED2;
wire LED3;
 
 //init input signal
initial begin
    KEY1 <= 1'b0;
    KEY2 <= 1'b0;
	 KEY3 <= 1'b0;
	 
end
 
 
 
 
 // Generate inputs to simulate the button press
// Every 10 ns, generate a random number. This random number will 
// take the modulus and find the remainder to generate random 0 and 1 
 always #10 KEY1 <= {$random} % 2;
 always #10 KEY2 <= {$random} % 2;
 always #10 KEY3 <= {$random} % 2;

initial begin
$timeformat(-9, 0, "ns", 6);// This part shows how to print values
                           
$monitor("@time %t:KEY1=%b KEY2=%b KEY3=%b LED3=%b LED2=%b LED1=%b LED0=%b",$time,KEY1,KEY2,KEY3,LED3,LED2,LED1,LED0);
//When time, in1, in2, sel, or out are changed, the information will be displayed
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