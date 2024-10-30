LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY instruction_register IS
   PORT
   (
      clk,ir_clr,ir_ld: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END instruction_register;
ARCHITECTURE rtl OF instruction_register IS
BEGIN
   PROCESS (clk,ir_clr)
	variable store:std_logic_vector(15 downto 0);
   BEGIN
		if (ir_clr='1') then
			q<="0000000000000000";
			store:="0000000000000000";
		else
			if (rising_edge(clk)) then
				if(ir_ld='1') then
					store:=data;
				end if;
				q<=store after 5 ns;
			end if;
		end if;				
   END PROCESS;
END rtl;