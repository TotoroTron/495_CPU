library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture behavioral of testbench is
	component top_level is
		generic(RAM_FILE: string);
		port(
			clk_50mhz : in std_logic; --reference clock
			hex0 : out std_logic_vector(6 downto 0);
			hex1 : out std_logic_vector(6 downto 0);
			hex2 : out std_logic_vector(6 downto 0)
		);
	end component;
	signal clk_50mhz : std_logic;
	signal hex0 : std_logic_vector(6 downto 0);
	signal hex1 : std_logic_vector(6 downto 0);
	signal hex2 : std_logic_vector(6 downto 0);
	constant clk_period : time := 20 ns;
begin

	UUT: top_level
		GENERIC MAP(RAM_FILE => "ram1.hex")
		PORT MAP(
			clk_50mhz => clk_50mhz,
			hex0 => hex0,
			hex1 => hex1,
			hex2 => hex2
		);
	
	--TESTBENCH: process
	--begin
	--	wait;
	--end process;
	
	CLOCK_GEN : process
	variable v_buffer : boolean := true;
   begin
    if v_buffer then
      v_buffer := false;
      wait for clk_period;
  end if;
		clk_50mhz <= '1';
		wait for clk_period/2;
		clk_50mhz <= '0';
		wait for clk_period/2;
   end process;
	
end architecture;