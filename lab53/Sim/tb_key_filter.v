`timescale  1ns/1ns

module  tb_key_filter();


parameter   CNT_1MS  = 20'd19   ,
            CNT_11MS = 21'd69   ,
            CNT_41MS = 22'd149  ,
            CNT_51MS = 22'd199  ,
            CNT_60MS = 22'd249  ;

wire            key_flag        ;  


reg             sys_clk         ;   
reg             sys_rst_n       ;   
reg             key_in          ;   
reg     [21:0]  tb_cnt          ;   


initial begin
    sys_clk    = 1'b1;
    sys_rst_n <= 1'b0;
    key_in    <= 1'b0;
    #20         
    sys_rst_n <= 1'b1;
end

//sys_clk:模拟系统时钟
always #10 sys_clk = ~sys_clk;

//tb_cnt:按键过程计数器，通过该计数器的计数时间来模拟按键的抖动过程
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        tb_cnt <= 22'b0;
    else    if(tb_cnt == CNT_60MS)
          //计数器计数到CNT_60MS完成一次按键从按下到释放的整个过程
        tb_cnt <= 22'b0;
    else    
        tb_cnt <= tb_cnt + 1'b1;

//key_in:产生输入随机数
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        key_in <= 1'b1;     //按键未按下时的状态为为高电平
    else    if((tb_cnt >= CNT_1MS && tb_cnt <= CNT_11MS)
                || (tb_cnt >= CNT_41MS && tb_cnt <= CNT_51MS))
    //在该计数区间内产生非负随机数0、1
        key_in <= {$random} % 2;    
    else    if(tb_cnt >= CNT_11MS && tb_cnt <= CNT_41MS)
        key_in <= 1'b0;

    else
        key_in <= 1'b1;


key_filter
#(
    .CNT_MAX    (20'd24     )

            //模拟出按键消抖的效果
)
key_filter_inst
(
    .sys_clk    (sys_clk    ),  //input     sys_clk
    .sys_rst_n  (sys_rst_n  ),  //input     sys_rst_n
    .key_in     (key_in     ),  //input     key_in
                        
    .key_flag   (key_flag   )   //output    key_flag
);

endmodule
