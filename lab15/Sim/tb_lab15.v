`timescale 1ns/1ns
// Define simulation parameter
// The first number is the time unit.
// The second number is the time precision.


// Define the testbench module
module tb_lab15();
    reg key1_in;
    reg key2_in;
    reg key3_in;
    wire led1_out;
    wire led0_out;
	 
	 initial
begin //init input signal
key1_in <= 1'b0;
key2_in <= 1'b0;
key3_in <= 1'b0;

end
always #10 key1_in <= {$random} % 2;
always #10 key2_in <= {$random} % 2;
always #10 key3_in <= {$random} % 2;
// Generate inputs to simulate the button press
// Every 10 ns, generate a random number. This random number will 
// take the modulus and find the remainder to generate random 0 and 1 



// Instantiate the testbench
initial begin
$timeformat(-9, 0, "ns", 6);
$monitor("@time %t:key1_in=%b key2_in=%b key3_in=%b led1_out=%b led0_out=%b",$time,key1_in,key2_in,key3_in,led1_out,led0_out);
 end

    lab15 lab15_inst(
	 .key1_in(key1_in),
	 .key2_in(key2_in),
	 .key3_in(key3_in),
	 .led1_out(led1_out),
	 .led0_out(led0_out)
	 
	 );
	 
endmodule