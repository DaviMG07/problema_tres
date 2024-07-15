module encoder_water_box(
    input direction,
    input [2:0] count,
    output [1:0] water_box
);

/*
| 3bit  | 2bit  |
| count | level |
|   0   |   C   |
|   1   |   L   |
|   2   |   L   |
|   3   |   M   | when the direction is down, the lvl is L
|   4   |   M   | when the direction is down, the lvl is L
|   5   |   M   |
|   6   |   M   |
|   7   |   H   |

lvl0 = Q2' · (Q1 XOR Q0) + Q2 · Q1 · Q0 + D' (Q2 · Q1' · Q0' + Q2' · Q1 · Q0)
lvl1 = Q2 · (Q1 + Q1' · Q0) + D · (Q2 · Q1' · Q0' + Q2' · Q1 · Q0)
*/

// Q1 XOR Q0
xor(aux[0], count[1], count[0]);

// Q2 · Q1' · Q0' + Q2' · Q1 · Q0
and(aux[1], !count[2], count[1], count[0]);
and(aux[2], count[2], !count[1], !count[0]);
or(aux[3], aux[1], aux[2]);

// D (Q2 · Q1' · Q0' + Q2' · Q1 · Q0)
and(aux[4], aux[3], direction);

// D' (Q2 · Q1' · Q0' + Q2' · Q1 · Q0)
and(aux[5], aux[3], !direction);

// Q2 · Q1 · Q0
and(aux[6], count[2], count[1], count[0]);

// Q2' · (Q1 XOR Q0)
and(aux[7], !count[2], aux[0]);

// Q1' · Q0
and(aux[8], !count[1], count[0]);

// Q1 + Q1' · Q0
or(aux[9], count[1], aux[8]);

// Q2 · (Q1 + Q1' · Q0)
and(aux[10], aux[9], count[2]);

// lvl0
or(water_box[0], aux[7], aux[6], aux[5]);

// lvl1
or(water_box[1], aux[10], aux[4]);

endmodule
