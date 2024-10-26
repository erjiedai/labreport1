`timescale  1ns/1ns

module  tb_lab24();

reg             sys_clk     ;
reg             sys_rst_n   ;
wire            led_out     ;
//Initialise system clock, global reset
initial 
    begin
    sys_clk    = 1'b1;
    sys_rst_n <= 1'b0;
    #20
    sys_rst_n <= 1'b1;
end

//sys_clk:Analogue system clock, level flipped every 10ns

always #10 sys_clk = ~sys_clk;

initial begin
    $timeformat(-9, 0, "ns", 6);
    $monitor("@time %t: led_out=%b", $time, led_out);
end


lab24
#(
    .CNT_MAX    (25'd24     )   //Instantiating modules with parameters
)
lab24_inst
(
    .sys_clk    (sys_clk    ),  //input     sys_clk
    .sys_rst_n  (sys_rst_n  ),  //input     sys_rst_n

    .led_out    (led_out    )	 //output    led_out
	 );
	 endmodule