module encoder_water_box(
    input direction,
    input [2:0] count_0_7,
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
lvl1 = Q2 · (Q1 + Q1' · Q0) + D · (Q2 · Q1' · Q0 + Q2' · Q1 · Q0)
*/

