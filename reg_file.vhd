library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;
use work.all;

entity reg_file is
	port(
		clk : in std_logic;
		uOps : in std_logic_vector(29 downto 9);
	);
end entity;

architecture structural of reg_file is
	--register, mux signals
	signal M_q, SP_q, PC_q, opcode, DR_q, R_q, A_q : std_logic_vector(7 downto 0);
	signal MARLOAD, SPLOAD, PCLOAD, IRLOAD, DRLOAD, RLOAD, ALOAD, ZLOAD : std_logic;
	signal WE, SPCNT, SPUD, PCCNT, PCCLR : std_logic;
	signal MARSEL, ASEL : std_logic_vector(1 downto 0);
	signal DRSEL, ALUSEL : std_logic;
	
begin
	
	
end architecture;