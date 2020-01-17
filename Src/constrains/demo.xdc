
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


set_property PACKAGE_PIN F8 [get_ports LE_p]
set_property IOSTANDARD LVDS [get_ports LE_p]

set_property PACKAGE_PIN M13 [get_ports cmp_in_p]

connect_debug_port dbg_hub/clk [get_nets REF_CLK_IN]

set_property PACKAGE_PIN H16 [get_ports tri_data]
set_property IOSTANDARD LVCMOS18 [get_ports tri_data]
set_property SLEW FAST [get_ports tri_data]



set_property OFFCHIP_TERM NONE [get_ports sma_swing]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list shifting_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 1 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/data_r]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/data_sync]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/f_sample0]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/f_sample1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/f_sample_false]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/inverse__0]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/r_sample0]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/r_sample1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/r_sample_false]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/rise_occ_r]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/rise_occ_r_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/sync_tri]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list ref_clk_fb]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 1 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/rise_occ]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 1 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/rising_detector]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 1 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list ZCU104_MCU_i/Auto_ETS_0/inst/test_trigger]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets ref_clk_fb]
