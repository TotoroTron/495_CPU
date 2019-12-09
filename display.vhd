-- die_decoder.vhd
library ieee;
use ieee.std_logic_1164.all;

entity display is
  port (
    clk : in std_logic;
    A_q : in std_logic_vector(7 downto 0);
    hex_1: out std_logic_vector(6 downto 0);
	 hex_0: out std_logic_vector(6 downto 0)
	 
  );
end display;

architecture behavior of display is
	signal not_hex_1 : std_logic_vector(6 downto 0);
	signal not_hex_0 : std_logic_vector(6 downto 0);
begin
	with A_q(7 downto 4) select not_hex_1 <=
		"0111111" when "0000", --0
		"0000110" when "0001", --1
		"1011011" when "0010", --2
		"1001111" when "0011", --3
		"1100110" when "0100", --4
		"1101101" when "0101", --5
		"1111101" when "0110", --6
		"0000111" when "0111", --7
		"1111111" when "1000", --8
		"1101111" when "1001", --9
		"1110111" when "1010", --A
		"1111100" when "1011", --B
		"0111001" when "1100", --C
		"1011110" when "1101", --D
		"1111001" when "1110", --E
		"1110001" when "1111", --F
		"0000000" when others;
		
	with A_q(3 downto 0) select not_hex_0 <=
		"0111111" when "0000", --0
		"0000110" when "0001", --1
		"1011011" when "0010", --2
		"1001111" when "0011", --3
		"1100110" when "0100", --4
		"1101101" when "0101", --5
		"1111101" when "0110", --6
		"0000111" when "0111", --7
		"1111111" when "1000", --8
		"1101111" when "1001", --9
		"1110111" when "1010", --A
		"1111100" when "1011", --B
		"0111001" when "1100", --C
		"1011110" when "1101", --D
		"1111001" when "1110", --E
		"1110001" when "1111", --F
		"0000000" when others;
    
	hex_0 <= not not_hex_0;
	hex_1 <= not not_hex_1;
		
end behavior;


