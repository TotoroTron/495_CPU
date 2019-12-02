library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity top_level is
	generic(RAM_FILE : string := "ram1.hex");
	port(
		clk_50mhz : in std_logic; --reference clock
		hex0 : out std_logic_vector(6 downto 0);
		hex1 : out std_logic_vector(6 downto 0);
		hex2 : out std_logic_vector(6 downto 0)
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
		port(
			clk : in std_logic;				--from clk-div.vhd
			M_q: in std_logic_vector(7 downto 0);		--from reg_FILE from lpm_ram_dq
			A_q: out std_logic_vector(7 downto 0);		--from reg_FILE from lpm_ram_dq
			M_addr: out std_logic_vector(7 downto 0);	--to reg_FILE to lpm_ram_dq
			M_write: out std_logic;				--to reg_FILE to lpm_ram_dq
			M_data: out std_logic_vector(7 downto 0)
		);
	end component;
	component display is
		port(
			clk : in std_logic;
			A_q : in std_logic_vector(7 downto 0); --from reg_file
			seven_seg_hund : out std_logic_vector(6 downto 0); --to top_level
			seven_seg_tens : out std_logic_vector(6 downto 0); --to top_level
			seven_seg_ones : out std_logic_vector(6 downto 0) --to top_level
		);
	end component;
	signal sys_clk : std_logic;
	signal ram_do : std_logic_vector(7 downto 0);
	signal ram_di : std_logic_vector(7 downto 0);
	signal ram_we : std_logic;
	signal ram_addr : std_logic_vector(7 downto 0);
	signal A_q : std_logic_vector(7 downto 0);
	signal not_clk : std_logic;
begin

	--CLK_DIVIDE: clk_div
	--	generic map(n => 50000000) --delay clock to 1Hz
	--	port map(clk_in => clk_50mhz, clk_out => sys_clk);
	sys_clk <= clk_50mhz;
	not_clk <= not sys_clk;
	
	RAM_BLOCK: lpm_ram_dq
		generic map(LPM_WIDTHAD => 8, LPM_WIDTH => 8, LPM_FILE => RAM_FILE)
		port map(inclock=>sys_clk, outclock=>sys_clk, data => ram_di, address => ram_addr, we => ram_we, q => ram_do);
	
	CPU_BLOCK: cpu
		port map(
			clk => sys_clk, --clk_div.vhd
			A_q => A_q,
			M_q =>ram_do,
			M_addr =>ram_addr,
			M_write =>ram_we,
			M_data=>ram_di
		);
	
	DISP_BLOCK: display
		port map(
			clk => sys_clk,
			A_q => A_q,
			seven_seg_hund =>hex2,
			seven_seg_tens =>hex1,
			seven_seg_ones =>hex0
		);
		
end architecture;
