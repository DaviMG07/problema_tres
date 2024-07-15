module demux_1_2_4(
    input x,
    input [1:0] key,
    output [3:0] y
);

and(y[0], !key[0], !key[1], x);
and(y[1], key[0], !key[1], x);
and(y[2], !key[0], key[1], x);
and(y[3], key[0], key[1], x);

endmodule
