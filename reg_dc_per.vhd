library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;


entity reg_dc_per is
	port --define inputs and outputs
	(	D_in:in std_logic_vector(5 downto 0);
		clk,load,nrst:in std_logic;
		reg_out:out std_logic_vector(5 downto 0)
	);
end reg_dc_per;

architecture behavior of reg_dc_per is

begin

process(clk,nrst)
variable store: std_logic_vector (5 downto 0);
begin
	if(nrst='1') then
		reg_out<="000000";
		store:="000000";
	else
		if(rising_edge(clk)) then
			if(load='1') then
				store:=D_in;
			end if;
			reg_out<=store;
		end if;
	end if;
end process;
end behavior;		
