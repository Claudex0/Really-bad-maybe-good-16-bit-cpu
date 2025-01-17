library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;


entity pwm_counter is
	port --define inputs and outputs
	(	count,clear_c,clk:in std_logic;
		counter_out:out std_logic_vector(5 downto 0)
	);
end pwm_counter;

architecture behavior of pwm_counter is

begin

process(clk,clear_c)
variable cnt:std_logic_vector(5 downto 0);
begin
	if(clear_c='1') then
		cnt:="000000";
		counter_out<=cnt;
	else
		if(rising_edge(clk)) then
			if(count='1') then
				cnt:=cnt+(not clear_c);
				counter_out<=cnt;
			else
				cnt:=cnt+"000000";
			end if;
		end if;
	end if;
end process;
end behavior;		
