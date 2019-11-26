library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;
use work.all;

entity cpu is
	port(
		clk : in std_logic
	);
end entity;

architecture dataflow of cpu is

begin
	
	uSEQUENCER : work.entity.exp7_useq
		--generic map();
		--port map();
	REG_FILE : work.entity.reg_FILE
		--generic map();
		--port map();
	
end architecture;