LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY pwm_controller IS
	
	PORT( 
		nrst,clk,equal,pwm_on: in  std_logic;
		valid,load_regs,count,clear_c: out std_logic
	);
END pwm_controller;

ARCHITECTURE RTL OF pwm_controller IS
	type state is (su, s0, s1, s2,s3,s4); 
	
	signal present_state, next_state : state;
BEGIN
	--next state decoder
	next_state_dec_proc:
	process(present_state,pwm_on,equal)
		variable n_s : state;
	begin
		case present_state is
			when s0 => 
				if (pwm_on='1') then
					n_s:=s1;
				else
					n_s:=s0;
				end if;
			when s1=>
				n_s:=s2;
			when s2=>
				n_s:=s3;
			when s3=>
				if (pwm_on='1') then
					n_s:=s0;
				else
					if (equal='1') then
						n_s:=s4;
					else
						n_s:=s3;
					end if;
				end if;
			when s4=>
				if (pwm_on='1') then
					n_s:=s0;
				else
					n_s:=s3;
				end if;
			when others => n_s := Su;
		end case;
		
		next_state <= n_s after 5 ns;
	end process;
	
	
	--memory
	mem_proc:
	process(nrst,clk)
	begin
		if nrst = '1' then
			present_state <= S0 after 5 ns;
		elsif rising_edge(clk) then
			present_state <= next_state after 5 ns;
		end if;
	end process;
	
	--output decoder
	output_dec_proc:
	process(present_state) 		
	begin		
		case present_state is
			when s0 => 
				valid<='0' after 5 ns;
				load_regs<='0' after 5 ns;
				count<='0' after 5 ns;
				clear_c<='1' after 5 ns;
			when s1 => 
				valid<='0' after 5 ns;
				load_regs<='1' after 5 ns;
				count<='0' after 5 ns;
				clear_c<='0' after 5 ns;
			when s2 => 
				valid<='0' after 5 ns;
				load_regs<='0' after 5 ns;
				count<='0' after 5 ns;
				clear_c<='0' after 5 ns;
			when s3 => 
				valid<='1' after 5 ns;
				load_regs<='0' after 5 ns;
				count<='1' after 5 ns;
				clear_c<='0' after 5 ns;
			when s4 => 
				valid<='0' after 5 ns;
				load_regs<='0' after 5 ns;
				count<='0' after 5 ns;
				clear_c<='1' after 5 ns;
			when others => 
				valid<='X' after 5 ns;
				load_regs<='X' after 5 ns;
				count<='X' after 5 ns;
				clear_c<='X' after 5 ns;
		end case;	
	end process;
END ARCHITECTURE;