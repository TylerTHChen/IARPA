

# Input clock pin constraint (typically 100 MHz onboard clock)
set_property IOSTANDARD LVCMOS33 [get_ports osc]
set_property PACKAGE_PIN E3 [get_ports osc]

set_property PACKAGE_PIN D18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk] 

# Output signal pins (example)
set_property PACKAGE_PIN D14 [get_ports GDS]
set_property IOSTANDARD LVCMOS33 [get_ports GDS]

set_property PACKAGE_PIN F16 [get_ports QMOD]
set_property IOSTANDARD LVCMOS33 [get_ports QMOD]