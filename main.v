/*
module main(
    input clock,
    input air_umidity,
    input soil_umidity,
    input temperature,
    input button,
    output [3:0] digits,
    output [7:0] segments
);

wire display_clock, one_hz, sprinkler_hz, drip_hz, fill_hz;
wire [1:0] water_box, irrigation_type;
wire sprinkler, drip, specific;
wire time_over;

frequency_divider(clock, display_clock, one_hz, sprinkler_hz, drip_hz, fill_hz);

irrigation(air_umidity, soil_umidity, !temperature, water_box, sprinkler, drip, specific);

encoder_irrigation(sprinkler, drip, specific, irrigation_type);

counter_30_0(one_hz, preset, reset, dozens, units, time_over);

decoder_dozens(dozens, dozens_seg);
decoder_units(units, units_seg);
decoder_extra(state, extra_seg);
decoder_states(state, states_seg);

driver_display(display_clock, states_seg, extra_seg, dozens_seg, units_seg, digits, segments);

endmodule
*/
