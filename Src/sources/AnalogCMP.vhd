----------------------------------------------------------------------------------------------------
-- brief: diffInputPad
-- file: diffInputPad.vhd
-- author: Lukas Leuenberger
----------------------------------------------------------------------------------------------------
-- Copyright (c) 2020 by HSR, Switzerland
-- All rights reserved.
----------------------------------------------------------------------------------------------------
-- File history:
--
-- Version | Date       | Author             | Remarks
----------------------------------------------------------------------------------------------------
-- 0.1     | 23.01.2020 | L. Leuenberger     | Auto-Created
----------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-- Library declarations
------------------------------------------------------------------------------------------------
library ieee;
-- This package defines the basic std_logic data types and a few functions.								
use ieee.std_logic_1164.all;
-- This package provides arithmetic functions for vectors.		
use ieee.numeric_std.all;
-- This package provides functions for the calcualtion with real values.
use ieee.math_real.all;
-- Vivado Components library
library unisim;
-- This package contains the iobuf component.
use unisim.vcomponents.all;

------------------------------------------------------------------------------------------------
-- Entity declarations
------------------------------------------------------------------------------------------------
entity AnalogCMP is
	port(
		-- Input and output ports
		comp_out : out   std_logic;
		PAD_P   : inout std_logic;
		PAD_N  : inout    std_logic;
		m_in_p   : in    std_logic;
		m_in_n   : in    std_logic;
		m_en_n   : in    std_logic
	);
end AnalogCMP;

------------------------------------------------------------------------------------------------
-- Architecture
------------------------------------------------------------------------------------------------
architecture behavioral of AnalogCMP is
	signal O_int : std_ulogic;
	signal VREF  : std_ulogic;
	
	attribute dont_touch     : string;
	attribute dont_touch of inst_OBUFT : label is "true";
	--attribute dont_touch of T : signal is "true";
	attribute dont_touch of inst_OBUFT2 : label is "true";
begin

	inst_DIFFINBUF : component DIFFINBUF
		generic map(
			DIFF_TERM               => false,
			DQS_BIAS                => "FALSE",
			IBUF_LOW_PWR            => "FALSE",
			ISTANDARD               => "LVDS",
			SIM_INPUT_BUFFER_OFFSET => 0
		)
		port map(
			O         => O_int,
			O_B       => open,
			DIFF_IN_N => PAD_N,
			DIFF_IN_P => PAD_P,
			OSC       => (others => '0'),
			OSC_EN    => (others => '0'),
			VREF      => VREF
		);

	inst_VREF : component HPIO_VREF
		generic map(
			VREF_CNTR => "FABRIC_RANGE2"
		)
		port map(
			VREF             => VREF,
			FABRIC_VREF_TUNE => "0000000"
		);

	inst_IBUFCTRL : component IBUFCTRL
		generic map(
			ISTANDARD       => "LVDS",
			USE_IBUFDISABLE => "FALSE"
		)
		port map(
			O             => comp_out,
			I             => O_int,
			IBUFDISABLE   => '0',
			INTERMDISABLE => '0',
			T             => '0'
		);
		
	inst_OBUFT : component OBUFT
			generic map(
      			SLEW => "SLOW",
				IOSTANDARD => "LVCMOS18"
			)
		port map(
			O => PAD_P,			
			I => m_in_p,
			T => '0'
		);
		
	inst_OBUFT2 : component OBUFT
		generic map(
      			SLEW => "FAST",
				IOSTANDARD => "LVCMOS18"
			)
		port map(
			O => PAD_N,			
			I => m_in_n,
			T => NOT m_en_n
		);


end behavioral;
