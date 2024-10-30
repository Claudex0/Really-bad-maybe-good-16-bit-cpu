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
-- CREATED		"Sat Jan 22 11:54:35 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY pwm_generator IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		pwm_on :  IN  STD_LOGIC;
		D_in :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		pwm_out :  OUT  STD_LOGIC
	);
END pwm_generator;

ARCHITECTURE bdf_type OF pwm_generator IS 

COMPONENT pwm_controller
	PORT(nrst : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 equal : IN STD_LOGIC;
		 pwm_on : IN STD_LOGIC;
		 valid : OUT STD_LOGIC;
		 load_regs : OUT STD_LOGIC;
		 count : OUT STD_LOGIC;
		 clear_c : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT comparator_dc
	PORT(counter : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 dc : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 pwm_out : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT reg_dc_per
	PORT(clk : IN STD_LOGIC;
		 load : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 D_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 reg_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comparator_per
	PORT(counter : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 per : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 equal : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT pwm_counter
	PORT(count : IN STD_LOGIC;
		 clear_c : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 counter_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;


BEGIN 



b2v_inst : pwm_controller
PORT MAP(nrst => nrst,
		 clk => clk,
		 equal => SYNTHESIZED_WIRE_0,
		 pwm_on => pwm_on,
		 valid => SYNTHESIZED_WIRE_10,
		 load_regs => SYNTHESIZED_WIRE_12,
		 count => SYNTHESIZED_WIRE_7,
		 clear_c => SYNTHESIZED_WIRE_8);


b2v_inst1 : comparator_dc
PORT MAP(counter => SYNTHESIZED_WIRE_11,
		 dc => SYNTHESIZED_WIRE_2,
		 pwm_out => SYNTHESIZED_WIRE_9);


b2v_inst2 : reg_dc_per
PORT MAP(clk => clk,
		 load => SYNTHESIZED_WIRE_12,
		 nrst => nrst,
		 D_in => D_in(5 DOWNTO 0),
		 reg_out => SYNTHESIZED_WIRE_2);


b2v_inst3 : comparator_per
PORT MAP(counter => SYNTHESIZED_WIRE_11,
		 per => SYNTHESIZED_WIRE_5,
		 equal => SYNTHESIZED_WIRE_0);


b2v_inst4 : reg_dc_per
PORT MAP(clk => clk,
		 load => SYNTHESIZED_WIRE_12,
		 nrst => nrst,
		 D_in => D_in(11 DOWNTO 6),
		 reg_out => SYNTHESIZED_WIRE_5);


b2v_inst5 : pwm_counter
PORT MAP(count => SYNTHESIZED_WIRE_7,
		 clear_c => SYNTHESIZED_WIRE_8,
		 clk => clk,
		 counter_out => SYNTHESIZED_WIRE_11);


PROCESS(SYNTHESIZED_WIRE_9,SYNTHESIZED_WIRE_10)
BEGIN
if (SYNTHESIZED_WIRE_10 = '1') THEN
	pwm_out <= SYNTHESIZED_WIRE_9;
ELSE
	pwm_out <= 'Z';
END IF;
END PROCESS;


END bdf_type;