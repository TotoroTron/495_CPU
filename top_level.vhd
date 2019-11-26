library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;
use work.all;

entity top_level is
	port(
		clk_50mhz : in std_logic; --reference clock
		hex0 : out std_logic_vector(6 downto 0);
		hex1 : out std_logic_vector(6 downto 0);
		hex2 : out std_logic_vector(6 downto 0)
	);
end entity;

architecture structural of top_level is
	signal sys_clk : std_logic;
	signal ram_do : std_logic_vector(15 downto 0);
	signal ram_di : std_logic_vector(15 downto 0);
	signal ram_we : std_logic;
	signal ram_addr : std_logic_vector(7 downto 0);
begin

	CLK_DIV: entity work.clk_div
		generic map(n => 50000000) --delay clock to 1Hz
		port map(clk_in => clk_50mhz, clk_out => sys_clk);
	
	RAM: lpm_ram_dq
		generic map(LPM_WIDTHAD => 8, LPM_WIDTH => 8, LPM_FILE => ram.mif)
		port map(data => ram_di, address => ram_addr, we => ram_we, q => ram_do);
	
	CPU: entity work.cpu
		--generic map()
		--port map();
	
	DISPLAY: entity work.display
		--generic map()
		--port map();
		
end architecture;