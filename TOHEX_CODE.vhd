LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY TOHEX_CODE IS
PORT
(
	bin : IN STD_LOGIC_VECTOR(3 downto 0);
	seg : OUT STD_LOGIC_VECTOR(6 downto 0)
);
END TOHEX_CODE;

ARCHITECTURE TOHEX_CODE_architecture OF TOHEX_CODE IS
SIGNAL tmp : std_logic_vector(6 downto 0);
BEGIN

PROCESS(bin)

	begin
		if    bin = "0000" then tmp <= "1000000" after 5 ns;--0
		elsif bin = "0001" then tmp <= "1111001" after 5 ns;--1
		elsif bin = "0010" then tmp <= "0100100" after 5 ns;--2
		elsif bin = "0011" then tmp <= "0110000" after 5 ns;--3
		
		elsif bin = "0100" then tmp <= "0011001" after 5 ns;--4
		elsif bin = "0101" then tmp <= "0010010" after 5 ns;--5
		elsif bin = "0110" then tmp <= "0000010" after 5 ns;--6
		elsif bin = "0111" then tmp <= "1111000" after 5 ns;--7
		
		elsif bin = "1000" then tmp <= "0000000" after 5 ns;--8
		elsif bin = "1001" then tmp <= "0011000" after 5 ns;--9
		elsif bin = "1010" then tmp <= "0001000" after 5 ns;--a
		elsif bin = "1011" then tmp <= "0000011" after 5 ns;--b
		
		elsif bin = "1100" then tmp <= "1000110" after 5 ns;--c
		elsif bin = "1101" then tmp <= "0100001" after 5 ns;--d
		elsif bin = "1110" then tmp <= "0000110" after 5 ns;--e
		elsif bin = "1111" then tmp <= "0001110" after 5 ns;--f
		else tmp <= "1111111" after 5 ns;
end if;		
	end process;

	seg <= tmp;
END TOHEX_CODE_architecture;