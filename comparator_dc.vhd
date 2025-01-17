library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;


entity comparator_dc is
	port --define inputs and outputs
	(	dc,counter:in std_logic_vector(5 downto 0);
		pwm_out:out std_logic
	);
end comparator_dc;

architecture behavior of comparator_dc is

begin

process(dc,counter)
begin
	if(counter < dc) then
		pwm_out<='1';
	else
		pwm_out<='0';
	end if;
end process;
end behavior;		
