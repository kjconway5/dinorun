module bird (
	clk_i,
	rst_ni,
	next_frame_i,
	spawn_i,
	rand_i,
	pixel_x_i,
	pixel_y_i,
	pixel_o
);
	reg _sv2v_0;
	input wire clk_i;
	input wire rst_ni;
	input wire next_frame_i;
	input wire spawn_i;
	input wire [1:0] rand_i;
	input wire [9:0] pixel_x_i;
	input wire [9:0] pixel_y_i;
	output reg pixel_o;
	localparam signed [31:0] BirdWidth = 21;
	localparam signed [31:0] BirdHeight = 18;
	localparam signed [31:0] BirdScaler = 2;
	localparam signed [31:0] dinorun_pkg_Ground = 400;
	localparam signed [31:0] BirdY0 = (dinorun_pkg_Ground - (BirdHeight * BirdScaler)) - 26;
	localparam signed [31:0] BirdY1 = (dinorun_pkg_Ground - (BirdHeight * BirdScaler)) - 43;
	localparam signed [31:0] BirdY2 = (dinorun_pkg_Ground - (BirdHeight * BirdScaler)) - 66;
	localparam signed [31:0] BirdY3 = (dinorun_pkg_Ground - (BirdHeight * BirdScaler)) - 90;
	localparam signed [31:0] BirdSpeed = 8;
	localparam signed [31:0] BirdFlapDelay = 8;
	reg [20:0] BIRD_UP [0:17];
	reg [20:0] BIRD_DOWN [0:17];
	initial $readmemb("bird_up.memb", BIRD_UP);
	initial $readmemb("bird_down.memb", BIRD_DOWN);
	reg signed [10:0] bird_x_d;
	reg signed [10:0] bird_x_q;
	reg signed [10:0] bird_y_d;
	reg signed [10:0] bird_y_q;
	reg [7:0] bird_flap_counter_d;
	reg [7:0] bird_flap_counter_q;
	reg bird_flap_up_d;
	reg bird_flap_up_q;
	always @(posedge clk_i)
		if (!rst_ni) begin
			bird_x_q <= -BirdWidth * BirdScaler;
			bird_y_q <= 0;
			bird_flap_counter_q <= 0;
			bird_flap_up_q <= 0;
		end
		else begin
			bird_x_q <= bird_x_d;
			bird_y_q <= bird_y_d;
			bird_flap_counter_q <= bird_flap_counter_d;
			bird_flap_up_q <= bird_flap_up_d;
		end
	always @(*) begin
		if (_sv2v_0)
			;
		bird_flap_counter_d = bird_flap_counter_q;
		bird_flap_up_d = bird_flap_up_q;
		if (next_frame_i) begin
			bird_flap_counter_d = bird_flap_counter_q + 1;
			if (bird_flap_counter_q == 7) begin
				bird_flap_counter_d = 0;
				bird_flap_up_d = !bird_flap_up_q;
			end
		end
	end
	wire off_screen;
	assign off_screen = bird_x_q <= (-BirdWidth * BirdScaler);
	localparam signed [31:0] dinorun_pkg_ObstacleInitialX = 640;
	always @(*) begin
		if (_sv2v_0)
			;
		bird_x_d = bird_x_q;
		bird_y_d = bird_y_q;
		if (next_frame_i) begin
			if (!off_screen)
				bird_x_d = bird_x_q - BirdSpeed;
			else if (spawn_i) begin
				bird_x_d = dinorun_pkg_ObstacleInitialX;
				(* full_case, parallel_case *)
				case (rand_i)
					0: bird_y_d = BirdY0;
					1: bird_y_d = BirdY1;
					2: bird_y_d = BirdY2;
					3: bird_y_d = BirdY3;
					default:
						;
				endcase
			end
		end
	end
	wire pixel_x_in_range = (pixel_x_i >= bird_x_q) && (pixel_x_i < (bird_x_q + (BirdWidth * BirdScaler)));
	wire pixel_y_in_range = (pixel_y_i >= bird_y_q) && (pixel_y_i < (bird_y_q + (BirdHeight * BirdScaler)));
	wire pixel_in_range = pixel_x_in_range && pixel_y_in_range;
	wire [9:0] rom_x = 20 - ((pixel_x_i - bird_x_q) / BirdScaler);
	wire [9:0] rom_y = (pixel_y_i - bird_y_q) / BirdScaler;
	always @(*) begin
		if (_sv2v_0)
			;
		pixel_o = 0;
		if (pixel_in_range)
			(* full_case, parallel_case *)
			case (bird_flap_up_q)
				0: pixel_o = BIRD_DOWN[rom_y][rom_x];
				1: pixel_o = BIRD_UP[rom_y][rom_x];
				default:
					;
			endcase
	end
	initial _sv2v_0 = 0;
endmodule
module cactus (
	clk_i,
	rst_ni,
	next_frame_i,
	spawn_i,
	rand_i,
	pixel_x_i,
	pixel_y_i,
	pixel_o
);
	reg _sv2v_0;
	input wire clk_i;
	input wire rst_ni;
	input wire next_frame_i;
	input wire spawn_i;
	input wire [1:0] rand_i;
	input wire [9:0] pixel_x_i;
	input wire [9:0] pixel_y_i;
	output reg pixel_o;
	localparam signed [31:0] CactusWidth = 15;
	localparam signed [31:0] CactusHeight = 33;
	localparam signed [31:0] CactusScaler = 2;
	localparam signed [31:0] dinorun_pkg_Ground = 400;
	localparam signed [31:0] CactusY = dinorun_pkg_Ground - (CactusHeight * CactusScaler);
	localparam signed [31:0] CactusSpeed = 8;
	reg [14:0] CACTUS0 [0:32];
	reg [14:0] CACTUS1 [0:32];
	reg [14:0] CACTUS2 [0:32];
	reg [14:0] CACTUS3 [0:32];
	initial $readmemb("cactus_0.memb", CACTUS0);
	initial $readmemb("cactus_1.memb", CACTUS1);
	initial $readmemb("cactus_2.memb", CACTUS2);
	initial $readmemb("cactus_3.memb", CACTUS3);
	reg signed [10:0] cactus_x_d;
	reg signed [10:0] cactus_x_q;
	reg [1:0] cactus_image_d;
	reg [1:0] cactus_image_q;
	always @(posedge clk_i)
		if (!rst_ni) begin
			cactus_x_q <= -CactusWidth * CactusScaler;
			cactus_image_q <= 0;
		end
		else begin
			cactus_x_q <= cactus_x_d;
			cactus_image_q <= cactus_image_d;
		end
	wire off_screen;
	assign off_screen = cactus_x_q <= (-CactusWidth * CactusScaler);
	localparam signed [31:0] dinorun_pkg_ObstacleInitialX = 640;
	always @(*) begin
		if (_sv2v_0)
			;
		cactus_x_d = cactus_x_q;
		cactus_image_d = cactus_image_q;
		if (next_frame_i) begin
			if (!off_screen)
				cactus_x_d = cactus_x_q - CactusSpeed;
			else if (spawn_i) begin
				cactus_x_d = dinorun_pkg_ObstacleInitialX;
				cactus_image_d = rand_i;
			end
		end
	end
	wire pixel_x_in_range = (pixel_x_i >= cactus_x_q) && (pixel_x_i < (cactus_x_q + (CactusWidth * CactusScaler)));
	wire pixel_y_in_range = (pixel_y_i >= CactusY) && (pixel_y_i < (CactusY + (CactusHeight * CactusScaler)));
	wire pixel_in_range = pixel_x_in_range && pixel_y_in_range;
	wire [9:0] rom_x = 14 - ((pixel_x_i - cactus_x_q) / CactusScaler);
	wire [9:0] rom_y = (pixel_y_i - CactusY) / CactusScaler;
	always @(*) begin
		if (_sv2v_0)
			;
		pixel_o = 0;
		if (pixel_in_range)
			(* full_case, parallel_case *)
			case (cactus_image_q)
				0: pixel_o = CACTUS0[rom_y][rom_x];
				1: pixel_o = CACTUS1[rom_y][rom_x];
				2: pixel_o = CACTUS2[rom_y][rom_x];
				3: pixel_o = CACTUS3[rom_y][rom_x];
				default:
					;
			endcase
	end
	initial _sv2v_0 = 0;
endmodule
module dino (
	clk_i,
	rst_ni,
	next_frame_i,
	up_i,
	down_i,
	hit_i,
	pixel_x_i,
	pixel_y_i,
	pixel_o
);
	reg _sv2v_0;
	input wire clk_i;
	input wire rst_ni;
	input wire next_frame_i;
	input wire up_i;
	input wire down_i;
	input wire hit_i;
	input wire [9:0] pixel_x_i;
	input wire [9:0] pixel_y_i;
	output reg pixel_o;
	localparam signed [31:0] DinoWidth = 58;
	localparam signed [31:0] DinoHeight = 43;
	localparam signed [31:0] DinoScaler = 1;
	localparam signed [31:0] DinoX = 80;
	localparam signed [31:0] dinorun_pkg_Ground = 400;
	localparam signed [31:0] DinoInitialY = dinorun_pkg_Ground - (DinoHeight * DinoScaler);
	localparam signed [31:0] DinoJumpStrength = 17;
	localparam signed [31:0] DinoLowGravity = 1;
	localparam signed [31:0] DinoHighGravity = 3;
	localparam signed [31:0] DinoStepDelay = 4;
	reg [57:0] DINO_DOWNLEFT [0:42];
	reg [57:0] DINO_DOWNRIGHT [0:42];
	reg [57:0] DINO_HIT [0:42];
	reg [57:0] DINO_LEFT [0:42];
	reg [57:0] DINO_RIGHT [0:42];
	reg [57:0] DINO_STANDING [0:42];
	initial $readmemb("dino_downleft.memb", DINO_DOWNLEFT);
	initial $readmemb("dino_downright.memb", DINO_DOWNRIGHT);
	initial $readmemb("dino_hit.memb", DINO_HIT);
	initial $readmemb("dino_left.memb", DINO_LEFT);
	initial $readmemb("dino_right.memb", DINO_RIGHT);
	initial $readmemb("dino_standing.memb", DINO_STANDING);
	reg signed [10:0] dino_yp_d;
	reg signed [10:0] dino_yp_q;
	reg signed [10:0] dino_yv_d;
	reg signed [10:0] dino_yv_q;
	reg [7:0] dino_step_counter_d;
	reg [7:0] dino_step_counter_q;
	reg dino_left_d;
	reg dino_left_q;
	always @(posedge clk_i)
		if (!rst_ni) begin
			dino_yp_q <= DinoInitialY;
			dino_yv_q <= 0;
			dino_step_counter_q <= 0;
			dino_left_q <= 0;
		end
		else if (next_frame_i) begin
			dino_yp_q <= dino_yp_d;
			dino_yv_q <= dino_yv_d;
			dino_step_counter_q <= dino_step_counter_d;
			dino_left_q <= dino_left_d;
		end
	always @(*) begin
		if (_sv2v_0)
			;
		dino_step_counter_d = dino_step_counter_q;
		dino_left_d = dino_left_q;
		dino_step_counter_d = dino_step_counter_q + 1;
		if (dino_step_counter_q == 3) begin
			dino_step_counter_d = 0;
			dino_left_d = !dino_left_q;
		end
	end
	wire grounded = dino_yp_q >= DinoInitialY;
	always @(*) begin
		if (_sv2v_0)
			;
		dino_yp_d = dino_yp_q;
		dino_yv_d = dino_yv_q;
		if (!hit_i) begin
			if (grounded && up_i)
				dino_yv_d = -DinoJumpStrength;
			dino_yp_d = dino_yp_q + dino_yv_d;
			dino_yv_d = dino_yv_d + (down_i ? DinoHighGravity : DinoLowGravity);
			if (dino_yp_d >= DinoInitialY) begin
				dino_yp_d = DinoInitialY;
				dino_yv_d = 0;
			end
		end
	end
	wire pixel_x_in_range = (pixel_x_i >= DinoX) && (pixel_x_i < (DinoX + (DinoWidth * DinoScaler)));
	wire pixel_y_in_range = (pixel_y_i >= dino_yp_q) && (pixel_y_i < (dino_yp_q + (DinoHeight * DinoScaler)));
	wire pixel_in_range = pixel_x_in_range && pixel_y_in_range;
	wire [9:0] rom_x = 57 - ((pixel_x_i - DinoX) / DinoScaler);
	wire [9:0] rom_y = (pixel_y_i - dino_yp_q) / DinoScaler;
	always @(*) begin
		if (_sv2v_0)
			;
		pixel_o = 0;
		if (pixel_in_range) begin
			if (hit_i)
				pixel_o = DINO_HIT[rom_y][rom_x];
			else if (!grounded)
				pixel_o = DINO_STANDING[rom_y][rom_x];
			else if (down_i) begin
				if (dino_left_q)
					pixel_o = DINO_DOWNLEFT[rom_y][rom_x];
				else
					pixel_o = DINO_DOWNRIGHT[rom_y][rom_x];
			end
			else if (dino_left_q)
				pixel_o = DINO_LEFT[rom_y][rom_x];
			else
				pixel_o = DINO_RIGHT[rom_y][rom_x];
		end
	end
	initial _sv2v_0 = 0;
endmodule
module title (
	pixel_x_i,
	pixel_y_i,
	pixel_o
);
	reg _sv2v_0;
	input wire [9:0] pixel_x_i;
	input wire [9:0] pixel_y_i;
	output reg pixel_o;
	localparam signed [31:0] TitleWidth = 47;
	localparam signed [31:0] TitleHeight = 7;
	localparam signed [31:0] TitleScaler = 13;
	localparam signed [31:0] TitleY = 70;
	localparam signed [31:0] dinorun_pkg_ScreenWidth = 640;
	localparam signed [31:0] TitleX = (dinorun_pkg_ScreenWidth - (TitleWidth * TitleScaler)) / 2;
	reg [46:0] TITLE_MEM [0:6];
	initial $readmemb("title.memb", TITLE_MEM);
	wire pixel_x_in_range = (pixel_x_i >= TitleX) && (pixel_x_i < (TitleX + (TitleWidth * TitleScaler)));
	wire pixel_y_in_range = (pixel_y_i >= TitleY) && (pixel_y_i < (TitleY + (TitleHeight * TitleScaler)));
	wire pixel_in_range = pixel_x_in_range && pixel_y_in_range;
	wire [9:0] rom_x = 46 - ((pixel_x_i - TitleX) / TitleScaler);
	wire [9:0] rom_y = (pixel_y_i - TitleY) / TitleScaler;
	always @(*) begin
		if (_sv2v_0)
			;
		pixel_o = 0;
		if (pixel_in_range)
			pixel_o = TITLE_MEM[rom_y][rom_x];
	end
	initial _sv2v_0 = 0;
endmodule
module edge_detector (
	clk_i,
	data_i,
	edge_o
);
	input wire clk_i;
	input wire data_i;
	output wire edge_o;
	wire data_d;
	reg data_q1;
	reg data_q2;
	assign data_d = data_i;
	assign edge_o = data_q1 && !data_q2;
	always @(posedge clk_i) begin
		data_q1 <= data_d;
		data_q2 <= data_q1;
	end
endmodule
module vga_timer (
	clk_i,
	rst_ni,
	hsync_o,
	vsync_o,
	visible_o,
	position_x_o,
	position_y_o
);
	parameter signed [31:0] H_VISIBLE = 640;
	parameter signed [31:0] H_FRONT = 16;
	parameter signed [31:0] H_SYNC = 96;
	parameter signed [31:0] H_BACK = 48;
	localparam signed [31:0] WHOLE_LINE = ((H_VISIBLE + H_FRONT) + H_SYNC) + H_BACK;
	parameter signed [31:0] V_VISIBLE = 480;
	parameter signed [31:0] V_FRONT = 10;
	parameter signed [31:0] V_SYNC = 2;
	parameter signed [31:0] V_BACK = 33;
	localparam signed [31:0] WHOLE_FRAME = ((V_VISIBLE + V_FRONT) + V_SYNC) + V_BACK;
	input wire clk_i;
	input wire rst_ni;
	output wire hsync_o;
	output wire vsync_o;
	output wire visible_o;
	output wire [$clog2(H_VISIBLE) - 1:0] position_x_o;
	output wire [$clog2(V_VISIBLE) - 1:0] position_y_o;
	wire [$clog2(WHOLE_LINE) - 1:0] x_counter_d;
	reg [$clog2(WHOLE_LINE) - 1:0] x_counter_q;
	wire [$clog2(WHOLE_FRAME) - 1:0] y_counter_d;
	reg [$clog2(WHOLE_FRAME) - 1:0] y_counter_q;
	assign x_counter_d = (x_counter_q == (WHOLE_LINE - 1) ? 0 : x_counter_q + 1);
	assign y_counter_d = (x_counter_q != (WHOLE_LINE - 1) ? y_counter_q : (y_counter_q == (WHOLE_FRAME - 1) ? 0 : y_counter_q + 1));
	wire hvisible;
	wire vvisible;
	assign hvisible = (x_counter_q < H_VISIBLE) && rst_ni;
	assign vvisible = (y_counter_q < V_VISIBLE) && rst_ni;
	assign visible_o = hvisible & vvisible;
	assign hsync_o = ~((((H_VISIBLE + H_FRONT) <= x_counter_q) && (x_counter_q < ((H_VISIBLE + H_FRONT) + H_SYNC))) && rst_ni);
	assign vsync_o = ~((((V_VISIBLE + V_FRONT) <= y_counter_q) && (y_counter_q < ((V_VISIBLE + V_FRONT) + V_SYNC))) && rst_ni);
	function automatic [$clog2(H_VISIBLE) - 1:0] sv2v_cast_60BAD;
		input reg [$clog2(H_VISIBLE) - 1:0] inp;
		sv2v_cast_60BAD = inp;
	endfunction
	assign position_x_o = sv2v_cast_60BAD(x_counter_q);
	function automatic [$clog2(V_VISIBLE) - 1:0] sv2v_cast_5F333;
		input reg [$clog2(V_VISIBLE) - 1:0] inp;
		sv2v_cast_5F333 = inp;
	endfunction
	assign position_y_o = sv2v_cast_5F333(y_counter_q);
	always @(posedge clk_i)
		if (!rst_ni) begin
			x_counter_q <= (H_VISIBLE + H_FRONT) + H_SYNC;
			y_counter_q <= (V_VISIBLE + V_FRONT) + V_SYNC;
		end
		else begin
			x_counter_q <= x_counter_d;
			y_counter_q <= y_counter_d;
		end
endmodule
module score_counter (
	clk_i,
	rst_ni,
	en_i,
	digit0_o,
	digit1_o,
	digit2_o,
	digit3_o
);
	reg _sv2v_0;
	input wire clk_i;
	input wire rst_ni;
	input wire en_i;
	output wire [3:0] digit0_o;
	output wire [3:0] digit1_o;
	output wire [3:0] digit2_o;
	output wire [3:0] digit3_o;
	reg [3:0] digit0_d;
	reg [3:0] digit0_q;
	reg [3:0] digit1_d;
	reg [3:0] digit1_q;
	reg [3:0] digit2_d;
	reg [3:0] digit2_q;
	reg [3:0] digit3_d;
	reg [3:0] digit3_q;
	assign digit0_o = digit0_q;
	assign digit1_o = digit1_q;
	assign digit2_o = digit2_q;
	assign digit3_o = digit3_q;
	always @(*) begin
		if (_sv2v_0)
			;
		digit0_d = digit0_q + 1;
		digit1_d = digit1_q;
		digit2_d = digit2_q;
		digit3_d = digit3_q;
		if (digit0_d == 10) begin
			digit0_d = 0;
			digit1_d = digit1_q + 1;
		end
		if (digit1_d == 10) begin
			digit1_d = 0;
			digit2_d = digit2_q + 1;
		end
		if (digit2_d == 10) begin
			digit2_d = 0;
			digit3_d = digit3_q + 1;
		end
	end
	always @(posedge clk_i)
		if (!rst_ni) begin
			digit0_q <= 0;
			digit1_q <= 0;
			digit2_q <= 0;
			digit3_q <= 0;
		end
		else if (en_i) begin
			digit0_q <= digit0_d;
			digit1_q <= digit1_d;
			digit2_q <= digit2_d;
			digit3_q <= digit3_d;
		end
	initial _sv2v_0 = 0;
endmodule
module lfsr16 (
	clk_i,
	rst_ni,
	next_i,
	rand_o
);
	input wire clk_i;
	input wire rst_ni;
	input wire next_i;
	output wire [15:0] rand_o;
	wire [15:0] rand_d;
	reg [15:0] rand_q;
	assign rand_d[15:1] = rand_q[14:0];
	assign rand_d[0] = ^(rand_q & 16'hd008);
	assign rand_o = rand_q;
	always @(posedge clk_i)
		if (!rst_ni)
			rand_q <= 1;
		else if (next_i)
			rand_q <= rand_d;
endmodule
module synchronizer (
	clk_sample_i,
	clk_target_i,
	async_data_i,
	sync_data_o
);
	reg _sv2v_0;
	parameter signed [31:0] WIDTH = 4;
	input wire clk_sample_i;
	input wire clk_target_i;
	input wire [WIDTH - 1:0] async_data_i;
	output wire [WIDTH - 1:0] sync_data_o;
	reg [WIDTH - 1:0] sync_data_d;
	reg [WIDTH - 1:0] sync_data_q;
	assign sync_data_o = sync_data_q;
	wire clk_target_d;
	reg clk_target_q1;
	reg clk_target_q2;
	wire clk_target_edge;
	assign clk_target_d = clk_target_i;
	assign clk_target_edge = clk_target_q1 && !clk_target_q2;
	always @(*) begin
		if (_sv2v_0)
			;
		sync_data_d = sync_data_q;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < WIDTH; i = i + 1)
				if (clk_target_edge || async_data_i[i])
					sync_data_d[i] = async_data_i[i];
		end
	end
	always @(posedge clk_sample_i) begin
		clk_target_q1 <= clk_target_d;
		clk_target_q2 <= clk_target_q1;
		sync_data_q <= sync_data_d;
	end
	initial _sv2v_0 = 0;
endmodule
module basys3_7seg_driver (
	clk_1k_i,
	rst_ni,
	digit0_en_i,
	digit0_i,
	digit1_en_i,
	digit1_i,
	digit2_en_i,
	digit2_i,
	digit3_en_i,
	digit3_i,
	anode_o,
	segments_o
);
	reg _sv2v_0;
	input clk_1k_i;
	input rst_ni;
	input wire digit0_en_i;
	input wire [3:0] digit0_i;
	input wire digit1_en_i;
	input wire [3:0] digit1_i;
	input wire digit2_en_i;
	input wire [3:0] digit2_i;
	input wire digit3_en_i;
	input wire [3:0] digit3_i;
	output reg [3:0] anode_o;
	output wire [6:0] segments_o;
	wire [1:0] counter_d;
	reg [1:0] counter_q;
	assign counter_d = counter_q + 1;
	always @(posedge clk_1k_i)
		if (!rst_ni)
			counter_q <= 0;
		else
			counter_q <= counter_d;
	reg [3:0] current_digit;
	wire [6:0] decoded_segments;
	hex7seg hex7seg(
		.d3(current_digit[3]),
		.d2(current_digit[2]),
		.d1(current_digit[1]),
		.d0(current_digit[0]),
		.A(decoded_segments[0]),
		.B(decoded_segments[1]),
		.C(decoded_segments[2]),
		.D(decoded_segments[3]),
		.E(decoded_segments[4]),
		.F(decoded_segments[5]),
		.G(decoded_segments[6])
	);
	reg segments_en;
	assign segments_o = (segments_en ? ~decoded_segments : ~0);
	always @(*) begin
		if (_sv2v_0)
			;
		anode_o = 1'sb1;
		current_digit = 1'sbx;
		segments_en = 0;
		case (counter_q)
			0: begin
				current_digit = digit0_i;
				anode_o[0] = ~digit0_en_i;
				segments_en = digit0_en_i;
			end
			1: begin
				current_digit = digit1_i;
				anode_o[1] = ~digit1_en_i;
				segments_en = digit1_en_i;
			end
			2: begin
				current_digit = digit2_i;
				anode_o[2] = ~digit2_en_i;
				segments_en = digit2_en_i;
			end
			3: begin
				current_digit = digit3_i;
				anode_o[3] = ~digit3_en_i;
				segments_en = digit3_en_i;
			end
			default:
				;
		endcase
	end
	initial _sv2v_0 = 0;
endmodule
module hex7seg (
	d3,
	d2,
	d1,
	d0,
	A,
	B,
	C,
	D,
	E,
	F,
	G
);
	input wire d3;
	input wire d2;
	input wire d1;
	input wire d0;
	output wire A;
	output wire B;
	output wire C;
	output wire D;
	output wire E;
	output wire F;
	output wire G;
	assign A = !((((((~d3 & ~d2) & ~d1) & d0) | (((~d3 & d2) & ~d1) & ~d0)) | (((d3 & ~d2) & d1) & d0)) | (((d3 & d2) & ~d1) & d0));
	assign B = !((((((((~d3 & d2) & ~d1) & d0) | (((~d3 & d2) & d1) & ~d0)) | (((d3 & ~d2) & d1) & d0)) | (((d3 & d2) & ~d1) & ~d0)) | (((d3 & d2) & d1) & ~d0)) | (((d3 & d2) & d1) & d0));
	assign C = !((((((~d3 & ~d2) & d1) & ~d0) | (((d3 & d2) & ~d1) & ~d0)) | (((d3 & d2) & d1) & ~d0)) | (((d3 & d2) & d1) & d0));
	assign D = !(((((((~d3 & ~d2) & ~d1) & d0) | (((~d3 & d2) & ~d1) & ~d0)) | (((~d3 & d2) & d1) & d0)) | (((d3 & !d2) & d1) & !d0)) | (((d3 & d2) & d1) & d0));
	assign E = !((((((((~d3 & ~d2) & ~d1) & d0) | (((~d3 & ~d2) & d1) & d0)) | (((~d3 & d2) & ~d1) & ~d0)) | (((~d3 & d2) & ~d1) & d0)) | (((~d3 & d2) & d1) & d0)) | (((d3 & ~d2) & ~d1) & d0));
	assign F = !(((((((~d3 & ~d2) & ~d1) & d0) | (((~d3 & ~d2) & d1) & ~d0)) | (((~d3 & ~d2) & d1) & d0)) | (((~d3 & d2) & d1) & d0)) | (((d3 & d2) & ~d1) & d0));
	assign G = !((((((~d3 & ~d2) & ~d1) & ~d0) | (((~d3 & ~d2) & ~d1) & d0)) | (((~d3 & d2) & d1) & d0)) | (((d3 & d2) & ~d1) & ~d0));
endmodule
module clk_100M_to_clk_1k (
	clk_100M_i,
	clk_1k_o
);
	input wire clk_100M_i;
	output wire clk_1k_o;
	localparam signed [31:0] COUNTER_RESET = 100000;
	wire [17:0] counter_d;
	reg [17:0] counter_q = 0;
	assign counter_d = (counter_q == 99999 ? {18 {1'sb0}} : counter_q + 1);
	always @(posedge clk_100M_i) counter_q <= counter_d;
	wire clk_d;
	reg clk_q;
	assign clk_d = counter_q > 50000;
	assign clk_1k_o = clk_q;
	always @(posedge clk_100M_i) clk_q <= clk_d;
endmodule
module dinorun (
	clk_25_175_i,
	rst_ni,
	start_i,
	up_i,
	down_i,
	digit0_en_o,
	digit0_o,
	digit1_en_o,
	digit1_o,
	digit2_en_o,
	digit2_o,
	digit3_en_o,
	digit3_o,
	vga_red_o,
	vga_green_o,
	vga_blue_o,
	vga_hsync_o,
	vga_vsync_o
);
	reg _sv2v_0;
	input wire clk_25_175_i;
	input wire rst_ni;
	input wire start_i;
	input wire up_i;
	input wire down_i;
	output wire digit0_en_o;
	output wire [3:0] digit0_o;
	output wire digit1_en_o;
	output wire [3:0] digit1_o;
	output wire digit2_en_o;
	output wire [3:0] digit2_o;
	output wire digit3_en_o;
	output wire [3:0] digit3_o;
	output wire [3:0] vga_red_o;
	output wire [3:0] vga_green_o;
	output wire [3:0] vga_blue_o;
	output wire vga_hsync_o;
	output wire vga_vsync_o;
	reg [1:0] state_d;
	reg [1:0] state_q;
	reg [7:0] flashing_timer_d;
	reg [7:0] flashing_timer_q;
	wire hit = (state_q == 2'd2) || (state_q == 2'd3);
	always @(posedge clk_25_175_i)
		if (!rst_ni) begin
			state_q <= 2'd0;
			flashing_timer_q <= 0;
		end
		else begin
			state_q <= state_d;
			flashing_timer_q <= flashing_timer_d;
		end
	wire next_frame;
	reg [3:0] vga_red_d;
	reg [3:0] vga_red_q;
	reg [3:0] vga_blue_d;
	reg [3:0] vga_blue_q;
	reg [3:0] vga_green_d;
	reg [3:0] vga_green_q;
	wire vga_visible_d;
	reg vga_visible_q;
	wire vga_hsync_d;
	reg vga_hsync_q;
	wire vga_vsync_d;
	reg vga_vsync_q;
	wire vsync_edge;
	assign next_frame = vsync_edge && !hit;
	edge_detector edge_detector(
		.clk_i(clk_25_175_i),
		.data_i(vga_vsync_q),
		.edge_o(vsync_edge)
	);
	always @(posedge clk_25_175_i) begin
		vga_red_q <= vga_red_d;
		vga_green_q <= vga_green_d;
		vga_blue_q <= vga_blue_d;
		vga_visible_q <= vga_visible_d;
		vga_hsync_q <= vga_hsync_d;
		vga_vsync_q <= vga_vsync_d;
	end
	assign vga_red_o = (vga_visible_q ? vga_red_q : 0);
	assign vga_green_o = (vga_visible_q ? vga_green_q : 0);
	assign vga_blue_o = (vga_visible_q ? vga_blue_q : 0);
	assign vga_hsync_o = vga_hsync_q;
	assign vga_vsync_o = vga_vsync_q;
	wire [15:0] lfsr16_rand;
	lfsr16 lfsr16(
		.clk_i(clk_25_175_i),
		.rst_ni(rst_ni),
		.next_i(next_frame),
		.rand_o(lfsr16_rand)
	);
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;
	vga_timer vga_timer(
		.clk_i(clk_25_175_i),
		.rst_ni(rst_ni),
		.hsync_o(vga_hsync_d),
		.vsync_o(vga_vsync_d),
		.visible_o(vga_visible_d),
		.position_x_o(pixel_x),
		.position_y_o(pixel_y)
	);
	reg reset_objects_n;
	wire drawing_dino;
	wire dino_enable;
	assign dino_enable = (state_q != 2'd2) || flashing_timer_q[3];
	dino dino(
		.clk_i(clk_25_175_i),
		.rst_ni(rst_ni),
		.next_frame_i(next_frame),
		.up_i(up_i),
		.down_i(down_i),
		.hit_i(hit),
		.pixel_x_i(pixel_x),
		.pixel_y_i(pixel_y),
		.pixel_o(drawing_dino)
	);
	wire spawn_cactus0;
	wire drawing_cactus0;
	cactus cactus0(
		.clk_i(clk_25_175_i),
		.rst_ni(reset_objects_n),
		.next_frame_i(next_frame),
		.spawn_i(spawn_cactus0),
		.rand_i(lfsr16_rand[1:0]),
		.pixel_x_i(pixel_x),
		.pixel_y_i(pixel_y),
		.pixel_o(drawing_cactus0)
	);
	assign spawn_cactus0 = (state_q == 2'd1) && (lfsr16_rand[12:8] == 5'b00000);
	wire spawn_cactus1;
	wire drawing_cactus1;
	cactus cactus1(
		.clk_i(clk_25_175_i),
		.rst_ni(reset_objects_n),
		.next_frame_i(next_frame),
		.spawn_i(spawn_cactus1),
		.rand_i(lfsr16_rand[1:0]),
		.pixel_x_i(pixel_x),
		.pixel_y_i(pixel_y),
		.pixel_o(drawing_cactus1)
	);
	assign spawn_cactus1 = (state_q == 2'd1) && (lfsr16_rand[11:7] == 5'b11111);
	wire drawing_cactus = drawing_cactus0 || drawing_cactus1;
	wire spawn_bird;
	wire drawing_bird;
	bird bird(
		.clk_i(clk_25_175_i),
		.rst_ni(reset_objects_n),
		.next_frame_i(next_frame),
		.spawn_i(spawn_bird),
		.rand_i(lfsr16_rand[1:0]),
		.pixel_x_i(pixel_x),
		.pixel_y_i(pixel_y),
		.pixel_o(drawing_bird)
	);
	assign spawn_bird = (state_q == 2'd1) && (lfsr16_rand[11:6] == 6'b101010);
	wire collision = drawing_dino && (drawing_cactus || drawing_bird);
	always @(*) begin
		if (_sv2v_0)
			;
		reset_objects_n = rst_ni;
		state_d = state_q;
		flashing_timer_d = 0;
		(* full_case, parallel_case *)
		case (state_q)
			2'd0:
				if (start_i)
					state_d = 2'd1;
			2'd1:
				if (collision) begin
					state_d = 2'd2;
					flashing_timer_d = 60;
				end
			2'd2: begin
				flashing_timer_d = flashing_timer_q;
				if (vsync_edge) begin
					flashing_timer_d = flashing_timer_d - 1;
					if (flashing_timer_d == 0)
						state_d = 2'd3;
				end
			end
			2'd3:
				if (start_i) begin
					state_d = 2'd1;
					reset_objects_n = 0;
				end
				else if (down_i || up_i) begin
					state_d = 2'd0;
					reset_objects_n = 0;
				end
			default:
				;
		endcase
	end
	wire drawing_title;
	title title(
		.pixel_x_i(pixel_x),
		.pixel_y_i(pixel_y),
		.pixel_o(drawing_title)
	);
	localparam signed [31:0] dinorun_pkg_Ground = 400;
	always @(*) begin
		if (_sv2v_0)
			;
		vga_red_d = 0;
		vga_green_d = 0;
		vga_blue_d = 0;
		if (drawing_title && (state_q == 2'd0))
			{vga_red_d, vga_green_d, vga_blue_d} = 12'hb0f;
		else if (drawing_bird)
			{vga_red_d, vga_green_d, vga_blue_d} = 12'h00f;
		else if (drawing_dino && dino_enable)
			{vga_red_d, vga_green_d, vga_blue_d} = 12'h070;
		else if (drawing_cactus)
			{vga_red_d, vga_green_d, vga_blue_d} = 12'h0f0;
		else if (pixel_y < 396)
			{vga_red_d, vga_green_d, vga_blue_d} = 12'hfb5;
		else
			{vga_red_d, vga_green_d, vga_blue_d} = 12'h931;
	end
	reg score_enable = next_frame && (state_q == 2'd1);
	score_counter score_counter(
		.clk_i(clk_25_175_i),
		.rst_ni(reset_objects_n),
		.en_i(score_enable),
		.digit0_o(digit0_o),
		.digit1_o(digit1_o),
		.digit2_o(digit2_o),
		.digit3_o(digit3_o)
	);
	assign digit0_en_o = 1;
	assign digit1_en_o = 1;
	assign digit2_en_o = 1;
	assign digit3_en_o = 1;
	initial _sv2v_0 = 0;
endmodule