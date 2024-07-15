module irrigation(
    input air_umidity,
    input soil_umidity,
    input temperature,
    input [1:0] water_box,
    output sprinkler,
    output drip,
    output specific
);

wire medium_level, empty;
wire [2:0] aux;

and(medium_level, water_box[1], !water_box[0]);
and(empty, !water_box[1], !water_box[0]);

// A = C' · Us' (Ua' + T' · M)
and(aux[0], !temperature, medium_level);
or(aux[1], aux[0], !air_umidity);
and(sprinkler, !soil_umidity, aux[1], !empty);

// G = C' · Us' · Ua · (T + M')
or(aux[2], temperature, !medium_level);
and(aux[2], air_umidity, !soil_umidity, !empty);

// S = Ua · T'
and(specific, air_umidity, !temperature);

endmodule
