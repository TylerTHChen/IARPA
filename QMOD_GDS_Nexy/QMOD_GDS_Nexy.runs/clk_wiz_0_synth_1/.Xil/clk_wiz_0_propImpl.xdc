set_property SRC_FILE_INFO {cfile:{c:/Users/tyler_hyposvu/OneDrive - UW-Madison/Research/IARPA/QMOD_GDS/QMOD_GDS_Nexy/QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0.xdc} rfile:../../../QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports osc]] 0.100
