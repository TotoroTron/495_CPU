library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture behavioral of testbench is
	component top_level is
		generic(RAM_FILE : string;
			uROM_FILE : string;
			clk_speed : integer);
		port(
			clk_50mhz : in std_logic; --reference clock
			hex_0 : out std_logic_vector(6 downto 0);
			hex_1 : out std_logic_vector(6 downto 0);
			upc_clear : in std_logic
		);
	end component;
	signal clk_50mhz : std_logic;
	signal hex_0 : std_logic_vector(6 downto 0);
	signal hex_1 : std_logic_vector(6 downto 0);
	
	signal upc_clear : std_logic;
	constant clk_period : time := 20 ns;
begin

	UUT: top_level
		GENERIC MAP(
			RAM_FILE => "test_programs/ram6.hex",
			uROM_FILE => "microde.hex",
			clk_speed => 2)
		PORT MAP(
			clk_50mhz => clk_50mhz,
			hex_0 => hex_0,
			hex_1 => hex_1,
			upc_clear => upc_clear
		);
	
	TESTBENCH: process
	begin
		upc_clear <= '0';
		wait;
	end process;
	
	CLOCK_GEN : process
   begin
		clk_50mhz <= '1';
		wait for clk_period/2;
		clk_50mhz <= '0';
		wait for clk_period/2;
   end process;
	
end architecture;