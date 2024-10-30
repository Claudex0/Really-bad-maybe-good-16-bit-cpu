LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY accumulator IS
   PORT
   (
      clk,acu_clr,acu_ld,cobo: IN   std_logic;
      acu_in:  IN   std_logic_vector (11 DOWNTO 0);
		acu_cobo: out std_logic;
      acu_out:     OUT  std_logic_vector (11 DOWNTO 0)
   );
END accumulator;
ARCHITECTURE rtl OF accumulator IS
BEGIN
   PROCESS (clk,acu_clr)
	variable store:std_logic_vector(11 downto 0);
	variable store_cobo:std_logic;
   BEGIN
		if (acu_clr='1') then
			acu_out<="000000000000";
			store:="000000000000";
			store_cobo:='0';
			acu_cobo<='0';
		else
			if (rising_edge(clk)) then
				if(acu_ld='1') then
					store(11 downto 0):=acu_in;
					store_cobo:=cobo;
				end if;
				acu_out<=store after 5 ns;
				acu_cobo<=store_cobo after 5 ns;
			end if;
		end if;				
   END PROCESS;
END rtl;