library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;
use work.all;

entity top_level is
	port(
		clk_50mhz : in std_logic; --reference clock
	);
end entity;

architecture structural of top_level is
	signal sys_clk : std_logic;
	signal ram_do : std_logic_vector(15 downto 0);
	signal ram_di : std_logic_vector(15 downto 0);
	signal ram_we : std_logic;
	signal ram_addr : std_logic_vector(7 downto 0);
begin

	CLOCK_DIVIDER: entity work.clk_div
		generic map(n => 50000000) --1Hz
		port map(clk_in => clk_50mhz, clk_out => sys_clk);
	
	LPM_RAM: lpm_ram_dq
		generic map(LPM_WIDTHAD => 8, LPM_WIDTH => 16, LPM_FILE => ram.mif)
		port map(data => ram_di, address => ram_addr, we => ram_we, q => ram_do);
	
	--REGISTER_FILE: entity work.reg_file
		
	--CONTROL_UNIT: entity work.exp7_useq
		
end architecture;