module encoder_irrigation(
    input sprinkler,
    input drip,
    input specific,
    output [1:0] irrigation_type
);

// R0 = A . G'
and(irrigation_type[0], sprinkler, !drip);

// R1 = A' · G · S' + A · G' · S
and(aux[0], irrigation_type[0], specific);
and(aux[1], !sprinkler, drip, !specific);
or(irrigation_type[1], aux[0], aux[1]);

endmodule
