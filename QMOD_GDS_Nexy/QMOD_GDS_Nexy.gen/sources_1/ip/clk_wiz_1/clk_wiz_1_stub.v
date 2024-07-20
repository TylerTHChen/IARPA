// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Wed Jul 10 12:20:37 2024
// Host        : Tyler running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/tyler_hyposvu/OneDrive -
//               UW-Madison/Research/IARPA/QMOD_GDS/QMOD_GDS_Nexy/QMOD_GDS_Nexy.gen/sources_1/ip/clk_wiz_1/clk_wiz_1_stub.v}
// Design      : clk_wiz_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_1(clk, reset, locked, osc)
/* synthesis syn_black_box black_box_pad_pin="reset,locked,osc" */
/* synthesis syn_force_seq_prim="clk" */;
  output clk /* synthesis syn_isclock = 1 */;
  input reset;
  output locked;
  input osc;
endmodule
