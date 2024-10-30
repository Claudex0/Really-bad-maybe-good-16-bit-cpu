library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;


entity comparator_per is
	port --define inputs and outputs
	(	per,counter:in std_logic_vector(5 downto 0);
		equal:out std_logic
	);
end comparator_per;

architecture behavior of comparator_per is

begin

process(per,counter)
begin
	if(counter < per) then
		equal<='0';
	else
		equal<='1';
	end if;
end process;
end behavior;		
