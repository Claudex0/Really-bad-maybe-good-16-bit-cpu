library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

ENTITY ALU IS
	
	PORT( 
		alu_sel:in  std_logic_vector(3 downto 0);
		aluMux0_input,aluMux1_input: in std_logic_vector(11 downto 0);
		cobo:out std_logic;
		alu_out :out std_logic_vector(11 downto 0)
	);
END ALU;

ARCHITECTURE Comb OF ALU IS
BEGIN
	process(alu_sel,aluMux0_input,aluMux1_input)
	variable sum,sub:std_logic_vector(12 downto 0);
	begin
	case alu_sel is
			when "0000"=>--add 0
				sum:=('0' & aluMux0_input) + ('0' & "000000000000");
				alu_out<=sum(11 downto 0) after 5 ns;
				cobo<=sum(12) after 5 ns;
			when "0001"=>--addition
				sum:=('0'& aluMux0_input) + ('0'& aluMux1_input);
				alu_out<=sum(11 downto 0) after 5 ns;
				cobo<=sum(12) after 5 ns;
			when "0010"=>--subtraction
				sub:=('0'& aluMux0_input) + ((not('0'& aluMux1_input))+1);
				if(sub(12)='1') then--checking for exceptional subtraction
					alu_out<=((not sub(11 downto 0)+1)) after 5 ns;
					cobo<=sub(12) after 5 ns;
				else
					alu_out<=sub(11 downto 0) after 5 ns;--normal subtraction
					cobo<=sub(12) after 5 ns;
				end if;
			when "0011"=>--AND
				alu_out<=(aluMux0_input and aluMux1_input) after 5 ns;
				cobo<='0' after 5 ns;
			when "0100"=>--NAND
				alu_out<=(aluMux0_input nand aluMux1_input) after 5 ns;
				cobo<='0' after 5 ns;
			when "0101"=>--or
				alu_out<=(aluMux0_input or aluMux1_input) after 5 ns;
				cobo<='0' after 5 ns;
			when "0110"=>--nor
				alu_out<=(aluMux0_input nor aluMux1_input) after 5 ns;
				cobo<='0' after 5 ns;
			when "0111"=>--xor
				alu_out<=(aluMux0_input xor aluMux1_input) after 5 ns;
				cobo<='0' after 5 ns;
			when "1000"=>--not
				alu_out<=(not aluMux0_input) after 5 ns;
				cobo<='0' after 5 ns;
			when "1001"=>--xnor
				alu_out<=(aluMux0_input xnor aluMux1_input) after 5 ns;
				cobo<='0' after 5 ns;
			when others=>
				cobo<='0' after 5 ns;
				alu_out<="000000000000" after 5 ns;
			end case;
	end process;
end architecture;