vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv "+incdir+../../../QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_0_1" \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_0_1" \
"../../../QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0_clk_wiz.v" \
"../../../QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0.v" \

vlog -work xil_defaultlib  -incr -mfcu  -sv "+incdir+../../../QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_0_1" \
"../../../../waves.sv" \

vlog -work xil_defaultlib \
"glbl.v"

