`timescale  1ns/1ns

module  tb_lab25();


wire    [3:0]   led_out     ;

reg             sys_clk     ;
reg             sys_rst_n   ;

//Initialise system clock, global reset
initial 
    begin
    sys_clk    = 1'b1;
    sys_rst_n <= 1'b0;
    #20
    sys_rst_n <= 1'b1;
end

//sys_clk:Analogue system clock, level flipped every 10ns, period 20ns, frequency 50Mhz
always #10 sys_clk = ~sys_clk;



lab25  
#(
    .CNT_MAX    (25'd24)
)
lab25_inst
(
    .sys_clk    (sys_clk    ),  //input          sys_clk
    .sys_rst_n  (sys_rst_n  ),  //input          sys_rst_n
                    
    .led_out    (led_out    )   //output  [3:0]  led_out
);

endmodule