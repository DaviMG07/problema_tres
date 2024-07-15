module test_state_machine(
    input clock,
    input sprinkler,
    input drip,
    input specific,
    input time_over,
    output [1:0] state
);

all_states(clock, sprinkler, drip, specific, time_over, state);

endmodule
