`timescale  1ns/1ns

module  vga_pic
(
    input   wire            vga_clk     ,   
    input   wire            sys_rst_n   ,   
    input   wire    [9:0]   pix_x       ,   
    input   wire    [9:0]   pix_y       ,   
    output  wire    [15:0]  pix_data_out    

);


parameter H_VALID = 10'd640 , //Maximum x value
V_VALID = 10'd480 ; //Maximum y value

parameter H_PIC = 10'd100 , //Length of image
W_PIC = 10'd100 , //Width of image
PIC_SIZE= 14'd10000 ; //Total pixel number

parameter RED = 16'hF800, //RED
ORANGE = 16'hFC00, //Orange
YELLOW = 16'hFFE0, //Yellow
GREEN = 16'h07E0, //Green
CYAN = 16'h07FF, //Cyan
BLUE = 16'h001F, //Blue
PURPPLE = 16'hF81F, //Purple
BLACK = 16'h0000, //Black
WHITE = 16'hFFFF, //White
GRAY = 16'hD69A; //Grey

//wire  define
wire            rd_en       ;   
wire    [15:0]  pic_data    ;   

//reg   define
reg     [13:0]  rom_addr    ;   
reg             pic_valid   ;   
reg     [15:0]  pix_data    ;   



//rd_en:ROM读使能
assign  rd_en = (((pix_x >= (((H_VALID - H_PIC)/2) - 1'b1))
                && (pix_x < (((H_VALID - H_PIC)/2) + H_PIC - 1'b1))) 
                &&((pix_y >= ((V_VALID - W_PIC)/2))
                && ((pix_y < (((V_VALID - W_PIC)/2) + W_PIC)))));

//pic_valid:图片数据有效信号
always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pic_valid   <=  1'b1;
    else
        pic_valid   <=  rd_en;

//pix_data_out:输出VGA显示图像数据
assign  pix_data_out = (pic_valid == 1'b1) ? pic_data : pix_data;


always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pix_data    <= 16'd0;
    else    if((pix_x >= 0) && (pix_x < (H_VALID/10)*1))
        pix_data    <=  RED;
    else    if((pix_x >= (H_VALID/10)*1) && (pix_x < (H_VALID/10)*2))
        pix_data    <=  ORANGE;
    else    if((pix_x >= (H_VALID/10)*2) && (pix_x < (H_VALID/10)*3))
        pix_data    <=  YELLOW;
    else    if((pix_x >= (H_VALID/10)*3) && (pix_x < (H_VALID/10)*4))
        pix_data    <=  GREEN;
    else    if((pix_x >= (H_VALID/10)*4) && (pix_x < (H_VALID/10)*5))
        pix_data    <=  CYAN;
    else    if((pix_x >= (H_VALID/10)*5) && (pix_x < (H_VALID/10)*6))
        pix_data    <=  BLUE;
    else    if((pix_x >= (H_VALID/10)*6) && (pix_x < (H_VALID/10)*7))
        pix_data    <=  PURPPLE;
    else    if((pix_x >= (H_VALID/10)*7) && (pix_x < (H_VALID/10)*8))
        pix_data    <=  BLACK;
    else    if((pix_x >= (H_VALID/10)*8) && (pix_x < (H_VALID/10)*9))
        pix_data    <=  WHITE;
    else    if((pix_x >= (H_VALID/10)*9) && (pix_x < H_VALID))
        pix_data    <=  GRAY;
    else
        pix_data    <=  BLACK;


always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rom_addr    <=  14'd0;
    else    if(rom_addr == (PIC_SIZE - 1'b1))
        rom_addr    <=  14'd0;
    else    if(rd_en == 1'b1)
        rom_addr    <=  rom_addr + 1'b1;


rom_pic rom_pic_inst
(
    .address    (rom_addr   ), 
    .clock      (vga_clk    ),  
    .rden       (rd_en      ),  

    .q          (pic_data   )   
);

endmodule
