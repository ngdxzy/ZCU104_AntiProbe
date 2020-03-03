# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH"
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH"
  ipgui::add_param $IPINST -name "ADDR_WIDTH"
  ipgui::add_param $IPINST -name "DATA_WIDTH"
  ipgui::add_param $IPINST -name "S_AXI_ADDR_WIDTH"
  ipgui::add_param $IPINST -name "S_AXI_DATA_WIDTH"
  ipgui::add_param $IPINST -name "CLK_SW"
  ipgui::add_param $IPINST -name "CLK_IN_PEO"
  ipgui::add_param $IPINST -name "VCO_MUL"
  ipgui::add_param $IPINST -name "VCO_DIV"
  ipgui::add_param $IPINST -name "FIXED_DIV"
  ipgui::add_param $IPINST -name "SWING_DIV"
  ipgui::add_param $IPINST -name "IMP_PHASE"

}

proc update_PARAM_VALUE.ADDR_WIDTH { PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to update ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADDR_WIDTH { PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to validate ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.CLK_IN_PEO { PARAM_VALUE.CLK_IN_PEO } {
	# Procedure called to update CLK_IN_PEO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLK_IN_PEO { PARAM_VALUE.CLK_IN_PEO } {
	# Procedure called to validate CLK_IN_PEO
	return true
}

proc update_PARAM_VALUE.CLK_SW { PARAM_VALUE.CLK_SW } {
	# Procedure called to update CLK_SW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLK_SW { PARAM_VALUE.CLK_SW } {
	# Procedure called to validate CLK_SW
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.FIXED_DIV { PARAM_VALUE.FIXED_DIV } {
	# Procedure called to update FIXED_DIV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIXED_DIV { PARAM_VALUE.FIXED_DIV } {
	# Procedure called to validate FIXED_DIV
	return true
}

proc update_PARAM_VALUE.IMP_PHASE { PARAM_VALUE.IMP_PHASE } {
	# Procedure called to update IMP_PHASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IMP_PHASE { PARAM_VALUE.IMP_PHASE } {
	# Procedure called to validate IMP_PHASE
	return true
}

proc update_PARAM_VALUE.SWING_DIV { PARAM_VALUE.SWING_DIV } {
	# Procedure called to update SWING_DIV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SWING_DIV { PARAM_VALUE.SWING_DIV } {
	# Procedure called to validate SWING_DIV
	return true
}

proc update_PARAM_VALUE.S_AXI_ADDR_WIDTH { PARAM_VALUE.S_AXI_ADDR_WIDTH } {
	# Procedure called to update S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.S_AXI_ADDR_WIDTH { PARAM_VALUE.S_AXI_ADDR_WIDTH } {
	# Procedure called to validate S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.S_AXI_DATA_WIDTH { PARAM_VALUE.S_AXI_DATA_WIDTH } {
	# Procedure called to update S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.S_AXI_DATA_WIDTH { PARAM_VALUE.S_AXI_DATA_WIDTH } {
	# Procedure called to validate S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.VCO_DIV { PARAM_VALUE.VCO_DIV } {
	# Procedure called to update VCO_DIV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VCO_DIV { PARAM_VALUE.VCO_DIV } {
	# Procedure called to validate VCO_DIV
	return true
}

proc update_PARAM_VALUE.VCO_MUL { PARAM_VALUE.VCO_MUL } {
	# Procedure called to update VCO_MUL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VCO_MUL { PARAM_VALUE.VCO_MUL } {
	# Procedure called to validate VCO_MUL
	return true
}


proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.ADDR_WIDTH { MODELPARAM_VALUE.ADDR_WIDTH PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADDR_WIDTH}] ${MODELPARAM_VALUE.ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.S_AXI_ADDR_WIDTH PARAM_VALUE.S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.S_AXI_DATA_WIDTH { MODELPARAM_VALUE.S_AXI_DATA_WIDTH PARAM_VALUE.S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.CLK_SW { MODELPARAM_VALUE.CLK_SW PARAM_VALUE.CLK_SW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLK_SW}] ${MODELPARAM_VALUE.CLK_SW}
}

proc update_MODELPARAM_VALUE.CLK_IN_PEO { MODELPARAM_VALUE.CLK_IN_PEO PARAM_VALUE.CLK_IN_PEO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLK_IN_PEO}] ${MODELPARAM_VALUE.CLK_IN_PEO}
}

proc update_MODELPARAM_VALUE.VCO_MUL { MODELPARAM_VALUE.VCO_MUL PARAM_VALUE.VCO_MUL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VCO_MUL}] ${MODELPARAM_VALUE.VCO_MUL}
}

proc update_MODELPARAM_VALUE.VCO_DIV { MODELPARAM_VALUE.VCO_DIV PARAM_VALUE.VCO_DIV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VCO_DIV}] ${MODELPARAM_VALUE.VCO_DIV}
}

proc update_MODELPARAM_VALUE.FIXED_DIV { MODELPARAM_VALUE.FIXED_DIV PARAM_VALUE.FIXED_DIV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIXED_DIV}] ${MODELPARAM_VALUE.FIXED_DIV}
}

proc update_MODELPARAM_VALUE.SWING_DIV { MODELPARAM_VALUE.SWING_DIV PARAM_VALUE.SWING_DIV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SWING_DIV}] ${MODELPARAM_VALUE.SWING_DIV}
}

proc update_MODELPARAM_VALUE.IMP_PHASE { MODELPARAM_VALUE.IMP_PHASE PARAM_VALUE.IMP_PHASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IMP_PHASE}] ${MODELPARAM_VALUE.IMP_PHASE}
}

