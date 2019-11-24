LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity clk_div is
	generic(n : positive := 50000000); --default 1hz clock
	port(
		clk_in : in std_logic;
		clk_out : inout std_logic
	);
end entity;

architecture behavioral of clk_div is
begin
	CLOCK_DIVIDE : process(clk_in)
		variable c : integer range 0 to (n/2)-1;
	begin
		if rising_edge(clk_in) then
			if c < (n/2)-1 then
				c := c + 1;
			else
				c := 0;
				clk_out <= NOT clk_out;
			end if;
		end if;
	end process;
end architecture;