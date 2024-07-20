set_property SRC_FILE_INFO {cfile:{c:/Users/tyler_hyposvu/OneDrive - UW-Madison/Research/IARPA/QMOD_GDS/QMOD_GDS_Nexy/QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc} rfile:../../../../../QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property SRC_FILE_INFO {cfile:{C:/Users/tyler_hyposvu/OneDrive - UW-Madison/Research/IARPA/QMOD_GDS/QMOD_GDS_Nexy/QMOD_GDS_Nexy.runs/clk_wiz_1_synth_1/dont_touch.xdc} rfile:../../../dont_touch.xdc id:2} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:53 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 10.000 -name osc [get_ports osc]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_property PHASESHIFT_MODE WAVEFORM [get_cells plle2_adv_inst]
current_instance
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkfbout_clk_wiz_1 -source [get_pins inst/plle2_adv_inst/CLKIN1] -edges {1 2 3} -edge_shift {0.000 10.000 20.000} -add -master_clock [get_clocks osc] [get_pins inst/plle2_adv_inst/CLKFBOUT]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clk_clk_wiz_1 -source [get_pins inst/plle2_adv_inst/CLKIN1] -edges {1 2 3} -edge_shift {0.000 43.553 87.105} -add -master_clock [get_clocks osc] [get_pins inst/plle2_adv_inst/CLKOUT0]
set_property src_info {type:XDC file:2 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property KEEP_HIERARCHY SOFT [get_cells inst]
