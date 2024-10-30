LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
USE ieee.std_logic_arith.all;

ENTITY cycle_counter IS
	
	PORT( 
			clk,cycle_clr,cycle_cnt:in std_logic;
			cycle_phs:out std_logic
	);
END cycle_counter;

ARCHITECTURE RTL OF cycle_counter IS

BEGIN
	process(clk,cycle_clr)
	variable cnt_value:std_logic_vector(1 downto 0);
	begin	
		if (cycle_clr='1') then
			cycle_phs<='0' after 5 ns;
			cnt_value:="00";
		else
			if (rising_edge(clk)) then
				if (cycle_cnt='1') then
					cnt_value:=cnt_value + (not cycle_clr);
					cycle_phs<=cnt_value(0) after 5 ns;
				end if;
			end if;
		end if;
	end process;	
END ARCHITECTURE;