-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"
-- CREATED		"Mon Jan 03 12:47:48 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY altera;

LIBRARY work;

ENTITY mux_0 IS 
PORT 
( 
	sel	:	IN	 STD_LOGIC;
	ir_input	:	IN	 STD_LOGIC_VECTOR(3 DOWNTO 0);
	pc_input	:	IN	 STD_LOGIC_VECTOR(3 DOWNTO 0);
	output	:	OUT	 STD_LOGIC_VECTOR(3 DOWNTO 0)
); 
END mux_0;

ARCHITECTURE bdf_type OF mux_0 IS 
BEGIN 

-- instantiate macrofunction 

b2v_inst4 : mux
PORT MAP(sel => sel,
		 ir_input => ir_input,
		 pc_input => pc_input,
		 output => output);

END bdf_type; 