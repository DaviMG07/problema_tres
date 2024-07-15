module main(
    input clock_50MHz,
    input clock_840Hz,
    input air_umidity,
    input soil_umidity,
    input temperature,
    input button,
    output [3:0] digits,
    output [7:0] segments,
    output [6:0] rows,
    output [4:0] cols
);

wire a_hz, g_hz, e_hz, one_hz;
wire sprinkler, drip, specific;
wire [1:0] water_box, state;
wire time_over;

wire init_timer;

wire [5:0] preset, reset;
wire [1:0] dozens;
wire [3:0] units;

wire [7:0] seg_dozens, seg_extra, seg_states, 
seg_units;
wire [2:0] count_0_7;
wire matrix_clock, matrix_direction;

wire [2:0] aux;

assign cols = 5'b11111;

// frequency divider
frequency_divider(clock_840Hz, a_hz, g_hz, e_hz, one_hz, blink);

// irrigation
irrigation(air_umidity, soil_umidity, !temperature, water_box, sprinkler, drip, specific);

// state machine
all_states(clock_50MHz, sprinkler, drip, specific, time_over, state);

// timer
or(init_timer, button, time_over);
gen_preset(init_timer, state, specific, preset, reset);
counter_30_0(one_hz, preset, reset, dozens, units);

and(aux[0], specific, dozens[0], units[2], units[0]);
and(aux[1], !dozens[0], !units[2], !units[0]);
or(aux[2], aux[0], aux[1]);
and(time_over, !dozens[1], !units[3], !units[1]);

// matrix
xor(matrix_direction, state[0], state[1]);
mux_4_2_1(e_hz, a_hz, g_hz, g_hz, count_0_7, matrix_clock);
dual_counter_0_7(matrix_clock, matrix_direction, , , count_0_7);
decoder_rows(blink, count_0_7, rows);

encoder_water_box(matrix_direction, count_0_7, water_box);

// display decoders
decoder_dozens(dozens, seg_dozens);
decoder_units(units, seg_units);
decoder_extra(state, seg_extra);
decoder_states(state, seg_states);

// display driver
driver_display(clock_840Hz, seg_states, seg_extra, seg_dozens, seg_units, digits, segments);

endmodule
