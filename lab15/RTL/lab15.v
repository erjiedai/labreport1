module lab15(
    input wire key1_in,
    input wire key2_in,
    input wire key3_in,
    output  wire led1_out,
    output wire led0_out
);

    assign led1_out = key1_in ^ key2_in ^ key3_in;
    assign led0_out = (key1_in & key2_in) | (key3_in & (key1_in ^ key2_in));

endmodule