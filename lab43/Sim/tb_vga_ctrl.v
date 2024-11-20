`timescale  1ns/1ns


module  tb_vga_ctrl();



wire            locked      ;
wire            rst_n       ;
wire            vga_clk     ;


reg             sys_clk     ;
reg             sys_rst_n   ;
reg     [15:0]  pix_data    ;




initial
    begin
        sys_clk     =   1'b1;
        sys_rst_n   <=  1'b0;
        #200
        sys_rst_n   <=  1'b1;
    end


always  #10 sys_clk = ~sys_clk  ;

//rst_n:VGA模块复位
assign  rst_n = (sys_rst_n & locked);

//pix_data:输入像素点色彩信息
always@(posedge vga_clk or  negedge rst_n)
    if(rst_n == 1'b0)
        pix_data    <=  16'h0;
    else
        pix_data    <=  16'hffff;



clk_gen clk_gen_inst
(
    .areset     (~sys_rst_n ),  //输入复位信号
    .inclk0     (sys_clk    ),  //输入时钟
    .c0         (vga_clk    ),  //输出VGA时钟
    .locked     (locked     )   //输出pll locked信号
);


vga_ctrl  vga_ctrl_inst
(
    .vga_clk    (vga_clk    ),  //输入工作时钟
    .sys_rst_n  (rst_n      ),  //输入复位信号,低电平有效
    .pix_data   (pix_data   ),  //输入像素点色彩信息

    .pix_x      (pix_x      ),  //输出VGA有效显示区域像素点X轴坐标
    .pix_y      (pix_y      ),  //输出VGA有效显示区域像素点Y轴坐标
    .hsync      (hsync      ),  //输出行同步信号
    .vsync      (vsync      ),  //输出场同步信号
    .rgb        (rgb        )   //输出像素点色彩信息
);

endmodule

