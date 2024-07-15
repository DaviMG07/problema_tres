module mux_32_2_8(
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    input [1:0] key,
    output [7:0] x
);

mux_4_2_1(a[0], b[0], c[0], d[0], key, x[0]);
mux_4_2_1(a[1], b[1], c[1], d[1], key, x[1]);
mux_4_2_1(a[2], b[2], c[2], d[2], key, x[2]);
mux_4_2_1(a[3], b[3], c[3], d[3], key, x[3]);
mux_4_2_1(a[4], b[4], c[4], d[4], key, x[4]);
mux_4_2_1(a[5], b[5], c[5], d[5], key, x[5]);
mux_4_2_1(a[6], b[6], c[6], d[6], key, x[6]);
mux_4_2_1(a[7], b[7], c[7], d[7], key, x[7]);

endmodule
