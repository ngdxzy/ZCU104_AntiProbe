set_property PACKAGE_PIN D5 [get_ports ref_clk_fb_good]
set_property IOSTANDARD LVCMOS33 [get_ports ref_clk_fb_good]
set_property PACKAGE_PIN U10 [get_ports ref_clk_in_p]
set_property IOSTANDARD LVCMOS33 [get_ports system_clk_good]
set_property PACKAGE_PIN D6 [get_ports system_clk_good]


#set_property IOSTANDARD LVCMOS18 [get_ports triger]
#set_property SLEW FAST [get_ports triger]




create_clock -period 10.000 -name REF_CLK -waveform {0.000 5.000} [get_nets {GTH_inst/gtwiz_userclk_tx_usrclk2_out[0]}]
create_generated_clock -name System_CLK -source [get_pins {GTH_inst/gtwiz_userclk_tx_usrclk2_out[0]}] -multiply_by 1 -add -master_clock REF_CLK [get_pins inst_ZCU104_AntiProbetop_wrapper/StreamETS_0/inst/inst_ClockSources/system_clk]
create_generated_clock -name Sample_CLK -source [get_pins {GTH_inst/gtwiz_userclk_tx_usrclk2_out[0]}] -multiply_by 1 -add -master_clock REF_CLK [get_pins inst_ZCU104_AntiProbetop_wrapper/StreamETS_0/inst/inst_ClockSources/sample_clk]
create_clock -period 6.400 -name ref_clk_in_p -waveform {0.000 3.200} [get_ports ref_clk_in_p]

set_input_delay -clock [get_clocks *S11*] -clock_fall -max -add_delay 2.500 [get_ports S11_CMP_p]
set_input_delay -clock [get_clocks *S21*] -clock_fall -max -add_delay 2.500 [get_ports S21_CMP_p]
set_input_delay -clock [get_clocks *S21*] -clock_fall -min -add_delay -2.500 [get_ports S21_CMP_p]
set_input_delay -clock [get_clocks *S11*] -clock_fall -min -add_delay -2.500 [get_ports S11_CMP_p]


set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports PAD_P]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports PAD_N]
set_property PACKAGE_PIN C9 [get_ports triger]
set_property PACKAGE_PIN F8 [get_ports PAD_P]

set_property ODT RTT_48 [get_ports PAD_P]
set_property ODT RTT_48 [get_ports PAD_N]
set_property OUTPUT_IMPEDANCE RDRV_48_48 [get_ports PAD_P]
set_property OUTPUT_IMPEDANCE RDRV_48_48 [get_ports PAD_N]

set_property SLEW SLOW [get_ports PAD_P]
set_property SLEW SLOW [get_ports PAD_N]

set_property PACKAGE_PIN F12 [get_ports PAD_P1]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports PAD_P1]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports PAD_N1]


set_property OUTPUT_IMPEDANCE RDRV_48_48 [get_ports PAD_P1]
set_property OUTPUT_IMPEDANCE RDRV_48_48 [get_ports PAD_N1]
set_property ODT RTT_48 [get_ports PAD_P1]
set_property ODT RTT_48 [get_ports PAD_N1]

set_property PACKAGE_PIN L20 [get_ports PAD_P2]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports PAD_P2]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports PAD_N2]
set_property ODT RTT_48 [get_ports PAD_P2]
set_property ODT RTT_48 [get_ports PAD_N2]
set_property SLEW SLOW [get_ports PAD_P1]
set_property SLEW SLOW [get_ports PAD_N1]
set_property SLEW SLOW [get_ports PAD_P2]
set_property SLEW SLOW [get_ports PAD_N2]
