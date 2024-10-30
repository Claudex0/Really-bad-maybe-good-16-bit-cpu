LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY pwmDemux IS
   PORT
   (
      pwmDemuxir_input: in std_logic_vector (11 downto 0);
		pwmDemux_sel:in std_logic;
		pwmDemux0_output,pwmDemux1_output: out std_logic_vector (11 downto 0)
   );
END pwmDemux;
ARCHITECTURE comb OF pwmDemux IS
BEGIN
   PROCESS (pwmDemuxir_input,pwmDemux_sel)
	begin
		if (pwmDemux_sel='0') then
			pwmDemux0_output<=pwmDemuxir_input;
		elsif (pwmDemux_sel='1') then
			pwmDemux1_output<=pwmDemuxir_input;
		end if;
   END PROCESS;
END comb;