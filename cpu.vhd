library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;
use work.all;

entity cpu is
	port(
		clk : in std_logic;				--from clk-div.vhd
		M_q: in std_logic_vector(7 downto 0);		--from reg_FILE from lpm_ram_dq
		M_addr: out std_logic_vector(7 downto 0);	--to reg_FILE to lpm_ram_dq
		M_write: out std_logic;				--to reg_FILE to lpm_ram_dq
		
	);
end entity;

architecture dataflow of cpu is

	signal uOP : std_logic_vector(7 downto 0);
	signal opcode : std_logic_vector(7 downto 0);
begin
	
	uSEQUENCER : work.entity.exp7_useq
		generic map(uROM_width => 30,	--exp7_useq.vhd
			   uROM_file => "microde.mif") --
		port map(opcode => opcode,
			 uop => uop);
	REG_FILE : work.entity.reg_FILE
		port map(clk => sys_clk, --clk_div.vhd
			 uOps => uOp,
			M_q => M_q,
			M_addr => M_addr,
			M_write => M_addr);
end architecture;
