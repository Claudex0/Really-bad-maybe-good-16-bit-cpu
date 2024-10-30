LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY program_counter IS
   PORT
   (
      clk,pc_clr,pc_ld,pc_cnt: IN   std_logic;
      input:  IN   std_logic_vector (7 DOWNTO 0);
      pc_out:     OUT  std_logic_vector (7 DOWNTO 0)
   );
END program_counter;
ARCHITECTURE rtl OF program_counter IS
BEGIN
   PROCESS (clk,pc_clr)
	variable cnt:std_logic_vector (7 downto 0);
   BEGIN
		if (pc_clr='1') then
			pc_out<="00000000";
			cnt:="00000000";
		else
			if (rising_edge(clk)) then
				if (pc_ld='1') then
					cnt:=input;
				elsif (pc_cnt='1') then
					cnt:=cnt+"00000001";
				end if;
				pc_out<=cnt;
			 end if;
		end if;
   END PROCESS;
END rtl;