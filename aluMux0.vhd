LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY aluMux0 IS
   PORT
   (
      aluMux0ir_input: in std_logic_vector (11 downto 0);
		aluMux0Pc_input: in std_logic_vector (7 downto 0);
		aluMux0_sel:in std_logic;
		aluMux0_output: out std_logic_vector (11 downto 0)
   );
END aluMux0;
ARCHITECTURE comb OF aluMux0 IS
BEGIN
   PROCESS (aluMux0_sel,aluMux0ir_input,aluMux0pc_input)
	begin
		if (aluMux0_sel='0') then
			aluMux0_output<=aluMux0ir_input;
		elsif (aluMux0_sel='1') then
			aluMux0_output<=("0000") & (aluMux0pc_input);
		end if;
   END PROCESS;
END comb;