LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY ram IS
   PORT
   (
      data:  IN   std_logic_vector (11 DOWNTO 0);
      addr:  IN   std_logic_vector (7 downto 0);
      we,clk:    IN   std_logic;
      ram_out:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END ram;
ARCHITECTURE rtl OF ram IS
	type ram_array is array(0 to 117) of std_logic_vector(15 downto 0);
	signal ram_words:ram_array:=
	( "0100001111000001",--00 Start/Stop PWM
	  "0000000000000000",--01 Do Nothing
	  "0000000000000000",--02 Do Nothing
	  "0000000000000000",--03 Do Nothing
	  "0000000000000000",--04 Do Nothing
	  "0100001111000001",--16 Stop PWM
	  "0100001111000010",--17 Start PWM
	  "0000000000000000",--18 Do Nothing
	  "0000000000000000",--19 Do Nothing
	  "0000000000000000",--20 Do Nothing
	  "0000000000000000",--21 Do Nothing
	  "0100001111000010",--33 Stop PWM
	  "0100001111000011",--34 Start PWM
	  "0000000000000000",--35 Do Nothing
	  "0000000000000000",--36 Do Nothing
	  "0000000000000000",--37 Do Nothing
	  "0000000000000000",--38 Do Nothing
	  "0100001111000011",--50 Stop PWM
	  "0100001111000100",--51 Start PWM
	  "0000000000000000",--52 Do Nothing
	  "0000000000000000",--53 Do Nothing
	  "0000000000000000",--54 Do Nothing
	  "0000000000000000",--55 Do Nothing
	  "0100001111000100",--67 Stop PWM
	  "0100001111000101",--68 Start PWM
	  "0000000000000000",--69 Do Nothing
	  "0000000000000000",--70 Do Nothing
	  "0000000000000000",--71 Do Nothing
	  "0000000000000000",--72 Do Nothing
	  "0100001111000101",--84 Stop PWM
	  "0100001111000110",--85 Start PWM
	  "0000000000000000",--86 Do Nothing
	  "0000000000000000",--87 Do Nothing
	  "0000000000000000",--88 Do Nothing
	  "0000000000000000",--89 Do Nothing
	  "0100001111000110",--101 Stop PWM
	  "0100001111000111",--102 Start PWM
	  "0000000000000000",--103 Do Nothing
	  "0000000000000000",--104 Do Nothing
	  "0000000000000000",--105 Do Nothing
	  "0000000000000000",--106 Do Nothing
	  "0100001111000111",--118 Stop PWM
	  "0100001111001000",--119 Start PWM
	  "0000000000000000",--120 Do Nothing
	  "0000000000000000",--121 Do Nothing
	  "0000000000000000",--122 Do Nothing
	  "0000000000000000",--123 Do Nothing
	  "0100001111001000",--135 Stop PWM
	  "0100001111001001",--136 Start PWM
	  "0000000000000000",--137 Do Nothing
	  "0000000000000000",--138 Do Nothing
	  "0000000000000000",--139 Do Nothing
	  "0000000000000000",--140 Do Nothing
	  "0000000000000000",--151 Do Nothing
	  "0100001111001001",--152 Stop PWM
	  "0100001111001010",--153 Start PWM
	  "0000000000000000",--154 Do Nothing
	  "0000000000000000",--155 Do Nothing
	  "0000000000000000",--156 Do Nothing
	  "0000000000000000",--157 Do Nothing
	  "0100001111001011",--170 Start PWM
	  "0000000000000000",--171 Do Nothing
	  "0000000000000000",--172 Do Nothing
	  "0000000000000000",--173 Do Nothing
	  "0000000000000000",--174 Do Nothing
	  "0100001111001011",--186 Stop PWM
	  "0100001111001100",--187 Start PWM
	  "0000000000000000",--188 Do Nothing
	  "0000000000000000",--189 Do Nothing
	  "0000000000000000",--190 Do Nothing
	  "0000000000000000",--191 Do Nothing
	  "0100001111001100",--203 Stop PWM
	  "0100001111001101",--204 Start PWM
	  "0000000000000000",--205 Do Nothing
	  "0000000000000000",--206 Do Nothing
	  "0000000000000000",--207 Do Nothing
	  "0000000000000000",--208 Do Nothing
	  "0100001111001101",--220 Stop PWM
	  "0100001111001110",--221 Start PWM
	  "0000000000000000",--222 Do Nothing
	  "0000000000000000",--223 Do Nothing
	  "0000000000000000",--224 Do Nothing
	  "0000000000000000",--225 Do Nothing
	  "0100001111001110",--237 Stop PWM
	  "0100001111001111",--238 Start PWM
	  "0000000000000000",--239 Do Nothing
	  "0000000000000000",--240 Do Nothing
	  "0000000000000000",--241 Do Nothing
	  "0000000000000000",--242 Do Nothing
	  "0100001111001111",--237 Stop PWM
	  "0100000111000001",--238 Start PWM
	  "0000000000000000",--240 Do Nothing
	  "0000000000000000",--241 Do Nothing
	  "0100000111000001",--237 Stop PWM
	  "0100000111000010",--238 Start PWM
	  "0000000000000000",--240 Do Nothing
	  "0000000000000000",--241 Do Nothing
	  "0100000111000010",--237 Stop PWM
	  "0100000111000011",--238 Start PWM
	  "0000000000000000",--240 Do Nothing
	  "0000000000000000",--241 Do Nothing
	  "0100000111000011",--237 Stop PWM
	  "0100000111000100",--238 Start PWM
	  "0000000000000000",--240 Do Nothing
	  "0000000000000000",--241 Do Nothing
	  "0100000111000100",--237 Stop PWM
	  "0100000111000101",--238 Start PWM
	  "0000000000000000",--240 Do Nothing
	  "0000000000000000",--241 Do Nothing
	  "0100000111000101",--237 Stop PWM
	  "0100000111000110",--238 Start PWM
	  "0001000000011000",--04 LOAD 24
	  "0010111111111000",--01 ADD 170
	  "0100000111000110",--237 Stop PWM
	  "0100000111000111",--238 Start PWM
	  "0111000001110101",--03 OUTPUT 117
	  "1110000000000000",--05 JUMP 7
	  "0000000000000000"--122 to store
	);
BEGIN

process(clk)
begin
	if (rising_edge(clk)) then
		if (we='1') then
			ram_words(to_integer(unsigned(addr)))<=("0000") & data;			
		end if;
	end if;
end process;
ram_out<= ram_words(to_integer(unsigned(addr)));
END rtl;

--"0101000000001100",--00 INPUT ACC 12
--	  "0010111111111000",--01 ADD 170
--	  "1111000000000100",--02 JUMPCON 4
--	  "0111000000000111",--03 OUTPUT 7
--	  "0001000000011000",--04 LOAD 24
--	  "1110000000000111",--05 JUMP 7
--	  "1101000000000110",--06 NOT 6
--	  "0001000000001010",--07 LOAD 11
--	  "0100001100000111",--08 Start/Stop PWM
--	  "0011000000000001",--09 SUB 1
--	  "1110000000000000",--10 JUMP 0
--	  "0000000000000000",--11 nothing
--	  "0000000000001111",--12 nothing
--	  "0000000000000000",--13 nothing
--	  "0000000000000000"--14 nothing