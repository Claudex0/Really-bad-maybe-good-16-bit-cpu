LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY decoder IS
	
	PORT( 
		nrst,clk,cycl_phs,co:in  std_logic;
		OpCode:in  std_logic_vector(3 downto 0);
		pc_cnt,pc_ld,pwn_en,ir_ld,ir_clr,we,memMux_sel,demux_sel,aluMux0_sel,aluMux1_sel,acu_ld,acu_clr,cycl_clr,cycle_cnt,pc_clr:out std_logic;
		alu_sel :out std_logic_vector(3 downto 0)
	);
END decoder;

ARCHITECTURE RTL OF decoder IS
	type state is (Su, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9,S10,S11,S12,S13,S14,S15,S16,s17,s18,s19,s20,s21,
	s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35); --Su = State uninitialized 
	
	signal present_state, next_state : state;
BEGIN
	--next state decoder
	next_state_dec_proc:
	process(present_state,OpCode,cycl_phs,co)
		variable n_s : state;
	begin
		case present_state is
			when s0 => 
				n_s:=s1;
			when s1=>--fetch begin
				if (cycl_phs='0') then
					n_s:=s2;
				else
					n_s:=s1;
				end if;
			when s2=>--fetch done
					if (opcode="0000") then --do nothing
						n_s:=s3;
					elsif (opcode="0001") then--load
						n_s:=s4;
					elsif (opcode="0010") then--add
						n_s:=s5;
					elsif (opcode="0011") then--sub
						n_s:=s6;
					elsif (opcode="0100") then--startStoppwm
						n_s:=s7;	
					elsif (opcode="0101") then--input
						n_s:=s8;
					elsif (opcode="0110") then--xnor
						n_s:=s9;
					elsif (opcode="0111") then--output
						n_s:=s10;
					elsif (opcode="1000") then--and
						n_s:=s11;
					elsif (opcode="1001") then--nand
						n_s:=s12;
					elsif (opcode="1010") then--or
						n_s:=s13;
					elsif (opcode="1011") then--nor
						n_s:=s14;
					elsif (opcode="1100") then--xor
						n_s:=s15;
					elsif (opcode="1101") then--not
						n_s:=s16;
					elsif (opcode="1110") then--jump
						n_s:=s17;
					else 
						if (opcode="1111") then--jumpCon
							if (co='1') then
								n_s:=s18;
							else
								n_s:=s19;
							end if;
						end if;
					end if;--decode end		
			when s3=>--execute begin
				if (cycl_phs='1') then --do nothing
					n_s:=s1;
				else
					n_s:=s3;
				end if;	
			when s4=>--execute begin
				if (cycl_phs='1') then--load
					n_s:=s20;
				else
					n_s:=s4;
				end if;
			when s5=>
				if (cycl_phs='1') then--add
					n_s:=s21;
				else
					n_s:=s5;
				end if;
			when s6=>
				if (cycl_phs='1') then--sub
					n_s:=s22;
				else
					n_s:=s6;
				end if;
			when s7=>
				if (cycl_phs='1') then--startStoppwm
					n_s:=s23;
				else
					n_s:=s7;
				end if;
			when s8=>
				if (cycl_phs='1') then--input
					n_s:=s24;
				else
					n_s:=s8;
				end if;
			when s9=>
				if (cycl_phs='1') then--xnor
					n_s:=s25;
				else
					n_s:=s9;
				end if;
			when s10=>
				if (cycl_phs='1') then--output
					n_s:=s26;
				else
					n_s:=s10;
				end if;
			when s11=>
				if (cycl_phs='1') then--and
					n_s:=s27;
				else
					n_s:=s11;
				end if;
			when s12=>
				if (cycl_phs='1') then--nand
					n_s:=s28;
				else
					n_s:=s12;
				end if;
			when s13=>
				if (cycl_phs='1') then--or
					n_s:=s29;
				else
					n_s:=s13;
				end if;
			when s14=>
				if (cycl_phs='1') then--nor
					n_s:=s30;
				else
					n_s:=s14;
				end if;
			when s15=>
				if (cycl_phs='1') then--xor
					n_s:=s31;
				else
					n_s:=s15;
				end if;
			when s16=>
				if (cycl_phs='1') then--not
					n_s:=s32;
				else
					n_s:=s16;
				end if;
			when s17=>
				if (cycl_phs='1') then--jump
					n_s:=s33;
				else
					n_s:=s17;
				end if;
			when s18=>
				if (cycl_phs='1') then--jumpContrue
					n_s:=s34;
				else
					n_s:=s18;
				end if;
			when s19=>
				if (cycl_phs='1') then--jumpConfalse
					n_s:=s35;
				else
					n_s:=s19;
				end if;
			when s20=>
				n_s:=s1;
			when s21=>
				n_s:=s1;
			when s22=>
				n_s:=s1;
			when s23=>
				n_s:=s1;
			when s24=>
				n_s:=s1;
			when s25=>
				n_s:=s1;
			when s26=>
				n_s:=s1;
			when s27=>
				n_s:=s1;
			when s28=>
				n_s:=s1;
			when s29=>
				n_s:=s1;
			when s30=>
				n_s:=s1;
			when s31=>
				n_s:=s1;
			when s32=>
				n_s:=s1;
			when s33=>
				n_s:=s1;
			when s34=>
				n_s:=s1;
			when s35=>
				n_s:=s1;
			when others => n_s := Su;
		end case;
		next_state <= n_s after 5 ns;
	end process;
	
	
	--memory
	mem_proc:
	process(nrst,clk)
	begin
		if nrst = '1' then
			present_state <= S0 after 5 ns;
		elsif rising_edge(clk) then
			present_state <= next_state after 5 ns;
		end if;
	end process;
	
	
	--output decoder
	output_dec_proc:
	process(present_state)	
	begin
		case present_state is
			when s0 => --initial state
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='1' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='1' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='1' after 5 ns;--reset pc
				alu_sel<="0000" after 5 ns;
			when s1=>--fetch begin
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='1' after 5 ns;--ld
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='1' after 5 ns;--clear cycle
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s2=>--fetch end
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s3=>--fetch end
				pc_cnt<='1' after 5 ns;--increment pc
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;--increment cycle
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s4=>--load
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;--0
				demux_sel<='0' after 5 ns;--0
				aluMux0_sel<='0' after 5 ns;--0
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;--increment cycle
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;--0000
			when s5=>--add
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0001" after 5 ns;
			when s6=>--sub
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0010" after 5 ns;
			when s7=>--startStoppwm
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='1' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s8=>--input
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='1' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='1' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s9=>--xnor
				pc_cnt<='0'after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="1001" after 5 ns;
			when s10=>--output
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='1' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s11=>--and
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0011" after 5 ns;
			when s12=>--nand
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0100" after 5 ns;
			when s13=>--or
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0101" after 5 ns;
			when s14=>--nor
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0110" after 5 ns;
			when s15=>--xor
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0111" after 5 ns;
			when s16=>--not
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="1000" after 5 ns;
			when s17=>--jump
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s18=>--jumpContrue
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s19=>--jumpConfalse
				pc_cnt<='0' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='1' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s20=>--exe_ld
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s21=>--exe_add
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0001" after 5 ns;
			when s22=>--exe_sub
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0010" after 5 ns;
			when s23=>--exe_startStoppwm
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='1' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='1' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s24=>--exe_input
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='1' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='1' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s25=>--exe_xnor
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="1001" after 5 ns;
			when s26=>--exe_output
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='1' after 5 ns;
				memMux_sel<='1' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s27=>--exe_and
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0011" after 5 ns;
			when s28=>--exe_nand
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0100" after 5 ns;
			when s29=>--exe_or
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0101" after 5 ns;
			when s30=>--exe_nor
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0110" after 5 ns;
			when s31=>--exe_xor
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0111" after 5 ns;
			when s32=>--exe_not
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='1' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="1000" after 5 ns;
			when s33=>--exe_jump
				pc_cnt<='0' after 5 ns;
				pc_ld<='1' after 5 ns;
				pwn_en<='0'after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s34=>--exe_jumpContrue
				pc_cnt<='0' after 5 ns;
				pc_ld<='1' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when s35=>--exe_jumpConfalse
				pc_cnt<='1' after 5 ns;
				pc_ld<='0' after 5 ns;
				pwn_en<='0' after 5 ns;
				ir_ld<='0' after 5 ns;
				ir_clr<='0' after 5 ns;
				we<='0' after 5 ns;
				memMux_sel<='0' after 5 ns;
				demux_sel<='0' after 5 ns;
				aluMux0_sel<='0' after 5 ns;
				aluMux1_sel<='0' after 5 ns;
				acu_ld<='0' after 5 ns;
				acu_clr<='0' after 5 ns;
				cycl_clr<='0' after 5 ns;
				cycle_cnt<='0' after 5 ns;
				pc_clr<='0' after 5 ns;
				alu_sel<="0000" after 5 ns;
			when others => 
				pc_cnt<='X' after 5 ns;
				pc_ld<='X' after 5 ns;
				pwn_en<='X' after 5 ns;
				ir_ld<='X' after 5 ns;
				ir_clr<='X' after 5 ns;
				we<='X' after 5 ns;
				memMux_sel<='X' after 5 ns;
				demux_sel<='X' after 5 ns;
				aluMux0_sel<='X' after 5 ns;
				aluMux1_sel<='X' after 5 ns;
				acu_ld<='X' after 5 ns;
				acu_clr<='X' after 5 ns;
				cycl_clr<='X' after 5 ns;
				cycle_cnt<='X' after 5 ns;
				pc_clr<='X' after 5 ns;
				alu_sel<="XXXX" after 5 ns;  
		end case;
	end process;	
END ARCHITECTURE;