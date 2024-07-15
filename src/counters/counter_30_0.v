module counter_30_0(
    input clock,
    input [5:0] preset,
    input [5:0] reset,
    output [1:0] dozens,
    output [3:0] units
);

wire end_condition, clockDozens;

and(end_condition, !dozens[0], !dozens[1], !units[0], !units[1], !units[2], !units[3]);

and(clockDozens, !units[0], !units[1], !units[2], !units[3]);

counter_9_0(clock, end_condition, preset[3:0], reset[3:0], units);

counter_3_0(!clockDozens, end_condition, preset[5:4], reset[5:4], dozens);

endmodule
