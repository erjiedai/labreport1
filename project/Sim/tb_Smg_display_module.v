module tb_Smg_display_module();

    // ---------------- Inputs ----------------
    reg Clk_50mhz;           // 50 MHz 时钟信号
    reg Rst_n;               // 全局复位信号
    reg Body_add_sig;        // 身体增长信号
    reg [2:0] Game_status;   // 游戏状态，3种：START=001, PLAY=010, END=100
    reg Apple_type;          // 苹果类型（0:红色，1:绿色）

    // ---------------- Outputs ----------------
    wire [7:0] Smg_duan;     // 数码管段选
    wire [3:0] Smg_we;       // 数码管位选

    // ---------------- Instantiate the Unit Under Test (UUT) ----------------
    Smg_display_module uut (
        .Clk_50mhz(Clk_50mhz),
        .Rst_n(Rst_n),
        .Body_add_sig(Body_add_sig),
        .Game_status(Game_status),
        .Apple_type(Apple_type),
        .Smg_duan(Smg_duan),
        .Smg_we(Smg_we)
    );

    // ---------------- Clock Generation ----------------
    always begin
        Clk_50mhz = 0; #10;   // 50 MHz 时钟，10 时间单位为 1/50MHz
        Clk_50mhz = 1; #10;
    end

    // ---------------- Stimulus ----------------
    initial begin
        // 初始状态
        Rst_n = 0;
        Body_add_sig = 0;
        Game_status = 3'b001;  // 游戏开始状态
        Apple_type = 0;        // 红色苹果
        #50;
        Rst_n = 1;  // 解除复位

        // 测试游戏状态切换
        #1000;
        Game_status = 3'b010;  // 游戏进行状态
        #1000;
        Game_status = 3'b100;  // 游戏结束状态
        #1000;

        // 测试吃苹果
        Body_add_sig = 1;  // 启动身体增长信号
        #500;
        Body_add_sig = 0;  // 停止身体增长信号
        #500;

        // 测试绿色苹果
        Apple_type = 1;  // 绿色苹果
        Body_add_sig = 1;
        #500;
        Body_add_sig = 0;

        // 模拟一些身体增长
        Body_add_sig = 1;
        #2000;
        Body_add_sig = 0;

        // 测试结束
        #1000;
        Game_status = 3'b100;  // 游戏结束状态
        #500;

        // 结束仿真
        $finish;
    end

    // ---------------- Monitor ----------------
    initial begin
        $monitor("At time %t, Game_status = %b, Smg_we = %b, Smg_duan = %b, Apple_type = %b", 
                 $time, Game_status, Smg_we, Smg_duan, Apple_type);
    end

endmodule
