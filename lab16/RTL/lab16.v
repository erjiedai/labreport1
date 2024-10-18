

module lab16(
    input KEY1,
    input KEY2,
	 input KEY3,
    output LED0,
    output LED1,
    output LED2,
    output LED3
    );
 
assign LED0 = KEY3 | KEY2;
assign LED1 = KEY2 | (~KEY3);
assign LED2 = KEY3 | (~KEY2);
assign LED3 = (~KEY2) | (~KEY3);
 
endmodule