LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity clk_div is
	generic(period : positive);
	port(
		clk_in : in std_logic;
		clk_out : out std_logic
	);
end entity;

architecture behavioral of clk_div is
begin
	CLOCK_DIVIDE : process(clk_in)
		variable c : integer range 0 to period := 0;
	begin
		if rising_edge(clk_in) then
			c := c + 1;
			clk_out <= '0';
			if(c = period) then
				clk_out <= '1';
				c := 0;
			end if;
		end if;
	end process;
end architecture;