module frequency_divider(
    input clock_840,
    output a_hz,
    output g_hz,
    output e_hz,
    output one_hz
);
// clock = 420 Hz
divider_by_two(clock_840, clock);

// 42 Hz
divider_by_ten(clock, aux[0]);

// 14 Hz
divider_by_three(aux[0], aux[1]);

// 2 Hz
divider_by_seven(aux[1], aux[2]);

// 0,4 Hz
divider_by_five(aux[2], a_hz);

// 0,2 Hz
divider_by_two(a_hz, g_hz);

// 7 Hz
divider_by_two(aux[1], aux[3]);

// 0,7 z
divider_by_ten(aux[3], e_hz);

// 1 Hz
divider_by_two(aux[2], one_hz);

endmodule
