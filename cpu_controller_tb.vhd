library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity cpu_controller_tb is
end cpu_controller_tb;

architecture tb of cpu_controller_tb is
    	Component CPU_Controller is
	PORT
	(
		nrst,clk,co:in  std_logic;
		OpCode:in  std_logic_vector(3 downto 0);
		pc_cnt,pc_ld,pwn_en,ir_ld,ir_clr,we,memMux_sel,demux_sel,aluMux0_sel,aluMux1_sel,acu_ld,pc_clr:out std_logic;
		alu_sel :out std_logic_vector(3 downto 0)
	);
	end component;	
	
		signal nrst,co:std_logic;
		signal clk:std_logic:='0';
		signal opcode,alu_sel:std_logic_vector(3 downto 0);
		signal pc_cnt,pc_ld,pwn_en,ir_ld,ir_clr,we,memMux_sel,demux_sel,aluMux0_sel,aluMux1_sel,acu_ld,pc_clr:std_logic;
		constant half_period: time := 15 ns;
		constant period: time := 30 ns;
		constant setup_fetch: time := 60 ns;
		constant setup_fetch_decode_execute: time := 120 ns;
	 
begin
    -- connecting testbench signals with cpu_controller component
    DUT : CPU_Controller port map 
	 (nrst => nrst, clk => clk, co => co,opcode=>opcode, pc_cnt=>pc_cnt, 
	 pc_ld => pc_ld, pwn_en=>pwn_en, ir_ld=>ir_ld, ir_clr=>ir_clr ,we=>we, memMux_sel=>memMux_sel,
	 demux_sel=>demux_sel,aluMux0_sel=>aluMux0_sel,aluMux1_sel=>aluMux1_sel,acu_ld=>acu_ld,pc_clr=>pc_clr,alu_sel=>alu_sel);
	 
	 nrst<= '1', '0' after 16 ns;
	 clk<= not clk after half_period;	
	 
data_stimuli:process
begin
	opcode<="0000";
	co<='0';
	wait for period;
	
	opcode<="0100";
	co<='0';
	wait for period;
	
	opcode<="0101";
	co<='0';
	wait for setup_fetch_decode_execute;
	
	opcode<="1111";
	co<='1';
	wait for setup_fetch_decode_execute;
	
	opcode<="0010";
	co<='0';
	wait;
end process;
end tb;