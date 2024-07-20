module waves_tb();

logic osc, GDS, QMOD, clk_out;

waves iDUT(.*);

initial begin
osc = 0;

end

always #5 osc = ~osc;

endmodule