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
-- CREATED		"Mon Jan 03 15:35:59 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY CPU_Controller IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		co :  IN  STD_LOGIC;
		opcode :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		pc_cnt :  OUT  STD_LOGIC;
		pc_ld :  OUT  STD_LOGIC;
		ir_ld :  OUT  STD_LOGIC;
		memMux_sel :  OUT  STD_LOGIC;
		demux_sel :  OUT  STD_LOGIC;
		aluMux0_sel :  OUT  STD_LOGIC;
		aluMux1_sel :  OUT  STD_LOGIC;
		acu_ld :  OUT  STD_LOGIC;
		pc_clr :  OUT  STD_LOGIC;
		pwn_en :  OUT  STD_LOGIC;
		we :  OUT  STD_LOGIC;
		ir_clr :  OUT  STD_LOGIC;
		acu_clr :  OUT  STD_LOGIC;
		alu_sel :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END CPU_Controller;

ARCHITECTURE bdf_type OF CPU_Controller IS 

COMPONENT decoder
	PORT(nrst : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 cycl_phs : IN STD_LOGIC;
		 co : IN STD_LOGIC;
		 OpCode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 pc_cnt : OUT STD_LOGIC;
		 pc_ld : OUT STD_LOGIC;
		 pwn_en : OUT STD_LOGIC;
		 ir_ld : OUT STD_LOGIC;
		 ir_clr : OUT STD_LOGIC;
		 we : OUT STD_LOGIC;
		 memMux_sel : OUT STD_LOGIC;
		 demux_sel : OUT STD_LOGIC;
		 aluMux0_sel : OUT STD_LOGIC;
		 aluMux1_sel : OUT STD_LOGIC;
		 acu_ld : OUT STD_LOGIC;
		 acu_clr : OUT STD_LOGIC;
		 cycl_clr : OUT STD_LOGIC;
		 cycle_cnt : OUT STD_LOGIC;
		 pc_clr : OUT STD_LOGIC;
		 alu_sel : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cycle_counter
	PORT(clk : IN STD_LOGIC;
		 cycle_clr : IN STD_LOGIC;
		 cycle_cnt : IN STD_LOGIC;
		 cycle_phs : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;


BEGIN 



b2v_inst : decoder
PORT MAP(nrst => nrst,
		 clk => clk,
		 cycl_phs => SYNTHESIZED_WIRE_0,
		 co => co,
		 OpCode => opcode,
		 pc_cnt => pc_cnt,
		 pc_ld => pc_ld,
		 pwn_en => pwn_en,
		 ir_ld => ir_ld,
		 ir_clr => ir_clr,
		 we => we,
		 memMux_sel => memMux_sel,
		 demux_sel => demux_sel,
		 aluMux0_sel => aluMux0_sel,
		 aluMux1_sel => aluMux1_sel,
		 acu_ld => acu_ld,
		 acu_clr => acu_clr,
		 cycl_clr => SYNTHESIZED_WIRE_1,
		 cycle_cnt => SYNTHESIZED_WIRE_2,
		 pc_clr => pc_clr,
		 alu_sel => alu_sel);


b2v_inst1 : cycle_counter
PORT MAP(clk => clk,
		 cycle_clr => SYNTHESIZED_WIRE_1,
		 cycle_cnt => SYNTHESIZED_WIRE_2,
		 cycle_phs => SYNTHESIZED_WIRE_0);


END bdf_type;