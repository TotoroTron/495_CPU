library ieee;
use ieee.std_logic_1164.all;

entity display is
	port(
		A_q : in std_logic_vector(7 downto 0); --from reg_file
		seven_seg_hund : out std_logic_vector(6 downto 0); --to top_level
		seven_seg_tens : out std_logic_vector(6 downto 0); --to top_level
		seven_seg_ones : out std_logic_vector(6 downto 0); --to top_level
	);
end entity;

architecture behavioral of display is
begin
	Count := to_integer(unsigned(A_q));

	Hund := ((count mod 1000) - (count mod 100))/100;
	Tens := ((count mod 100) - (count mod 10))/10;
	Ones := ((count mod 10) - (count mod 1))/1;
	
	Case hund is
	When 0=>seven_seg_hund<="1000000";
	When 1=>seven_seg_hund<="1111001";
	When 2=>seven_seg_hund<="0100100";
	When 3=>seven_seg_hund<="0110000";
	When 4=>seven_seg_hund<="0011001";
	When 5=>seven_seg_hund<="0010010";
	When 6=>seven_seg_hund<="0000010";
	When 7=>seven_seg_hund<="1111000";
	When 8=>seven_seg_hund<="0000000";
	When 9=>seven_seg_hund<="0010000";
	end case;

	Case tens is
	When 0=>seven_seg_tens<="1000000";
	When 1=>seven_seg_tens<="1111001";
	When 2=>seven_seg_tens<="0100100";
	When 3=>seven_seg_tens<="0110000";
	When 4=>seven_seg_tens<="0011001";
	When 5=>seven_seg_tens<="0010010";
	When 6=>seven_seg_tens<="0000010";
	When 7=>seven_seg_tens<="1111000";
	When 8=>seven_seg_tens<="0000000";
	When 9=>seven_seg_tens<="0010000";
	end case;

	Case ones is
	When 0=>seven_seg_ones<="1000000";
	When 1=>seven_seg_ones<="1111001";
	When 2=>seven_seg_ones<="0100100";
	When 3=>seven_seg_ones<="0110000";
	When 4=>seven_seg_ones<="0011001";
	When 5=>seven_seg_ones<="0010010";
	When 6=>seven_seg_ones<="0000010";
	When 7=>seven_seg_ones<="1111000";
	When 8=>seven_seg_ones<="0000000";
	When 9=>seven_seg_ones<="0010000";
	end case;


end architecture;
