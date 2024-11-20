`timescale  1ns/1ns

module  vga_rom_pic
(
    input   wire            sys_clk     ,   //输入工作时钟,频率50MHz
    input   wire            sys_rst_n   ,   //输入复位信号,低电平有效

    output  wire            hsync       ,   //输出行同步信号
    output  wire            vsync       ,   //输出场同步信号
    output  wire    [15:0]  rgb             //输出像素信息

);


//wire define
wire            vga_clk ;   //VGA工作时钟,频率25MHz
wire            locked  ;   //PLL locked信号
wire            rst_n   ;   //VGA模块复位信号
wire    [9:0]   pix_x   ;   //VGA有效显示区域X轴坐标
wire    [9:0]   pix_y   ;   //VGA有效显示区域Y轴坐标
wire    [15:0]  pix_data;   //VGA像素点色彩信息

//rst_n:VGA模块复位信号
assign  rst_n = (sys_rst_n & locked);



//------------- clk_gen_inst -------------
clk_gen clk_gen_inst
(
    .areset     (~sys_rst_n ), 
    .inclk0     (sys_clk    ),  
    .c0         (vga_clk    ),  
    .locked     (locked     )   
);

//------------- vga_ctrl_inst -------------
vga_ctrl  vga_ctrl_inst
(
    .vga_clk    (vga_clk    ),  
    .sys_rst_n  (rst_n      ),  
    .pix_data   (pix_data   ),  

    .pix_x      (pix_x      ),  
    .pix_y      (pix_y      ),  
    .hsync      (hsync      ),  
    .vsync      (vsync      ),  
    .rgb        (rgb        )   
);

//------------- vga_pic_inst -------------
vga_pic vga_pic_inst
(
    .vga_clk        (vga_clk    ),  
    .sys_rst_n      (rst_n      ),  
    .pix_x          (pix_x      ),  
    .pix_y          (pix_y      ),  

    .pix_data_out   (pix_data   )   

);

endmodule
