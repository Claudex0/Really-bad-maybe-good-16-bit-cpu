library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity pwm_generator_tb is
end pwm_generator_tb;

architecture tb of pwm_generator_tb is
    	Component pwm_generator is
	PORT
	(
		nrst,clk,pwm_on:in  std_logic;
		d_in:in  std_logic_vector(11 downto 0);
		pwm_out :out std_logic
	);
	end component;	
	
		signal nrst:std_logic;
		signal clk:std_logic:='0';
		signal pwm_on,pwm_out:std_logic;
		signal d_in:std_logic_vector(11 downto 0);
		constant half_period: time := 15 ns;
		constant period: time := 30 ns;
	 
begin
    -- connecting testbench signals with cpu_controller component
    DUT : pwm_generator port map 
	 (nrst => nrst, clk => clk, pwm_on=>pwm_on,pwm_out=>pwm_out,d_in=>d_in);
	 
	 nrst<= '1', '0' after 16 ns;
	 clk<= not clk after half_period;	
	 
data_stimuli:process
begin
	d_in<="000000000000";
	pwm_on<='0';
	wait for period;
	
	d_in<="100000011111";
	pwm_on<='1';
	wait for period;
	
	d_in<="100000011111";
	pwm_on<='0';
	wait for 3100 ns;
	
	d_in<="100000011111";
	pwm_on<='1';
	wait for period;
	
	d_in<="100000011111";
	pwm_on<='0';
	wait for period;
	wait;
end process;
end tb;