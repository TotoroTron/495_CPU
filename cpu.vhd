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
		M_data: out std_logic_vector(7 downto 0)
	);
end entity;

architecture dataflow of cpu is
	component exp7_useq is
		port(
			opcode: in std_logic_vector(3 downto 0);
			uop: out std_logic_vector(1 to (uROM_width-9));
			clock: in std_logic
		);
	end component;
	component reg_file is
		port(
			clk : in std_logic;
			uOps : in std_logic_vector(29 downto 9); --from useq
			M_q : in std_logic_vector(7 downto 0); --from ram
			A_q : out std_logic_vector(7 downto 0);
			M_data : out std_logic_vector(7 downto 0);
			M_addr : out std_logic_vector(7 downto 0); --to ram
			M_write : out std_logic --to ram
		);
	end component;
	signal uOP : std_logic_vector(7 downto 0);
	signal opcode : std_logic_vector(7 downto 0);
begin
	
	uSEQUENCER : exp7_useq
		generic map(uROM_width => 30, uROM_file => "microde.mif")
		port map(clk => sys_clk, opcode => opcode, uop => uop);
		
	REG_FILE : reg_FILE
		port map(
			clk => sys_clk, --clk_div.vhd
			uOps => uOp,
			M_q => M_q,
			A_q => A_q,
			M_addr => M_addr,
			M_write => M_addr
		);
end architecture;
