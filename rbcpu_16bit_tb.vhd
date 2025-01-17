library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity rbcpu_16bit_tb is
end rbcpu_16bit_tb;

architecture tb of rbcpu_16bit_tb is
    	Component rbcpu_16bit is
	PORT
	(
		clk :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		pc_ld :  OUT  STD_LOGIC;
		pc_cnt :  OUT  STD_LOGIC;
		pwm_en: out std_logic;
		co :  OUT  STD_LOGIC;
		pwm_out :  OUT  STD_LOGIC;
		acu_out :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		addr :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		alu_out :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		aluMux0_output :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		aluMux1_output :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0);
		pc_out :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		ram_out :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
	end component;	
	
		signal clk : STD_LOGIC:='0';
		signal nrst : STD_LOGIC;
		signal co,pc_ld,pc_cnt : STD_LOGIC;
		signal pc_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
		signal pwm_en,pwm_out : STD_LOGIC;
		signal addr,alu_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
		signal aluMux0_output, acu_out :    STD_LOGIC_VECTOR(11 DOWNTO 0);
		signal aluMux1_output :    STD_LOGIC_VECTOR(11 DOWNTO 0);
		signal ram_out :   STD_LOGIC_VECTOR(15 DOWNTO 0);
		constant half_period: time := 15 ns;
		constant period: time := 30 ns;
		constant setup_fetch: time := 60 ns;
		constant setup_fetch_decode_execute: time := 150 ns;
	 
begin
    -- connecting testbench signals with rbcpu_16bit_tb component
    DUT : RBCPU_16bit port map 
	 (nrst => nrst, clk => clk,ram_out=>ram_out, co => co, pwm_en=>pwm_en,pwm_out=>pwm_out,pc_out=>pc_out,alu_out=>alu_out,
	 addr=>addr,aluMux0_output=>aluMux0_output,aluMux1_output=>aluMux1_output,acu_out=>acu_out,pc_cnt=>pc_cnt,pc_ld=>pc_ld);
	 
	 nrst<= '1', '0' after 16 ns;
	 clk<= not clk after half_period;	
	 
data_stimuli:process
begin
	wait;
end process;
end tb;