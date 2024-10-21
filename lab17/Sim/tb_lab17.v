`timescale 1ns/1ns
// Define simulation parameter
// The first number is the time unit.
// The second number is the time precision.

module tb_lab17();

reg a;
reg b;

wire [2:0] c;

 //init input signal
initial begin
a <= 1'b0;
b <= 1'b0;
end



// Generate inputs to simulate the button press
// Every 10 ns, generate a random number. This random number will 
// take the modulus and find the remainder to generate random 0 and 1
always #10 a <= {$random} % 2;

always #10 b <= {$random} % 2;


// This part shows how to print values
initial begin
$timeformat(-9, 0, "ns", 6);
$monitor("@time %t:a=%b b=%b c=%b",$time,a,b,c);//When time, in1, in2, sel, or out are changed, the information will be displayed
end


lab17 lab17_inst
(
.a (a), 
.b (b), 

.c (c)

);

 endmodule