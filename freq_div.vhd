LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
ENTITY freq_div IS
PORT
(
	clk_in,nrst : IN STD_LOGIC;
	clk_out : OUT STD_LOGIC
);
END freq_div;

ARCHITECTURE behaviour OF freq_div IS
signal clk_div:std_logic_vector(23 downto 0);
BEGIN


process(clk_in,nrst)

begin
	if(nrst='1') then
		clk_div<="000000000000000000000000";
	elsif rising_edge(clk_in) then
		clk_div<=clk_div+"000000000000000000000001";
		clk_out<=clk_div(15);
	end if;
	end process;
END architecture;