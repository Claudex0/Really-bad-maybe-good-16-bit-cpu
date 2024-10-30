LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY aluMux1 IS
   PORT
   (
      aluMux1acc_input,aluMux1ram_input: in std_logic_vector (11 downto 0);
		aluMux1_sel:in std_logic;
		aluMux1_output: out std_logic_vector (11 downto 0)
   );
END aluMux1;
ARCHITECTURE comb OF aluMux1 IS
BEGIN
   PROCESS (aluMux1_sel,aluMux1acc_input,aluMux1ram_input)
	begin
		if (aluMux1_sel='0') then
			aluMux1_output<=aluMux1acc_input;
		elsif (aluMux1_sel='1') then
			aluMux1_output<=aluMux1ram_input;
		end if;
   END PROCESS;
END comb;