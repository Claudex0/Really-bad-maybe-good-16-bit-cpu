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
-- CREATED		"Sat Jan 22 14:41:23 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY RBCPU_16bit IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		pc_ld :  OUT  STD_LOGIC;
		pc_cnt :  OUT  STD_LOGIC;
		co :  OUT  STD_LOGIC;
		pwm_out :  OUT  STD_LOGIC;
		pwm_en :  OUT  STD_LOGIC;
		acu_out :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		addr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		alu_out :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		aluMux0_output :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		aluMux1_output :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		pc_out :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		ram_out :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END RBCPU_16bit;

ARCHITECTURE bdf_type OF RBCPU_16bit IS 

COMPONENT cpu_controller
	PORT(nrst : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 co : IN STD_LOGIC;
		 opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
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
		 pc_clr : OUT STD_LOGIC;
		 alu_sel : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT program_counter
	PORT(clk : IN STD_LOGIC;
		 pc_clr : IN STD_LOGIC;
		 pc_ld : IN STD_LOGIC;
		 pc_cnt : IN STD_LOGIC;
		 input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 pc_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alumux0
	PORT(aluMux0_sel : IN STD_LOGIC;
		 aluMux0ir_input : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 aluMux0Pc_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 aluMux0_output : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alumux1
	PORT(aluMux1_sel : IN STD_LOGIC;
		 aluMux1acc_input : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 aluMux1ram_input : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 aluMux1_output : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ram
	PORT(we : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 addr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 ram_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT accumulator
	PORT(clk : IN STD_LOGIC;
		 acu_clr : IN STD_LOGIC;
		 acu_ld : IN STD_LOGIC;
		 cobo : IN STD_LOGIC;
		 acu_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 acu_cobo : OUT STD_LOGIC;
		 acu_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
	PORT(alu_sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 aluMux0_input : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 aluMux1_input : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 cobo : OUT STD_LOGIC;
		 alu_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT instruction_register
	PORT(clk : IN STD_LOGIC;
		 ir_clr : IN STD_LOGIC;
		 ir_ld : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT freq_div
	PORT(clk_in : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 clk_out : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT pwmdemux
	PORT(pwmDemux_sel : IN STD_LOGIC;
		 pwmDemuxir_input : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 pwmDemux0_output : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 pwmDemux1_output : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pwm_generator
	PORT(nrst : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 pwm_on : IN STD_LOGIC;
		 D_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 pwm_out : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT memmux
	PORT(memMux_sel : IN STD_LOGIC;
		 irMemmux_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 pcMemmux_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 memMux_output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	alu_out_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	aluMux0_output_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	q :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	ram_out_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC;


BEGIN 
pc_ld <= SYNTHESIZED_WIRE_4;
pc_cnt <= SYNTHESIZED_WIRE_5;
co <= SYNTHESIZED_WIRE_1;
pwm_en <= SYNTHESIZED_WIRE_26;
acu_out <= SYNTHESIZED_WIRE_32;
addr <= SYNTHESIZED_WIRE_13;
aluMux1_output <= SYNTHESIZED_WIRE_20;
pc_out <= SYNTHESIZED_WIRE_31;



b2v_inst : cpu_controller
PORT MAP(nrst => nrst,
		 clk => SYNTHESIZED_WIRE_30,
		 co => SYNTHESIZED_WIRE_1,
		 opcode => q(15 DOWNTO 12),
		 pc_cnt => SYNTHESIZED_WIRE_5,
		 pc_ld => SYNTHESIZED_WIRE_4,
		 pwn_en => SYNTHESIZED_WIRE_26,
		 ir_ld => SYNTHESIZED_WIRE_23,
		 ir_clr => SYNTHESIZED_WIRE_22,
		 we => SYNTHESIZED_WIRE_11,
		 memMux_sel => SYNTHESIZED_WIRE_28,
		 demux_sel => SYNTHESIZED_WIRE_24,
		 aluMux0_sel => SYNTHESIZED_WIRE_6,
		 aluMux1_sel => SYNTHESIZED_WIRE_9,
		 acu_ld => SYNTHESIZED_WIRE_17,
		 acu_clr => SYNTHESIZED_WIRE_16,
		 pc_clr => SYNTHESIZED_WIRE_3,
		 alu_sel => SYNTHESIZED_WIRE_19);


b2v_inst1 : program_counter
PORT MAP(clk => SYNTHESIZED_WIRE_30,
		 pc_clr => SYNTHESIZED_WIRE_3,
		 pc_ld => SYNTHESIZED_WIRE_4,
		 pc_cnt => SYNTHESIZED_WIRE_5,
		 input => alu_out_ALTERA_SYNTHESIZED(7 DOWNTO 0),
		 pc_out => SYNTHESIZED_WIRE_31);


b2v_inst10 : alumux0
PORT MAP(aluMux0_sel => SYNTHESIZED_WIRE_6,
		 aluMux0ir_input => SYNTHESIZED_WIRE_7,
		 aluMux0Pc_input => SYNTHESIZED_WIRE_31,
		 aluMux0_output => aluMux0_output_ALTERA_SYNTHESIZED);


b2v_inst11 : alumux1
PORT MAP(aluMux1_sel => SYNTHESIZED_WIRE_9,
		 aluMux1acc_input => SYNTHESIZED_WIRE_32,
		 aluMux1ram_input => ram_out_ALTERA_SYNTHESIZED(11 DOWNTO 0),
		 aluMux1_output => SYNTHESIZED_WIRE_20);


b2v_inst13 : ram
PORT MAP(we => SYNTHESIZED_WIRE_11,
		 clk => SYNTHESIZED_WIRE_30,
		 addr => SYNTHESIZED_WIRE_13,
		 data => SYNTHESIZED_WIRE_32,
		 ram_out => ram_out_ALTERA_SYNTHESIZED);


b2v_inst2 : accumulator
PORT MAP(clk => SYNTHESIZED_WIRE_30,
		 acu_clr => SYNTHESIZED_WIRE_16,
		 acu_ld => SYNTHESIZED_WIRE_17,
		 cobo => SYNTHESIZED_WIRE_18,
		 acu_in => alu_out_ALTERA_SYNTHESIZED,
		 acu_cobo => SYNTHESIZED_WIRE_1,
		 acu_out => SYNTHESIZED_WIRE_32);


b2v_inst21 : alu
PORT MAP(alu_sel => SYNTHESIZED_WIRE_19,
		 aluMux0_input => aluMux0_output_ALTERA_SYNTHESIZED,
		 aluMux1_input => SYNTHESIZED_WIRE_20,
		 cobo => SYNTHESIZED_WIRE_18,
		 alu_out => alu_out_ALTERA_SYNTHESIZED);


b2v_inst3 : instruction_register
PORT MAP(clk => SYNTHESIZED_WIRE_30,
		 ir_clr => SYNTHESIZED_WIRE_22,
		 ir_ld => SYNTHESIZED_WIRE_23,
		 data => ram_out_ALTERA_SYNTHESIZED,
		 q => q);


b2v_inst4 : freq_div
PORT MAP(clk_in => clk,
		 nrst => nrst,
		 clk_out => SYNTHESIZED_WIRE_30);


b2v_inst5 : pwmdemux
PORT MAP(pwmDemux_sel => SYNTHESIZED_WIRE_24,
		 pwmDemuxir_input => q(11 DOWNTO 0),
		 pwmDemux0_output => SYNTHESIZED_WIRE_7,
		 pwmDemux1_output => SYNTHESIZED_WIRE_27);


b2v_inst6 : pwm_generator
PORT MAP(nrst => nrst,
		 clk => SYNTHESIZED_WIRE_30,
		 pwm_on => SYNTHESIZED_WIRE_26,
		 D_in => SYNTHESIZED_WIRE_27,
		 pwm_out => pwm_out);


b2v_inst7 : memmux
PORT MAP(memMux_sel => SYNTHESIZED_WIRE_28,
		 irMemmux_input => aluMux0_output_ALTERA_SYNTHESIZED(7 DOWNTO 0),
		 pcMemmux_input => SYNTHESIZED_WIRE_31,
		 memMux_output => SYNTHESIZED_WIRE_13);

alu_out(7 DOWNTO 0) <= alu_out_ALTERA_SYNTHESIZED(7 DOWNTO 0);
aluMux0_output <= aluMux0_output_ALTERA_SYNTHESIZED;
ram_out <= ram_out_ALTERA_SYNTHESIZED;

END bdf_type;