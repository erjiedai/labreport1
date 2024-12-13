module tb_Game_ctrl_module();

    // ---------------- Inputs ----------------
    reg Clk_50mhz;           // 50 MHz 时钟信号
    reg Rst_n;               // 全局复位信号
    reg Key_left;            // 左按键
    reg Key_right;           // 右按键
    reg Key_up;              // 上按键
    reg Key_down;            // 下按键
    reg Hit_wall_sig;        // 撞墙信号
    reg Hit_body_sig;        // 撞到身体信号

    // ---------------- Outputs ----------------
    wire [2:0] Game_status; // 游戏状态，START=001，PLAY=010，END=100
    wire Flash_sig;          // Flash 信号

    // ---------------- Instantiate the Unit Under Test (UUT) ----------------
    Game_ctrl_module uut (
        .Clk_50mhz(Clk_50mhz),
        .Rst_n(Rst_n),
        .Key_left(Key_left),
        .Key_right(Key_right),
        .Key_up(Key_up),
        .Key_down(Key_down),
        .Game_status(Game_status),
        .Hit_wall_sig(Hit_wall_sig),
        .Hit_body_sig(Hit_body_sig),
        .Flash_sig(Flash_sig)
    );

    // ---------------- Clock Generation ----------------
    always begin
        Clk_50mhz = 0; #10;   // 50 MHz 时钟，10 时间单位为 1/50MHz
        Clk_50mhz = 1; #10;
    end

    // ---------------- Stimulus ----------------
    initial begin
        // 初始状态
        Rst_n = 0;             // 先施加复位信号
        Key_left = 0;          // 按键初始为未按下
        Key_right = 0;
        Key_up = 0;
        Key_down = 0;
        Hit_wall_sig = 0;      // 撞墙信号初始为未发生
        Hit_body_sig = 0;      // 撞到自己身体信号初始为未发生
        #50;                   // 经过一定时间后解除复位
        Rst_n = 1;

        // 测试按键按下后进入 PLAY 状态
        #100;
        Key_up = 1;            // 按下上键
        #10;
        Key_up = 0;            // 松开上键
        #10;

        // 测试进入 PLAY 状态并模拟撞墙或撞到自己
        #100;
        Hit_wall_sig = 1;      // 撞墙
        #10;
        Hit_wall_sig = 0;      // 撞墙信号解除

        #100;
        Hit_body_sig = 1;      // 撞到自己身体
        #10;
        Hit_body_sig = 0;      // 撞到身体信号解除

        // 测试进入 END 状态后按下按键返回 START 状态
        #100;
        Key_left = 1;          // 按下左键
        #10;
        Key_left = 0;          // 松开左键
        #10;

        // 测试结束后不按键时保持 END 状态
        #200;
        // 此时应该保持在 END 状态

        // 结束仿真
        $finish;
    end

    // ---------------- Monitor ----------------
    initial begin
        $monitor("At time %t, Game_status = %b, Flash_sig = %b, Key_up = %b, Key_left = %b, Hit_wall_sig = %b, Hit_body_sig = %b", 
                 $time, Game_status, Flash_sig, Key_up, Key_left, Hit_wall_sig, Hit_body_sig);
    end

endmodule
