`timescale 1ns/1ns

module tb_lab17();

reg a;
reg b;

wire [2:0] c;

 
initial begin
a <= 1'b0;
b <= 1'b0;
end

always #10 a <= {$random} % 2;

always #10 b <= {$random} % 2;


initial begin
$timeformat(-9, 0, "ns", 6);
$monitor("@time %t:a=%b b=%b c=%b",$time,a,b,c);
end


lab17 lab17_inst
(
.a (a), 
.b (b), 

.c (c)

);

 endmodule