library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity cpu is
	port(
		clk : in std_logic;				--from clk-div.vhd
		M_q: in std_logic_vector(7 downto 0);		--from reg_FILE from lpm_ram_dq
		A_q: out std_logic_vector(7 downto 0);		--from reg_FILE from lpm_ram_dq
		M_addr: out std_logic_vector(7 downto 0);	--to reg_FILE to lpm_ram_dq
		M_write: out std_logic;				--to reg_FILE to lpm_ram_dq
		M_data: out std_logic_vector(7 downto 0);
		upc_clear : in std_logic
	);
end entity;

architecture dataflow of cpu is
	component exp7_useq is
		generic (
			uROM_width: integer;
			uROM_file: string
		);
		port(
			opcode: in std_logic_vector(3 downto 0);
			uop: out std_logic_vector(29 downto 9);
			clock, enable, clear: in std_logic
		);
	end component;
	component reg_file is
		port(
			clk : in std_logic;
			clk2 : in std_logic;
			uOps : in std_logic_vector(29 downto 9); --from useq
			M_q : in std_logic_vector(7 downto 0); --from ram
			opcode : out std_logic_vector(3 downto 0);
			A_q_out : out std_logic_vector(7 downto 0);
			M_data : out std_logic_vector(7 downto 0);
			M_addr : out std_logic_vector(7 downto 0); --to ram
			M_write : out std_logic --to ram
		);
	end component;
	component clk_div is
		generic(period : integer);
		port(clk_in : in std_logic; clk_out : out std_logic);
	end component;
	signal uOP : std_logic_vector(29 downto 9);
	signal opcode : std_logic_vector(3 downto 0);
	signal clk2: std_logic;
begin

	CLK_DELAY: lpm_counter generic map(lpm_width=>2) --22
		port map(clock => clk, cout => clk2);
	
--	CLK_DELAY: clk_div
--		generic map(period => 4)
--		port map(clk_in => clk, clk_out => clk2);
	
	uSEQUENCER : exp7_useq
		generic map(uROM_width => 30, uROM_file => "microde.hex")
		port map(clock => clk, enable => clk2, clear => upc_clear, opcode => opcode, uop => uOP);
		
	REGISTER_FILE : reg_file
		port map(
			clk => clk, --50mhz
			clk2 => clk2, --1HZ
			uOps => uOp,
			M_q => M_q,
			opcode => opcode,
			A_q_out => A_q,
			M_addr => M_addr,
			M_data => M_data,
			M_write => M_write
		);
	
end architecture;
