module dino(clk_i, rst_ni, next_frame_i, up_i, down_i, hit_i, pixel_x_i, pixel_y_i, pixel_o);
  wire [10:0] _00_;
  wire [10:0] _01_;
  wire _02_;
  wire [10:0] _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire [7:0] _08_;
  wire [10:0] _09_;
  wire [10:0] _10_;
  wire [31:0] _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire [31:0] _15_;
  wire [31:0] _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire [57:0] _25_;
  wire [57:0] _26_;
  wire [57:0] _27_;
  wire [57:0] _28_;
  wire [57:0] _29_;
  wire [57:0] _30_;
  wire [10:0] _31_;
  wire _32_;
  wire _33_;
  wire _34_;
  wire _35_;
  wire _36_;
  wire _37_;
  wire [31:0] _38_;
  wire _sv2v_0;
  input clk_i;
  wire clk_i;
  wire dino_left_q;
  wire [7:0] dino_step_counter_d;
  wire [7:0] dino_step_counter_q;
  wire [10:0] dino_yp_q;
  wire [10:0] dino_yv_q;
  input down_i;
  wire down_i;
  wire grounded;
  input hit_i;
  wire hit_i;
  input next_frame_i;
  wire next_frame_i;
  wire pixel_in_range;
  output pixel_o;
  wire pixel_o;
  input [9:0] pixel_x_i;
  wire [9:0] pixel_x_i;
  wire pixel_x_in_range;
  input [9:0] pixel_y_i;
  wire [9:0] pixel_y_i;
  wire pixel_y_in_range;
  wire [9:0] rom_x;
  wire [9:0] rom_y;
  input rst_ni;
  wire rst_ni;
  input up_i;
  wire up_i;
  reg [57:0] DINO_DOWNLEFT [42:0];
  initial begin
    DINO_DOWNLEFT[0] = 58'h000000000000000;
    DINO_DOWNLEFT[1] = 58'h000000000000000;
    DINO_DOWNLEFT[2] = 58'h000000000000000;
    DINO_DOWNLEFT[3] = 58'h000000000000000;
    DINO_DOWNLEFT[4] = 58'h000000000000000;
    DINO_DOWNLEFT[5] = 58'h000000000000000;
    DINO_DOWNLEFT[6] = 58'h000000000000000;
    DINO_DOWNLEFT[7] = 58'h000000000000000;
    DINO_DOWNLEFT[8] = 58'h000000000000000;
    DINO_DOWNLEFT[9] = 58'h000000000000000;
    DINO_DOWNLEFT[10] = 58'h000000000000000;
    DINO_DOWNLEFT[11] = 58'h000000000000000;
    DINO_DOWNLEFT[12] = 58'h000000000000000;
    DINO_DOWNLEFT[13] = 58'h000000000000000;
    DINO_DOWNLEFT[14] = 58'h000000000000000;
    DINO_DOWNLEFT[15] = 58'h000000000000000;
    DINO_DOWNLEFT[16] = 58'h000000000000000;
    DINO_DOWNLEFT[17] = 58'h060000000000000;
    DINO_DOWNLEFT[18] = 58'h06000000003fffc;
    DINO_DOWNLEFT[19] = 58'h07e01ffff03fffc;
    DINO_DOWNLEFT[20] = 58'h07e01ffff0fffff;
    DINO_DOWNLEFT[21] = 58'h07fffffffff3fff;
    DINO_DOWNLEFT[22] = 58'h07fffffffff3fff;
    DINO_DOWNLEFT[23] = 58'h01fffffffffffff;
    DINO_DOWNLEFT[24] = 58'h01fffffffffffff;
    DINO_DOWNLEFT[25] = 58'h007ffffffffffff;
    DINO_DOWNLEFT[26] = 58'h007ffffffffffff;
    DINO_DOWNLEFT[27] = 58'h001ffffffffffff;
    DINO_DOWNLEFT[28] = 58'h001ffffffffffff;
    DINO_DOWNLEFT[29] = 58'h0007ffffffffc00;
    DINO_DOWNLEFT[30] = 58'h0007ffffffffc00;
    DINO_DOWNLEFT[31] = 58'h0001fffffc3fff0;
    DINO_DOWNLEFT[32] = 58'h0001fffffc3fff0;
    DINO_DOWNLEFT[33] = 58'h00007ffffc00000;
    DINO_DOWNLEFT[34] = 58'h00007ff83000000;
    DINO_DOWNLEFT[35] = 58'h0000c3f03000000;
    DINO_DOWNLEFT[36] = 58'h0000c3f03c00000;
    DINO_DOWNLEFT[37] = 58'h0000f3c03c00000;
    DINO_DOWNLEFT[38] = 58'h0000f3c00000000;
    DINO_DOWNLEFT[39] = 58'h000003000000000;
    DINO_DOWNLEFT[40] = 58'h000003000000000;
    DINO_DOWNLEFT[41] = 58'h000003c00000000;
    DINO_DOWNLEFT[42] = 58'h000003c00000000;
  end
  assign _25_ = DINO_DOWNLEFT[rom_y[5:0]];
  reg [57:0] DINO_DOWNRIGHT [42:0];
  initial begin
    DINO_DOWNRIGHT[0] = 58'h000000000000000;
    DINO_DOWNRIGHT[1] = 58'h000000000000000;
    DINO_DOWNRIGHT[2] = 58'h000000000000000;
    DINO_DOWNRIGHT[3] = 58'h000000000000000;
    DINO_DOWNRIGHT[4] = 58'h000000000000000;
    DINO_DOWNRIGHT[5] = 58'h000000000000000;
    DINO_DOWNRIGHT[6] = 58'h000000000000000;
    DINO_DOWNRIGHT[7] = 58'h000000000000000;
    DINO_DOWNRIGHT[8] = 58'h000000000000000;
    DINO_DOWNRIGHT[9] = 58'h000000000000000;
    DINO_DOWNRIGHT[10] = 58'h000000000000000;
    DINO_DOWNRIGHT[11] = 58'h000000000000000;
    DINO_DOWNRIGHT[12] = 58'h000000000000000;
    DINO_DOWNRIGHT[13] = 58'h000000000000000;
    DINO_DOWNRIGHT[14] = 58'h000000000000000;
    DINO_DOWNRIGHT[15] = 58'h000000000000000;
    DINO_DOWNRIGHT[16] = 58'h000000000000000;
    DINO_DOWNRIGHT[17] = 58'h060000000000000;
    DINO_DOWNRIGHT[18] = 58'h06000000003fffc;
    DINO_DOWNRIGHT[19] = 58'h07e01ffff03fffc;
    DINO_DOWNRIGHT[20] = 58'h07e01ffff0fffff;
    DINO_DOWNRIGHT[21] = 58'h07fffffffff3fff;
    DINO_DOWNRIGHT[22] = 58'h07fffffffff3fff;
    DINO_DOWNRIGHT[23] = 58'h01fffffffffffff;
    DINO_DOWNRIGHT[24] = 58'h01fffffffffffff;
    DINO_DOWNRIGHT[25] = 58'h007ffffffffffff;
    DINO_DOWNRIGHT[26] = 58'h007ffffffffffff;
    DINO_DOWNRIGHT[27] = 58'h001ffffffffffff;
    DINO_DOWNRIGHT[28] = 58'h001ffffffffffff;
    DINO_DOWNRIGHT[29] = 58'h0007ffffffffc00;
    DINO_DOWNRIGHT[30] = 58'h0007ffffffffc00;
    DINO_DOWNRIGHT[31] = 58'h0001fffffc3fff0;
    DINO_DOWNRIGHT[32] = 58'h0001fffffc3fff0;
    DINO_DOWNRIGHT[33] = 58'h00007ffffc00000;
    DINO_DOWNRIGHT[34] = 58'h00007ff83000000;
    DINO_DOWNRIGHT[35] = 58'h0000fc3e3000000;
    DINO_DOWNRIGHT[36] = 58'h0000fc3e3c00000;
    DINO_DOWNRIGHT[37] = 58'h0000f0003c00000;
    DINO_DOWNRIGHT[38] = 58'h0000f0000000000;
    DINO_DOWNRIGHT[39] = 58'h0000c0000000000;
    DINO_DOWNRIGHT[40] = 58'h0000c0000000000;
    DINO_DOWNRIGHT[41] = 58'h0000f0000000000;
    DINO_DOWNRIGHT[42] = 58'h0000f0000000000;
  end
  assign _26_ = DINO_DOWNRIGHT[rom_y[5:0]];
  reg [57:0] DINO_HIT [42:0];
  initial begin
    DINO_HIT[0] = 58'h000000ffff00000;
    DINO_HIT[1] = 58'h000000ffff00000;
    DINO_HIT[2] = 58'h000003ffffc0000;
    DINO_HIT[3] = 58'h000003c3ffc0000;
    DINO_HIT[4] = 58'h000003dbffc0000;
    DINO_HIT[5] = 58'h000003dbffc0000;
    DINO_HIT[6] = 58'h000003c3ffc0000;
    DINO_HIT[7] = 58'h000003ffffc0000;
    DINO_HIT[8] = 58'h000003ffffc0000;
    DINO_HIT[9] = 58'h000003ffffc0000;
    DINO_HIT[10] = 58'h000003ffffc0000;
    DINO_HIT[11] = 58'h000003ffffc0000;
    DINO_HIT[12] = 58'h000003ffffc0000;
    DINO_HIT[13] = 58'h000003fffc00000;
    DINO_HIT[14] = 58'h000003fffc00000;
    DINO_HIT[15] = 58'h30000ffc0000000;
    DINO_HIT[16] = 58'h30000ffc0000000;
    DINO_HIT[17] = 58'h30007ffc0000000;
    DINO_HIT[18] = 58'h30007ffc0000000;
    DINO_HIT[19] = 58'h3c03ffffc000000;
    DINO_HIT[20] = 58'h3c03ffffc000000;
    DINO_HIT[21] = 58'h3f0ffffcc000000;
    DINO_HIT[22] = 58'h3f0ffffcc000000;
    DINO_HIT[23] = 58'h3ffffffc0000000;
    DINO_HIT[24] = 58'h3ffffffc0000000;
    DINO_HIT[25] = 58'h3ffffffc0000000;
    DINO_HIT[26] = 58'h3ffffffc0000000;
    DINO_HIT[27] = 58'h0ffffffc0000000;
    DINO_HIT[28] = 58'h0ffffff00000000;
    DINO_HIT[29] = 58'h03fffff00000000;
    DINO_HIT[30] = 58'h03fffff00000000;
    DINO_HIT[31] = 58'h00ffffc00000000;
    DINO_HIT[32] = 58'h00ffffc00000000;
    DINO_HIT[33] = 58'h003fff000000000;
    DINO_HIT[34] = 58'h003fff000000000;
    DINO_HIT[35] = 58'h000fcf000000000;
    DINO_HIT[36] = 58'h000fcf000000000;
    DINO_HIT[37] = 58'h000f03000000000;
    DINO_HIT[38] = 58'h000f03000000000;
    DINO_HIT[39] = 58'h000c03000000000;
    DINO_HIT[40] = 58'h000c03000000000;
    DINO_HIT[41] = 58'h000f03c00000000;
    DINO_HIT[42] = 58'h000f03c00000000;
  end
  assign _27_ = DINO_HIT[rom_y[5:0]];
  reg [57:0] DINO_LEFT [42:0];
  initial begin
    DINO_LEFT[0] = 58'h000000ffff00000;
    DINO_LEFT[1] = 58'h000000ffff00000;
    DINO_LEFT[2] = 58'h000003ffffc0000;
    DINO_LEFT[3] = 58'h000003cfffc0000;
    DINO_LEFT[4] = 58'h000003cfffc0000;
    DINO_LEFT[5] = 58'h000003ffffc0000;
    DINO_LEFT[6] = 58'h000003ffffc0000;
    DINO_LEFT[7] = 58'h000003ffffc0000;
    DINO_LEFT[8] = 58'h000003ffffc0000;
    DINO_LEFT[9] = 58'h000003ffffc0000;
    DINO_LEFT[10] = 58'h000003ffffc0000;
    DINO_LEFT[11] = 58'h000003ff0000000;
    DINO_LEFT[12] = 58'h000003ff0000000;
    DINO_LEFT[13] = 58'h000003fffc00000;
    DINO_LEFT[14] = 58'h000003fffc00000;
    DINO_LEFT[15] = 58'h30000ffc0000000;
    DINO_LEFT[16] = 58'h30000ffc0000000;
    DINO_LEFT[17] = 58'h30007ffc0000000;
    DINO_LEFT[18] = 58'h30007ffc0000000;
    DINO_LEFT[19] = 58'h3c03ffffc000000;
    DINO_LEFT[20] = 58'h3c03ffffc000000;
    DINO_LEFT[21] = 58'h3f0ffffcc000000;
    DINO_LEFT[22] = 58'h3f0ffffcc000000;
    DINO_LEFT[23] = 58'h3ffffffc0000000;
    DINO_LEFT[24] = 58'h3ffffffc0000000;
    DINO_LEFT[25] = 58'h3ffffffc0000000;
    DINO_LEFT[26] = 58'h3ffffffc0000000;
    DINO_LEFT[27] = 58'h0ffffffc0000000;
    DINO_LEFT[28] = 58'h0ffffff00000000;
    DINO_LEFT[29] = 58'h03fffff00000000;
    DINO_LEFT[30] = 58'h03fffff00000000;
    DINO_LEFT[31] = 58'h00ffffc00000000;
    DINO_LEFT[32] = 58'h00ffffc00000000;
    DINO_LEFT[33] = 58'h003fff000000000;
    DINO_LEFT[34] = 58'h003fff000000000;
    DINO_LEFT[35] = 58'h000f0f000000000;
    DINO_LEFT[36] = 58'h000f0f000000000;
    DINO_LEFT[37] = 58'h0003c3000000000;
    DINO_LEFT[38] = 58'h0003c3000000000;
    DINO_LEFT[39] = 58'h000003000000000;
    DINO_LEFT[40] = 58'h000003000000000;
    DINO_LEFT[41] = 58'h000003c00000000;
    DINO_LEFT[42] = 58'h000003c00000000;
  end
  assign _28_ = DINO_LEFT[rom_y[5:0]];
  reg [57:0] DINO_RIGHT [42:0];
  initial begin
    DINO_RIGHT[0] = 58'h000000ffff00000;
    DINO_RIGHT[1] = 58'h000000ffff00000;
    DINO_RIGHT[2] = 58'h000003ffffc0000;
    DINO_RIGHT[3] = 58'h000003cfffc0000;
    DINO_RIGHT[4] = 58'h000003cfffc0000;
    DINO_RIGHT[5] = 58'h000003ffffc0000;
    DINO_RIGHT[6] = 58'h000003ffffc0000;
    DINO_RIGHT[7] = 58'h000003ffffc0000;
    DINO_RIGHT[8] = 58'h000003ffffc0000;
    DINO_RIGHT[9] = 58'h000003ffffc0000;
    DINO_RIGHT[10] = 58'h000003ffffc0000;
    DINO_RIGHT[11] = 58'h000003ff0000000;
    DINO_RIGHT[12] = 58'h000003ff0000000;
    DINO_RIGHT[13] = 58'h000003fffc00000;
    DINO_RIGHT[14] = 58'h000003fffc00000;
    DINO_RIGHT[15] = 58'h30000ffc0000000;
    DINO_RIGHT[16] = 58'h30000ffc0000000;
    DINO_RIGHT[17] = 58'h30007ffc0000000;
    DINO_RIGHT[18] = 58'h30007ffc0000000;
    DINO_RIGHT[19] = 58'h3c03ffffc000000;
    DINO_RIGHT[20] = 58'h3c03ffffc000000;
    DINO_RIGHT[21] = 58'h3f0ffffcc000000;
    DINO_RIGHT[22] = 58'h3f0ffffcc000000;
    DINO_RIGHT[23] = 58'h3ffffffc0000000;
    DINO_RIGHT[24] = 58'h3ffffffc0000000;
    DINO_RIGHT[25] = 58'h3ffffffc0000000;
    DINO_RIGHT[26] = 58'h3ffffffc0000000;
    DINO_RIGHT[27] = 58'h0ffffffc0000000;
    DINO_RIGHT[28] = 58'h0ffffff00000000;
    DINO_RIGHT[29] = 58'h03fffff00000000;
    DINO_RIGHT[30] = 58'h03fffff00000000;
    DINO_RIGHT[31] = 58'h00ffffc00000000;
    DINO_RIGHT[32] = 58'h00ffffc00000000;
    DINO_RIGHT[33] = 58'h003fff000000000;
    DINO_RIGHT[34] = 58'h003fff000000000;
    DINO_RIGHT[35] = 58'h000fc3e00000000;
    DINO_RIGHT[36] = 58'h000fc3e00000000;
    DINO_RIGHT[37] = 58'h000f00000000000;
    DINO_RIGHT[38] = 58'h000f00000000000;
    DINO_RIGHT[39] = 58'h000c00000000000;
    DINO_RIGHT[40] = 58'h000c00000000000;
    DINO_RIGHT[41] = 58'h000f00000000000;
    DINO_RIGHT[42] = 58'h000f00000000000;
  end
  assign _29_ = DINO_RIGHT[rom_y[5:0]];
  reg [57:0] DINO_STANDING [42:0];
  initial begin
    DINO_STANDING[0] = 58'h000000ffff00000;
    DINO_STANDING[1] = 58'h000000ffff00000;
    DINO_STANDING[2] = 58'h000003ffffc0000;
    DINO_STANDING[3] = 58'h000003cfffc0000;
    DINO_STANDING[4] = 58'h000003cfffc0000;
    DINO_STANDING[5] = 58'h000003ffffc0000;
    DINO_STANDING[6] = 58'h000003ffffc0000;
    DINO_STANDING[7] = 58'h000003ffffc0000;
    DINO_STANDING[8] = 58'h000003ffffc0000;
    DINO_STANDING[9] = 58'h000003ffffc0000;
    DINO_STANDING[10] = 58'h000003ffffc0000;
    DINO_STANDING[11] = 58'h000003ff0000000;
    DINO_STANDING[12] = 58'h000003ff0000000;
    DINO_STANDING[13] = 58'h000003fffc00000;
    DINO_STANDING[14] = 58'h000003fffc00000;
    DINO_STANDING[15] = 58'h30000ffc0000000;
    DINO_STANDING[16] = 58'h30000ffc0000000;
    DINO_STANDING[17] = 58'h30007ffc0000000;
    DINO_STANDING[18] = 58'h30007ffc0000000;
    DINO_STANDING[19] = 58'h3c03ffffc000000;
    DINO_STANDING[20] = 58'h3c03ffffc000000;
    DINO_STANDING[21] = 58'h3f0ffffcc000000;
    DINO_STANDING[22] = 58'h3f0ffffcc000000;
    DINO_STANDING[23] = 58'h3ffffffc0000000;
    DINO_STANDING[24] = 58'h3ffffffc0000000;
    DINO_STANDING[25] = 58'h3ffffffc0000000;
    DINO_STANDING[26] = 58'h3ffffffc0000000;
    DINO_STANDING[27] = 58'h0ffffffc0000000;
    DINO_STANDING[28] = 58'h0ffffff00000000;
    DINO_STANDING[29] = 58'h03fffff00000000;
    DINO_STANDING[30] = 58'h03fffff00000000;
    DINO_STANDING[31] = 58'h00ffffc00000000;
    DINO_STANDING[32] = 58'h00ffffc00000000;
    DINO_STANDING[33] = 58'h003fff000000000;
    DINO_STANDING[34] = 58'h003fff000000000;
    DINO_STANDING[35] = 58'h000fcf000000000;
    DINO_STANDING[36] = 58'h000fcf000000000;
    DINO_STANDING[37] = 58'h000f03000000000;
    DINO_STANDING[38] = 58'h000f03000000000;
    DINO_STANDING[39] = 58'h000c03000000000;
    DINO_STANDING[40] = 58'h000c03000000000;
    DINO_STANDING[41] = 58'h000f03c00000000;
    DINO_STANDING[42] = 58'h000f03c00000000;
  end
  assign _30_ = DINO_STANDING[rom_y[5:0]];
  \$add  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd8),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd8)
  ) _39_ (
    .A(dino_step_counter_q),
    .B(1'h1),
    .Y(_08_)
  );
  \$add  #(
    .A_SIGNED(32'd1),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd1),
    .B_WIDTH(32'd11),
    .Y_WIDTH(32'd11)
  ) _40_ (
    .A(dino_yp_q),
    .B(_01_),
    .Y(_09_)
  );
  \$add  #(
    .A_SIGNED(32'd1),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd1),
    .B_WIDTH(32'd3),
    .Y_WIDTH(32'd11)
  ) _41_ (
    .A(_01_),
    .B({ 1'h0, _38_[1:0] }),
    .Y(_10_)
  );
  \$add  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd6),
    .Y_WIDTH(32'd12)
  ) _42_ (
    .A(dino_yp_q),
    .B(6'h2b),
    .Y(_11_[11:0])
  );
  \$sdffe  #(
    .CLK_POLARITY(32'd1),
    .EN_POLARITY(32'd1),
    .SRST_POLARITY(32'd0),
    .SRST_VALUE(1'h0),
    .WIDTH(32'd1)
  ) dino_left_q_reg /* _43_ */ (
    .CLK(clk_i),
    .D(_22_),
    .EN(_12_),
    .Q(dino_left_q),
    .SRST(rst_ni)
  );
  \$sdffe  #(
    .CLK_POLARITY(32'd1),
    .EN_POLARITY(32'd1),
    .SRST_POLARITY(32'd0),
    .SRST_VALUE(8'h00),
    .WIDTH(32'd8)
  ) _44_ (
    .CLK(clk_i),
    .D(dino_step_counter_d),
    .EN(next_frame_i),
    .Q(dino_step_counter_q),
    .SRST(rst_ni)
  );
  \$sdffe  #(
    .CLK_POLARITY(32'd1),
    .EN_POLARITY(32'd1),
    .SRST_POLARITY(32'd0),
    .SRST_VALUE(11'h000),
    .WIDTH(32'd11)
  ) _45_ (
    .CLK(clk_i),
    .D(_03_),
    .EN(_13_),
    .Q(dino_yv_q),
    .SRST(rst_ni)
  );
  \$sdffe  #(
    .CLK_POLARITY(32'd1),
    .EN_POLARITY(32'd1),
    .SRST_POLARITY(32'd0),
    .SRST_VALUE(11'h165),
    .WIDTH(32'd11)
  ) _46_ (
    .CLK(clk_i),
    .D(_00_),
    .EN(_13_),
    .Q(dino_yp_q),
    .SRST(rst_ni)
  );
  \$not  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _47_ (
    .A(hit_i),
    .Y(_14_)
  );
  \$reduce_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _48_ (
    .A({ _17_, next_frame_i }),
    .Y(_12_)
  );
  \$reduce_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _49_ (
    .A({ _14_, next_frame_i }),
    .Y(_13_)
  );
  \$eq  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd8),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd2),
    .Y_WIDTH(32'd1)
  ) _50_ (
    .A(dino_step_counter_q),
    .B(2'h3),
    .Y(_17_)
  );
  \$ge  #(
    .A_SIGNED(32'd1),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd1),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _51_ (
    .A(dino_yp_q),
    .B(10'h165),
    .Y(grounded)
  );
  \$ge  #(
    .A_SIGNED(32'd1),
    .A_WIDTH(32'd11),
    .B_SIGNED(32'd1),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _52_ (
    .A(_09_),
    .B(10'h165),
    .Y(_18_)
  );
  \$ge  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd7),
    .Y_WIDTH(32'd1)
  ) _53_ (
    .A(pixel_x_i),
    .B(7'h50),
    .Y(_19_)
  );
  \$ge  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd11),
    .Y_WIDTH(32'd1)
  ) _54_ (
    .A(pixel_y_i),
    .B(dino_yp_q),
    .Y(_20_)
  );
  \$logic_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _55_ (
    .A(grounded),
    .B(up_i),
    .Y(_21_)
  );
  \$logic_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _56_ (
    .A(_19_),
    .B(_23_),
    .Y(pixel_x_in_range)
  );
  \$logic_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _57_ (
    .A(_20_),
    .B(_24_),
    .Y(pixel_y_in_range)
  );
  \$logic_and  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _58_ (
    .A(pixel_x_in_range),
    .B(pixel_y_in_range),
    .Y(pixel_in_range)
  );
  \$logic_not  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd1),
    .Y_WIDTH(32'd1)
  ) _59_ (
    .A(dino_left_q),
    .Y(_22_)
  );
  \$lt  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd8),
    .Y_WIDTH(32'd1)
  ) _60_ (
    .A(pixel_x_i),
    .B(8'h8a),
    .Y(_23_)
  );
  \$lt  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd12),
    .Y_WIDTH(32'd1)
  ) _61_ (
    .A(pixel_y_i),
    .B(_11_[11:0]),
    .Y(_24_)
  );
  \$mux  #(
    .WIDTH(32'd1)
  ) _62_ (
    .A(_04_),
    .B(_32_),
    .S(hit_i),
    .Y(_02_)
  );
  \$mux  #(
    .WIDTH(32'd1)
  ) _63_ (
    .A(1'h0),
    .B(_02_),
    .S(pixel_in_range),
    .Y(pixel_o)
  );
  \$mux  #(
    .WIDTH(32'd11)
  ) _64_ (
    .A(_10_),
    .B(11'h000),
    .S(_18_),
    .Y(_03_)
  );
  \$mux  #(
    .WIDTH(32'd11)
  ) _65_ (
    .A(_09_),
    .B(11'h165),
    .S(_18_),
    .Y(_00_)
  );
  \$mux  #(
    .WIDTH(32'd11)
  ) _66_ (
    .A(dino_yv_q),
    .B(11'h7ef),
    .S(_21_),
    .Y(_31_)
  );
  \$mux  #(
    .WIDTH(32'd11)
  ) _67_ (
    .A(_31_),
    .B(11'hxxx),
    .S(hit_i),
    .Y(_01_)
  );
  \$mux  #(
    .WIDTH(32'd8)
  ) _68_ (
    .A(_08_),
    .B(8'h00),
    .S(_17_),
    .Y(dino_step_counter_d)
  );
  \$mux  #(
    .WIDTH(32'd1)
  ) _69_ (
    .A(_37_),
    .B(_36_),
    .S(dino_left_q),
    .Y(_07_)
  );
  \$mux  #(
    .WIDTH(32'd1)
  ) _70_ (
    .A(_35_),
    .B(_34_),
    .S(dino_left_q),
    .Y(_06_)
  );
  \$mux  #(
    .WIDTH(32'd1)
  ) _71_ (
    .A(_07_),
    .B(_06_),
    .S(down_i),
    .Y(_05_)
  );
  \$mux  #(
    .WIDTH(32'd1)
  ) _72_ (
    .A(_33_),
    .B(_05_),
    .S(grounded),
    .Y(_04_)
  );
  \$shiftx  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd58),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _73_ (
    .A(_27_),
    .B(rom_x),
    .Y(_32_)
  );
  \$shiftx  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd58),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _74_ (
    .A(_30_),
    .B(rom_x),
    .Y(_33_)
  );
  \$shiftx  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd58),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _75_ (
    .A(_25_),
    .B(rom_x),
    .Y(_34_)
  );
  \$shiftx  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd58),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _76_ (
    .A(_26_),
    .B(rom_x),
    .Y(_35_)
  );
  \$shiftx  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd58),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _77_ (
    .A(_28_),
    .B(rom_x),
    .Y(_36_)
  );
  \$shiftx  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd58),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd1)
  ) _78_ (
    .A(_29_),
    .B(rom_x),
    .Y(_37_)
  );
  \$sub  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd7),
    .Y_WIDTH(32'd11)
  ) _79_ (
    .A(pixel_x_i),
    .B(7'h50),
    .Y({ _15_[31], _15_[9:0] })
  );
  \$sub  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd6),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd10),
    .Y_WIDTH(32'd10)
  ) _80_ (
    .A(6'h39),
    .B(_15_[9:0]),
    .Y(rom_x)
  );
  \$sub  #(
    .A_SIGNED(32'd0),
    .A_WIDTH(32'd10),
    .B_SIGNED(32'd0),
    .B_WIDTH(32'd11),
    .Y_WIDTH(32'd12)
  ) _81_ (
    .A(pixel_y_i),
    .B(dino_yp_q),
    .Y({ _16_[31], _16_[10], rom_y })
  );
  \$mux  #(
    .WIDTH(32'd2)
  ) _82_ (
    .A(2'h1),
    .B(2'h3),
    .S(down_i),
    .Y(_38_[1:0])
  );
  assign _11_[31:12] = 20'h00000;
  assign _15_[30:10] = { _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31], _15_[31] };
  assign _16_[9:0] = rom_y;
  assign _16_[30:11] = { _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31], _16_[31] };
  assign _38_[31:2] = 30'h00000000;
  assign _sv2v_0 = 1'h0;
endmodule
