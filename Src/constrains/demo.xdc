set_property PACKAGE_PIN D5 [get_ports ref_clk_fb_good]
set_property IOSTANDARD LVCMOS33 [get_ports ref_clk_fb_good]
set_property PACKAGE_PIN U10 [get_ports ref_clk_in_p]
set_property IOSTANDARD LVCMOS33 [get_ports system_clk_good]
set_property PACKAGE_PIN D6 [get_ports system_clk_good]

set_property PACKAGE_PIN E17 [get_ports ref_swing]
set_property IOSTANDARD LVCMOS18 [get_ports ref_swing]
set_property IOSTANDARD LVCMOS18 [get_ports S11_swing]
set_property IOSTANDARD LVCMOS18 [get_ports S21_swing]
set_property SLEW FAST [get_ports ref_swing]
set_property SLEW FAST [get_ports S11_swing]
set_property SLEW FAST [get_ports S21_swing]
set_property PACKAGE_PIN E12 [get_ports S11_swing]
set_property PACKAGE_PIN J10 [get_ports S21_swing]
set_property IOSTANDARD LVDS [get_ports LE_ref_p]
set_property IOSTANDARD LVDS [get_ports LE_S11_p]
set_property IOSTANDARD LVDS [get_ports LE_S21_p]
set_property PACKAGE_PIN D16 [get_ports LE_ref_p]
set_property PACKAGE_PIN B6 [get_ports LE_S11_p]
set_property PACKAGE_PIN F8 [get_ports LE_S21_p]
set_property IOSTANDARD LVDS [get_ports ref_CMP_p]
set_property IOSTANDARD LVDS [get_ports S11_CMP_p]
set_property IOSTANDARD LVDS [get_ports S21_CMP_p]
set_property EQUALIZATION EQ_LEVEL0 [get_ports S11_CMP_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports S11_CMP_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports S21_CMP_p]
set_property EQUALIZATION EQ_LEVEL0 [get_ports S21_CMP_p]
set_property IOSTANDARD LVCMOS18 [get_ports triger]
set_property PACKAGE_PIN K20 [get_ports triger]
set_property SLEW FAST [get_ports triger]
set_property PACKAGE_PIN A13 [get_ports ref_CMP_p]
set_property PACKAGE_PIN B10 [get_ports S11_CMP_p]
set_property PACKAGE_PIN E9 [get_ports S21_CMP_p]

set_property DQS_BIAS TRUE [get_ports S21_CMP_p]
set_property DQS_BIAS TRUE [get_ports S21_CMP_n]
set_property DQS_BIAS TRUE [get_ports S11_CMP_p]
set_property DQS_BIAS TRUE [get_ports S11_CMP_n]
set_property DQS_BIAS TRUE [get_ports ref_CMP_p]
set_property DQS_BIAS TRUE [get_ports ref_CMP_n]

create_clock -period 6.400 -name REF_CLK_IN -waveform {0.000 3.200} IBUFDS_GTE4_inst/O

create_clock -period 6.957 -name REF_CLK -waveform {0.000 3.479} -add GTH_inst/inst/gen_gtwizard_gthe4_top.gtwizard_ultrascale_0_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_rx_user_clocking_internal.gen_single_instance.gtwiz_userclk_rx_inst/gen_gtwiz_userclk_rx_main.bufg_gt_usrclk_inst/O
create_clock -period 6.957 -name SYS_CLK -waveform {0.000 3.479} -add ZCU104_MCU_i/Auto_ETS_0/inst/MMCME3_ADV_inst/CLKOUT0
create_clock -period 6.957 -name SHIFTING_CLK -waveform {0.000 3.479} -add ZCU104_MCU_i/Auto_ETS_0/inst/MMCME3_ADV_inst/CLKOUT1
