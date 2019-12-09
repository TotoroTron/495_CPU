library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity top_level is
	generic(
		RAM_FILE : string := "ram12.hex";
		clk_speed : integer := 22);
	port(
		clk_50mhz : in std_logic; --reference clock
		hex_1 : out std_logic_vector(6 downto 0);
		hex_0 : out std_logic_vector(6 downto 0);
		upc_clear : in std_logic
	);
end entity;

architecture structural of top_level is
	component clk_div is
		generic(n : positive); --default 1hz clock
		port(
			clk_in : in std_logic;
			clk_out : inout std_logic
		);
	end component;
	component cpu is
	  generic(clk_speed : integer);
		port(
			clk : in std_logic;				--from clk-div.vhd
			M_q: in std_logic_vector(7 downto 0);		--from reg_FILE from lpm_ram_dq
			A_q: out std_logic_vector(7 downto 0);		--from reg_FILE from lpm_ram_dq
			M_addr: out std_logic_vector(7 downto 0);	--to reg_FILE to lpm_ram_dq
			M_write: out std_logic;				--to reg_FILE to lpm_ram_dq
			M_data: out std_logic_vector(7 downto 0);
			upc_clear: in std_logic
		);
	end component;
	component display is
		port(
			clk : in std_logic;
			A_q : in std_logic_vector(7 downto 0); --from reg_file
			hex_1 : out std_logic_vector(6 downto 0); --to top_level
			hex_0 : out std_logic_vector(6 downto 0) --to top_level
		);
	end component;
	signal ram_do : std_logic_vector(7 downto 0);
	signal ram_di : std_logic_vector(7 downto 0);
	signal ram_we : std_logic;
	signal ram_addr : std_logic_vector(7 downto 0);
	signal A_q : std_logic_vector(7 downto 0);
begin
	
	RAM_BLOCK: lpm_ram_dq
		generic map(LPM_WIDTHAD => 8, LPM_WIDTH => 8, LPM_FILE => RAM_FILE)
		port map(
			inclock => CLK_50mhz,
			outclock => clk_50mhz,
			data => ram_di,
			address => ram_addr,
			we => ram_we,
			q => ram_do
		);
	
	CPU_BLOCK: cpu
		generic map(clk_speed => clk_speed)
		port map(
			clk => clk_50mhz, --clk_div.vhd
			A_q => A_q,
			M_q => ram_do,
			M_addr => ram_addr,
			M_write => ram_we,
			M_data => ram_di,
			upc_clear => upc_clear
		);
	
	DISP_BLOCK: display
		port map(
			clk => clk_50mhz,
			A_q => A_q,	
			hex_1 => hex_1,
			hex_0 => hex_0
		);
		
end architecture;
