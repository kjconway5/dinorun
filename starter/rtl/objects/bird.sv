module bird(clk_i, rst_ni, next_frame_i, spawn_i, rand_i, pixel_x_i, pixel_y_i, pixel_o);
  wire [7:0] _00_;
  wire [10:0] _01_;
  wire _02_;
  wire [10:0] _03_;
  wire [10:0] _04_;
  wire [7:0] _05_;
  wire [11:0] _06_;
  wire [31:0] _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire [31:0] _12_;
  wire [31:0] _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire [20:0] _20_;
  wire [20:0] _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire [31:0] _29_;
  wire [31:0] _30_;
  wire [31:0] _31_;
  wire _sv2v_0;
  wire [7:0] bird_flap_counter_q;
  wire bird_flap_up_q;
  wire [10:0] bird_x_q;
  wire [10:0] bird_y_q;
  input clk_i;
  wire clk_i;
  input next_frame_i;
  wire next_frame_i;
  wire off_screen;
  wire pixel_in_range;
  output pixel_o;
  wire pixel_o;
  input [9:0] pixel_x_i;
  wire [9:0] pixel_x_i;
  wire pixel_x_in_range;
  input [9:0] pixel_y_i;
  wire [9:0] pixel_y_i;
  wire pixel_y_in_range;
  input [1:0] rand_i;
  wire [1:0] rand_i;
  wire [9:0] rom_x;
  wire [9:0] rom_y;
  input rst_ni;
  wire rst_ni;
  input spawn_i;
  wire spawn_i;
  reg [20:0] BIRD_DOWN [17:0];
  initial begin
    BIRD_DOWN[0] = 21'h000000;
    BIRD_DOWN[1] = 21'h000000;
    BIRD_DOWN[2] = 21'h000000;
    BIRD_DOWN[3] = 21'h018000;
    BIRD_DOWN[4] = 21'h038000;
    BIRD_DOWN[5] = 21'h07c000;
    BIRD_DOWN[6] = 21'h0fc000;
    BIRD_DOWN[7] = 21'h1fff80;
    BIRD_DOWN[8] = 21'h007fc0;
    BIRD_DOWN[9] = 21'h003fff;
    BIRD_DOWN[10] = 21'h001ff8;
    BIRD_DOWN[11] = 21'h001ffe;
    BIRD_DOWN[12] = 21'h001ff0;
    BIRD_DOWN[13] = 21'h001e00;
    BIRD_DOWN[14] = 21'h001c00;
    BIRD_DOWN[15] = 21'h001800;
    BIRD_DOWN[16] = 21'h001800;
    BIRD_DOWN[17] = 21'h001000;
  end
  assign _20_ = BIRD_DOWN[rom_y[4:0]];
  reg [20:0] BIRD_UP [17:0];
  initial begin
    BIRD_UP[0] = 21'h002000;
    BIRD_UP[1] = 21'h003000;
    BIRD_UP[2] = 21'h003800;
    BIRD_UP[3] = 21'h019c00;
    BIRD_UP[4] = 21'h039e00;
    BIRD_UP[5] = 21'h07df00;
    BIRD_UP[6] = 21'h0fdf80;
    BIRD_UP[7] = 21'h1fff80;
    BIRD_UP[8] = 21'h007fc0;
    BIRD_UP[9] = 21'h003fff;
    BIRD_UP[10] = 21'h001ff8;
    BIRD_UP[11] = 21'h000ffe;
    BIRD_UP[12] = 21'h0007f0;
    BIRD_UP[13] = 21'h000000;
    BIRD_UP[14] = 21'h000000;
    BIRD_UP[15] = 21'h000000;
    BIRD_UP[16] = 21'h000000;
    BIRD_UP[17] = 21'h000000;
  end
  assign _21_ = BIRD_UP[rom_y[4:0]];
  \$add  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd8),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd8)
  ) _32_ (
    .A(bird_flap_counter_q),
    .B(1'h1),
    .Y(_05_)
  );
  \$add  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd6),
    .Y_WIDTH(32'd12)
  ) _33_ (
    .A(bird_x_q),
    .B(6'h2a),
    .Y(_06_)
  );
  \$add  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd6),
    .Y_WIDTH(32'd12)
  ) _34_ (
    .A(bird_y_q),
    .B(6'h24),
    .Y(_07_[11:0])
  );
  \$sdffe  #(
    .CLK_POLARITY(32'd1),
    .EN_POLARITY(32'd1),
    .SRST_POLARITY(32'd0),
    .SRST_VALUE(1'h0),
    .WIDTH(32'd1)
  ) bird_flap_up_q_reg /* _35_ */ (
    .CLK(clk_i),
    .D(_17_),
    .EN(_09_),
    .Q(bird_flap_up_q),
    .SRST(rst_ni)
  );
  \$sdffe  #(
    .CLK_POLARITY(32'd1),
    .EN_POLARITY(32'd1),
    .SRST_POLARITY(32'd0),
    .SRST_VALUE(8'h00),
    .WIDTH(32'd8)
  ) _36_ (
    .CLK(clk_i),
    .D(_00_),
    .EN(next_frame_i),
    .Q(bird_flap_counter_q),
    .SRST(rst_ni)
  );
  \$sdffe  #(
    .CLK_POLARITY(32'd1),
    .EN_POLARITY(32'd1),
    .SRST_POLARITY(32'd0),
    .SRST_VALUE(11'h000),
    .WIDTH(32'd11)
  ) _37_ (
    .CLK(clk_i),
    .D(_04_),
    .EN(_10_),
    .Q(bird_y_q),
    .SRST(rst_ni)
  );
  \$sdffe  #(
    .CLK_POLARITY(32'd1),
    .EN_POLARITY(32'd1),
    .SRST_POLARITY(32'd0),
    .SRST_VALUE(11'h7d6),
    .WIDTH(32'd11)
  ) _38_ (
    .CLK(clk_i),
    .D(_01_),
    .EN(_11_),
    .Q(bird_x_q),
    .SRST(rst_ni)
  );
  \$ne  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _39_ (
    .A({ off_screen, spawn_i }),
    .B(2'h2),
    .Y(_08_)
  );
  \$reduce_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _40_ (
    .A({ _14_, next_frame_i }),
    .Y(_09_)
  );
  \$reduce_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd3),
    .Y_WIDTH(32'd1)
  ) _41_ (
    .A({ off_screen, spawn_i, next_frame_i }),
    .Y(_10_)
  );
  \$reduce_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _42_ (
    .A({ _08_, next_frame_i }),
    .Y(_11_)
  );
  \$eq  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd8),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd3),
    .Y_WIDTH(32'd1)
  ) _43_ (
    .A(bird_flap_counter_q),
    .B(3'h7),
    .Y(_14_)
  );
  \$ge  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd11),
    .Y_WIDTH(32'd1)
  ) _44_ (
    .A(pixel_x_i),
    .B(bird_x_q),
    .Y(_15_)
  );
  \$ge  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd11),
    .Y_WIDTH(32'd1)
  ) _45_ (
    .A(pixel_y_i),
    .B(bird_y_q),
    .Y(_16_)
  );
  \$le  #(
    .A_SIGNED(32'd1),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd1),
    .B_WIDTH(32'd7),
    .Y_WIDTH(32'd1)
  ) _46_ (
    .A(bird_x_q),
    .B(7'h56),
    .Y(off_screen)
  );
  \$logic_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _47_ (
    .A(_15_),
    .B(_18_),
    .Y(pixel_x_in_range)
  );
  \$logic_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _48_ (
    .A(_16_),
    .B(_19_),
    .Y(pixel_y_in_range)
  );
  \$logic_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _49_ (
    .A(pixel_x_in_range),
    .B(pixel_y_in_range),
    .Y(pixel_in_range)
  );
  \$logic_not  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _50_ (
    .A(bird_flap_up_q),
    .Y(_17_)
  );
  \$lt  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd12),
    .Y_WIDTH(32'd1)
  ) _51_ (
    .A(pixel_x_i),
    .B(_06_),
    .Y(_18_)
  );
  \$lt  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd12),
    .Y_WIDTH(32'd1)
  ) _52_ (
    .A(pixel_y_i),
    .B(_07_[11:0]),
    .Y(_19_)
  );
  \$pmux  #(
    .S_WIDTH(32'd2),
    .WIDTH(32'd1)
  ) _53_ (
    .A(1'hx),
    .B({ _27_, _28_ }),
    .S({ _22_, bird_flap_up_q }),
    .Y(_02_)
  );
  \$not  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _54_ (
    .A(bird_flap_up_q),
    .Y(_22_)
  );
  \$mux  #(
    .WIDTH(32'd1)
  ) _55_ (
    .A(1'h0),
    .B(_02_),
    .S(pixel_in_range),
    .Y(pixel_o)
  );
  \$pmux  #(
    .S_WIDTH(32'd4),
    .WIDTH(32'd11)
  ) _56_ (
    .A(11'hxxx),
    .B(44'h2a450495112),
    .S({ _26_, _25_, _24_, _23_ }),
    .Y(_04_)
  );
  \$eq  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _57_ (
    .A(rand_i),
    .B(2'h3),
    .Y(_23_)
  );
  \$eq  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _58_ (
    .A(rand_i),
    .B(2'h2),
    .Y(_24_)
  );
  \$eq  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _59_ (
    .A(rand_i),
    .B(1'h1),
    .Y(_25_)
  );
  \$logic_not  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _60_ (
    .A(rand_i),
    .Y(_26_)
  );
  \$mux  #(
    .WIDTH(32'd11)
  ) _61_ (
    .A(11'hxxx),
    .B(11'h280),
    .S(spawn_i),
    .Y(_03_)
  );
  \$mux  #(
    .WIDTH(32'd11)
  ) _62_ (
    .A(_29_[10:0]),
    .B(_03_),
    .S(off_screen),
    .Y(_01_)
  );
  \$mux  #(
    .WIDTH(32'd8)
  ) _63_ (
    .A(_05_),
    .B(8'h00),
    .S(_14_),
    .Y(_00_)
  );
  \$shiftx  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd21),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _64_ (
    .A(_20_),
    .B(rom_x),
    .Y(_27_)
  );
  \$shiftx  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd21),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _65_ (
    .A(_21_),
    .B(rom_x),
    .Y(_28_)
  );
  \$sub  #(
    .A_SIGNED(32'd1),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd1),
    .B_WIDTH(32'd5),
    .Y_WIDTH(32'd11)
  ) _66_ (
    .A(bird_x_q),
    .B(5'h08),
    .Y(_29_[10:0])
  );
  \$sub  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd11),
    .Y_WIDTH(32'd12)
  ) _67_ (
    .A(pixel_x_i),
    .B(bird_x_q),
    .Y({ _12_[30], _12_[9:0], _30_[0] })
  );
  \$sub  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd5),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd10)
  ) _68_ (
    .A(5'h14),
    .B(_12_[9:0]),
    .Y(rom_x)
  );
  \$sub  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd11),
    .Y_WIDTH(32'd12)
  ) _69_ (
    .A(pixel_y_i),
    .B(bird_y_q),
    .Y({ _13_[30], rom_y, _31_[0] })
  );
  assign _07_[31:12] = 20'h00000;
  assign _12_[29:10] = { _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30] };
  assign _12_[31] = 1'h0;
  assign _13_[29:0] = { _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], rom_y };
  assign _13_[31] = 1'h0;
  assign _30_[31:1] = { _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[30], _12_[9:0] };
  assign _31_[31:1] = { _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], _13_[30], rom_y };
  assign _sv2v_0 = 1'h0;
endmodule
