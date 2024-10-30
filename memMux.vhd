LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY memMux IS
   PORT
   (
      irMemmux_input,pcMemmux_input: in std_logic_vector (7 downto 0);
		memMux_sel:in std_logic;
		memMux_output: out std_logic_vector (7 downto 0)
   );
END memMux;
ARCHITECTURE comb OF memMux IS
BEGIN
   PROCESS (memMux_sel,irMemmux_input,pcMemmux_input)
	begin
		if (memMux_sel='0') then
			memMux_output<=pcMemmux_input;
		elsif (memMux_sel='1') then
			memMux_output<=irMemmux_input;
		end if;
   END PROCESS;
END comb;