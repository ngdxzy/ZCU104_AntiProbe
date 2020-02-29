
set_property PACKAGE_PIN E15 [get_ports clk_in_p]
set_property IOSTANDARD LVDS [get_ports clk_in_p]
set_property IOSTANDARD LVDS [get_ports clk_in_n]
set_property DIFF_TERM_ADV TERM_100 [get_ports clk_in_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports clk_in_n]
set_property PACKAGE_PIN D5 [get_ports ref_clk_fb_good]
set_property IOSTANDARD LVCMOS33 [get_ports ref_clk_fb_good]
set_property PACKAGE_PIN U10 [get_ports ref_clk_in_p]
set_property IOSTANDARD LVCMOS18 [get_ports sma_swing]
set_property PACKAGE_PIN M13 [get_ports sma_swing]
set_property IOSTANDARD LVCMOS33 [get_ports system_clk_good]
set_property PACKAGE_PIN D6 [get_ports system_clk_good]

set_property IOSTANDARD LVDS [get_ports cmp_in_p]
set_property IOSTANDARD LVDS [get_ports cmp_in_n]
set_property DIFF_TERM_ADV TERM_100 [get_ports cmp_in_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports cmp_in_n]
set_property EQUALIZATION EQ_LEVEL0 [get_ports cmp_in_p]
set_property EQUALIZATION EQ_LEVEL0 [get_ports cmp_in_n]
set_property SLEW FAST [get_ports sma_swing]

set_property DQS_BIAS TRUE [get_ports cmp_in_p]
set_property DQS_BIAS TRUE [get_ports cmp_in_n]


set_property PACKAGE_PIN B10 [get_ports LE_p]
set_property IOSTANDARD LVDS [get_ports LE_p]

set_property PACKAGE_PIN D12 [get_ports cmp_in_p]


set_property PACKAGE_PIN D16 [get_ports tri_data]
set_property IOSTANDARD LVCMOS18 [get_ports tri_data]
set_property SLEW FAST [get_ports tri_data]



set_property OFFCHIP_TERM NONE [get_ports sma_swing]