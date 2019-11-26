library ieee;
use ieee.std_logic_1164.all;

entity display is
	port(
		A_q : in std_logic_vector(7 downto 0); --from reg_file
		hex0 : out std_logic_vector(6 downto 0); --to top_level
		hex1 : out std_logic_vector(6 downto 0); --to top_level
		hex2 : out std_logic_vector(6 downto 0); --to top_level
	);
end entity;

architecture behavioral of display is
begin

	--display value of A_q on hex displays

end architecture;